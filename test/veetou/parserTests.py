#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.parser as parser

class Test__Parser(unittest.TestCase):
    def test__funcions_symbols__1(self):
        self.assertIs(parser.dictmatcher      , parser.functions_.dictmatcher)
        self.assertIs(parser.fullmatch        , parser.functions_.fullmatch)
        self.assertIs(parser.fullmatchdict    , parser.functions_.fullmatchdict)
        self.assertIs(parser.ifullmatch       , parser.functions_.ifullmatch)
        self.assertIs(parser.imatch           , parser.functions_.imatch)
        self.assertIs(parser.imatcher         , parser.functions_.imatcher)
        self.assertIs(parser.match            , parser.functions_.match)
        self.assertIs(parser.matchdict        , parser.functions_.matchdict)
        self.assertIs(parser.matcher          , parser.functions_.matcher)
        self.assertIs(parser.permutexpr       , parser.functions_.permutexpr)
        self.assertIs(parser.reentrant        , parser.functions_.reentrant)
        self.assertIs(parser.scatter          , parser.functions_.scatter)
        self.assertIs(parser.search           , parser.functions_.search)
        self.assertIs(parser.searchpd         , parser.functions_.searchpd)
        self.assertIs(parser.skipemptylines    , parser.functions_.skipemptylines)

    def test__parsererror_symbols__1(self):
        self.assertIs(parser.ParserError, parser.parsererror_.ParserError)

    def test__parser_symbols__1(self):
        self.assertIs(parser.Parser, parser.parser_.Parser)
        self.assertIs(parser.RootParser, parser.parser_.RootParser)

    def test__addressparser__1(self):
        self.assertIs(parser.AddressParser, parser.addressparser_.AddressParser)

    def test__contactparser__1(self):
        self.assertIs(parser.ContactParser, parser.contactparser_.ContactParser)

    def test__footerparser__1(self):
        self.assertIs(parser.FooterParser, parser.footerparser_.FooterParser)

    def test__headerparser__1(self):
        self.assertIs(parser.HeaderParser, parser.headerparser_.HeaderParser)

    def test__keymapparser__1(self):
        self.assertIs(parser.KeyMapParser, parser.keymapparser_.KeyMapParser)

    def test__pageparser__1(self):
        self.assertIs(parser.PageParser, parser.pageparser_.PageParser)

    def test__preambleparser__1(self):
        self.assertIs(parser.PreambleParser, parser.preambleparser_.PreambleParser)

    def test__reportparser__1(self):
        self.assertIs(parser.ReportParser, parser.reportparser_.ReportParser)

    def test__sheetparser__1(self):
        self.assertIs(parser.SheetParser, parser.sheetparser_.SheetParser)

    def test__summaryparser__1(self):
        self.assertIs(parser.SummaryParser, parser.summaryparser_.SummaryParser)

    def test__tableparser__1(self):
        self.assertIs(parser.TableParser, parser.tableparser_.TableParser)

    def test__tbodyparser__1(self):
        self.assertIs(parser.TbodyParser, parser.tbodyparser_.TbodyParser)

    def test__thparser__1(self):
        self.assertIs(parser.ThParser, parser.thparser_.ThParser)

    def test__trparser__1(self):
        self.assertIs(parser.TrParser, parser.trparser_.TrParser)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
