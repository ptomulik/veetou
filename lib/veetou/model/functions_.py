# -*- coding: utf8 -*-
"""`veetou.model.functions_`

Provides model-related functions
"""

__all__ = ( 'arrayclass',
            'arraygen',
            'checkinstance',
            'checksubclass',
            'columniter',
            'datatype',
            'declare',
            'entityclass',
            'fielditer',
            'modelname',
            'modelrefstr',
            'recordclass',
            'recordgen',
            'safedelattr',
            'schemaname',
            'setdelattr',
            'snakecase',
            'tableclass',
            'tablename',
            'tupleclass',
            'tuplegen')

import re

def checksubclass(klass, base):
    if not isinstance(klass, type) or not issubclass(klass, base):
        raise TypeError('%s is not a subclass of %s' % (repr(klass), repr(base)))
    return klass

def checkinstance(obj, klass):
    if not isinstance(obj, klass):
        raise TypeError('%s is not an instance of %s' % (repr(obj), repr(klass)))
    return obj

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

def declare(base, *args, **kw):
    return base.__declare__(*args, **kw)

def modelname(obj):
    if hasattr(obj,'__modelname__'):
        return obj.__modelname__()
    elif isinstance(obj,type):
        return obj.__name__
    else:
        return type(obj).__name__

def schemaname(obj):
    if hasattr(obj, '__schemaname__'):
        return obj.__schemaname__()
    else:
        return modelname(obj)

def modelrefstr(obj):
    if isinstance(obj,type):
        return modelname(obj)
    else:
        return "<%s object at 0x%x>" % (modelname(obj), id(obj))

def arrayclass(obj):
    return obj.__arrayclass__()

def tupleclass(obj):
    return obj.__tupleclass__()

def entityclass(obj):
    return obj.__entityclass__()

def recordclass(obj):
    return obj.__recordclass__()

def tableclass(obj):
    return obj.__tableclass__()

def tablename(obj):
    return obj.__tablename__()

def datatype(obj):
    return obj.__datatype__()

def arraygen(obj,*args,**kw):
    return obj.__arraygen__(*args,**kw)

def tuplegen(obj):
    return obj.__tuplegen__()

def recordgen(obj):
    return obj.__recordgen__()

def columniter(obj):
    return obj.__columniter__()

def fielditer(obj):
    return obj.__fielditer__()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
