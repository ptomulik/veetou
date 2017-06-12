# -*- coding: utf8 -*-
"""`veetou.input.inputline_`

Provides the InputLine class
"""

from . import inputloc_
from ..model import checkinstance

__all__ = ('InputLine',)

class InputLine(str):

    __slots__ = ('_loc',)

    def __new__(cls, string = '', loc = None):
        return super().__new__(cls, string)

    def __init__(self, string = '', loc = None):
        if loc is not None:
            self._loc = checkinstance(loc, inputloc_.InputLoc)
        else:
            self._loc = None

    def loc(self):
        return self._loc

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
