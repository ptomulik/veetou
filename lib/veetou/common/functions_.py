# -*- coding: utf8 -*-
"""`veetou.model.functions_`

Provides general-purpose functions
"""

__all__ = ( 'checkinstance',
            'checksubclass',
            'logstr',
            'safedelattr',
            'setdelattr',
            'snakecase' )

import re

def checkinstance(obj, klass):
    if not isinstance(obj, klass):
        raise TypeError('%s is not an instance of %s' % (repr(obj), repr(klass)))
    return obj

def checksubclass(klass, base):
    if not isinstance(klass, type) or not issubclass(klass, base):
        raise TypeError('%s is not a subclass of %s' % (repr(klass), repr(base)))
    return klass

def logstr(obj):
    return obj.__logstr__()

def safedelattr(obj, attr):
    try:
        delattr(obj, attr)
    except AttributeError:
        pass

def setdelattr(obj, attr, value = None, checkfun = lambda x : x):
    if value is None:
        safedelattr(obj, attr)
    else:
        setattr(obj, attr, checkfun(value))

def snakecase(s):
  return re.sub(r'([a-z])([A-Z])', r'\1_\2', s).lower()


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
