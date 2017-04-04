# -*- coding: utf8 -*-
"""`veetou.model.object_`

Provides the Object class
"""

from . import functions_

__all__ = ('Object',)

class Object(object):
    """Base class for most model objects"""

    __slots__ = ()

    @classmethod
    def __modelname__(cls):
        """Returns the type name used to represent objects in Python. This is
        used by __repr__"""
        return cls.__name__

    @classmethod
    def __schemaname__(cls):
        """Returns the entity name used for modelling data (entity name in the
        entity - relationship model)"""
        return functions_.snakecase(functions_.modelname(cls))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
