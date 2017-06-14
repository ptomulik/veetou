# -*- coding: utf8 -*-
"""`veetou.pz.pzpageparser_`

Provides the PzPageParser class
"""

from . import pzheaderparser_
from . import pzfooterparser_
from . import pzpreambleparser_
from . import pztableparser_
from . import pzsummaryparser_

from ..parser import PageParser

__all__ = ( 'PzPageParser', )

class PzPageParser(PageParser):

    __slots__ = ()

    @property
    def table(self):
        return self.prefixed_table

    @property
    def endpoint(self):
        return self.prefixed_endpoint

    def create_header_parser(self, **kw):
        return pzheaderparser_.PzHeaderParser(**kw)

    def create_footer_parser(self, **kw):
        return pzfooterparser_.PzFooterParser(**kw)

    def create_preamble_parser(self, **kw):
        return pzpreambleparser_.PzPreambleParser(**kw)

    def create_table_parser(self, **kw):
        return pztableparser_.PzTableParser(**kw)

    def create_summary_parser(self, **kw):
        return pzsummaryparser_.PzSummaryParser(**kw)

    def table_optional(self):
        return True

    def expecting_preamble(self):
        return (not self.parent.pages_parsed)

    def summary_optional(self):
        return True

    def parse_summary(self, iterator, kw):
        if not super().parse_summary(iterator, kw):
            return False
        self.parent.next_sheet_parsed()
        return True


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
