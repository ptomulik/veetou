# -*- coding: utf8 -*-
"""`veetou.cli.reportparsercmd_`

Implements the ReportParserCmd class
"""

from . import rootcmd_
from . import csvoutcmd_
from . import dboutcmd_
from . import tablecmd_
from . import linkcmd_

from ..model import JoinTypeDict
from ..common import logstr

import abc
import sys
import datetime
import subprocess


__all__ = ('ReportParserCmd', )

class ReportParserCmd(rootcmd_.RootCmd):

    __slots__ = ('_csvoutcmd', '_tablecmd', '_linkcmd')

    def __init__(self):
        super().__init__()
        self._tablecmd = tablecmd_.TableCmd(self)
        self._linkcmd = linkcmd_.LinkCmd(self)
        self._csvoutcmd = csvoutcmd_.CsvOutCmd(self)
        self._dboutcmd = dboutcmd_.DbOutCmd(self, self.full_view)

    @property
    @abc.abstractmethod
    def start_table(self):
        pass

    @property
    @abc.abstractmethod
    def full_view(self):
        pass

    @abc.abstractmethod
    def create_parser(self, **kw):
        pass

    @abc.abstractmethod
    def open_input_file(filetype, filename, *args, **kw):
        pass


    @property
    def outfile(self):
        if not self.arguments.output or self.arguments.output == '-':
            return sys.stdout
        else:
            return open(self.arguments.output, 'w')

    def print_input_files(self):
        endl = lambda s : s if s.endswith('\n') else s + '\n'
        printed = 0
        if not self.arguments.inputs:
            filenames = ['-']
        else:
            filenames = self.arguments.inputs
        with self.outfile as outfile:
            for filename in filenames:
                try:
                    with self.open_input_file(filename) as lines:
                        outfile.writelines(map(endl, lines))
                except NotImplementedError as err:
                    sys.stderr.write("error: %s\n" % err)
                    break
                except subprocess.CalledProcessError as err:
                    sys.stderr.write("error: %s\n" % err.stdout.strip())
                    break
        return printed == len(filenames)

    def parse_input_files(self, parser):
        parsed = 0
        if not self.arguments.inputs:
            filenames = ['-']
        else:
            filenames = self.arguments.inputs
        for filename in filenames:
            try:
                with self.open_input_file(filename) as lines:
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
            sys.stderr.write("%s\n" % logstr(err))

        if parsed < len(filenames):
            return False

        return True

    def add_arguments(self):
        argparser = self.argparser
        argparser.add_argument( "inputs",
                                metavar='FILE',
                                nargs='*',
                                help="inputs file to be parsed" )
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
            if not self.print_input_files():
                return 1
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
        return 0

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
