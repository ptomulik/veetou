#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.parser.sheetparser_ as sheetparser_
import veetou.parser.reportparser_ as reportparser_
import veetou.parser.parser_ as parser_
import veetou.input as input
import veetou.model as model

import io


_Report = model.declare(model.DataType, 'Report',
        ('source', 'sheets_parsed', 'pages_parsed', 'first_page'),
        plural = 'Reports'
)

_Sheet = model.declare(model.DataType, 'Sheet',

        ('pages_parsed', 'first_page'),
        plural = 'Sheets'
)

_Reports = model.tableclass(_Report)
_Sheets = model.tableclass(_Sheet)


class _DataModel(model.DataModel):
    def __init__(self):
        super().__init__()
        self.tables['reports'] = _Reports()
        self.tables['sheets'] = _Sheets()
        self.relations['report_sheets'] = model.Junction(
                (self.tables['reports'], self.tables['sheets']),
                ('sheets', 'report')
        )

class _ReportParser(reportparser_.ReportParser):
    def create_datamodel(self, **kw):
        return _DataModel(**kw)
    def create_sheet_parser(self, **kw):
        return _SheetParser(**kw)

class _SheetParser(sheetparser_.SheetParser):

    __slots__ = ('before', 'after')

    def __init__(self, *args, **kw):
        super().__init__(*args, **kw)
        self.before = 0
        self.after = 0

    def create_page_parser(self, **kw):
        return _PageParser(**kw)

    def parse_before_pages(self, iterator, kw):
        self.before += 1
        return True

    def parse_after_pages(self, iterator, kw):
        self.after += 1
        return True

class _PageParser(parser_.Parser):
    def parse(self, iterator):
        for line in iterator:
            if line.strip() == '.':
                return True
            elif line.strip() == '=':
                self.parent.next_sheet_parsed()
                return True
        self.parent.next_sheet_parsed()
        return True

class Test__SheetParser(unittest.TestCase):
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
        self.assertTrue(issubclass(sheetparser_.SheetParser, parser_.Parser))

    def test__abstract__1(self):
        with self.assertRaisesRegex(TypeError, r'abstract methods?'):
            sheetparser_.SheetParser()

    def test__init__1(self):
        root = _ReportParser()
        parser = root.sheet_parser
        self.assertIsInstance(parser.page_parser, _PageParser)
        self.assertEqual(parser.pages_parsed, 0)
        self.assertEqual(parser.first_page, 1)
        self.assertFalse(parser.sheet_complete)

    def test__parse__1(self):
        lines = input.InputLines(io.StringIO(self.text))
        lines = input.BufferedIterator(lines)
        root = _ReportParser()
        parser = root.sheet_parser
        self.assertTrue(root.parse(lines))
        self.assertEqual(root.sheets_parsed, 2)
        self.assertEqual(root.pages_parsed, 4)
        self.assertEqual(root.first_page, 1)
        self.assertEqual(parser.pages_parsed, 2)
        self.assertEqual(parser.first_page, 3)
        self.assertEqual(parser.before, 2)
        self.assertEqual(parser.after, 2)
        sheets = parser.datamodel.tables['sheets']
        self.assertEqual(len(sheets),2)
        self.assertEqual(sheets[0]['pages_parsed'], 2)
        self.assertEqual(sheets[0]['first_page'], 1)
        self.assertEqual(sheets[1]['pages_parsed'], 2)
        self.assertEqual(sheets[1]['first_page'], 3)

    def test__parse__2(self):
        lines = input.InputLines(io.StringIO(self.text))
        lines = input.BufferedIterator(lines)
        root = _ReportParser(True)
        parser = root.sheet_parser
        self.assertTrue(root.parse(lines))
        self.assertEqual(root.sheets_parsed, 2)
        self.assertEqual(root.pages_parsed, 4)
        self.assertEqual(root.first_page, 1)
        self.assertEqual(parser.pages_parsed, 2)
        self.assertEqual(parser.first_page, 3)
        sheets = parser.datamodel.tables['sheets']
        self.assertEqual(len(sheets),0)

    def test__parse__3(self):
        lines = input.InputLines(io.StringIO(self.text))
        lines = input.BufferedIterator(lines)
        root = _ReportParser()
        parser = root.sheet_parser
        self.assertTrue(root.parse(lines, first_page=20))
        self.assertEqual(root.sheets_parsed, 2)
        self.assertEqual(root.pages_parsed, 4)
        self.assertEqual(root.first_page, 20)
        self.assertEqual(parser.pages_parsed, 2)
        self.assertEqual(parser.first_page, 22)
        sheets = parser.datamodel.tables['sheets']
        self.assertEqual(len(sheets),2)
        self.assertEqual(sheets[0]['pages_parsed'], 2)
        self.assertEqual(sheets[0]['first_page'], 20)
        self.assertEqual(sheets[1]['pages_parsed'], 2)
        self.assertEqual(sheets[1]['first_page'], 22)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
