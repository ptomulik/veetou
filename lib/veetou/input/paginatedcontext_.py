# -*- coding: utf8 -*-
"""`veetou.input.paginatedcontext_`

Provides the PaginatedContext class
"""

from . import inputcontext_

__all__ = ('PaginatedContext', )

class PaginatedContext(inputcontext_.InputContext):

    __slots__ = ('page','pageline')

    def __init__(self, name, line, page, pageline):
        super().__init__(name, line)
        self.page = page
        self.pageline = pageline

    def __log__(self):
        """Returns a string useful when logging errors/warnings"""
        return '%s:%s:[page=%s,line=%s]' % \
            (self.name, repr(self.line), repr(self.page), repr(self.pageline))

    def __repr__(self):
        return self.__class__.__name__ + '(name=%s,line=%s,page=%s,pageline=%s)' % \
                (repr(self.name), repr(self.line), repr(self.page), repr(self.pageline))

    def __eq__(self, other):
        if isinstance(other, type(self)):
            return super().__eq__(other) \
                and self.page == other.page \
                and self.pageline == other.pageline
        else:
            return False

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
