# -*- coding: utf8 -*-
"""`veetou.cli.dboutcmd_`

Implements the DbOutCmd class
"""

from ..model import checkinstance
from ..model import columniter
from ..model import entityclass
from ..model import schemaname
from ..model import modelname
from ..model import tablename
from ..model import Dict
from ..model import Join
from ..model import Junction
from ..model import Link
from ..model import Ref
from ..model import Relation
from ..model import LEFT
from ..model import LEFT_JOIN
from ..model import INNER_JOIN
from ..model import RIGHT_JOIN
from ..model import OUTER_JOIN
from ..model import RIGHT

from . import cmd_
import sys
import sqlite3

__all__ = ('DbOutCmd',)

_types = {
    None    : 'TEXT',
    str     : 'TEXT',
    int     : 'INTEGER'
}

_join_type_strings = {
        INNER_JOIN : 'INNER',
        LEFT_JOIN  : 'LEFT',
        RIGHT_JOIN : 'RIGHT',
        OUTER_JOIN : 'OUTER'
}

class RelationNameDict(Dict):
    """A dictionary with relations (junctions/links) mapped to strings.

    So it may be something like:

        {
            junction1 : 'junction1',
            junction2 : 'junction2',
            link1     : 'link3',
        }

    The keys are compared by identity (with "is" operator, not "==").
    """
    def __keywrap__(self, key):
        if isinstance(key, Ref):
            return key
        else:
            return Ref(checkinstance(key, Relation))

    def __keyunwrap__(self, key):
        return key.obj

    def __wrap__(self, value):
        return checkinstance(value, str)

class DbOutCmd(cmd_.Cmd):

    __slots__ = ()

    @property
    def dbfile(self):
        if not self.arguments.output or self.arguments.output == '-' or self.arguments.db_sql:
            return ':memory:'
        else:
            return self.arguments.output

    @property
    def outfile(self):
        if not self.arguments.output or self.arguments.output == '-':
            return sys.stdout
        else:
            return open(self.arguments.output, 'w')

    def sql_create_junction(self, dbc, name, junction):
        ltab = tablename(junction.tables[LEFT])
        rtab = tablename(junction.tables[RIGHT])
        lent = schemaname(entityclass(junction.tables[LEFT]))
        rent = schemaname(entityclass(junction.tables[RIGHT]))
        return dbc.execute(
"""CREATE TABLE %s (
    %s_id INTEGER,
    %s_id INTEGER,
    CONSTRAINT %s_pk PRIMARY KEY (%s_id, %s_id),
    FOREIGN KEY(%s_id) REFERENCES %s(id),
    FOREIGN KEY(%s_id) REFERENCES %s(id)
)""" % (name, lent, rent, name, lent, rent, lent, ltab, rent, rtab)
        )

    def sql_create_table(self, dbc, name, table):
        entity = entityclass(table)
        efnames = entity.keys()
        eftypes = entity.types()
        if eftypes is None:
            eftypes = len(efnames) * (str,)
        types = tuple(_types.get(t,'TEXT') for t in eftypes)
        names = tuple(efnames)
        coldefs = tuple( "%s %s" % (n, t) for n,t in zip(*(names, types)) )
        return dbc.execute(
"""CREATE TABLE %s (
    id INTEGER NOT NULL,
    %s,
    PRIMARY KEY(id)
)""" % (name, ',\n    '.join(coldefs)))

    def sql_fill_table(self, dbc, name, table):
        entity = entityclass(table)
        qmarks = ', '.join((1 + len(entity)) * ('?',))
        flatten = lambda item : (item[0],) + tuple(item[1])
        return dbc.executemany("INSERT INTO %s VALUES (%s)" % (name, qmarks), map(flatten, table.items()))

    def sql_fill_junction(self, dbc, name, junction):
        return dbc.executemany("INSERT INTO %s VALUES (?,?)" % name, junction)


    def sql_create_join_view(self, dbc, name, join, relnames):
        if not join.tables:
            return

        result_column = lambda c : "%s AS %s_%s" % (schemaname(c), schemaname(entityclass(c)), c.key)

        result_columns = list(map(result_column, columniter(join.tables[0])))
        join_clause = ""
        for i in range(0,len(join.sources)):
            srcindex = join.sources[i]
            srctable = join.tables[srcindex]
            endpoint = join.endpoints[i]
            tgttable = endpoint.opposite_table
            relation = endpoint.relation
            jt = _join_type_strings[join.jointype_for(relation)]
            rn = relnames[relation]                         # relation name
            st = tablename(srctable)                        # source table name
            se = schemaname(entityclass(srctable))          # source entity name
            tt = tablename(tgttable)                        # dest. table name
            te = schemaname(entityclass(tgttable))          # dest. entity name
            if isinstance(relation, Junction):
                s = """ %s JOIN %s ON %s.%s_id = %s.id %s JOIN %s ON %s.%s_id = %s.id""" % \
                    (jt, rn, rn, se, st, jt, tt, rn, te, tt)
                result_columns.extend(map(result_column,  columniter(tgttable)))
            elif isinstance(relation, Link):
                # FIXME: needs to be implemented somehow?
                s = """"""
                msg = "sql export of %s not implemented yet, " % modelname(relation) + \
                      "skipping relation %s (tables: %s, %s)" % (rn, st, tt)
                sys.stderr.write("warning: %s\n" % msg)
                pass
            else:
                raise NotImplementedError("unsupported relation type %s" % repr(type(relation)))
            join_clause = join_clause + s
        select = """SELECT %s FROM %s %s""" % (', '.join(result_columns), tablename(join.tables[0]), join_clause)
        return dbc.execute( """CREATE VIEW %s AS %s""" % (name, select) )

    def add_arguments(self):
        argparser = self.argparser
        argparser.add_argument("--db-sql",
                               action='store_true',
                               help="output database as sql script")

    def run(self, datamodel, start_table, jointypes=()):
        join = Join(datamodel.tables[start_table], jointypes=jointypes)
        relnames = RelationNameDict(map(reversed, datamodel.relations.items()))
        with sqlite3.connect(self.dbfile) as dbc:
            for name, table in datamodel.tables.items():
                self.sql_create_table(dbc, name, table)
                self.sql_fill_table(dbc, name, table)
            for name, relation in datamodel.relations.items():
                if isinstance(relation, Junction):
                    self.sql_create_junction(dbc, name, relation)
                    self.sql_fill_junction(dbc, name, relation)
            self.sql_create_join_view(dbc, 'joined', join, relnames)
            if self.dbfile == ':memory:':
                with self.outfile as outfile:
                    for line in dbc.iterdump():
                        outfile.write("%s\n" % line)
        return 0


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
