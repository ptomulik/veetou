# -*- coding: utf8 -*-
"""`veetou.pz.pzsheetparser_`

Provides the PzSheetParser class
"""

from . import pzpageparser_
from ..parser import SheetParser

__all__ = ( 'PzSheetParser', )

class PzSheetParser(SheetParser):

    __slots__ = ()

    def create_page_parser(self, **kw):
        return pzpageparser_.PzPageParser(**kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
