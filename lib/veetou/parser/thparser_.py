# -*- coding: utf8 -*-
"""`veetou.parser.thparser_`

Provides the ThParser class
"""

from . import parser_

__all__ = ('ThParser',)

class ThParser(parser_.Parser):

    @property
    def prefixed_table(self):
        return '%sths' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%sth' % self.prefix

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
