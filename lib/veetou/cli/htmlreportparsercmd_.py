# -*- coding: utf8 -*-
"""`veetou.cli.htmlreportparsercmd_`

Provides the `HtmlReportParserCmd` class
"""

from . import reportparsercmd_

from veetou.input import InputLines
from veetou.input import BufferedIterator
from veetou.input import FileType
from veetou.util import filemime

import sys

__all__ = ('HtmlReportParserCmd', )


class HtmlReportParserCmd(reportparsercmd_.ReportParserCmd):

    def open_input_file(self, filename, *args, **kw):
        def error(filename, *args, **kw):
            msg = "unsupported file type %s for %s" % (repr(fmime), repr(filename))
            raise NotImplementedError(msg)
        if filename == '-':
            return sys.stdin
        else:
            switcher = { FileType.HTML:   self.open_html }
            ftype = FileType.from_filemime(filemime(filename))
            return switcher.get(ftype, error)(filename, *args, **kw)

    def open_html(self, filename, *args, **kw):
        return open(filename, *args, **kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
