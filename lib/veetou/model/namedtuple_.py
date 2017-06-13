# -*- coding: utf8 -*-
"""`veetou.model.namedtuple_`

Provides the NamedTuple class
"""

from . import type_
from . import tuple_
from . import functions_
from . import keystuple_
from ..common import checksubclass
from ..common import checkinstance
from ..common import setdelattr

import collections.abc
import abc

__all__ = ('NamedTuple', )

class NamedTupleMeta(abc.ABCMeta):
    """Metaclass for NamedTuple"""
    def __len__(self):
        return len(self.keys())

    @property
    def arrayclass(self):
        try:
            return self.datatype.arrayclass
        except AttributeError:
            return self._arrayclass

    @property
    def datatype(self):
        return self._datatype

    @arrayclass.setter
    def arrayclass(self, klass):
        from . import namedarray_
        checker = lambda x : checksubclass(x, namedarray_.NamedArray)
        setdelattr(self, '_arrayclass', klass, checker)

    @datatype.setter
    def datatype(self, dt):
        from . import datatype_
        checker = lambda x : checkinstance(x, datatype_.DataType)
        setdelattr(self, '_datatype', dt, checker)

class NamedTuple(tuple_.Tuple, collections.abc.Mapping, metaclass=NamedTupleMeta):
    """Base class for particular named tuples.

    A named tuple is a tuple with names assigned to tuple fields. Field
    names and tuple size are fixed for a given subclass of ``NamedTuple``.

    Usage example (minimal)::

            import veetou.model.namedtuple as namedtuple_
            import veetou.model.keystuple as keystuple_
            class Dog(namedtuple_.NamedTuple):
                keys_ = keystuple_.KeysTuple(('name', 'age'))

            dog = Dog(['Snoopy', 8])
            print("keys:   %r" % dog.keys())
            print("values: %r" % dog.values())
            print("name:   %r" % dog['name'])
            print("age:    %r" % dog['age'])

    Output::

            keys:   KeysTuple(['name', 'age'])
            values: Tuple(['Snoopy', 8])
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
    def __arrayclass__(cls):
        """Return a subclass of NamedArray compatible with this NamedTuple."""
        try:
            return cls.arrayclass
        except AttributeError:
            return functions_.arraygen(cls)

    @classmethod
    def __arraygen__(cls):
        from . import namedarray_ # must be here due to circular dependency
        return functions_.declare(namedarray_.NamedArray, keys = cls.keys())

    @classmethod
    def __declare__(cls, name = "", keys = (), attributes = (), **kw):
        _dict = { '_keys' : keystuple_.KeysTuple(keys) }
        _dict.update(attributes)
        bases = tuple(kw.get('bases', (cls,)))
        klass = functions_.declare(type_.Type, name, bases, _dict, **kw)
        # the following are class @properties - should not be set via __dict__
        for k in ('datatype', 'arrayclass'):
            if k in kw:
                setattr(klass, k, kw[k])
        return klass

    def values(self):
        """Return the values held by NamedTuple"""
        return self[:]

    def items(self):
        """Return the (key,value) items"""
        return tuple_.Tuple(zip(self.keys(), self.values()))

    def __getitem__(self, key):
        return super().__getitem__(type(self).keyindex(key))

    def __contains__(self, key):
        try:
            return self.get(key) is not None
        except IndexError:
            return False

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
