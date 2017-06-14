#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.pz.pzmodel_ as pzmodel_
import veetou.model.datatype_ as datatype_
import veetou.model.keystuple_ as keystuple_
import veetou.model

class Test__PzReport(unittest.TestCase):
    def test__type_1(self):
        self.assertIsInstance(pzmodel_.PzReport, datatype_.DataType)

    def test__names__1(self):
        dt = pzmodel_.PzReport
        self.assertEqual(dt.entityclass.__name__, 'PzReport')
        self.assertEqual(dt.tableclass.__name__,  'PzReports')
        self.assertEqual(dt.recordclass.__name__, 'PzReportRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PzReportTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PzReportArray')

    def test__keys__1(self):
        dt = pzmodel_.PzReport
        keys = ( 'source', 'datetime', 'first_page', 'sheets_parsed', 'pages_parsed' )
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(keys))

##    def test__types__1(self):
##        dt = pzmodel_.PzReport
##        types = (  str,          str,       str )
##        self.assertEqual(dt.types(), types)

class Test__PzSheet(unittest.TestCase):
    def test__type_1(self):
        self.assertIsInstance(pzmodel_.PzSheet, datatype_.DataType)

    def test__names__1(self):
        dt = pzmodel_.PzSheet
        self.assertEqual(dt.entityclass.__name__, 'PzSheet')
        self.assertEqual(dt.tableclass.__name__,  'PzSheets')
        self.assertEqual(dt.recordclass.__name__, 'PzSheetRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PzSheetTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PzSheetArray')

    def test__keys__1(self):
        dt = pzmodel_.PzSheet
        keys = ( 'pages_parsed', 'first_page' )
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(keys))

##    def test__types__1(self):
##        dt = pzmodel_.PzSheet
##        types = (  str,          str,       str )
##        self.assertEqual(dt.types(), types)

class Test__PzPage(unittest.TestCase):
    def test__type_1(self):
        self.assertIsInstance(pzmodel_.PzPage, datatype_.DataType)

    def test__names__1(self):
        dt = pzmodel_.PzPage
        self.assertEqual(dt.entityclass.__name__, 'PzPage')
        self.assertEqual(dt.tableclass.__name__,  'PzPages')
        self.assertEqual(dt.recordclass.__name__, 'PzPageRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PzPageTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PzPageArray')

    def test__keys__1(self):
        dt = pzmodel_.PzPage
        keys = ( 'page_number', 'parser_page_number' )
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(keys))

##    def test__types__1(self):
##        dt = pzmodel_.PzPage
##        types = (  str,          str,       str )
##        self.assertEqual(dt.types(), types)

class Test__PzPreamble(unittest.TestCase):
    def test__type_1(self):
        self.assertIsInstance(pzmodel_.PzPreamble, datatype_.DataType)

    def test__names__1(self):
        dt = pzmodel_.PzPreamble
        self.assertEqual(dt.entityclass.__name__, 'PzPreamble')
        self.assertEqual(dt.tableclass.__name__,  'PzPreambles')
        self.assertEqual(dt.recordclass.__name__, 'PzPreambleRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PzPreambleTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PzPreambleArray')

    def test__keys__1(self):
        dt = pzmodel_.PzPreamble
        keys = ( 'town', 'date', 'time', 'title', 'exam', 'sheet_id',
                 'semester_code', 'sheet_serie', 'sheet_number', 'return_desc',
                 'return_date', 'subj_name','subj_code', 'subj_department',
                 'subj_tutor', 'subj_grades', 'subj_cond' )
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(keys))

##    def test__types__1(self):
##        dt = pzmodel_.PzPreamble
##        types = 16 * (str,)
##        self.assertEqual(dt.types(), types)

class Test__PzHeader(unittest.TestCase):
    def test__type_1(self):
        self.assertIsInstance(pzmodel_.PzHeader, datatype_.DataType)

    def test__names__1(self):
        dt = pzmodel_.PzHeader
        self.assertEqual(dt.entityclass.__name__, 'PzHeader')
        self.assertEqual(dt.tableclass.__name__,  'PzHeaders')
        self.assertEqual(dt.recordclass.__name__, 'PzHeaderRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PzHeaderTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PzHeaderArray')

    def test__keys__1(self):
        dt = pzmodel_.PzHeader
        keys = (  'university', 'faculty', 'entity' )
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(keys))

##    def test__types__1(self):
##        dt = pzmodel_.PzHeader
##        types = (  str,          str,       str )
##        self.assertEqual(dt.types(), types)

