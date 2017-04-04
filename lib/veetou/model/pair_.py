# -*- coding: utf8 -*-
"""`veetou.model.pair_`

Provides the Pair class
"""

from . import tuple_
from . import list_
from . import functions_

__all__ = ('Pair','PairList')

class Pair(tuple_.Tuple):
    """Holds a pair of elements named left and right"""

    __slots__ = ()

    def __init__(self, left, right):
        super().__init__((left,right))

    @property
    def left(self):
        return self[0]

    @property
    def right(self):
        return self[1]

    def __repr__(self):
        return "%s(%s)" % (type(self).__name__, ','.join([repr(x) for x in self]))

class PairList(list_.List):

    __slots__ = ()

    def __wrap__(self, value):
        return functions_.checkinstance(value, Pair)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
