# -*- coding: utf8 -*-
"""`veetou.cli.inputcmd_`
"""

from . import cmd_

from ..util import filemime
from ..input import FileType
from ..input import InputLines
from ..input import PdfTextLines
from ..input import BufferedIterator

import sys

__all__ = ('InputCmd',)

class InputCmd(cmd_.Cmd):

    def add_arguments(self):
        argparser = self.argparser
        argparser.add_argument( "--pdftotext",
                                default='pdftotext',
                                metavar='PROG',
                                help="alternative path to 'pdftotext' program"  )
        argparser.add_argument( "inputs",
                                metavar='FILE',
                                nargs='*',
                                help="inputs file to be parsed" )

    def open_txt(self, filename, *args, **kw):
        return BufferedIterator(InputLines(open(filename, *args, **kw)))

    def open_pdf(self, filename, *args, **kw):
        return BufferedIterator(PdfTextLines(open(filename, *args, **kw)))

    def open_html(self, filename, *args, **kw):
        return open(filename, *args, **kw)

    def open_by_mime(self, filename, *args, **kw):
        def error(filename, *args, **kw):
            msg = "unsupported file type %s for %s" % (repr(fmime), repr(filename))
            raise NotImplementedError(msg)
        fmime = filemime(filename)
        ftype = FileType.from_filemime(fmime)
        switcher = { FileType.TXT:   self.open_txt,
                     FileType.PDF:   self.open_pdf,
                     FileType.HTML:  self.open_html }
        return switcher.get(ftype, error)(filename, *args, **kw)

    def open(self, filename, *args, **kw):
        if filename == '-':
            # FIXME: because we're unable to run filemime('-'), as this would
            # consume our precious input lines...
            raise NotImplementedError("reading from stdin is not supported")
        else:
            return self.open_by_mime(filename, *args, **kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
