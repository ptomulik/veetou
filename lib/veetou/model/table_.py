# -*- coding: utf8 -*-
"""`veetou.model.table_`

Provides the Table class
"""

from . import object_
from . import mapset_
from . import functions_
from . import list_
from . import dict_
from . import reflist_
from . import namedtuple_
from ..common import checksubclass
from ..common import checkinstance
from ..common import setdelattr
import collections
import collections.abc
import abc

__all__ = ( 'Table',
            'TableColumnDescriptor',
            'TableColumnIterator',
            'TableList',
            'TableDict',
            'TableSequenceColumnIterator' )

class TableMeta(abc.ABCMeta):
    """Metaclass for Table"""

    @property
    def entityclass(self):
        try:
            return self.datatype.entityclass
        except AttributeError:
            return self._entityclass

    @property
    def recordclass(self):
        try:
            return self.datatype.recordclass
        except AttributeError:
            return self._recordclass

    @property
    def datatype(self):
        return self._datatype

    @entityclass.setter
    def entityclass(self, klass):
        from . import entity_ # must be here due to circular dependency
        checker = lambda x : checksubclass(x, entity_.Entity)
        setdelattr(self, '_entityclass', klass, checker)

    @recordclass.setter
    def recordclass(self, klass):
        from . import record_ # must be here due to circular dependency
        checker = lambda x : checksubclass(x, record_.Record)
        setdelattr(self, '_recordclass', klass, checker)

    @datatype.setter
    def datatype(self, dt):
        from . import datatype_ # must be here due to circular dependency
        checker = lambda x : checkinstance(x, datatype_.DataType)
        setdelattr(self, '_datatype', dt, checker)

class Table(object_.Object, mapset_.Mapset, metaclass=TableMeta):

    __slots__ = ('_relations',
                 '_start_append_id',
                 '_last_append_id',
                 '_high_append_id',
                 '_name')

    def __init__(self, items = (), **kw):
        from . import endpoint_ # imported here to avoid circular dependencies
        from . import link_ # imported here to avoid circular dependencies
        if not items: functions_.entityclass(self)
        self._relations = endpoint_.EndpointDict()
        super().__init__(items)
        self.start_append_id = kw.get('start_append_id', 0)
        self.name = kw.get('name', functions_.schemaname(self.__class__))

    @property
    def relations(self):
        return self._relations

    @property
    def start_append_id(self):
        return self._start_append_id

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, name):
        # FIXME: perform some sanity checking (like syntax...)?
        self._name = name

    @start_append_id.setter
    def start_append_id(self, i):
        self._start_append_id = int(i)

    @property
    def last_append_id(self):
        return self._last_append_id

    @property
    def high_append_id(self):
        return self._high_append_id

    @classmethod
    def __entityclass__(cls):
        return cls.entityclass

    @classmethod
    def __recordclass__(cls):
        return cls.recordclass

    @classmethod
    def __datatype__(cls):
        return cls.datatype

    def __tablename__(self):
        return self.name

    @classmethod
    def __declare__(cls, name = "", attributes = (), **kw):
        _dict = dict()
        for (k1,k2) in (('module', '__module__'),):
            try:
                x = kw[k1]
            except KeyError:
                pass
            else:
                _dict[k2] = x
        _dict.update(attributes)
        bases = tuple(kw.get('bases', (cls,)))
        klass = type(name, bases, _dict)
        for k in ('entityclass', 'recordclass', 'datatype'):
            if k in kw:
                setattr(klass, k, kw[k])
        return klass

    def __columniter__(self):
        return TableColumnIterator(self)

    def __wrap__(self, value):
        return checkinstance(value, type(self).entityclass)

    def append(self, value):
        try:
            i = self._high_append_id + 1
        except AttributeError:
            i = self.start_append_id
        while i in self: i = i+1
        self[i] = value
        self._last_append_id = i # set last_append_id only if successfully added
        self._high_append_id = i # the same for high_append_id
        return i

    def find_or_append(self, value):
        if self.count(value):
            for k, v in self.items():
                if v == value:
                    self._last_append_id = k
                    return (k, False)
            raise RuntimeError('could not find record in table')
        else:
            return (self.append(value), True)


    def getrecord(self, key):
        record = functions_.recordclass(self)
        return record(self[key], self, key)

class TableColumnDescriptor(object):

    __slots__ = ('_table', '_index')

    def __init__(self, table, index):
        super().__init__()
        self._table = checkinstance(table, Table)
        entity = self.entityclass
        if index < -len(entity) or index >= len(entity):
            raise IndexError("table column index out of range")
        self._index = index

    @property
    def table(self):
        return self._table

    @property
    def index(self):
        return self._index

    @property
    def entityclass(self):
        return functions_.entityclass(self.table)

    def __tableclass__(self):
        return type(self.table)

    def __entityclass__(self):
        return self.entityclass

    @property
    def key(self):
        keys = self.entityclass.keys()
        return keys[self.index]

    @property
    def schemaname(self):
        return '.'.join((functions_.tablename(self.table), self.key))

    @property
    def modelname(self):
        return "%s[%s]" % (functions_.modelname(self.entityclass), repr(self.key))

    @property
    def type(self):
        types = self.entityclass.types()
        return types[self.index] if types is not None else None

    def __schemaname__(self):
        return self.schemaname

    def __modelname__(self):
        return self.modelname

    def __repr__(self):
        return "%s(%s,%d)" % (functions_.modelname(self), functions_.modelname(self.table), self.index)

class TableColumnIterator(collections.abc.Iterator):

    __slots__ = ('_table', '_index')

    def __init__(self, table):
        super().__init__()
        self._table = checkinstance(table, Table)
        self._index = 0

    def __next__(self):
        entity = functions_.entityclass(self._table)
        if self._index < len(entity):
            col = TableColumnDescriptor(self._table, self._index)
            self._index += 1
            return col
        else:
            raise StopIteration

    def __repr__(self):
        return "%s(%s,%d)" % (functions_.modelname(self), functions_.modelname(self._table), self._index)

class TableList(reflist_.RefList):

    def __wrap__(self, value):
        return super().__wrap__(checkinstance(value, Table))

    def __columniter__(self):
        return TableSequenceColumnIterator(self)

    @property
    def columndict(self):
        return { functions_.schemaname(c) : c for c in functions_.columniter(self) }

class TableDict(dict_.Dict):
    def __wrap__(self,  value):
        return super().__wrap__(checkinstance(value, Table))

class TableSequenceColumnIterator(collections.abc.Iterator):

    __slots__ = ('_tabiter', '_coliter')

    def __init__(self, tables):
        super().__init__()
        self._tabiter = iter(tables)
        self._coliter = None

    def __next__(self):
        if self._coliter is None:
            self._coliter = TableColumnIterator(next(self._tabiter))

        while True: # skip all empty tables
            try:
                return next(self._coliter)
            except StopIteration:
                self._coliter = TableColumnIterator(next(self._tabiter))

    def __repr__(self):
        return "%s(%s)" % (functions_.modelname(self), functions_.modelname(self._tabiter))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
