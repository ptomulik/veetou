# -*- coding: utf8 -*-
"""`veetou.cli.kocmd_`

Implements the 'ko' subcommand
"""

from . import pdfreportparsercmd_

from ..model import entityclass
from ..ko import KoReportParser
from ..ko import KoVariable

import datetime
import uuid
import platform
import getpass

__all__ = ('KoCmd', )


class KoCmd(pdfreportparsercmd_.PdfReportParserCmd):

    def _create_parse_variables(self, variables, **kw):
        var = entityclass(variables)
        p_uuid = uuid.uuid4().hex
        p_timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        p_host = platform.node()
        p_user = getpass.getuser()
        variables.append(var(('parse_uuid', p_uuid)))
        variables.append(var(('parse_timestamp', p_timestamp)))
        variables.append(var(('parse_host', p_host)))
        variables.append(var(('parse_user', p_user)))
        variables.append(var(('parse_name', '')))

    def _create_variables(self, variables, **kw):
        self._create_parse_variables(variables, **kw)

    def create_parser(self, **kw):
        parser = KoReportParser(**kw)
        self._create_variables(parser.datamodel.tables['ko_variables'], **kw)
        if self.arguments.squash:
            parser.header_parser.squashing = True
            parser.footer_parser.squashing = True
        return parser

    @property
    def description(self):
        return "Convert 'Karta Osiągnięć' (PDF/TXT)"

    @property
    def start_table(self):
        return 'ko_trs'

    @property
    def full_view(self):
        return 'ko_full'


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
