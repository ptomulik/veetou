# -*- coding: utf8 -*-
"""`veetou.model.type_`

Provides the Type class
"""

import re
from . import functions_

__all__ = ('Type',)

class Type(object):
    """TODO: write documentation"""

    __slots__ = ()

    @classmethod
    def kwattr(cls):
        return (('module','__module__'),)

    @classmethod
    def __declare__(cls, *args, **kw):
        if len(args) != 3:
            raise TypeError('__declare__() takes exactly 3 positional arguments (%d given)' % len(args))
        name, bases, attributes = args
        _dict = { k2: kw[k1] for k1,k2 in cls.kwattr() if k1 in kw }
        _dict.update(attributes)
        return type(name, bases, _dict)



# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
