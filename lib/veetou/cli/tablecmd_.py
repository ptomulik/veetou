# -*- coding: utf8 -*-
"""`veetou.cli.tablecmd_`
"""

from . import cmd_
from ..model import declare
from ..model import entityclass
from ..model import tableclass
from ..model import DataType

import re
import sys
import csv

__all__ = ('TableCmd',)

_re_id = r'(?:[^\d\W]\w*)'
_rg_arg_table = re.compile(r'^(?P<table>%s)\s*=\s*(["\']?)(?P<file>[^:]+)\2(?:\s*:\s*(?P<key>%s))?$' % (_re_id, _re_id))
_rg_tab_header = re.compile(r'^\s*[^\W\d]\w*(?:\s*(?P<delimiter>[,:;])\s*[^\W\d]\w*(?:\s*\1\s*[^\W\d]\w*)*)?\s*$')

class TableCmd(cmd_.Cmd):

    __slots__ = ()

    def __init__(self, parent):
        super().__init__(parent)

    def add_arguments(self):
        argparser = self.argparser
        argparser.add_argument( "--table", "-t",
                                action='append',
                                metavar='name=FILE[:key]',
                                dest='tables',
                                help="read additional table from FILE"  )


    def read_csv_table(self, datamodel, tablename, filename, key):
        if tablename in datamodel.tables:
            sys.stderr.write('error: table %s already defined' % repr(tablename))
            return False

        with open(filename, 'r', newline='') as f:
            try:
                header = next(f)
            except StopIteration:
                sys.stderr.write("%s:1:error: can't parse table header\n" % filename)
                sys.stderr.write("(end of input)\n")
                return False
            else:
                m = re.match(_rg_tab_header, header)
                if not m:
                    sys.stderr.write("%s:1:error: can't parse table header\n" % filename)
                    sys.stderr.write("%s\n" % header)
                    return False
                delimiter = m.group('delimiter')
                if delimiter is None: # we have only one line...
                    th = (header.strip(),)
                else:
                    th = tuple(c.strip() for c in header.split(delimiter))

                datatype = declare(DataType, tablename, th, plural=tablename)
                refine = lambda s : s if s else None
                entity = entityclass(datatype)
                table = tableclass(datatype)()

                reader = csv.reader(f, delimiter=delimiter)
                if key is None:
                    for row in reader:
                        ent = entity(map(refine,row))
                        table.append(ent)
                else:
                    if key not in entity.keys():
                        sys.stderr.write("error: no column named %s in %s\n" % (repr(key), repr(filename)))
                        return False
                    for row in reader:
                        ent = entity(map(refine,row))
                        table[ent[key]] = ent
                datamodel.tables[tablename] = table
        return True

    def process_tables_arg(self, datamodel):
        tabdict = dict()
        if not self.parse_tables_arg(tabdict):
            return False

        for table, info in tabdict.items():
            if not self.read_csv_table(datamodel, table, *info):
                return False
        return True


    def parse_tables_arg(self, tables):
        # 'tables' is expected to be a dictionary
        if self.arguments.tables:
            for s in self.arguments.tables:
                m = re.match(_rg_arg_table, s)
                if not m:
                    sys.stderr.write("error: syntax error in expression for -t argument: %s\n" % repr(s))
                    return False
                e, f, k = (m.group(x) for x in ('table', 'file', 'key'))
                tables[e] = (f, k)
        return True

    def run(self, datamodel):
        return self.process_tables_arg(datamodel)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
