# -*- coding: utf8 -*-
"""`veetou.ko.kopageparser_`

Provides the KoPageParser class
"""

from . import koheaderparser_
from . import kofooterparser_
from . import kopreambleparser_
from . import kotableparser_
from . import kosummaryparser_

from ..parser import PageParser

__all__ = ( 'KoPageParser', )

class KoPageParser(PageParser):

    __slots__ = ()

    def create_header_parser(self, **kw):
        return koheaderparser_.KoHeaderParser(**kw)

    def create_footer_parser(self, **kw):
        return kofooterparser_.KoFooterParser(**kw)

    def create_preamble_parser(self, **kw):
        return kopreambleparser_.KoPreambleParser(**kw)

    def create_table_parser(self, **kw):
        return kotableparser_.KoTableParser(**kw)

    def create_summary_parser(self, **kw):
        return kosummaryparser_.KoSummaryParser(**kw)

    def parse_footer(self, iterator, kw):
        if not super().parse_footer(iterator, kw):
            return False
        data = self.footer_parser.data
        page = int(data.get('sheet_page_number', 1))
        total = int(data.get('sheet_pages_total',1))
        if page == total:
            self.parent.next_sheet_parsed()
        return True

    def table_optional(self):
        return True

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
