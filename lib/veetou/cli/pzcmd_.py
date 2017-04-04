# -*- coding: utf8 -*-
"""`veetou.cli.pzcmd_`

Implements the 'pz' subcommand
"""

from . import reportparsercmd_

from veetou.pz import PzReportParser

__all__ = ('PzCmd', )


class PzCmd(reportparsercmd_.ReportParserCmd):

    def create_parser(self, **kw):
        parser = PzReportParser(**kw)
        if self.arguments.squash:
            parser.header_parser.squashing = True
            parser.footer_parser.squashing = True
            parser.summary_parser.squashing = True
        return parser

    @property
    def description(self):
        return "Convert 'Protokół Zaliczeń' (PDF/TXT)"

    @property
    def start_table(self):
        return 'trs'


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