class Test__PzFooter(unittest.TestCase):
    def test__type_1(self):
        self.assertIsInstance(pzmodel_.PzFooter, datatype_.DataType)

    def test__names__1(self):
        dt = pzmodel_.PzFooter
        self.assertEqual(dt.entityclass.__name__, 'PzFooter')
        self.assertEqual(dt.tableclass.__name__,  'PzFooters')
        self.assertEqual(dt.recordclass.__name__, 'PzFooterRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PzFooterTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PzFooterArray')

    def test__keys__1(self):
        dt = pzmodel_.PzFooter
        keys = ( 'pagination', 'sheet_page_number', 'sheet_pages_total',
                 'title', 'subj_name', 'subj_code', 'sheet_id', 'semester_code',
                 'sheet_serie', 'sheet_number', 'generator_name',
                 'generator_home', 'sig_prompt')
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(keys))

##    def test__types__1(self):
##        dt = pzmodel_.PzFooter
##        types = (  str,          str,       str )
##        self.assertEqual(dt.types(), types)

class Test__PzAddress(unittest.TestCase):
    def test__type_1(self):
        self.assertIsInstance(pzmodel_.PzAddress, datatype_.DataType)

    def test__names__1(self):
        dt = pzmodel_.PzAddress
        self.assertEqual(dt.entityclass.__name__, 'PzAddress')
        self.assertEqual(dt.tableclass.__name__,  'PzAddresses')
        self.assertEqual(dt.recordclass.__name__, 'PzAddressRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PzAddressTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PzAddressArray')

    def test__keys__1(self):
        dt = pzmodel_.PzAddress
        keys  = ( 'street_prefix',   'street_name', 'street_number', 'postoffice_zip',
                  'postoffice_town', 'edifice',     'room',          'website' )
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(keys))

##    def test__types__1(self):
##        dt = pzmodel_.PzAddress
##        types = ( str,               str,           str,             str,
##                  str,               str,           str,             str )
##        self.assertEqual(dt.types(), types)

class Test__PzContact(unittest.TestCase):
    def test__type_1(self):
        self.assertIsInstance(pzmodel_.PzContact, datatype_.DataType)

    def test__names__1(self):
        dt = pzmodel_.PzContact
        self.assertEqual(dt.entityclass.__name__, 'PzContact')
        self.assertEqual(dt.tableclass.__name__,  'PzContacts')
        self.assertEqual(dt.recordclass.__name__, 'PzContactRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PzContactTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PzContactArray')

    def test__keys__1(self):
        dt = pzmodel_.PzContact
        keys =  ( 'phone_prefix', 'phone_numbers', 'faxtel_prefix', 'faxtel_numbers',
                  'email_prefix', 'email_address' )
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(keys))

##    def test__types__1(self):
##        dt = pzmodel_.PzContact
##        types = ( str,            str,             str,              str,
##                  str,            str             )
##        self.assertEqual(dt.types(), types)

class Test__PzTr(unittest.TestCase):
    def test__type_1(self):
        self.assertIsInstance(pzmodel_.PzTr, datatype_.DataType)

    def test__names__1(self):
        dt = pzmodel_.PzTr
        self.assertEqual(dt.entityclass.__name__, 'PzTr')
        self.assertEqual(dt.tableclass.__name__,  'PzTrs')
        self.assertEqual(dt.recordclass.__name__, 'PzTrRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PzTrTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PzTrArray')

    def test__keys__1(self):
        dt = pzmodel_.PzTr
        keys = (  'tr_ord_no', 'student_name', 'student_index', 'subj_grade',
                  'subj_grade_final', 'subj_grade_project', 'subj_grade_lecture',
                  'subj_grade_class', 'subj_grade_p', 'subj_grade_n',
                  'tr_remarks' )
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(keys))

##    def test__types__1(self):
##        dt = pzmodel_.PzTr
##        types = 11 * (str,)
##        self.assertEqual(dt.types(), types)

class Test__PzSummary(unittest.TestCase):
    def test__type_1(self):
        self.assertIsInstance(pzmodel_.PzSummary, datatype_.DataType)

    def test__names__1(self):
        dt = pzmodel_.PzSummary
        self.assertEqual(dt.entityclass.__name__, 'PzSummary')
        self.assertEqual(dt.tableclass.__name__,  'PzSummaries')
        self.assertEqual(dt.recordclass.__name__, 'PzSummaryRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PzSummaryTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PzSummaryArray')

    def test__keys__1(self):
        dt = pzmodel_.PzSummary
        keys =  ( 'caption', 'th', 'content' )
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(keys))

##    def test__types__1(self):
##        dt = pzmodel_.PzSummary
##        types = ( str,            str,             str,              str,
##                  str,            str             )
##        self.assertEqual(dt.types(), types)

