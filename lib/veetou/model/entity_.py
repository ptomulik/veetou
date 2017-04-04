# -*- coding: utf8 -*-
"""`veetou.model.entity_`

Provides the Entity class
"""

from . import namedtuple_
from . import object_
from . import functions_
from . import keystuple_

import collections.abc
import abc

__all__ = ('Entity', )

class Entity(object_.Object, namedtuple_.NamedTuple):
    """Base class for an entity, similar in concept to that from relational
    databases.

    An entity is basically a NamedTuple with the following changes:

        - it inherits from `object_.Object`,
        - its hash includes also entity class (type), so two entities with same
          content but of different types will yield different hashes,
        - class method ``validate()`` is used to validate and adjust input data.
    """

    __slots__ = ('_hash')

    def __init__(self, *args, **kw):
        # this trick allows us to use any name in kw
        values = (lambda values = None : values)(*args)
        array = functions_.arrayclass(self)
        super().__init__(self.validate(array(self.apply_types(self.mixargs(values,**kw)))))
        self._hash = hash((type(self),self._hash_data()))

    def _hash_data(self):
        """Returns the data that is used to compute the hash"""
        return self._data

    @classmethod
    def types(cls):
        try:
            return cls._types
        except AttributeError:
            return None

    @classmethod
    def apply_types(cls, data):
        types = cls.types()
        if types is not None:
            cast = lambda t,x: t(x) if t is not None else x
            return map(lambda args : cast(*args), zip(types,data))
        else:
            return data

    @classmethod
    def validate(cls, data):
        """In a subclass this may check the input data, refine it or raise
        a ValueError in an extreme case. The function must return a sequence
        of all its positional arguments (except the cls)"""
        return data

    @classmethod
    def __declare__(cls, name = "", keys = (), types = None, validate = None, attributes = (), **kw):
        klass = super().__declare__(name, keys, attributes, **kw)
        if types is not None:
            klass._types = tuple(types)
        if validate is not None:
            klass.validate =  classmethod(validate)
        return klass

    def __hash__(self):
        return self._hash

    def __repr__(self):
        return "%s([%s])" % (functions_.modelname(self), ','.join([repr(x) for x in self]))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
