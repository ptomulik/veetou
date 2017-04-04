# -*- coding: utf8 -*-
"""`veetou.model.datatype_`

Provides the DataType class
"""

__all__ = ('DataType', )

from . import entity_
from . import namedtuple_
from . import namedarray_
from . import record_
from . import table_
from . import functions_

class DataType(object):

    __slots__ = ('_entityclass', '_tableclass', '_recordclass', '_arrayclass',
                 '_tupleclass')

    def __init__(self, entity = None, table = None, record = None, namedtuple = None, namedarray = None):
        super().__init__()
        self.entityclass = entity
        self.tableclass = table
        self.recordclass = record
        self.tupleclass = namedtuple
        self.arrayclass = namedarray

    @property
    def entityclass(self):
        return self._entityclass
    @property
    def tableclass(self):
        return self._tableclass
    @property
    def recordclass(self):
        return self._recordclass
    @property
    def arrayclass(self):
        return self._arrayclass
    @property
    def tupleclass(self):
        return self._tupleclass

    @entityclass.setter
    def entityclass(self,  klass):
        checker = lambda x : functions_.checksubclass(x, entity_.Entity)
        functions_.setdelattr(self, '_entityclass', klass, checker)

    @tableclass.setter
    def tableclass(self,  klass):
        checker = lambda x : functions_.checksubclass(x, table_.Table)
        functions_.setdelattr(self, '_tableclass', klass, checker)

    @recordclass.setter
    def recordclass(self,  klass):
        checker = lambda x : functions_.checksubclass(x, record_.Record)
        functions_.setdelattr(self, '_recordclass', klass, checker)

    @arrayclass.setter
    def arrayclass(self,  klass):
        checker = lambda x : functions_.checksubclass(x, namedarray_.NamedArray)
        functions_.setdelattr(self, '_arrayclass', klass, checker)

    @tupleclass.setter
    def tupleclass(self,  klass):
        checker = lambda x : functions_.checksubclass(x, namedtuple_.NamedTuple)
        functions_.setdelattr(self, '_tupleclass', klass, checker)

    def __entityclass__(self):
        return self.entityclass
    def __recordclass__(self):
        return self.recordclass
    def __tableclass__(self):
        return self.tableclass
    def __arrayclass__(self):
        return self.arrayclass
    def __tupleclass__(self):
        return self.tupleclass

    @classmethod
    def __declare__(cls, name = "", keys = (), types = None, validate = None, **kw):
        def append(s):
            return lambda x : x + s if x else x

        def getordeclare(what, *args):
            try:
                return kw[what + 'class']
            except KeyError:
                fwd = ('module',)
                kw2 = { k : kw[k] for k in fwd if k in kw }
                kw2.update(kw.get(what + 'args', dict()))
                return functions_.declare(*args, **kw2)

        plural = kw.get('plural')
        entityname = kw.get('entityname', name)
        recordname = kw.get('recordname', append('Record')(name))
        tablename  = kw.get('tablename', plural or append('Table')(name))
        tuplename  = kw.get('tuplename', append('Tuple')(name))
        arrayname  = kw.get('arrayname', append('Array')(name))

        entity = getordeclare('entity', entity_.Entity, entityname, keys, types, validate)
        record = getordeclare('record', record_.Record, recordname)
        table  = getordeclare('table', table_.Table, tablename)
        tuple  = getordeclare('tuple', namedtuple_.NamedTuple, tuplename, keys)
        array  = getordeclare('array', namedarray_.NamedArray, arrayname, keys)

        dt = cls(entity, table, record, tuple, array)

        if hasattr(dt, 'entityclass'): dt.entityclass.datatype = dt
        if hasattr(dt, 'tableclass'): dt.tableclass.datatype = dt
        if hasattr(dt, 'recordclass'): dt.recordclass.datatype = dt
        if hasattr(dt, 'tupleclass'): dt.tupleclass.datatype = dt
        if hasattr(dt, 'arrayclass'): dt.arrayclass.datatype = dt

        return dt

    def newentity(self,*args,**kw):
        return self.entityclass(*args,**kw)
    def newtable(self,*args,**kw):
        return self.tableclass(*args,**kw)
    def newrecord(self,*args,**kw):
        return self.recordclass(*args,**kw)
    def newtuple(self,*args,**kw):
        return self.tupleclass(*args,**kw)
    def newarray(self,*args,**kw):
        return self.arrayclass(*args,**kw)

    def keys(self):
        return self.entityclass.keys()
    def types(self):
        return self.entityclass.types()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
