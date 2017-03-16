# -*- coding: utf8 -*-

import re
import subprocess

_re_pageno_footline = re.compile(r'^( +)\d+( *)/( *)\d+( *)$', re.M)

def backtick(cmd):
    process = subprocess.Popen(cmd, stdout = subprocess.PIPE)
    out, err = process.communicate()
    status = process.wait()
    if status != 0 and status != 2:
        raise RuntimeError('command %s returned non-zero exit code %d' %(cmd[0], status))
    return out.decode('utf-8')

def pdfinfo(filename):
    """Executes 'pdfinfo' and returns its output"""
    cmd = ['pdfinfo', filename]
    return backtick(cmd)

def pdftotext(filename, first, last=None, **kw):
    """Executes 'pdftotext' and returns its output"""
    global _re_pageno_footline
    if last is None:
        last = first
    cmd = [ 'pdftotext', '-f', str(first), '-l', str(last), '-fixed', '4', filename, '-']
    out = backtick(cmd)
    page = kw.get('page', first)
    pages = kw.get('pages')
    if page is not None and pages is not None:
        out = _re_pageno_footline.sub("\\g<1>%d\\g<2>/\\g<3>%d\\g<4>" % (page, pages), out, 1)
    return out

def pdfpages(filename):
    """Executes 'pdfinfo' and extracts number of PDF pages from its output"""
    global _re_pageno_footline
    out = pdfinfo(filename)
    m = re.search(r'^Pages: +(?P<pages>\d+)$', out, re.M|re.U)
    if not m:
        raise RuntimeError('Could not determine number of pages in PDF')
    return int(m.group('pages'))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
