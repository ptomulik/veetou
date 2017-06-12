# -*- coding: utf8 -*-
"""`veetou.parser.parsererror_`

Provides the ParserError and ParserWarning classes
"""

from ..input import inputline_
from ..input import inputiterator_
from ..input import bufferediterator_
from ..input import inputloc_
from ..model.functions_ import checkinstance

import abc

__all__ = ('ParserError', 'ParserWarning')

class ParserError(object, metaclass=abc.ABCMeta):

    __slots__ = ('_loc', '_description', '_lines')

    def __init__(self, at, description, lines = None):
        if isinstance(at, (inputiterator_.InputIterator, inputline_.InputLine)):
            loc = at.loc()
        else:
            loc = at
        self._loc = checkinstance(loc, inputloc_.InputLoc)

        self._description = description

        if lines is None:
            if isinstance(at, str):
                lines = (at, )
            elif isinstance(at, bufferediterator_.BufferedIterator):
                tmp = at.state()
                try:
                    s = next(at)
                except StopIteration:
                    s = '(end of input)'
                finally:
                    at.restore(tmp)
                lines = (s,)
        if isinstance(lines, str):
            lines = (lines,)
        self._lines = tuple(lines)

    @abc.abstractmethod
    def category(self):
        pass

    @property
    def lines(self):
        return self._lines

    @property
    def description(self):
        return self._description

    def loc(self):
        return self._loc

    def message(self):
        return "%s: %s: %s" % (self.loc().__log__(), self.category(), self.description)

    def __log__(self):
        return self.message()

    def category(self):
        return "error"

class ParserWarning(ParserError):
    def category(self):
        return "warning"

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
