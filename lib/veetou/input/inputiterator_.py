# -*- coding: utf8 -*-
"""`veetou.input.inputiterator_`

Provides the InputIterator class
"""

import collections.abc
import abc

__all__ = ('InputIterator', )

class InputIterator(collections.abc.Iterator):
    """Base class for input iterators.

    In addition to plain iterator, it provides `loc()` method, which
    returns `InputLoc` object describing current position within the input.
    This is useful for syntax error reporting."""

    __slots__ = ()

    @abc.abstractmethod
    def loc(self):
        pass



# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
