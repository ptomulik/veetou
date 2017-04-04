# -*- coding: utf8 -*-
"""`veetou.cli.inputcmd_`
"""

from . import cmd_

from ..util import filemime
from ..input import FileType
from ..input import InputLines
from ..input import PdfTextLines

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

    def open(self, filename, *args, **kw):
        if filename == '-':
            return InputLines(sys.stdin)
        else:
            fmime = filemime(filename)
            ftype = FileType.from_filemime(fmime)
            if ftype is FileType.TXT:
                return InputLines(open(filename, *args, **kw))
            elif ftype is FileType.PDF:
                return PdfTextLines(open(filename, *args, **kw))
            else:
                msg = "unsupported file type %s for %s" % (repr(fmime), repr(filename))
                raise NotImplementedError(msg)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
