# -*- coding: utf8 -*-
"""`veetou.model.tuple_`

Provides the Tuple class
"""

import collections.abc

__all__ = ('Tuple',)

class Tuple(collections.abc.Sequence):
    """This works almost same way as the built-in tuple, except that:

       - the expression ``"%r" % Tuple([1,2])`` does not raise an error
         (whereas we know that ``"%r" % (1,2)`` would throw
         ``TypeError: not all arguments converted during string formatting``,
    """

    __slots__ = ('_data')

    """Wrapped tuple, may be used for further subclassing"""
    def __init__(self, values = ()):
        self._data = tuple(values)
        super().__init__()

    def __len__(self):
        return len(self._data)

    def __getitem__(self, i):
        if isinstance(i, slice):
            return Tuple(self._data[i])
        else:
            return self._data[i]

    def __eq__(self, other):
        if isinstance(other, Tuple):
            return self._data == other._data
        else:
            return self._data == other

    def __lt__(self, other):
        if isinstance(other, Tuple):
            return self._data < other._data
        else:
            return self._data < other

    def __gt__(self, other):
        if isinstance(other, Tuple):
            return self._data > other._data
        else:
            return self._data > other

    def __le__(self, other):
        if isinstance(other, Tuple):
            return self._data <= other._data
        else:
            return self._data <= other

    def __ge__(self, other):
        if isinstance(other, Tuple):
            return self._data >= other._data
        else:
            return self._data >= other

    def __hash__(self):
        return hash(self._data)

    def __repr__(self):
        return '%s([%s])' % (self.__class__.__name__, ','.join([repr(k) for k in self._data]))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
