# -*- coding: utf8 -*-
"""`veetou.parser.preambleparser_`

Provides the PreambleParser class
"""

from . import parser_

__all__ = ('PreambleParser',)

class PreambleParser(parser_.Parser):

    @property
    def prefixed_table(self):
        return '%spreambles' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%spreamble' % self.prefix

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
