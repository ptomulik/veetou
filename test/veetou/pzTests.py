#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.pz as pz

class Test__Pz(unittest.TestCase):
    def test__pzmodel__symbols_1(self):
        self.assertIs(pz.pzmodel_.PzReport, pz.PzReport),
        self.assertIs(pz.pzmodel_.PzSheet, pz.PzSheet),
        self.assertIs(pz.pzmodel_.PzPage, pz.PzPage),
        self.assertIs(pz.pzmodel_.PzPreamble, pz.PzPreamble),
        self.assertIs(pz.pzmodel_.PzHeader, pz.PzHeader),
        self.assertIs(pz.pzmodel_.PzFooter, pz.PzFooter),
        self.assertIs(pz.pzmodel_.PzAddress, pz.PzAddress),
        self.assertIs(pz.pzmodel_.PzContact, pz.PzContact),
        self.assertIs(pz.pzmodel_.PzTr, pz.PzTr),
        self.assertIs(pz.pzmodel_.PzSummary, pz.PzSummary)
        self.assertIs(pz.pzmodel_.PzDataModel, pz.PzDataModel)

    def test__pzreportparser_symbols__1(self):
        self.assertIs(pz.pzreportparser_.PzReportParser, pz.PzReportParser)

    def test__pzsheetparser_symbols__1(self):
        self.assertIs(pz.pzsheetparser_.PzSheetParser, pz.PzSheetParser)

    def test__pzpageparser_symbols__1(self):
        self.assertIs(pz.pzpageparser_.PzPageParser, pz.PzPageParser)

    def test__pzheaderparser_symbols__1(self):
        self.assertIs(pz.pzheaderparser_.PzHeaderParser, pz.PzHeaderParser)

    def test__pzfooterparser_symbols__1(self):
        self.assertIs(pz.pzfooterparser_.PzFooterParser, pz.PzFooterParser)

    def test__pzpreambleparser_symbols__1(self):
        self.assertIs(pz.pzpreambleparser_.PzPreambleParser, pz.PzPreambleParser)

    def test__pztableparser_symbols__1(self):
        self.assertIs(pz.pztableparser_.PzTableParser, pz.PzTableParser)

    def test__pzaddressparser_symbols__1(self):
        self.assertIs(pz.pzaddressparser_.PzAddressParser, pz.PzAddressParser)

    def test__pzcontactparser_symbols__1(self):
        self.assertIs(pz.pzcontactparser_.PzContactParser, pz.PzContactParser)

    def test__pzthparser_symbols__1(self):
        self.assertIs(pz.pzthparser_.PzThParser, pz.PzThParser)

    def test__pztrparser_symbols__1(self):
        self.assertIs(pz.pztrparser_.PzTrParser, pz.PzTrParser)

    def test__pztbodyparser_symbols__1(self):
        self.assertIs(pz.pztbodyparser_.PzTbodyParser, pz.PzTbodyParser)

    def test__pzsummaryparser_symbols__1(self):
        self.assertIs(pz.pzsummaryparser_.PzSummaryParser, pz.PzSummaryParser)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
