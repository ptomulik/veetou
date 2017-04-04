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
        self.assertEqual(dt.entityclass.__name__, 'Report')
        self.assertEqual(dt.tableclass.__name__,  'Reports')
        self.assertEqual(dt.recordclass.__name__, 'ReportRecord')
        self.assertEqual(dt.tupleclass.__name__,  'ReportTuple')
        self.assertEqual(dt.arrayclass.__name__,  'ReportArray')

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
        self.assertEqual(dt.entityclass.__name__, 'Sheet')
        self.assertEqual(dt.tableclass.__name__,  'Sheets')
        self.assertEqual(dt.recordclass.__name__, 'SheetRecord')
        self.assertEqual(dt.tupleclass.__name__,  'SheetTuple')
        self.assertEqual(dt.arrayclass.__name__,  'SheetArray')

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
        self.assertEqual(dt.entityclass.__name__, 'Page')
        self.assertEqual(dt.tableclass.__name__,  'Pages')
        self.assertEqual(dt.recordclass.__name__, 'PageRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PageTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PageArray')

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
        self.assertEqual(dt.entityclass.__name__, 'Preamble')
        self.assertEqual(dt.tableclass.__name__,  'Preambles')
        self.assertEqual(dt.recordclass.__name__, 'PreambleRecord')
        self.assertEqual(dt.tupleclass.__name__,  'PreambleTuple')
        self.assertEqual(dt.arrayclass.__name__,  'PreambleArray')

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
        self.assertEqual(dt.entityclass.__name__, 'Header')
        self.assertEqual(dt.tableclass.__name__,  'Headers')
        self.assertEqual(dt.recordclass.__name__, 'HeaderRecord')
        self.assertEqual(dt.tupleclass.__name__,  'HeaderTuple')
        self.assertEqual(dt.arrayclass.__name__,  'HeaderArray')

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
        self.assertEqual(dt.entityclass.__name__, 'Footer')
        self.assertEqual(dt.tableclass.__name__,  'Footers')
        self.assertEqual(dt.recordclass.__name__, 'FooterRecord')
        self.assertEqual(dt.tupleclass.__name__,  'FooterTuple')
        self.assertEqual(dt.arrayclass.__name__,  'FooterArray')

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
        self.assertEqual(dt.entityclass.__name__, 'Address')
        self.assertEqual(dt.tableclass.__name__,  'Addresses')
        self.assertEqual(dt.recordclass.__name__, 'AddressRecord')
        self.assertEqual(dt.tupleclass.__name__,  'AddressTuple')
        self.assertEqual(dt.arrayclass.__name__,  'AddressArray')

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
        self.assertEqual(dt.entityclass.__name__, 'Contact')
        self.assertEqual(dt.tableclass.__name__,  'Contacts')
        self.assertEqual(dt.recordclass.__name__, 'ContactRecord')
        self.assertEqual(dt.tupleclass.__name__,  'ContactTuple')
        self.assertEqual(dt.arrayclass.__name__,  'ContactArray')

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
        self.assertEqual(dt.entityclass.__name__, 'Tr')
        self.assertEqual(dt.tableclass.__name__,  'Trs')
        self.assertEqual(dt.recordclass.__name__, 'TrRecord')
        self.assertEqual(dt.tupleclass.__name__,  'TrTuple')
        self.assertEqual(dt.arrayclass.__name__,  'TrArray')

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
        self.assertEqual(dt.entityclass.__name__, 'Summary')
        self.assertEqual(dt.tableclass.__name__,  'Summaries')
        self.assertEqual(dt.recordclass.__name__, 'SummaryRecord')
        self.assertEqual(dt.tupleclass.__name__,  'SummaryTuple')
        self.assertEqual(dt.arrayclass.__name__,  'SummaryArray')

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
        self.assertIsInstance(dm.tables['reports'], tc(pzmodel_.PzReport))
        self.assertIsInstance(dm.tables['sheets'], tc(pzmodel_.PzSheet))
        self.assertIsInstance(dm.tables['pages'], tc(pzmodel_.PzPage))
        self.assertIsInstance(dm.tables['preambles'], tc(pzmodel_.PzPreamble))
        self.assertIsInstance(dm.tables['headers'], tc(pzmodel_.PzHeader))
        self.assertIsInstance(dm.tables['footers'], tc(pzmodel_.PzFooter))
        self.assertIsInstance(dm.tables['addresses'], tc(pzmodel_.PzAddress))
        self.assertIsInstance(dm.tables['contacts'], tc(pzmodel_.PzContact))
        self.assertIsInstance(dm.tables['trs'], tc(pzmodel_.PzTr))
        self.assertIsInstance(dm.tables['summaries'], tc(pzmodel_.PzSummary))

    def test__relations__1(self):
        dm = pzmodel_.PzDataModel()
        # Junctions (relations)
        self.assertIsInstance(dm.relations['report_sheets'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['sheet_pages'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['sheet_preamble'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['page_header'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['page_footer'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['header_address'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['header_contact'], veetou.model.Junction)
        self.assertIsInstance(dm.relations['page_trs'], veetou.model.Junction)

        self.assertIs(dm.relations['report_sheets'].tables[veetou.model.LEFT], dm.tables['reports'])
        self.assertIs(dm.relations['report_sheets'].tables[veetou.model.RIGHT], dm.tables['sheets'])
        self.assertEqual(dm.relations['report_sheets'].endnames, ('sheets', 'report'))

        self.assertIs(dm.relations['sheet_pages'].tables[veetou.model.LEFT], dm.tables['sheets'])
        self.assertIs(dm.relations['sheet_pages'].tables[veetou.model.RIGHT], dm.tables['pages'])
        self.assertEqual(dm.relations['sheet_pages'].endnames, ('pages', 'sheet'))

        self.assertIs(dm.relations['sheet_preamble'].tables[veetou.model.LEFT], dm.tables['sheets'])
        self.assertIs(dm.relations['sheet_preamble'].tables[veetou.model.RIGHT], dm.tables['preambles'])
        self.assertEqual(dm.relations['sheet_preamble'].endnames, ('preamble', 'sheet'))

        self.assertIs(dm.relations['page_header'].tables[veetou.model.LEFT], dm.tables['pages'])
        self.assertIs(dm.relations['page_header'].tables[veetou.model.RIGHT], dm.tables['headers'])
        self.assertEqual(dm.relations['page_header'].endnames, ('header', 'page'))

        self.assertIs(dm.relations['page_footer'].tables[veetou.model.LEFT], dm.tables['pages'])
        self.assertIs(dm.relations['page_footer'].tables[veetou.model.RIGHT], dm.tables['footers'])
        self.assertEqual(dm.relations['page_footer'].endnames, ('footer', 'page'))

        self.assertIs(dm.relations['header_address'].tables[veetou.model.LEFT], dm.tables['headers'])
        self.assertIs(dm.relations['header_address'].tables[veetou.model.RIGHT], dm.tables['addresses'])
        self.assertEqual(dm.relations['header_address'].endnames, ('address', 'header'))

        self.assertIs(dm.relations['header_contact'].tables[veetou.model.LEFT], dm.tables['headers'])
        self.assertIs(dm.relations['header_contact'].tables[veetou.model.RIGHT], dm.tables['contacts'])
        self.assertEqual(dm.relations['header_contact'].endnames, ('contact', 'header'))

        self.assertIs(dm.relations['page_trs'].tables[veetou.model.LEFT], dm.tables['pages'])
        self.assertIs(dm.relations['page_trs'].tables[veetou.model.RIGHT], dm.tables['trs'])
        self.assertEqual(dm.relations['page_trs'].endnames, ('trs', 'page'))

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
