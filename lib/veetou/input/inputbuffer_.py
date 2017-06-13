# -*- coding: utf8 -*-
"""`veetou.parser.inputbuffer_`

Provides the InputBuffer class
"""

from . import inputline_
from ..common import checkinstance
from ..model import List

__all__ = ('InputBuffer',)

class InputBuffer(List):

    __slots__ = ()

    def __wrap__(self, value):
        return checkinstance(value, inputline_.InputLine)


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
