# -*- coding: utf8 -*-
"""`veetou.cli.csvoutcmd_`

Implements the CsvOutCmd class
"""

from . import cmd_

from ..model import Join
from ..model import schemaname
from ..model import columniter
from ..model import fielditer
from ..model import FieldMapper
from ..input import InputLines
from ..input import BufferedIterator
from ..parser import KeyMapParser

import csv
import sys

__all__ = ('CsvOutCmd',)

_quoting_options = {
    'all':  csv.QUOTE_ALL,
    'minimal':  csv.QUOTE_MINIMAL,
    'nonnumeric': csv.QUOTE_NONNUMERIC,
    'none': csv.QUOTE_NONE
}

class CsvOutCmd(cmd_.Cmd):

    __slots__ = ()

    @property
    def outfile(self):
        if not self.arguments.output or self.arguments.output == '-':
            return sys.stdout
        else:
            return open(self.arguments.output, 'w', newline='')

    def add_arguments(self):
        argparser = self.argparser

        argparser.add_argument( "--csv-delimiter",
                                default=';',
                                metavar='D',
                                help="use D to separate fields in csv output" )
        argparser.add_argument( "--csv-quoting",
                                choices=('all', 'minimal', 'nonnumeric', 'none'),
                                default='minimal',
                                help="controls how quotes should be used in csv output" )
        argparser.add_argument( "--csv-no-doublequote",
                                action='store_false',
                                dest='csv_doublequote',
                                help='when set, the escapechar is used as ' + \
                                'prefix to the quote char inside field in ' + \
                                'csv output' )
        argparser.add_argument( "--csv-quotechar",
                                choices=('"', "'"),
                                default='"',
                                help='a single-char string used to quote ' + \
                                'csv fields containing special characters')
        argparser.add_argument( "--csv-escapechar",
                                default='\\',
                                metavar='E',
                                help='a single-char string used to escape ' + \
                                'delimiter in csv output if quoting is set ' + \
                                'to none and the quotechar if doublequote ' + \
                                'is disabled')
        argparser.add_argument( "--csv-fieldmap",
                                action="append",
                                dest="csv_fieldmaps",
                                metavar="FILE",
                                help="read FILE and extract 'field:alias' map " +\
                                "for filtering and aliasing fields that " + \
                                "enter csv output")

    def run(self, datamodel, start_table, jointypes=()):
        kw = {  'delimiter': self.arguments.csv_delimiter,
                'quoting': _quoting_options[self.arguments.csv_quoting],
                'doublequote': self.arguments.csv_doublequote,
                'quotechar': self.arguments.csv_quotechar,
                'escapechar': self.arguments.csv_escapechar }

        if self.arguments.csv_fieldmaps:
            parser = KeyMapParser()
            keymaps = []
            for filename in self.arguments.csv_fieldmaps:
                with BufferedIterator(InputLines(open(filename, 'r'))) as lines:
                    if not parser.parse(lines):
                        for error in parser.errors:
                            sys.stderr.write("%s\n" % error.message())
                            sys.stderr.write("%s\n" % "\n".join(error.lines))
                        return 1
                    keymaps.extend(parser.result)
            fieldmapper = FieldMapper(keymaps)
        else:
            fieldmapper = None

        join = Join(datamodel.tables[start_table], jointypes=jointypes)
        with self.outfile as outfile:
            writer = csv.writer(outfile, **kw)
            if not fieldmapper:
                writer.writerow(map(schemaname, columniter(join.tables)))
                fieldvalue = lambda x : x.value
                fieldvalues = lambda r : map(fieldvalue, fielditer(r))
            else:
                writer.writerow(map(lambda x:x[0], fieldmapper(join.tables)))
                fieldvalue = lambda x : x[1].value
                fieldvalues = lambda r : map(fieldvalue, fieldmapper(r))
            writer.writerows(map(fieldvalues, join.rows()))
        return 0


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
