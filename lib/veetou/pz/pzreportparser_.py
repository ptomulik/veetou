# -*- coding: utf8 -*-
"""`veetou.pz.pzreportparser_`

Provides the PzReportParser class
"""

from . import pzsheetparser_
from . import pzmodel_
from ..parser import ReportParser

__all__ = ( 'PzReportParser', )

class PzReportParser(ReportParser):

    __slots__ = ()

    def create_datamodel(self, **kw):
        return pzmodel_.PzDataModel(**kw)

    def create_sheet_parser(self, **kw):
        return pzsheetparser_.PzSheetParser(**kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
