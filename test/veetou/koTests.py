#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.ko as ko

class Test__Ko(unittest.TestCase):
    def test__komodel__symbols_1(self):
        self.assertIs(ko.komodel_.KoReport, ko.KoReport),
        self.assertIs(ko.komodel_.KoSheet, ko.KoSheet),
        self.assertIs(ko.komodel_.KoPage, ko.KoPage),
        self.assertIs(ko.komodel_.KoPreamble, ko.KoPreamble),
        self.assertIs(ko.komodel_.KoHeader, ko.KoHeader),
        self.assertIs(ko.komodel_.KoFooter, ko.KoFooter),
        self.assertIs(ko.komodel_.KoTbody, ko.KoTbody),
        self.assertIs(ko.komodel_.KoTr, ko.KoTr),
        self.assertIs(ko.komodel_.KoDataModel, ko.KoDataModel)

    def test__koreportparser_symbols__1(self):
        self.assertIs(ko.koreportparser_.KoReportParser, ko.KoReportParser)

    def test__kosheetparser_symbols__1(self):
        self.assertIs(ko.kosheetparser_.KoSheetParser, ko.KoSheetParser)

    def test__kopageparser_symbols__1(self):
        self.assertIs(ko.kopageparser_.KoPageParser, ko.KoPageParser)

    def test__koheaderparser_symbols__1(self):
        self.assertIs(ko.koheaderparser_.KoHeaderParser, ko.KoHeaderParser)

    def test__kofooterparser_symbols__1(self):
        self.assertIs(ko.kofooterparser_.KoFooterParser, ko.KoFooterParser)

    def test__kopreambleparser_symbols__1(self):
        self.assertIs(ko.kopreambleparser_.KoPreambleParser, ko.KoPreambleParser)

    def test__kotableparser_symbols__1(self):
        self.assertIs(ko.kotableparser_.KoTableParser, ko.KoTableParser)

    def test__koaddressparser_symbols__1(self):
        self.assertIs(ko.koaddressparser_.KoAddressParser, ko.KoAddressParser)

    def test__kocontactparser_symbols__1(self):
        self.assertIs(ko.kocontactparser_.KoContactParser, ko.KoContactParser)

    def test__kothparser_symbols__1(self):
        self.assertIs(ko.kothparser_.KoThParser, ko.KoThParser)

    def test__kotrparser_symbols__1(self):
        self.assertIs(ko.kotrparser_.KoTrParser, ko.KoTrParser)

    def test__kotbodyparser_symbols__1(self):
        self.assertIs(ko.kotbodyparser_.KoTbodyParser, ko.KoTbodyParser)

    def test__kosummaryparser_symbols__1(self):
        self.assertIs(ko.kosummaryparser_.KoSummaryParser, ko.KoSummaryParser)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
