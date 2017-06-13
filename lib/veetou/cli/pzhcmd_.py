# -*- coding: utf8 -*-
"""`veetou.cli.pzcmd_`

Implements the 'pzh' subcommand
"""

from . import htmlreportparsercmd_
import datetime

from veetou.pzh import PzHReportParser

__all__ = ('PzHCmd', )


class PzHCmd(htmlreportparsercmd_.HtmlReportParserCmd):

    def create_parser(self, **kw):
        return PzHReportParser(**kw)

    @property
    def description(self):
        return "Convert 'Protokół Zaliczeń' (HTML)"

    @property
    def start_table(self):
        return 'trs'


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
