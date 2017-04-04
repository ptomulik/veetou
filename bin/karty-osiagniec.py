#!/usr/bin/env python3
# -*- coding: utf8 -*-

import veetou
import argparse
import subprocess
import re
import sys

class SpliAppendTokens(argparse._AppendAction):
    def __init__(self, *args, **kw):
        super(SpliAppendTokens, self).__init__(*args, **kw)
    def __call__(self, parser, namespace, values, *args, **kw):
        values = re.split('\W+', values)
        for value in values:
            super(SpliAppendTokens, self).__call__(parser, namespace, value, *args, **kw)


argpar = argparse.ArgumentParser()
argpar.add_argument('inputfile', type=str, metavar='FILE', nargs='*', help='input file (pdf) to be processed')
argpar.add_argument('-I', '--input-type', type=str, dest='input_type', choices = ['pdf', 'csv'], default='pdf', help='input format (default: pdf)')
argpar.add_argument('-S', '--input-separator', type=str, dest='input_separator', metavar='SEP', default=';', help='cell separator (in input csv file, default: ";")')
argpar.add_argument('-c', '--input-encoding', type=str, dest='input_encoding', metavar='CODE', default='utf8', help='character set used to encode input text (default: utf8)')
argpar.add_argument('-O', '--output-type', type=str, dest='output_type', choices = ['csv', 'txt'], default='csv', help='output format (default: csv)')
argpar.add_argument('-s', '--output-separator', type=str, dest='output_separator', metavar='SEP', default=';', help='field separator (for output csv, default: ";")')
argpar.add_argument('-o', '--output', type=str, dest='output', metavar='FILE', help='output file name')
argpar.add_argument('-f', '--first', type=int, dest='first_page', help='first page number')
argpar.add_argument('-l', '--last', type=int, dest='last_page', help='last page number')
argpar.add_argument('--fields', action=SpliAppendTokens, dest='fields', help='fields that should appear in output (in order)')
argpar.add_argument('--fields-include', action=SpliAppendTokens, dest='include_fields', help='include these (extra) fields in output')
argpar.add_argument('--fields-exclude', action=SpliAppendTokens, dest='exclude_fields', help='exclude these fields from output')
argpar.add_argument('-r', '--raw-header', dest='raw_header', action='store_true', help='use raw field names instead of column names')
argpar.add_argument('--field-info', dest='field_info', action='store_true', help='dump list of predefined fields and exit')
argpar.add_argument('-m', '--map', action='append',  dest='maps', metavar='FILE', help='insert extra values from map file(s)')
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
    fields  = veetou.KartaOsiagniec.all_fields()
    titles   = veetou.KartaOsiagniec.all_field_titles()
    print(u'\n'.join([u'%s:%s' % (k,titles[k]) for k in fields]))
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
    if args.include_fields:
        kw['include_fields'] = args.include_fields
    if args.exclude_fields:
        kw['exclude_fields'] = args.exclude_fields

    maps = veetou.Maps()
    if args.maps:
        for m in args.maps:
            with open(m, 'rt') as f:
                maps.parse(f.read().splitlines())
    kw['maps'] = maps

    karta = veetou.KartaOsiagniec()
    header = karta.generate_subjects_header(raw = args.raw_header, **kw)
    outfile.write(args.output_separator.join(header) + '\n')
    if args.input_type == 'pdf':
        for filename in args.inputfile:
            npages = veetou.pdfpages(filename)
            first_page, last_page = pagerange(npages)
            for page in range(first_page, last_page + 1):
                lines = veetou.pdftotext(filename, page, pages = npages).splitlines()
                karta.reset(file = filename, page = page, pages = npages)
                karta.parse_txt(lines)
                table = karta.generate_subjects_rows(**kw)
                if len(table) > 0:
                    s = u'\n'.join([ args.output_separator.join(row) for row in table ])
                    outfile.write(u"%s\n" % s)
    else:
##        kw = { 'delimiter' : args.input_separator,
##               'encoding' : args.input_encoding }
##        for filename in args.inputfile:
##            npages = veetou.csvpages(filename, **kw)
##            first_page, last_page = pagerange(npages)
##            for page in range(first_page, last_page+1):
##                pass
        raise NotImplementedError("parsing %s is not implemented yet" % args.input_type)
# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
