# -*- coding: utf8 -*-
"""`veetou.pz.pzsheetparser_`

Provides the PzSheetParser class
"""

from . import pzpageparser_
from ..parser import SheetParser

__all__ = ( 'PzSheetParser', )

class PzSheetParser(SheetParser):

    __slots__ = ()

    @property
    def table(self):
        return self.prefixed_table

    @property
    def endpoint(self):
        return self.prefixed_endpoint

    def create_page_parser(self, **kw):
        return pzpageparser_.PzPageParser(**kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
