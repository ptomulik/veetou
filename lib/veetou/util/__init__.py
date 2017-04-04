# -*- coding: utf8 -*-
"""`veetou.util`

Utility functions
"""

import re
import io
import csv
import subprocess

##_re_txt_pageno_footline = re.compile(r'^( +)\d+( *)/( *)\d+( *)$', re.M)
##_re_csv_newpage_cell = re.compile(  r'^ *(?P<student_id>\d+)' + r' *- *' +
##                                    r'(?:(?P<first_name>(?:[^\W\d_]|-)+( +(?:[^\W\d_]|-)+)*) +)?' +
##                                    r'(?P<last_name>(?:[^\W\d_]|-)+) *$' )

def backtick(cmd, input=None, timeout=None):
    stdin = subprocess.PIPE if input is not None else None
    process = subprocess.Popen(cmd, stdout = subprocess.PIPE, stdin = stdin)
    out, err = process.communicate(input,timeout)
    status = process.wait()
    if status != 0 and status != 2:
        raise RuntimeError('command %s returned non-zero exit code %d' %(cmd[0], status))
    return out.decode('utf-8')

def pdfinfo(filename):
    """Executes 'pdfinfo' and returns its output"""
    cmd = ['pdfinfo', filename]
    return backtick(cmd)

##def pdftotext(filename, first, last=None, **kw):
##    """Executes 'pdftotext' and returns its output"""
##    global _re_txt_pageno_footline
##    if last is None:
##        last = first
##    cmd = [ 'pdftotext', '-f', str(first), '-l', str(last), '-fixed', '4', filename, '-']
##    out = backtick(cmd)
##    page = kw.get('page', first)
##    pages = kw.get('pages')
##    if page is not None and pages is not None:
##        out = _re_txt_pageno_footline.sub("\\g<1>%d\\g<2>/\\g<3>%d\\g<4>" % (page, pages), out, 1)
##    return out

def pdftotextpage(filename, pageno, **kw):
    """Executes 'pdftotext' and returns its output"""
    cmd = [ 'pdftotext', '-f', str(pageno), '-l', str(pageno), '-fixed', '4', filename, '-']
    out = backtick(cmd)
    return out

##def pdfpages(filename):
##    """Executes 'pdfinfo' and extracts number of PDF pages from its output"""
##    global _re_txt_pageno_footline
##    out = pdfinfo(filename)
##    m = re.search(r'^Pages: +(?P<pages>\d+)$', out, re.M|re.U)
##    if not m:
##        raise RuntimeError('Could not determine number of pages in PDF')
##    return int(m.group('pages'))

def filecmd(filename, flags):
    """Executes 'file <flags> filename' and returns its output"""
    cmd = [ 'file' ] + list(flags)
    if isinstance(filename, str):
        if filename == '-':
            raise NotImplementedError("stdin input is not implemented")
        cmd.append(filename)
        out = backtick(cmd).strip()
    else:
        fnames = list(filename)
        if len(fnames) > 0:
            if '-' in fnames:
                raise NotImplementedError("stdin input is not implemented")
            cmd.extend(fnames)
            out = [ s.strip() for s in backtick(cmd).splitlines() ]
        else:
            out = []
    return out

def filetype(filename):
    """Executes 'file -b filename' and returns its output"""
    return filecmd(filename, ['-b'])

def filemime(filename):
    """Executes 'file -bi filename' and returns its output"""
    return filecmd(filename, ['-b', '-i'])


##def csvpages(filename, **kw):
##    """Scan  csv file (an export from girdac or so...) and try to extract
##    number of original PDF pages"""
##    count = 0
##    try:
##        encoding = kw['encoding']
##        del(kw['encoding'])
##    except KeyError:
##        encoding = 'utf8'
##    with io.open(filename, encoding=encoding, newline='') as fd:
##        reader = csv.reader(fd, **kw)
##        for row in reader:
##            if (len(row) > 0):
##                m = _re_csv_newpage_cell.match(row[0])
##                if m:
##                    count += 1
##    return count


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
