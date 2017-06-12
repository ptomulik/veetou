# -*- coding: utf8 -*-
"""`veetou.cli.pzcmd_`

Implements the 'pzh' subcommand
"""

from . import reportparsercmd_
import datetime

from veetou.pzh import PzHReportParser

__all__ = ('PzHCmd', )


class PzHCmd(reportparsercmd_.ReportParserCmd):

    def create_parser(self, **kw):
        parser = PzHReportParser(**kw)
##        if self.arguments.squash:
##            parser.header_parser.squashing = True
##            parser.footer_parser.squashing = True
##            parser.summary_parser.squashing = True
        return parser

    def parse_input_files(self, parser):
        parsed = 0
        if not self.arguments.inputs:
            filenames = ['-']
        else:
            filenames = self.arguments.inputs
        for filename in filenames:
            try:
                with open(filename, 'r') as lines:
                    dt = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                    if parser.parse(lines, source=filename, datetime=dt):
                        parsed += 1
                    else:
                        break
            except NotImplementedError as err:
                sys.stderr.write("error: %s\n" % err)
                break

        for err in parser.errors:
            sys.stderr.write("%s\n" % err.message())
            sys.stderr.write("%s\n" % '\n'.join(err.lines))

        if parsed < len(filenames):
            return False

        return True

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
