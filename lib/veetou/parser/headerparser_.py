# -*- coding: utf8 -*-
"""`veetou.parser.headerparser_`

Provides the HeaderParser class
"""

from . import parser_

__all__ = ('HeaderParser',)

class HeaderParser(parser_.Parser):

    __slots__ = ()

    @property
    def table(self):
        return 'headers'

    @property
    def endpoint(self):
        return 'header'

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
