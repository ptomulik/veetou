# -*- coding: utf8 -*-
"""`veetou.model.endpoint_`

Provides the Endpoint class
"""

from . import functions_
from . import relation_
from . import dict_
from . import list_
from . import reflist_
from . import pair_
import collections

__all__ = ('Endpoint', 'EndpointDict', 'EndpointList')

class Endpoint(object):
    """An endpoint of a relation"""

    __slots__ = ('_relation', '_side')

    def __init__(self, relation, side):
        super().__init__()
        self.relation = relation
        self.side = side

    @property
    def side(self):
        return self._side

    @side.setter
    def side(self, i):
        self._side = relation_.checkside(i)

    @property
    def relation(self):
        return self._relation

    @relation.setter
    def relation(self, rel):
        self._relation = functions_.checkinstance(rel, relation_.Relation)

    @property
    def opposite_side(self):
        return relation_.Relation.opposite_side(self.side)

    @property
    def opposite_table(self):
        return self.relation.opposite_table(self.side)

    def opposite_keys(self, key):
        return self.relation.opposite_keys(self.side, key)

    def opposite_entities(self, key):
        return self.relation.opposite_entities(self.side, key)

    def opposite_records(self, key):
        return self.relation.opposite_records(self.side, key)

    def pair(self, this_key, opposite_key):
        if self.side is relation_.LEFT:
            return pair_.Pair(this_key, opposite_key)
        else:
            return pair_.Pair(opposite_key, this_key)


    def __repr__(self):
        return "%s(relation=%s,side=%s)" % (
                functions_.modelname(self),
                functions_.modelrefstr(self.relation),
                ('LEFT','RIGHT')[self.side]
        )

class EndpointDict(dict_.Dict):

    __slots__ = ()

    @classmethod
    def __dictclass__(cls):
        return collections.OrderedDict

    def __wrap__(self, value):
        return functions_.checkinstance(value, Endpoint)

class EndpointList(list_.List):

    __slots__ = ()

    @classmethod
    def __listclass__(cls):
        return reflist_.RefList

    def __wrap__(self, value):
        return functions_.checkinstance(value, Endpoint)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
