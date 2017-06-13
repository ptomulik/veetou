# -*- coding: utf8 -*-
"""`veetou.input.inputloc_`

Provides the InputLoc class
"""

__all__ = ('InputLoc', )

class InputLoc(object):
    """Encapsulates information about current position within an input file"""

    __slots__ = ('name', 'line')

    def __init__(self, name, line):
        self.name = name
        self.line = line

    def __logstr__(self):
        """Returns a string useful when logging errors/warnings"""
        return '%s:%s' % (self.name, repr(self.line))

    def __repr__(self):
        return self.__class__.__name__ + '(name=%s,line=%s)' % \
                (repr(self.name), repr(self.line))

    def __eq__(self, other):
        if isinstance(other, type(self)):
            return self.name == other.name and self.line == other.line
        else:
            return False

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
