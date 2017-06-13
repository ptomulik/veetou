# -*- coding: utf8 -*-
"""`veetou.parser.inputiterator_`

Provides the BufferedIterator class
"""

from . import inputbuffer_
from . import inputiterator_
from ..common import checkinstance

__all__ = ('BufferedIterator', 'BufferedIteratorState')

class BufferedIteratorState(object):
    def __init__(self, iterator):
        checkinstance(iterator, BufferedIterator)
        self._index = iterator._index
        self._iterator = iterator

    def __eq__(self, other):
        if isinstance(other, type(self)):
            return (self._iterator is other._iterator) and self._index == other._index
        else:
            return False

class BufferedIterator(inputiterator_.InputIterator):
    """Input iterator with internal buffering.

    Whilst typical Python iterator is a single-pass iterator, the
    BufferedIterator may be reverted to a previous position allowing for
    multi-pass traversal ."""

    __slots__ = ('_input', '_buffer', '_index')

    def __init__(self, input):
        self._input = checkinstance(input, inputiterator_.InputIterator)
        self._buffer = inputbuffer_.InputBuffer()
        self._index = 0

    def __next__(self):
        if self._index in range(0,len(self._buffer)):
            item = self._buffer[self._index]
        else:
            item = next(self._input)
            self._buffer.append(item)
        self._index += 1
        return item

    def __enter__(self):
        self._input.__enter__()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        return self._input.__exit__(exc_type, exc_val, exc_tb)

    def loc(self):
        if self._index in range(0,len(self._buffer)):
            ctx = self._buffer[self._index].loc()
        else:
            ctx = self._input.loc()
        return ctx

    def rewind(self):
        """Rewind iterator to the begining of buffer"""
        self._index = 0
        return self

    def clear(self):
        self._buffer.clear()
        self._index = 0

    def drop(self):
        """Delete this part of buffer which is prior to current position"""
        del self._buffer[:self._index]
        self.rewind()

    def state(self):
        return BufferedIteratorState(self)

    def restore(self, state):
        checkinstance(state, BufferedIteratorState)
        if state._iterator is not self:
            raise RuntimeError("can't use state of other instance")
        if state._index < 0 or state._index > len(self._buffer):
            raise IndexError('index out of range')
        self._index = state._index
        return self

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
