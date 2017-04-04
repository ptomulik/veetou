# -*- coding: utf8 -*-
"""`veetou.input.inputline_`

Provides the InputLine class
"""

from . import inputcontext_
from ..model import checkinstance

__all__ = ('InputLine',)

class InputLine(str):

    __slots__ = ('_context',)

    def __new__(cls, string = '', context = None):
        return super().__new__(cls, string)

    def __init__(self, string = '', context = None):
        if context is not None:
            self._context = checkinstance(context, inputcontext_.InputContext)
        else:
            self._context = None

    def context(self):
        return self._context

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
