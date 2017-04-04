# -*- coding: utf8 -*-
"""`veetou.model.record_`

Provides the Record class
"""

from . import namedarray_
from . import object_
from . import functions_
from . import list_
import collections.abc
import abc

__all__ = ( 'Record',
            'RecordFieldProxy',
            'RecordFieldIterator',
            'RecordSequence',
            'RecordSequenceFieldIterator' )

class RecordMeta(namedarray_.NamedArrayMeta):
    @property
    def entityclass(self):
        try:
            return self.datatype.entityclass
        except AttributeError:
            return self._entityclass

    @property
    def tableclass(self):
        try:
            return self.datatype.tableclass
        except AttributeError:
            return self._tableclass

    @entityclass.setter
    def entityclass(self, klass):
        from . import entity_
        checker = lambda x : functions_.checksubclass(x, entity_.Entity)
        functions_.setdelattr(self, '_entityclass', klass, checker)

    @tableclass.setter
    def tableclass(self, klass):
        from . import table_
        checker = lambda x : functions_.checksubclass(x, table_.Table)
        functions_.setdelattr(self, '_tableclass', klass, checker)


class Record(object_.Object, namedarray_.NamedArray, metaclass = RecordMeta):
    """Represents an entity retrieved from a particular table"""

    __slots__ = ('_table', 'id')

    def __init__(self, *args, **kw):
        # this trick allows us to use any name in kw
        (data, table, id) = (lambda data,table,id=None : (data, table, id))(*args)
        super().__init__(data, **kw)
        self.table = table
        self.id = id

    @classmethod
    def __entityclass__(cls):
        """Return a subclass of Entity compatible with this Record."""
        return cls.entityclass

    @classmethod
    def __tableclass__(cls):
        """Return a subclass of Entity compatible with this Record."""
        return cls.tableclass

    @classmethod
    def keys(cls):
        return functions_.entityclass(cls).keys()

    @property
    def table(self):
        return self._table

    @table.setter
    def table(self, table):
        checker = lambda x : functions_.checkinstance(x, type(self).tableclass)
        functions_.setdelattr(self, '_table', table, checker)

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
        for k in ('entityclass', 'tableclass', 'datatype'):
            if k in kw:
                setattr(klass, k, kw[k])
        return klass

    def copy(self):
        return self.__class__(self, self.table, self.id)

    def save(self):
        entity = type(self).entityclass
        if self.id is None:
            self.id = self.table.append(entity(self))
        else:
            self.table[self.id] = entity(self)
        return self.id

    def __repr__(self):
        return "%s([%s],table=%s,id=%r)" % (
                functions_.modelname(self),
                ','.join([repr(x) for x in self]),
                functions_.modelrefstr(self.table),
                self.id
        )

class RecordFieldProxy(object):

    __slots__ = ('_record', '_index')

    def __init__(self, record, index):
        super().__init__()
        self._record = functions_.checkinstance(record, Record)
        if index < -len(record) or index >= len(record):
            raise IndexError("record field index out of range")
        self._index = index

    @property
    def record(self):
        return self._record

    @property
    def index(self):
        return self._index

    @property
    def recordclass(self):
        return type(self.record)

    @property
    def entityclass(self):
        return functions_.entityclass(self.recordclass)

    def __recordclass__(self):
        return self.recordclass

    def __entityclass__(self):
        return self.entityclass

    @property
    def key(self):
        keys = self.record.keys()
        return keys[self.index]

    @property
    def value(self):
        return self.record[self.index]

    @value.setter
    def value(self, val):
        self.record[self.index] = val

    @property
    def schemaname(self):
        return '.'.join((functions_.tablename(self.record.table), self.key))

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
        return "%s(%s,%d)" % (functions_.modelname(self), functions_.modelname(self.recordclass), self.index)


class RecordFieldIterator(collections.abc.Iterator):

    __slots__ = ('_record', '_index')

    def __init__(self, record):
        super().__init__()
        self._record = functions_.checkinstance(record, Record)
        self._index = 0

    def __next__(self):
        entity = functions_.entityclass(self._record)
        if self._index < len(entity):
            col = RecordFieldProxy(self._record, self._index)
            self._index += 1
            return col
        else:
            raise StopIteration

    def __repr__(self):
        return "%s(%s,%d)" % (functions_.modelname(self), functions_.modelrefstr(self._record), self._index)


class RecordSequence(list_.List):

    def __wrap__(cls, value):
        return functions_.checkinstance(value, Record)

    def __fielditer__(self):
        return RecordSequenceFieldIterator(self)

class RecordSequenceFieldIterator(collections.abc.Iterator):

    __slots__ = ('_tabiter', '_coliter')

    def __init__(self, records):
        super().__init__()
        self._tabiter = iter(records)
        self._coliter = None

    def __next__(self):
        if self._coliter is None:
            self._coliter = RecordFieldIterator(next(self._tabiter))

        while True: # skip all empty records
            try:
                return next(self._coliter)
            except StopIteration:
                self._coliter = RecordFieldIterator(next(self._tabiter))

    def __repr__(self):
        return "%s(%s)" % (functions_.modelname(self), functions_.modelname(self._tabiter))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
