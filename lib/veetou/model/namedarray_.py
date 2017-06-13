# -*- coding: utf8 -*-
"""`veetou.model.namedarray_`

Provides the NamedArray class
"""

from . import type_
from . import array_
from . import functions_
from . import keystuple_
from ..common import checksubclass
from ..common import checkinstance
from ..common import setdelattr

import collections.abc
import abc

__all__ = ('NamedArray',)

class NamedArrayMeta(abc.ABCMeta):
    """Metaclass for NamedArray"""
    def __len__(self):
        return len(self.keys())

    @property
    def tupleclass(self):
        try:
            return self.datatype.tupleclass
        except AttributeError:
            return self._tupleclass

    @property
    def datatype(self):
        return self._datatype

    @tupleclass.setter
    def tupleclass(self, klass):
        from . import namedtuple_
        checker = lambda x : checksubclass(x, namedtuple_.NamedTuple)
        setdelattr(self, '_tupleclass', klass, checker)

    @datatype.setter
    def datatype(self, dt):
        from . import datatype_
        checker = lambda x : checkinstance(x, datatype_.DataType)
        setdelattr(self, '_datatype', dt, checker)

class NamedArray(array_.Array, collections.abc.Mapping, metaclass=NamedArrayMeta):
    """Base class for particular named arrays.

    A named array is a fixed length list with names assigned to array fields.
    Field names and array size are fixed for a given subclass of ``NamedArray``.

    Usage example (minimal)::

            import veetou.model.namedarray_ as namedarray_
            import veetou.model.keystuple_ as keystuple_
            class Dog(namedarray_.NamedArray):
                keys_ = keystuple_.KeysTuple(('name', 'age'))

            dog = Dog(['Snoopy', 8])
            print("keys:   %r" % dog.keys())
            print("values: %r" % dog.values())
            print("name:   %r" % dog['name'])
            print("age:    %r" % dog['age'])

    Output::

            keys:   KeysTuple(['name', 'age'])
            values: Array(['Snoopy', 8])
            name:   'Snoopy'
            age:    8
    """

    __slots__ = ()

    def __init__(self, *args, **kw):
        super().__init__(self.mixargs(*args, **kw))
        if len(type(self)) != len(self):
            raise ValueError('incompatible lengths')

    @classmethod
    def mixargs(cls, *args, **kw):
        keys = cls.keys()
        # this trick allows us to use any name in kw
        values = (lambda values = None : values)(*args)
        if values is not None:
            ivzip = zip(range(len(cls)), values)
            return map(lambda iv: kw.get(keys[iv[0]], iv[1]), ivzip)
        else:
            return map(lambda k : kw.get(k), keys)

    @classmethod
    def keys(cls):
        return cls._keys

    @classmethod
    def keyindex(cls, key):
        """Returns storage index for given key"""
        if isinstance(key, str):
            try:
                return cls.keys().index(key)
            except ValueError:
                raise KeyError(key)
        else:
            return key

    @classmethod
    def __tupleclass__(cls):
        """Return a subclass of NamedTuple compatible with this NamedArray."""
        try:
            return cls.tupleclass
        except AttributeError:
            return functions_.tuplegen(cls)

    @classmethod
    def __tuplegen__(cls):
        from . import namedtuple_ # must be here due to circular dependency
        return functions_.declare(namedtuple_.NamedTuple, keys = cls.keys())

    @classmethod
    def __declare__(cls, name = "", keys = (), attributes = (), **kw):
        _dict = { '_keys' : keystuple_.KeysTuple(keys) }
        _dict.update(attributes)
        bases = tuple(kw.get('bases', (cls,)))
        klass = functions_.declare(type_.Type, name, bases, _dict, **kw)
        # the following are class @properties - should not be set via __dict__
        for k in ('tupleclass', 'datatype'):
            if k in kw:
                setattr(klass, k, kw[k])
        return klass

    def values(self):
        """Return the values held by NamedArray"""
        return self[:]

    def items(self):
        """Return the (key,value) items"""
        return array_.Array(zip(self.keys(), self.values()))

    def __getitem__(self, key):
        return super().__getitem__(type(self).keyindex(key))

    def __setitem__(self, key, value):
        super().__setitem__(type(self).keyindex(key), value)

    def __contains__(self, key):
        try:
            return self.get(key) is not None
        except IndexError:
            return False

    def update(self, items):
        try:
            items = items.items()
        except AttributeError:
            pass
        for k,v in items:
            self[k] = v



# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
