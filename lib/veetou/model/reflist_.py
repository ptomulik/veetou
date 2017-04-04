# -*- coding: utf8 -*-
"""`veetou.model.reflist_`

Provides the RefList class
"""

from . import ref_
from . import list_
import collections.abc
import itertools

__all__ = ('RefList',)

class RefList(list_.List):
    """Same as List, but wraps the stored objects with Ref"""

    __slots__ = ()

    def __wrap__(self, value):
        return value if isinstance(value, ref_.Ref) else ref_.Ref(value)

    def __unwrap__(self, value):
        return value.obj


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
