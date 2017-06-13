# -*- coding: utf8 -*-
"""`veetou.cli.pzcmd_`

Implements the 'pz' subcommand
"""

from . import pdfreportparsercmd_

from veetou.pz import PzReportParser
from veetou.input import InputLines
from veetou.input import BufferedIterator
from veetou.input import FileType

__all__ = ('PzCmd', )


class PzCmd(pdfreportparsercmd_.PdfReportParserCmd):

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
