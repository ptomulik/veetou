# -*- coding: utf8 -*-
"""`veetou.parser.headerparser_`

Provides the HeaderParser class
"""

from . import parser_

__all__ = ('HeaderParser',)

class HeaderParser(parser_.Parser):

    __slots__ = ()

    @property
    def prefixed_table(self):
        return '%sheaders' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%sheader' % self.prefix

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
