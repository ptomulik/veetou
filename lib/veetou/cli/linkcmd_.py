# -*- coding: utf8 -*-
"""`veetou.cli.linkcmd_`
"""

from . import cmd_
from ..model import Link
from ..model import SourceColumnBasedLinkResolver
from ..model import ConditionBasedLinkResolver
from ..model import INNER_JOIN
from ..model import LEFT_JOIN
from ..model import entityclass
from ..parser import fullmatch

import re
import sys

__all__ = ('LinkCmd',)

_re_id = r'(?:[^\d\W]\w*)'
_rg_col2key = re.compile(
    r'(?P<src>%s)\.(?P<col>%s)\s*(?P<jo>(?:->|~>))\s*(?P<tgt>%s)' % \
        (_re_id, _re_id, _re_id)
)

_rg_col2col = re.compile(
    r'(?P<src>%s)\.(?P<scol>%s)\s*(?P<jo>(?:->|~>))\s*(?P<tgt>%s)\.(?P<tcol>%s)' % \
        (_re_id, _re_id, _re_id, _re_id)
)


_join_types = { '->': INNER_JOIN, '~>': LEFT_JOIN }

class LinkArgParser(object):

    __slots__ = ('_datamodel', '_jointypes', '_counter', '_errors')
    def __init__(self, datamodel, jointypes):
        self._datamodel = datamodel
        self._jointypes = jointypes
        self._counter = 0
        self._errors = []

    @property
    def datamodel(self):
        return self._datamodel

    @property
    def errors(self):
        return self._errors

    def check_tables_in_model(self, tables):
        for tab in tables:
            if tab not in self.datamodel.tables:
                self.errors.append('unknown table %s' % repr(tab))
                return False
        return True

    def check_join_operator(self, jo):
        if jo not in _join_types:
            self.errors.append('unknown join operator %s' % repr(jo))
            return False
        return True

    def check_column_in_table(self, column, table):
        entity = entityclass(self.datamodel.tables[table])
        try:
            entity.keyindex(column)
        except KeyError:
            self.errors.append('unknown column %s in table %s' % (repr(column), repr(table)))
            return False
        return True

    def check_relation(self, relation):
        if relation in self.datamodel.relations:
            self.errors.append('relation %s already defined' % repr(relation))
            return False
        return True

    def parse_col2key(self, string, kw):
        if not fullmatch(_rg_col2key, string, strip=True, groupdict=kw):
            return False
        if not self.check_tables_in_model((kw['src'],kw['tgt'])):
            return False
        if not self.check_column_in_table(kw['col'], kw['src']):
            return False
        if not self.check_join_operator(kw['jo']):
            return False
        src = self.datamodel.tables[kw['src']]
        tgt = self.datamodel.tables[kw['tgt']]

        jt = _join_types[kw['jo']]
        kw['resolver'] = SourceColumnBasedLinkResolver(src, kw['col'])
        kw['tables'] = (src, tgt)
        kw['jointype'] = jt
        return True

    def parse_col2col(self, string, kw):
        if not fullmatch(_rg_col2col, string, strip=True, groupdict=kw):
            return False
        if not self.check_tables_in_model((kw['src'],kw['tgt'])):
            return False
        if not self.check_column_in_table(kw['scol'], kw['src']):
            return False
        if not self.check_column_in_table(kw['tcol'], kw['tgt']):
            return False
        if not self.check_join_operator(kw['jo']):
            return False
        src = self.datamodel.tables[kw['src']]
        tgt = self.datamodel.tables[kw['tgt']]

        jt = _join_types[kw['jo']]
        op = lambda src, tgt : src[1][kw['scol']] == tgt[1][kw['tcol']]
        kw['resolver'] = ConditionBasedLinkResolver((src,tgt), op)
        kw['tables'] = (src, tgt)
        kw['jointype'] = jt
        return True

    def parse(self, string, **kw):
        self._errors = []
        if not self.parse_col2key(string, kw) and \
           not self.parse_col2col(string, kw):
            if not self.errors:
                self.errors.append('syntax error in expression for --link option')
            return False

        relation = '__rel_%.3d' % self._counter
        endnames = ('__l_%.3d' % self._counter, '__r__%.3d' % self._counter)
        link = Link(kw['tables'], endnames, resolver=kw['resolver'])
        if not self.check_relation(relation):
            return False

        self._jointypes[link] = kw['jointype']
        self.datamodel.relations[relation] = link
        self._counter += 1
        return True

class LinkCmd(cmd_.Cmd):

    __slots__ = ()

    @property
    def jointypes(self):
        return self._jointypes

    def add_arguments(self):
        argparser = self.argparser
        argparser.add_argument( "--link",
                                action='append',
                                metavar='src.scol (->|~>) tgt[.tcol]',
                                dest='links',
                                help="define link from table 'src' to 'tgt'; " + \
                                "'scol' is a column of 'src' used to match " + \
                                "values in column 'tcol' in 'tgt'; if 'tcol' " +\
                                "is absent, 'scol' is used to match keys " + \
                                "of 'tgt', '->' means 'INNER JOIN', " + \
                                "'~>' means 'LEFT JOIN'"  )



    def process_links_arg(self, datamodel, jointypes):
        parser = LinkArgParser(datamodel, jointypes)

        if self.arguments.links:
            for arg in self.arguments.links:
                if not parser.parse(arg):
                    for err in parser.errors:
                        sys.stderr.write("error: error processing --link option: %s\n" % err)
                    return False
        return True


    def run(self, datamodel, jointypes):
        return self.process_links_arg(datamodel, jointypes)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
