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

    def _create_job_variables(self, variables, **kw):
        var = entityclass(variables)
        job_uuid = uuid.uuid4().hex
        job_timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        job_host = platform.node()
        job_user = getpass.getuser()
        variables.append(var(('job_uuid', job_uuid)))
        variables.append(var(('job_timestamp', job_timestamp)))
        variables.append(var(('job_host', job_host)))
        variables.append(var(('job_user', job_user)))
        variables.append(var(('job_name', '')))

    def _create_variables(self, variables, **kw):
        self._create_job_variables(variables, **kw)

    def create_parser(self, **kw):
        parser = KoReportParser(**kw)
        self._create_variables(parser.datamodel.tables['ko_variables'], **kw)
        if self.arguments.squash:
            # NOTE: don't try squashing in parsers which have child parsers.
            #       if you try, you'll get screwed up relations in the
            #       generated database!
            parser.header_parser.squashing = True
            parser.footer_parser.squashing = True
            parser.preamble_parser.squashing = True
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
