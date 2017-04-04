# -*- coding: utf8 -*-
"""`veetou.parser.footerparser_`

Provides the FooterParser class
"""

from . import parser_

__all__ = ('FooterParser',)

class FooterParser(parser_.Parser):

    __slots__ = ()

    @property
    def table(self):
        return 'footers'

    @property
    def endpoint(self):
        return 'footer'

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
