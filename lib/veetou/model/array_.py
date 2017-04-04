# -*- coding: utf8 -*-
"""`veetou.model.array_`

Provides the Array class
"""

import collections.abc

__all__ = ('Array',)

class Array(collections.abc.MutableSequence):
    """Constant size list (like a Tuple, but with mutable values)"""

    __slots__ = ('_data')

    def __init__(self, values = ()):
        self._data = list(values)
        super().__init__()

    def __len__(self):
        return len(self._data)

    def __getitem__(self, i):
        if isinstance(i, slice):
            return Array(self._data[i])
        else:
            return self._data[i]

    def __setitem__(self, i, value):
        if isinstance(i, slice):
            k = 0
            for j in range(len(self))[i]:
                self._data[j] = value[k]
                k += 1
        else:
            self._data[i] = value

    @property
    def __delitem__(self):
        raise AttributeError

    @property
    def insert(self):
        raise AttributeError

    @property
    def append(self):
        raise AttributeError

    @property
    def extend(self):
        raise AttributeError

    @property
    def pop(self):
        raise AttributeError

    @property
    def remove(self):
        raise AttributeError

    @property
    def __iadd__(self):
        raise AttributeError

    def __eq__(self, other):
        if isinstance(other, Array):
            return self._data == other._data
        else:
            return self._data == other

    def __lt__(self, other):
        if isinstance(other, Array):
            return self._data < other._data
        else:
            return self._data < other

    def __gt__(self, other):
        if isinstance(other, Array):
            return self._data > other._data
        else:
            return self._data > other

    def __le__(self, other):
        if isinstance(other, Array):
            return self._data <= other._data
        else:
            return self._data <= other

    def __ge__(self, other):
        if isinstance(other, Array):
            return self._data >= other._data
        else:
            return self._data >= other

    def __repr__(self):
        return '%s([%s])' % (self.__class__.__name__, ','.join([repr(k) for k in self._data]))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
