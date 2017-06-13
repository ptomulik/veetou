# -*- coding: utf8 -*-
"""`veetou.model.link_`

Provides the Link class
"""

from . import relation_
from . import linkresolver_
from ..common import checkinstance

__all__ = ('SOURCE', 'TARGET', 'Link')

SOURCE = relation_.LEFT
TARGET = relation_.RIGHT

class Link(relation_.Relation):
    """Represents a link from one table to another. A special kind of relation,
    which is inherently unidirectional (the opposite relation may be found,
    but it involves lookup algorithm which is very costly."""

    __slots__ = ('_resolver',)

    def __init__(self, tables, endnames, register = True, resolver=None, column=None):
        super().__init__(tables, endnames, register)
        if resolver is not None:
            self._resolver = checkinstance(resolver, linkresolver_.LinkResolver)
        elif column is not None:
            self._resolver = linkresolver_.SourceColumnBasedLinkResolver(self.source_table, column)
        else:
            msg = 'missing one of alternative arguments: column, resolver'
            raise TypeError(msg)

    @property
    def source_table(self):
        return self.tables[SOURCE]

    @property
    def target_table(self):
        return self.tables[TARGET]

    def opposite_keys(self, side, key):
        if side == SOURCE:
            return filter(lambda k : k in self.target_table, self._resolver(key))
        else:
            if key in self.target_table:
                return map(lambda x : x[0], filter(lambda x : (key in self._resolver(x[0])), self.source_table.items()))
            else:
                return []

    def __eq__(self, other):
        if isinstance(other, Link):
            return super().__eq__(other) and self._resolver == other._resolver

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
