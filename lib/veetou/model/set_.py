# -*- coding: utf8 -*-
"""`veetou.model.entities_`

Provides the Set class
"""

from . import functions_
import collections.abc
import abc

__all__ = ('Set',)

class Set(collections.abc.MutableSet):
    """A set of unique items stored as references (but key-compared by value).
    This set also counts how many times given value was added."""

    __slots__ = ('_data', '_counts')

    def __init__(self, items = ()):
        self._data = dict()
        self._counts = dict()
        for item in items: self.add(item)

    def __contains__(self, item):
        return item in self._data

    def __iter__(self):
        return iter(self._data)

    def __len__(self):
        return len(self._data)

    def add(self, item):
        try:
            item = self._data[item]
        except KeyError:
            self._data[item] = item
            self._counts[item] = 1
        else:
            self._counts[item] += 1
        return item

    def inc(self, item):
        try:
            n = self._counts[item] + 1
        except KeyError:
            n = 1
            self._data[item] = item
        self._counts[item] = n
        return n

    def dec(self, item):
        self._counts[item] -= 1
        n = self._counts[item]
        if n < 1:
            del self._data[item]
        return n

    def discard(self, item):
        if item in self:
            del self._data[item]
            del self._counts[item]

    def __getitem__(self, item):
        return self._data[item]

    def get(self, item, default = None):
        return self[item] if item in self else default

    def count(self, item):
        return self._counts.get(item, 0)

    def clear(self):
        self._data.clear()
        self._counts.clear()

    def __repr__(self):
        return "%s([%s])" % (functions_.modelname(self), ','.join(repr(x) for x in self))


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
