# -*- coding: utf8 -*-
"""`veetou.model.keystuple_`

Provides the KeysTuple class
"""

from . import tuple_

__all__ = ('KeysTuple',)

class KeysTuple(tuple_.Tuple):
    def __init__(self, keys = ()):
        if len(keys) != len(set(keys)):
            raise ValueError("key names must be unique")
        super().__init__(keys)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
