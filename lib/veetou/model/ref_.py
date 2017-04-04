# -*- coding: utf8 -*-
"""`veetou.model.ref_`

Provides the Ref class
"""

__all__ = ('Ref',)

class Ref(object):
    """A wrapper which compares by reference"""

    __slots__ = ('_obj',)

    def __init__(self, obj):
        self._obj = obj

    @property
    def obj(self):
        return self._obj

    def __hash__(self):
        return id(self.obj)

    def __eq__(self, other):
        if isinstance(other, Ref):
            return id(self.obj) == id(other.obj)
        else:
            return id(self.obj) == id(other)

    def __ne__(self, other):
        if isinstance(other, Ref):
            return id(self.obj) != id(other.obj)
        else:
            return id(self.obj) != id(other)

    def __lt__(self, other):
        if isinstance(other, Ref):
            return id(self.obj) < id(other.obj)
        else:
            return id(self.obj) < id(other)

    def __gt__(self, other):
        if isinstance(other, Ref):
            return id(self.obj) > id(other.obj)
        else:
            return id(self.obj) > id(other)

    def __le__(self, other):
        if isinstance(other, Ref):
            return id(self.obj) <= id(other.obj)
        else:
            return id(self.obj) <= id(other)

    def __ge__(self, other):
        if isinstance(other, Ref):
            return id(self.obj) >= id(other.obj)
        else:
            return id(self.obj) >= id(other)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
