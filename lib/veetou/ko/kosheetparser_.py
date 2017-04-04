# -*- coding: utf8 -*-
"""`veetou.ko.kosheetparser_`

Provides the KoSheetParser class
"""

from . import kopageparser_
from ..parser import SheetParser

__all__ = ( 'KoSheetParser', )

class KoSheetParser(SheetParser):

    __slots__ = ()

    def create_page_parser(self, **kw):
        return kopageparser_.KoPageParser(**kw)

    def parse_before_children(self, iterator, kw):
        self.tbody_parser.sheet_ects_data.clear()
        return super().parse_before_children(iterator, kw)

    def parse_after_children(self, iterator, kw):
        kw.update(self.tbody_parser.sheet_ects_data)
        return super().parse_after_children(iterator, kw)


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