class Test__PzDataModel(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(pzmodel_.PzDataModel, veetou.model.DataModel)

    def test__tables__1(self):
        dm = pzmodel_.PzDataModel()
        tc = veetou.model.tableclass
        # Tables
        self.assertIsInstance(dm.tables['pz_reports'], tc(pzmodel_.PzReport))
        self.assertIsInstance(dm.tables['pz_sheets'], tc(pzmodel_.PzSheet))
        self.assertIsInstance(dm.tables['pz_pages'], tc(pzmodel_.PzPage))
        self.assertIsInstance(dm.tables['pz_preambles'], tc(pzmodel_.PzPreamble))
        self.assertIsInstance(dm.tables['pz_headers'], tc(pzmodel_.PzHeader))
        self.assertIsInstance(dm.tables['pz_footers'], tc(pzmodel_.PzFooter))
        self.assertIsInstance(dm.tables['pz_addresses'], tc(pzmodel_.PzAddress))
        self.assertIsInstance(dm.tables['pz_contacts'], tc(pzmodel_.PzContact))
        self.assertIsInstance(dm.tables['pz_trs'], tc(pzmodel_.PzTr))
        self.assertIsInstance(dm.tables['pz_summaries'], tc(pzmodel_.PzSummary))

    def test__relations__1(self):
        dm = pzmodel_.PzDataModel()
        # Junctions (relations)
        self.assertIsInstance(dm.relations['pz_report_sheets'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['pz_sheet_pages'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['pz_sheet_preamble'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['pz_page_header'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['pz_page_footer'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['pz_header_address'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['pz_header_contact'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['pz_page_trs'], veetou.model.Junction)

        self.assertIs(dm.relations['pz_report_sheets'].tables[veetou.model.LEFT], dm.tables['pz_reports'])
        self.assertIs(dm.relations['pz_report_sheets'].tables[veetou.model.RIGHT], dm.tables['pz_sheets'])
        self.assertEqual(dm.relations['pz_report_sheets'].endnames, ('pz_sheets', 'pz_report'))

        self.assertIs(dm.relations['pz_sheet_pages'].tables[veetou.model.LEFT], dm.tables['pz_sheets'])
        self.assertIs(dm.relations['pz_sheet_pages'].tables[veetou.model.RIGHT], dm.tables['pz_pages'])
        self.assertEqual(dm.relations['pz_sheet_pages'].endnames, ('pz_pages', 'pz_sheet'))

        self.assertIs(dm.relations['pz_sheet_preamble'].tables[veetou.model.LEFT], dm.tables['pz_sheets'])
        self.assertIs(dm.relations['pz_sheet_preamble'].tables[veetou.model.RIGHT], dm.tables['pz_preambles'])
        self.assertEqual(dm.relations['pz_sheet_preamble'].endnames, ('pz_preamble', 'pz_sheet'))

        self.assertIs(dm.relations['pz_page_header'].tables[veetou.model.LEFT], dm.tables['pz_pages'])
        self.assertIs(dm.relations['pz_page_header'].tables[veetou.model.RIGHT], dm.tables['pz_headers'])
        self.assertEqual(dm.relations['pz_page_header'].endnames, ('pz_header', 'pz_page'))

        self.assertIs(dm.relations['pz_page_footer'].tables[veetou.model.LEFT], dm.tables['pz_pages'])
        self.assertIs(dm.relations['pz_page_footer'].tables[veetou.model.RIGHT], dm.tables['pz_footers'])
        self.assertEqual(dm.relations['pz_page_footer'].endnames, ('pz_footer', 'pz_page'))

        self.assertIs(dm.relations['pz_header_address'].tables[veetou.model.LEFT], dm.tables['pz_headers'])
        self.assertIs(dm.relations['pz_header_address'].tables[veetou.model.RIGHT], dm.tables['pz_addresses'])
        self.assertEqual(dm.relations['pz_header_address'].endnames, ('pz_address', 'pz_header'))

        self.assertIs(dm.relations['pz_header_contact'].tables[veetou.model.LEFT], dm.tables['pz_headers'])
        self.assertIs(dm.relations['pz_header_contact'].tables[veetou.model.RIGHT], dm.tables['pz_contacts'])
        self.assertEqual(dm.relations['pz_header_contact'].endnames, ('pz_contact', 'pz_header'))

        self.assertIs(dm.relations['pz_page_trs'].tables[veetou.model.LEFT], dm.tables['pz_pages'])
        self.assertIs(dm.relations['pz_page_trs'].tables[veetou.model.RIGHT], dm.tables['pz_trs'])
        self.assertEqual(dm.relations['pz_page_trs'].endnames, ('pz_trs', 'pz_page'))

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
