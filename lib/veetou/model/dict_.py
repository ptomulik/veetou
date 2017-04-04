# -*- coding: utf8 -*-
"""`veetou.model.dict_`

Provides the Dict class
"""

from . import functions_
import collections.abc

__all__ = ('Dict',)

class Dict(collections.abc.MutableMapping):
    """Like a normal dict, but provides some extra possibilities

    Key poitns:
        - __dictclass__ method may be overriden in a subclass to return a class
          that will be used as underlying dictionary storage,
        - ``__wrap__`` and ``__unwrap__`` methods may be overriden in a
          subclass to transform any value that enters/leaves Dict,
        - ``__keywrap__`` and ``__keyunwrap__`` methods may be overriden in a
          subclass to transform any key that enters/leaves Dict.
    """

    __slots__ = ('_data')

    @classmethod
    def __dictclass__(cls):
        return dict

    def __wrap__(self, value):
        return value

    def __unwrap__(self, value):
        return value

    def __keywrap__(self, key):
        return key

    def __keyunwrap__(self, key):
        return key

    def __init__(self, items = ()):
        super().__init__()
        self._data = (self.__dictclass__())()
        self.update(items)

    def __getitem__(self, key):
        return self.__unwrap__(self._data[self.__keywrap__(key)])

    def __setitem__(self, key, value):
        self._data[self.__keywrap__(key)] = self.__wrap__(value)

    def __delitem__(self, key):
        del self._data[self.__keywrap__(key)]

    def __iter__(self):
        for k in iter(self._data):
            yield self.__keyunwrap__(k)

    def __len__(self):
        return len(self._data)

    def setdefault(self, key, default):
        k = self.__keywrap__(key)
        try:
            return self[k]
        except KeyError:
            self[key] = default
            return self[key]

    def __repr__(self):
        return "%s(%s)" % (functions_.modelname(self), repr(dict(self.items())))


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
