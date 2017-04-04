# -*- coding: utf8 -*-
"""`veetou.input.pdftextlines_`

Provides the PdfTextLines class
"""

from . import popenlines_
from . import inputcontext_
from . import paginatedcontext_

import io
import subprocess

__all__ = ('PdfTextLines', )

class PdfTextLines(popenlines_.PopenLines):
    """Iterates over lines of a pdf file converted to a text"""

    __slots__ = ('_page', '_pageline')

    def __init__(self, file, page=None, first=None, last=None, fixed=4,
                 pdftotext='pdftotext', charset=None, **kw):
        pdf = '-' if isinstance(file, io.IOBase) else file
        cmd = [pdftotext]
        # pages
        cmd.extend(self._handle_page_args(page, first, last))
        # -fixed n
        if fixed is not None:
            cmd.extend(['-fixed', str(fixed)])
        # output (always stdout)
        cmd.extend([pdf, '-'])
        if 'universal_newlines' not in kw:
            kw['universal_newlines'] = True
        if isinstance(file, io.IOBase):
            process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stdin=file, **kw)
            try:
                name = file.name
            except AttributeError:
                name = repr(file)
        else:
            process = subprocess.Popen(cmd, stdout=subprocess.PIPE, **kw)
            name = file
        self._pageline = 1
        super().__init__(process, name, charset)

    def _handle_page_args(self, page=None, first=None, last=None):
        cmd = []
        if page is not None:
            if first is None:
                first = page
            if last is None:
                last = page
        if first is not None:
            cmd.extend(['-f', str(first)])
        if last is not None:
            cmd.extend(['-l', str(last)])
        if first is not None:
            self._page = first
        else:
            self._page = 1
        return cmd

    def __wrap__(self, string):
        if string.startswith('\f'):
            self._page += 1
            self._pageline = 1
        line = super().__wrap__(string)
        self._pageline += 1
        return line

    @property
    def page(self):
        return self._page

    @property
    def pageline(self):
        return self._pageline

    def context(self):
        return paginatedcontext_.PaginatedContext(self.name, self.line, self.page, self.pageline)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
