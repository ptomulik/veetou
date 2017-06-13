# -*- coding: utf8 -*-
"""`veetou.cli.pdfreportparsercmd_`

Provides the `PdfReportParserCmd` class
"""

from . import reportparsercmd_

from veetou.input import BufferedIterator
from veetou.input import InputLines
from veetou.input import PdfTextLines
from veetou.input import FileType
from veetou.util import filemime

import sys

__all__ = ('PdfReportParserCmd', )


class PdfReportParserCmd(reportparsercmd_.ReportParserCmd):

    def add_arguments(self):
        argparser = self.argparser
        argparser.add_argument( "--pdftotext",
                                default='pdftotext',
                                metavar='PROG',
                                help="alternative path to 'pdftotext' program"  )
        super().add_arguments()

    def open_input_file(self, filename, *args, **kw):
        def error(filename, *args, **kw):
            msg = "unsupported file type %s for %s" % (repr(fmime), repr(filename))
            raise NotImplementedError(msg)
        if filename == '-':
            return BufferedIterator(InputLines(sys.stdin))
        else:
            switcher = { FileType.TXT:   self.open_txt,
                        FileType.PDF:   self.open_pdf }
            ftype = FileType.from_filemime(filemime(filename))
            return switcher.get(ftype, error)(filename, *args, **kw)

    def open_txt(self, filename, *args, **kw):
        return BufferedIterator(InputLines(open(filename, *args, **kw)))

    def open_pdf(self, filename, *args, **kw):
        return BufferedIterator(PdfTextLines(open(filename, *args, **kw)))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
