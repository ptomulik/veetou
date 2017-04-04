# -*- coding: utf8 -*-
"""`veetou.input.inputlines_`

Provides the InputLines class
"""

from . import inputiterator_
from . import inputline_
from . import inputcontext_
from ..model import checkinstance

import io

__all__ = ('InputLines', )

class InputLines(inputiterator_.InputIterator):
    """Iterates over lines of a text stream yielding instances of InputLine"""

    __slots__ = ('_counter', '_input')

    def __init__(self, input):
        self._counter = 0
        self._input = checkinstance(input, io.IOBase)

    def __next__(self):
        line = self.__wrap__( next(self._input) )
        self._counter += 1
        return line

    def __enter__(self):
        self._input.__enter__()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        return self._input.__exit__(exc_type, exc_val, exc_tb)

    def __wrap__(self, string):
        return inputline_.InputLine(string.rstrip('\n'), self.context())

    @property
    def name(self):
        input = self._input
        try:
            return input.name
        except AttributeError:
            return repr(input)

    @property
    def line(self):
        return self._counter + 1

    def context(self):
        return inputcontext_.InputContext(self.name, self.line)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
