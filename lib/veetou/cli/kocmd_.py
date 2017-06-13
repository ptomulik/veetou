# -*- coding: utf8 -*-
"""`veetou.cli.kocmd_`

Implements the 'ko' subcommand
"""

from . import pdfreportparsercmd_

from veetou.ko import KoReportParser

__all__ = ('KoCmd', )


class KoCmd(pdfreportparsercmd_.PdfReportParserCmd):

    def create_parser(self, **kw):
        parser = KoReportParser(**kw)
        if self.arguments.squash:
            parser.header_parser.squashing = True
            parser.footer_parser.squashing = True
        return parser

    @property
    def description(self):
        return "Convert 'Karta Osiągnięć' (PDF/TXT)"

    @property
    def start_table(self):
        return 'trs'


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
