#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.pz.pzreportparser_ as pzreportparser_
import veetou.pz.pzsheetparser_ as pzsheetparser_
import veetou.parser as parser

try:
    from test.veetou.pz.pzparsertestcase_ import PzParserTestCase
except ImportError:
    from pzparsertestcase_ import PzParserTestCase

class Test__PzReportParser(PzParserTestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(pzreportparser_.PzReportParser, parser.ReportParser))

    def test__init__1(self):
        parser = pzreportparser_.PzReportParser()
        self.assertIsInstance(parser.sheet_parser, pzsheetparser_.PzSheetParser)

##    def test__sheet_parser__1(self):
##        parser = pzreportparser_.PzReportParser()
##        self.assertIsInstance(parser.sheet_parser, pzreportparser_.PzSheetParser)
##        self.assertIs(parser.sheet_parser, parser._sheet_parser)
##        self.assertTrue(parser.sheet_parser in parser.children)
##
##    def test__sheet_parser_setter__1(self):
##        parser = pzreportparser_.PzReportParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.sheet_parser = 'foo'
##
##    def test__parse_local__1(self):
##        parser = pzreportparser_.PzReportParser()
##        iterator = self.mkBufferedIterator([])
##        ts = datetime.datetime.now()
##        kw = {  'source'      : 'foo.pdf',
##                'pages_total' : 10,
##                'first_page'  : 2,
##                'last_page'   : 12,
##                'timestamp'   : ts }
##        self.assertTrue(parser.parse_local(iterator,**kw))
##        table = parser.datamodel.tables['reports']
##        entity = veetou.model.entityclass(table)
##        self.assertEqual(len(table), 1)
##        self.assertEqual(table[table.last_append_id], entity(('foo.pdf', 10, 2, 12, ts)))
##
##    def test__parse_local__2(self):
##        parser = pzreportparser_.PzReportParser()
##        iterator = self.mkBufferedIterator([])
##        self.assertTrue(parser.parse_local(iterator))
##        table = parser.datamodel.tables['reports']
##        entity = veetou.model.entityclass(table)
##        self.assertEqual(len(table), 1)
##        self.assertEqual(table[table.last_append_id], entity())

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
