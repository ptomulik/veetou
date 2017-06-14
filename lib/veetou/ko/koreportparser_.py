# -*- coding: utf8 -*-
"""`veetou.ko.koreportparser_`

Provides the KoReportParser class
"""

from . import kosheetparser_
from . import komodel_
from ..parser import ReportParser

__all__ = ( 'KoReportParser', )

class KoReportParser(ReportParser):

    __slots__ = ()

    def create_datamodel(self, **kw):
        return komodel_.KoDataModel(**kw)

    def create_sheet_parser(self, **kw):
        return kosheetparser_.KoSheetParser(**kw)

    @property
    def table(self):
        return self.prefixed_table

    @property
    def endpoint(self):
        return self.prefixed_endpoint

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
