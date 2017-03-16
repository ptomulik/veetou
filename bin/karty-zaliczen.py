#!/usr/bin/env python3
# -*- coding: utf8 -*-

import veetou
import argparse
import subprocess
import re
import sys


argpar = argparse.ArgumentParser()
argpar.add_argument('inputfile', type=str, metavar='FILE', nargs='*', help='input file (pdf) to be processed')
argpar.add_argument('-O', '--output-type', type=str, dest='output_type', choices = ['csv', 'txt'], default='csv', help='output format (default: csv)')
argpar.add_argument('-s', '--separator', type=str, dest='separator', metavar='SEP', default=';', help='field separator (for csv)')
argpar.add_argument('-o', '--output', type=str, dest='output', metavar='FILE', help='output file name')
argpar.add_argument('--first', type=int, dest='first_page', help='first page number')
argpar.add_argument('--last', type=int, dest='last_page', help='last page number')
argpar.add_argument('-f', '--field', action='append', dest='fields', help='output only the fields (columns) listed')
argpar.add_argument('--raw-header', dest='raw_header', action='store_true', help='use raw field names instead of column names')
argpar.add_argument('--field-info', dest='field_info', action='store_true', help='dump list of predefined fields and exit')
args = argpar.parse_args()

def pagerange(npages):
    if args.first_page is not None:
        first_page = args.first_page
    else:
        first_page = 1
    if args.last_page is not None:
        last_page = min(args.last_page, npages)
    else:
        last_page = npages
    return (first_page, last_page)

if args.field_info:
    fields  = veetou.KartaZaliczen._all_fields
    names   = veetou.KartaZaliczen._all_field_names
    print(u'\n'.join([u'%s:%s' % (k,names[k]) for k in fields]))
    exit(0)


if args.output:
    outfile = open(args.output, 'wt')
else:
    outfile = sys.stdout

if args.output_type == 'txt':
    for filename in args.inputfile:
        npages = veetou.pdfpages(filename)
        first_page, last_page = pagerange(npages)
        for page in range(first_page, last_page + 1):
            txt = veetou.pdftotext(filename, page, pages = npages)
            outfile.write(txt)
else:
    kw = dict()
    if args.fields:
        kw['fields'] = args.fields
    karta = veetou.KartaZaliczen()
    header = karta.generate_subjects_header(raw = args.raw_header, **kw)
    outfile.write(args.separator.join(header) + '\n')
    for filename in args.inputfile:
        npages = veetou.pdfpages(filename)
        first_page, last_page = pagerange(npages)
        for page in range(first_page, last_page + 1):
            lines = veetou.pdftotext(filename, page, pages = npages).splitlines()
            karta.reset(file = filename, page = page, pages = npages)
            karta.parse(lines)
            table = karta.generate_subjects_table(**kw)
            if len(table) > 0:
                s = u'\n'.join([ args.separator.join(row) for row in table ])
                outfile.write(u"%s\n" % s)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
