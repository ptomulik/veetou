# -*- coding: utf8 -*-
"""`veetou.model.list_`

Provides the List class
"""

from . import functions_
import collections.abc
import itertools

__all__ = ('List',)

class List(collections.abc.MutableSequence):
    """Same as list, but provides following features

        - a subclass may override ``__wrap__()`` and ``__unwrap__()`` to perfom
          transformations on values entering/leaving the List.
        - a subclass may override ``__listclass__()`` method to change the type
          of underlying list used for storage.
    """

    __slots__ = ('_data')

    @classmethod
    def __listclass__(cls):
        return list

    def __init__(self, items = ()):
        super().__init__()
        self._data = (self.__listclass__())()
        self[:] = items

    def __wrap__(self, value):
        return value

    def __unwrap__(self, value):
        return value

    def __getitem__(self, index):
        if isinstance(index, slice):
            it = itertools.islice(self._data, index.start, index.stop, index.step)
            return self.__class__(it)
        else:
            return self.__unwrap__(self._data[index])

    def __setitem__(self, index, value):
        if isinstance(index, slice):
            self._data[index] = map(self.__wrap__, value)
        else:
            self._data[index] = self.__wrap__(value)

    def __delitem__(self, index):
        del self._data[index]

    def __len__(self):
        return len(self._data)

    def clear(self):
        self._data.clear()

    def insert(self, index, value):
        self._data.insert(index, self.__wrap__(value))

    def append(self, value):
        self._data.append(self.__wrap__(value))

    def reverse(self):
        self._data.reverse()

    def extend(self, values):
        self._data.extend(map(self.__wrap__, values))

    def pop(self):
        return self.__unwrap__(self._data.pop())

    def remove(self, value):
        self._data.remove(self.__wrap__(value))

    def __contains__(self, value):
        return self.__wrap__(value) in self._data

    def count(self, value):
        return self._data.count(self.__wrap__(value))

    def __eq__(self, other):
        if isinstance(other, type(self)):
            return self._data == other._data
        else:
            return self._data == other

    def __ne__(self, other):
        if isinstance(other, type(self)):
            return self._data != other._data
        else:
            return self._data != other

    def __lt__(self, other):
        if isinstance(other, type(self)):
            return self._data < other._data
        else:
            return self._data < other

    def __le__(self, other):
        if isinstance(other, type(self)):
            return self._data <= other._data
        else:
            return self._data <= other

    def __gt__(self, other):
        if isinstance(other, type(self)):
            return self._data > other._data
        else:
            return self._data > other

    def __ge__(self, other):
        if isinstance(other, type(self)):
            return self._data >= other._data
        else:
            return self._data >= other

    def __repr__(self):
        return "%s([%s])" % (functions_.modelname(self), ','.join(repr(x) for x in self))


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
