#!/usr/bin/env python3
# -*- coding: utf8 -*-

import veetou
import argparse
import subprocess
import re
import sys


argpar = argparse.ArgumentParser()
argpar.add_argument('inputfile', type=str, metavar='FILE', nargs='+', help='input file (pdf) to be processed')
argpar.add_argument('-F', '--output-format', type=str, dest='output_format', choices = ['csv'], default='csv', help='output format (default: csv)')
argpar.add_argument('-s', '--separator', type=str, dest='separator', metavar='SEP', default=';', help='field separator (for csv)')
argpar.add_argument('-o', '--output', type=str, dest='output', metavar='FILE', help='output file name')
args = argpar.parse_args()

def backtick(cmd):
    process = subprocess.Popen(cmd, stdout = subprocess.PIPE)
    out, err = process.communicate()
    status = process.wait()
    if status != 0 and status != 2:
        raise RuntimeError('command %s returned non-zero exit code %d' %(cmd[0], status))
    return out.decode('utf-8')

def pdfinfo(filename):
    cmd = ['pdfinfo', filename]
    return backtick(cmd)

def pdftotext(filename, first, last=None):
    if last is None:
        last = first
    cmd = [ 'pdftotext', '-f', str(first), '-l', str(last), '-fixed', '4', filename, '-']
    return backtick(cmd)

if args.output:
    outfile = open(args.output, 'wt')
else:
    outfile = sys.stdout

karta = veetou.KartaZaliczen()
header = karta.generate_subjects_header()
outfile.write(args.separator.join(header) + '\n')
for filename in args.inputfile:
    out = pdfinfo(filename)
    m = re.search(r'^Pages: +(?P<pages>\d+)$', out, re.M|re.U)
    if not m:
        raise RuntimeError('Could not determine number of pages in PDF')
    npages = int(m.group('pages'))
    for page in range(1,npages+1):
        lines = pdftotext(filename, page).splitlines()
        karta.reset(file = filename, page = page, pages = npages)
        karta.parse(lines)
        table = karta.generate_subjects_table()
        if len(table) > 0:
            s = u'\n'.join([ args.separator.join(row) for row in table ]) + u'\n'
            outfile.write(s)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
