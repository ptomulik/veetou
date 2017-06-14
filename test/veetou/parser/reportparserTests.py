#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.parser.reportparser_ as reportparser_
import veetou.parser.parser_ as parser_
import veetou.model.datamodel_ as datamodel_
import veetou.model as model
import veetou.input as input

import io

_Report = model.declare(model.DataType, 'Report',

        ('source', 'sheets_parsed', 'pages_parsed', 'first_page'),
        plural = 'Reports'
)
_Reports = model.tableclass(_Report)

class _DataModel(model.DataModel):
    def __init__(self):
        super().__init__()
        self.tables['reports'] = _Reports()

class _SheetParser(parser_.Parser):
    def parse(self, iterator):
        for line in iterator:
            if line.strip() == '=':
                self.root.next_page_parsed()
                return True # sheet parsed too
            elif line.strip() == '.':
                self.root.next_page_parsed()
        self.root.next_page_parsed()
        return True

class _ReportParser(reportparser_.ReportParser):

    __slots__ = ('before', 'after')

    def __init__(self, *args, **kw):
        super().__init__(*args, **kw)
        self.before = 0
        self.after = 0

    @property
    def table(self):
        return self.prefixed_table

    @property
    def endpoint(self):
        return self.prefixed_endpoint

    def create_datamodel(self, **kw):
        return _DataModel(**kw)

    def create_sheet_parser(self, **kw):
        return _SheetParser(**kw)

    def parse_before_sheets(self, iterator, kw):
        self.before += 1
        return True

    def parse_after_sheets(self, iterator, kw):
        self.after += 1
        return True


class Test__ReportParser(unittest.TestCase):
    text="""sheet 1 page 1 line 1
            sheet 1 page 1 line 2
            .
            sheet 1 page 2 line 4
            sheet 1 page 2 line 5
            =
            sheet 2 page 3 line 7
            .
            sheet 2 page 4 line 9"""

    def test__subclass__1(self):
        self.assertTrue(issubclass(reportparser_.ReportParser, parser_.RootParser))

    def test__abstract__1(self):
        with self.assertRaisesRegex(TypeError, r'abstract methods?'):
            reportparser_.ReportParser()

    def test__init__1(self):
        parser = _ReportParser()
        self.assertIsInstance(parser.datamodel, _DataModel)
        self.assertIsInstance(parser.sheet_parser, _SheetParser)
        self.assertFalse(parser.datamodel_disabled)
        self.assertEqual(parser.sheets_parsed, 0)
        self.assertEqual(parser.pages_parsed, 0)
        self.assertEqual(parser.first_page, 1)

    def test__parse__1(self):
        lines = input.InputLines(io.StringIO(self.text))
        lines = input.BufferedIterator(lines)
        parser = _ReportParser()
        self.assertTrue(parser.parse(lines))
        self.assertEqual(parser.sheets_parsed, 2)
        self.assertEqual(parser.pages_parsed, 4)
        self.assertEqual(parser.first_page, 1)
        self.assertEqual(parser.before, 1)
        self.assertEqual(parser.after, 1)
        reports = parser.datamodel.tables['reports']
        self.assertEqual(len(reports),1)
        self.assertIsNone(reports[0]['source'])
        self.assertEqual(reports[0]['sheets_parsed'], 2)
        self.assertEqual(reports[0]['pages_parsed'], 4)
        self.assertEqual(reports[0]['first_page'], 1)

    def test__parse__2(self):
        lines = input.InputLines(io.StringIO(self.text))
        lines = input.BufferedIterator(lines)
        parser = _ReportParser(True)
        self.assertTrue(parser.parse(lines))
        self.assertEqual(parser.sheets_parsed, 2)
        self.assertEqual(parser.pages_parsed, 4)
        self.assertEqual(parser.first_page, 1)
        self.assertEqual(parser.before, 1)
        self.assertEqual(parser.after, 1)
        reports = parser.datamodel.tables['reports']
        self.assertEqual(len(reports),0)

    def test__parse__3(self):
        lines = input.InputLines(io.StringIO(self.text))
        lines = input.BufferedIterator(lines)
        parser = _ReportParser()
        self.assertTrue(parser.parse(lines, source='foo.pdf', first_page=20))
        self.assertEqual(parser.sheets_parsed, 2)
        self.assertEqual(parser.pages_parsed, 4)
        self.assertEqual(parser.first_page, 20)
        self.assertEqual(parser.before, 1)
        self.assertEqual(parser.after, 1)
        reports = parser.datamodel.tables['reports']
        self.assertEqual(len(reports),1)
        self.assertEqual(reports[0]['source'], 'foo.pdf')
        self.assertEqual(reports[0]['sheets_parsed'], 2)
        self.assertEqual(reports[0]['pages_parsed'], 4)
        self.assertEqual(reports[0]['first_page'], 20)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
