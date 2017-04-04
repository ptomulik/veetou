# -*- coding: utf8 -*-
"""`veetou.model.mapset_`

Provides the Mapset class
"""

from . import set_
from . import dict_

__all__ = ('Mapset',)

class Mapset(dict_.Dict):
    """Like Dict, but saves space for values that repeat.

    Key poitns:
        - only works with hashable values (immutable, like our Tuple),
        - if a value is inserted multiple times (under different keys),
          only one copy will be keept in memory for Mapset,
        - the occurence count of a given value (under different keys) is
          recorded in Mapset and is returned by the ``count()`` method.
    """

    __slots__ = ('_set',)

    def __init__(self, items = ()):
        super().__init__()
        self._set  = set_.Set() # we rely on a special feature of our Set
        self.update(items)

    def __setitem__(self, key, value):
        key = self.__keywrap__(key)
        try:
            old = self._data[key]
        except KeyError:
            self._data[key] = self._set.add(self.__wrap__(value))
        else:
            self._data[key] = self._set.add(self.__wrap__(value))
            self._set.dec(old)

    def __delitem__(self, key):
        value = self._data[self.__keywrap__(key)]
        super().__delitem__(key)
        self._set.dec(value)

    def count(self, value):
        return self._set.count(self.__wrap__(value))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
