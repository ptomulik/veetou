# -*- coding: utf8 -*-
"""`veetou.model.join_`

Provides the InnerJoin class
"""

from . import functions_
from . import table_
from . import record_
from . import dict_
from . import ref_
from . import endpoint_
from . import relation_
from ..common import checkinstance

import collections.abc

__all__ = ('Join', 'JoinTypeDict', 'INNER_JOIN', 'LEFT_JOIN', 'RIGHT_JOIN', 'OUTER_JOIN')


# Join types
INNER_JOIN = 0
LEFT_JOIN = 1
RIGHT_JOIN = 2
OUTER_JOIN = 3

class JoinTypeDict(dict_.Dict):
    """A dictionary with relations (junctions/links) mapped to join types.

    So it may be something like:

        {
            rel1 : INNER_JOIN,
            rel2 : LEFT_JOIN,
            link1 : INNER_JOIN,
        }

    The keys are compared by identity (with "is" operator, not "==").
    """
    def __keywrap__(self, key):
        if isinstance(key, ref_.Ref):
            return key
        else:
            return ref_.Ref(checkinstance(key, relation_.Relation))

    def __keyunwrap__(self, key):
        return key.obj

    def __wrap__(self, value):
        if value not in (INNER_JOIN, LEFT_JOIN, RIGHT_JOIN, OUTER_JOIN):
            raise ValueError('invalid join type %s' % repr(value))
        return value

class Join(collections.abc.Iterator):

    __slots__ = ('_root', '_default_jointype', '_jointypes', '_tables', '_endpoints', '_sources')

    @property
    def root(self):
        return self._root

    @root.setter
    def root(self, r):
        self._root = checkinstance(r, table_.Table)
        self._determine_path(r)

    @property
    def tables(self):
        return self._tables

    @property
    def endpoints(self):
        return self._endpoints

    @property
    def sources(self):
        return self._sources

    @property
    def default_jointype(self):
        return self._default_jointype

    @default_jointype.setter
    def default_jointype(self, value):
        if value not in (INNER_JOIN, LEFT_JOIN, RIGHT_JOIN, OUTER_JOIN):
            raise ValueError('invalid join type %s' % repr(value))
        self._default_jointype = value

    @property
    def jointypes(self):
        return self._jointypes

    def jointype_for(self, relation):
        return self.jointypes.get(relation, self.default_jointype)

    def __init__(self, root = None, **kw):
        super().__init__()
        if root is not None:
            self.root = root
        self.default_jointype = kw.get('jointype', INNER_JOIN)
        self._jointypes = JoinTypeDict(kw.get('jointypes', ()))

    def __next__(self):
        yield from self.rows()

    def _determine_further_path(self, table):
        source = len(self._tables)
        self._tables.append(table)
        for name, endpoint in table.relations.items():
            if endpoint not in self._endpoints and endpoint.opposite_table not in self.tables:
                self._sources.append(source)
                self._endpoints.append(endpoint)
                self._determine_further_path(endpoint.opposite_table)

    def _determine_path(self, root):
        self._tables = table_.TableList()
        self._endpoints = endpoint_.EndpointList()
        self._sources = list()
        self._determine_further_path(root)

    def rows(self, root = None):
        if root is not None:
            self.root = root
        keystack = len(self.tables) * [None]
        if len(keystack) > 0:
            keys = map(lambda x : x[0], self.tables[0].items())
            yield from self._rows_from_table(keystack, 0, keys)

    def _make_row_sequence(self, keystack):
        rs = []
        for i in range(len(keystack)):
            if keystack[i] is not None:
                rs.append(self.tables[i].getrecord(keystack[i]))
            else:
                record = functions_.recordclass(self.tables[i])
                entity = functions_.entityclass(self.tables[i])
                rs.append(record(entity(),self.tables[i]))
        return record_.RecordSequence(rs)


    def _rows_from_table(self, keystack, depth, keys, left_join=False):
        counter = 0
        if depth+1 == len(keystack):
            for key in keys:
                keystack[depth] = key
                yield self._make_row_sequence(keystack)
                counter += 1
            if left_join and not counter:
                keystack[depth] = None
                yield self._make_row_sequence(keystack)
        else:
            for key in keys:
                keystack[depth] = key
                yield from self._rows_from_joint_tables(keystack, depth)
                counter += 1
            if left_join and not counter:
                keystack[depth] = None
                yield from self._rows_from_joint_tables(keystack, depth)

    def _rows_from_joint_tables(self, keystack, depth):
        src = keystack[ self.sources[depth] ]
        endpoint = self._endpoints[depth]
        keys = endpoint.opposite_keys(src)
        jointype = self.jointype_for(endpoint.relation)
        if jointype == INNER_JOIN:
            yield from self._rows_from_table(keystack, depth+1, keys)
        elif jointype == LEFT_JOIN:
            yield from self._rows_from_table(keystack, depth+1, keys, left_join=True)
        else:
            if jointype <= OUTER_JOIN:
                jts = ('INNER_JOIN', 'LEFT_JOIN', 'RIGHT_JOIN', 'OUTER_JOIN')[jointype]
            else:
                jts = repr(jointype)
            raise NotImplementedError('join type %s is not implemented' % jts)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
