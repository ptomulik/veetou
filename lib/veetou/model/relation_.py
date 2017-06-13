# -*- coding: utf8 -*-
"""`veetou.model.relation_`

Provides the Relation class
"""

from . import object_
from . import dict_
from . import functions_
from ..common import checkinstance
import abc

__all__ = ('LEFT', 'RIGHT', 'Relation', 'RelationDict')

LEFT  = 0
RIGHT = 1

def checkside(side):
    if side not in (LEFT, RIGHT):
        raise ValueError('%s is neither LEFT nor RIGHT' % repr(side))
    return side

class Relation(object_.Object, metaclass = abc.ABCMeta):
    """Abstract base class for a relation betwen tables"""

    __slots__ = ('_tables', '_endnames')

    def __init__(self, tables, endnames, register = True):
        super().__init__()
        self._set_tables(*tables)
        self._set_endnames(*endnames)
        if register: self.register_in_tables()

    def _set_tables(self, left, right):
        from . import table_ # imported here to avoid circular dependencies
        self._tables = (checkinstance(left, table_.Table),
                        checkinstance(right, table_.Table))

    def _set_endnames(self, left, right):
        left = checkinstance(left, str)
        right = checkinstance(right, str)
        self._endnames = (left,right)

    @property
    def tables(self):
        return self._tables

    @property
    def endnames(self):
        return self._endnames

    def register_in_table(self, side):
        from . import endpoint_ # must be here due to a circular dependency
        checkside(side)
        role = self.endnames[side]
        table = self.tables[side]
        if role and table is not None:
            table.relations[role] = endpoint_.Endpoint(self, side)

    def register_in_tables(self):
        for side in (LEFT, RIGHT):
            self.register_in_table(side)

    def unregister_from_table(self, side):
        checkside(side)
        table = self.tables[side]
        role = self.endnames[side]
        if role and table is not None:
            del table.relations[role]

    def unregister_from_tables(self):
        for side in (LEFT, RIGHT):
            self.unregister_from_table(side)

    @staticmethod
    def opposite_side(side):
        return checkside(side) ^ 1

    def opposite_table(self, side):
        opposite = Relation.opposite_side(side)
        return self.tables[opposite]

    @abc.abstractmethod
    def opposite_keys(self, side, key):
        """This may return iterator or generator object as well, not only sequence"""
        pass

    def opposite_entities(self, side, key):
        opposite = self.opposite_table(side)
        return map(lambda k : opposite[k], self.opposite_keys(side, key))

    def opposite_records(self, side, key):
        opposite = self.opposite_table(side)
        return map(lambda k : opposite.getrecord(k), self.opposite_keys(side, key))

    def __eq__(self, other):
        if isinstance(other, type(self)):
            return  self.tables[LEFT] is other.tables[LEFT] and \
                    self.tables[RIGHT] is other.tables[RIGHT] and \
                    self.endnames[LEFT] == other.endnames[LEFT] and \
                    self.endnames[RIGHT] == other.endnames[RIGHT]
        else:
            return False

    def __repr__(self):
        return "%s((%s,%s),(%s,%s))" % (
                functions_.modelname(self),
                functions_.modelrefstr(self.tables[LEFT]),
                functions_.modelrefstr(self.tables[RIGHT]),
                repr(self.endnames[LEFT]), repr(self.endnames[RIGHT])
        )

class RelationDict(dict_.Dict):
    def __wrap__(self,  value):
        return super().__wrap__(checkinstance(value, Relation))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
