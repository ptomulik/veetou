# -*- coding: utf8 -*-
"""`veetou.model.datamodel_`

Provides the DataModel class
"""

from . import table_
from . import relation_

__all__ = ('DataModel', )

class DataModel(object):

    __slots__ = ('_tables', '_relations')

    def __init__(self, tables = (), relations = ()):
        self._tables = table_.TableDict(tables)
        self._relations = relation_.RelationDict(relations)

    def __getattr__(self, name):
        if len(name) > 4:
            if name.startswith('tab_'):
                if name[4:] in self.tables:
                    return self.tables[name[4:]]
            elif name.startswith('rel_'):
                if name[4:] in self.relations:
                    return self.relations[name[4:]]
        raise AttributeError('%s object has no attribute %s' % (repr(self.__class__.__name__), name))

    @property
    def tables(self):
        return self._tables

    @property
    def relations(self):
        return self._relations

    @property
    def prefix(self):
        return ''

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
