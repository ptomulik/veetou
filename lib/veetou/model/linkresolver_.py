# -*- coding: utf8 -*-
"""`veetou.model.linkresolver_`

Provides the LinkResolver class
"""

from . import functions_
import abc

__all__ = ( 'LinkResolver',
            'SourceTableBasedLinkResolver',
            'SourceColumnBasedLinkResolver',
            'ConditionBasedLinkResolver' )

class LinkResolver(object, metaclass = abc.ABCMeta):
    """A callable object which takes a source key as input and returns sequence
    of values that pressumably are keys to target table. The resolver may be
    quite dumb, meaning it may return keys that do not exist in target table
    (they will be filtered out in Link object)"""

    __slots__ = ()

    @abc.abstractmethod
    def __call__(self, key):
        pass

    @abc.abstractmethod
    def __eq__(self, other):
        pass

class SourceTableBasedLinkResolver(LinkResolver):

    __slots__ = ('_source_table',)

    def __init__(self, source_table):
        from . import table_ # placed here due to circular dependency
        self._source_table = functions_.checkinstance(source_table, table_.Table)

    def __call__(self, key):
        return self.foreign_keys((key, self._source_table[key]))

    @abc.abstractmethod
    def foreign_keys(self, item):
        pass

class ConditionBasedLinkResolver(LinkResolver):
    """Base class for more generic relations, where source key/entity is
    matched against records from target table"""

    __slots__ = ('_tables', '_cond')

    def __init__(self, tables, cond):
        from . import table_ # placed here due to circular dependency
        self._tables = tuple(functions_.checkinstance(t, table_.Table) for t in tables)
        self._cond = cond

    @property
    def source_table(self):
        from . import link_ # placed here due to circular dependency
        return self._tables[link_.SOURCE]

    @property
    def target_table(self):
        from . import link_ # placed here due to circular dependency
        return self._tables[link_.TARGET]

    def __call__(self, key):
        si = (key, self.source_table[key])
        cond = lambda ti: self._cond(si, ti)
        return map(lambda ti: ti[0], filter(cond, self.target_table.items()))

    def __eq__(self, key):
        if isinstance(other, type(self)):
            return self.source_table is other.source_table and \
                   self.target_table is other.target_table and \
                   self._cond is other._cond
        else:
            return False

class SourceColumnBasedLinkResolver(SourceTableBasedLinkResolver):
    """Simple relation where a column in source table holds foreign keys"""

    __slots__ = ('_index',)

    def __init__(self, source_table, column):
        super().__init__(source_table)
        self._index = functions_.entityclass(source_table).keyindex(column)

    def foreign_keys(self, item):
        key, entity = item
        return (entity[self._index],)

    def __eq__(self, other):
        if isinstance(other, type(self)):
            return self._source_table is other._source_table and \
                   self._index == other._index
        else:
            return False

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
