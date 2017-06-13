# -*- coding: utf8 -*-
"""`veetou.cli.reportparsercmd_`

Implements the ReportParserCmd class
"""

from . import rootcmd_
from . import inputcmd_
from . import txtoutcmd_
from . import csvoutcmd_
from . import dboutcmd_
from . import tablecmd_
from . import linkcmd_

from ..model import JoinTypeDict

import abc
import sys
import datetime
import subprocess


__all__ = ('ReportParserCmd', )

class ReportParserCmd(rootcmd_.RootCmd):

    __slots__ = ('_inputcmd', '_txtoutcmd', '_csvoutcmd', '_tablecmd', '_linkcmd')

    def __init__(self):
        super().__init__()
        self._inputcmd = inputcmd_.InputCmd(self)
        self._tablecmd = tablecmd_.TableCmd(self)
        self._linkcmd = linkcmd_.LinkCmd(self)
        self._txtoutcmd = txtoutcmd_.TxtOutCmd(self, self._inputcmd)
        self._csvoutcmd = csvoutcmd_.CsvOutCmd(self)
        self._dboutcmd = dboutcmd_.DbOutCmd(self)

    @property
    @abc.abstractmethod
    def start_table(self):
        pass

    @abc.abstractmethod
    def create_parser(self, **kw):
        pass

    def parse_input_files(self, parser):
        parsed = 0
        if not self.arguments.inputs:
            filenames = ['-']
        else:
            filenames = self.arguments.inputs
        for filename in filenames:
            try:
                with self._inputcmd.open(filename) as lines:
                    dt = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                    if parser.parse(lines, source=filename, datetime=dt):
                        parsed += 1
                    else:
                        break
            except NotImplementedError as err:
                sys.stderr.write("error: %s\n" % err)
                break
            except subprocess.CalledProcessError as err:
                sys.stderr.write("error: %s\n" % err.stdout.strip())
                break

        for err in parser.errors:
            sys.stderr.write("%s\n" % err.message())
            sys.stderr.write("%s\n" % '\n'.join(err.lines))

        if parsed < len(filenames):
            return False

        return True

    def add_arguments(self):
        argparser = self.argparser
        argparser.add_argument( "--output","-o",
                                metavar='FILE',
                                help="write result to FILE" )
        argparser.add_argument( "--output-format", "-O",
                                choices=('csv', 'db', 'txt'),
                                default='csv',
                                help="output format (csv - spreadsheet, " + \
                                "db - sqlite3 database, txt - original " + \
                                "report in plain text)" )
        argparser.add_argument( "--parse-only",
                                action='store_true',
                                help="parse (validate) input without producing any output" )
        argparser.add_argument( "--squash",
                                action='store_true',
                                help="elimitate repeating records in tables where possible" )

    def run(self):
        super().run()

        of = self.arguments.output_format

        if of == 'txt':
            return self._txtoutcmd.run()
        elif of in ('csv', 'db'):
            parser = self.create_parser(disable_datamodel = self.arguments.parse_only)
            jointypes = JoinTypeDict()
            if not self._tablecmd.run(parser.datamodel):
                return 1
            if not self._linkcmd.run(parser.datamodel, jointypes):
                return 1
            if not self.parse_input_files(parser):
                return 1
            if not self.arguments.parse_only:
                if of == 'csv':
                    return self._csvoutcmd.run(parser.datamodel, self.start_table, jointypes)
                else:
                    return self._dboutcmd.run(parser.datamodel, self.start_table, jointypes)
        else:
            sys.stderr.write("error: unsupported output format %s\n" % repr(of))
            return 1

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
