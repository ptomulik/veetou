# -*- coding: utf8 -*-
"""`veetou.parser.summaryparser_`

Provides the SummaryParser class
"""

from . import parser_

__all__ = ('SummaryParser',)

class SummaryParser(parser_.Parser):

    @property
    def prefixed_table(self):
        return '%ssummaries' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%ssummary' % self.prefix

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
