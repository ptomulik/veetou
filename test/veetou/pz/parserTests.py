#!/usr/bin/env python3
# -*- coding: utf8 -*-


##import unittest
##import veetou.pz.parser_ as parser_
##import veetou.parser
##import veetou.model
###import veetou.parser.bufferediterator_ as bufferediterator_
##
##import veetou.input.bufferediterator_ as bufferediterator_
##import veetou.input.inputlines_ as inputlines_
##
##import re
##import io
##import itertools
##import datetime
##
##class PzParserTestCase(unittest.TestCase):
##    def assertRegexFullMatch(self, s, r, msg=None):
##        try: p = r.pattern
##        except AttributeError: p = r
##        try: f = r.flags
##        except AttributeError: f = 0
##        if not p.startswith('^') and not p.startswith(r'\A'):
##            p = r'\A' + p
##        if not p.endswith('$') and not p.endswith(r'\Z'):
##            p = p + r'\Z'
##        r = re.compile(p, f)
##        self.assertRegex(s, r, msg)
##
##    def mkInputLines(self, strings):
##        return inputlines_.InputLines(io.StringIO('\n'.join(strings)))
##
##    def mkBufferedIterator(self, strings):
##        return parser_.BufferedIterator(self.mkInputLines(strings))
##
##class Test__scatter(PzParserTestCase):
##    def test__scatter__1(self):
##        pat = r'f {,1}o {,1}o'
##        self.assertEqual(parser_._scatter(r'foo'), pat)
##
##    def test__scatter__2(self):
##        pat = r'o {,1}n {,1}e +t {,1}w {,1}o +t {,1}h {,1}r {,1}e {,1}e'
##        self.assertEqual(parser_._scatter(r'one two three'), pat)
##
##    def test__scatter__3(self):
##        pat = r'o {,3}n {,3}e +t {,3}w {,3}o +t {,3}h {,3}r {,3}e {,3}e'
##        self.assertEqual(parser_._scatter(r'one two three', 3), pat)
##
##class Test__PzDocumentParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzDocumentParser, veetou.parser.RootParser))
##
##    def test__sheet_parser__1(self):
##        parser = parser_.PzDocumentParser()
##        self.assertIsInstance(parser.sheet_parser, parser_.PzSheetParser)
##        self.assertIs(parser.sheet_parser, parser._sheet_parser)
##        self.assertTrue(parser.sheet_parser in parser.children)
##
##    def test__sheet_parser_setter__1(self):
##        parser = parser_.PzDocumentParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.sheet_parser = 'foo'
##
##    def test__parse_local__1(self):
##        parser = parser_.PzDocumentParser()
##        iterator = self.mkBufferedIterator([])
##        ts = datetime.datetime.now()
##        kw = {  'source'      : 'foo.pdf',
##                'pages_total' : 10,
##                'first_page'  : 2,
##                'last_page'   : 12,
##                'timestamp'   : ts }
##        self.assertTrue(parser.parse_local(iterator,**kw))
##        table = parser.datamodel.tables['documents']
##        entity = veetou.model.entityclass(table)
##        self.assertEqual(len(table), 1)
##        self.assertEqual(table[table.last_append_id], entity(('foo.pdf', 10, 2, 12, ts)))
##
##    def test__parse_local__2(self):
##        parser = parser_.PzDocumentParser()
##        iterator = self.mkBufferedIterator([])
##        self.assertTrue(parser.parse_local(iterator))
##        table = parser.datamodel.tables['documents']
##        entity = veetou.model.entityclass(table)
##        self.assertEqual(len(table), 1)
##        self.assertEqual(table[table.last_append_id], entity())
##
##class Test__PzSheetParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzSheetParser, veetou.parser.Parser))
##
##    def test__page_parser__1(self):
##        parser = parser_.PzSheetParser()
##        self.assertIsInstance(parser.page_parser, parser_.PzPageParser)
##        self.assertIs(parser.page_parser, parser._page_parser)
##        self.assertTrue(parser.page_parser in parser.children)
##
##    def test__page_parser_setter__1(self):
##        parser = parser_.PzSheetParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.page_parser = 'foo'
##
##class Test__PzPageParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzPageParser, veetou.parser.Parser))
##
##    def test__header_parser__1(self):
##        parser = parser_.PzPageParser()
##        self.assertIsInstance(parser.header_parser, parser_.PzHeaderParser)
##        self.assertIs(parser.header_parser, parser._header_parser)
##        self.assertTrue(parser.header_parser in parser.children)
##
##    def test__header_parser_setter__1(self):
##        parser = parser_.PzPageParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.header_parser = 'foo'
##
##    def test__footer_parser__1(self):
##        parser = parser_.PzPageParser()
##        self.assertIsInstance(parser.footer_parser, parser_.PzFooterParser)
##        self.assertIs(parser.footer_parser, parser._footer_parser)
##        self.assertTrue(parser.footer_parser in parser.children)
##
##    def test__footer_parser_setter__1(self):
##        parser = parser_.PzPageParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.footer_parser = 'foo'
##
##    def test__preamble_parser__1(self):
##        parser = parser_.PzPageParser()
##        self.assertIsInstance(parser.preamble_parser, parser_.PzPreambleParser)
##        self.assertIs(parser.preamble_parser, parser._preamble_parser)
##        self.assertTrue(parser.preamble_parser in parser.children)
##
##    def test__preamble_parser_setter__1(self):
##        parser = parser_.PzPageParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.preamble_parser = 'foo'
##
##    def test__table_parser__1(self):
##        parser = parser_.PzPageParser()
##        self.assertIsInstance(parser.table_parser, parser_.PzTableParser)
##        self.assertIs(parser.table_parser, parser._table_parser)
##        self.assertTrue(parser.table_parser in parser.children)
##
##    def test__table_parser_setter__1(self):
##        parser = parser_.PzPageParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.table_parser = 'foo'
##
##    def test__summary_parser__1(self):
##        parser = parser_.PzPageParser()
##        self.assertIsInstance(parser.summary_parser, parser_.PzSummaryParser)
##        self.assertIs(parser.summary_parser, parser._summary_parser)
##        self.assertTrue(parser.summary_parser in parser.children)
##
##    def test__summary_parser_setter__1(self):
##        parser = parser_.PzPageParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.summary_parser = 'foo'
##
##class Test__PzHeaderParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzHeaderParser, veetou.parser.Parser))
##
##    def test__address_parser__1(self):
##        parser = parser_.PzHeaderParser()
##        self.assertIsInstance(parser.address_parser, parser_.PzAddressParser)
##        self.assertIs(parser.address_parser, parser._address_parser)
##        self.assertTrue(parser.address_parser in parser.children)
##
##    def test__address_parser_setter__1(self):
##        parser = parser_.PzHeaderParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.address_parser = 'foo'
##
##    def test__contact_parser__1(self):
##        parser = parser_.PzHeaderParser()
##        self.assertIsInstance(parser.contact_parser, parser_.PzContactParser)
##        self.assertIs(parser.contact_parser, parser._contact_parser)
##        self.assertTrue(parser.address_parser in parser.children)
##
##    def test__contact_parser_setter__1(self):
##        parser = parser_.PzHeaderParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.contact_parser = 'foo'
##
##    def test__pd_university__1(self):
##        pd = parser_.PzHeaderParser._pd_university[r'POLITECHNIKA WARSZAWSKA']
##        self.assertRegexFullMatch('POLITECHNIKA WARSZAWSKA', pd)
##        self.assertRegexFullMatch('POLITECHNIKI WARSZAWSKIEJ', pd)
##        self.assertRegexFullMatch('P O L I T E C H N I K A   W A R S Z A W S K A', pd)
##        self.assertRegexFullMatch('P O L I T E C H N I K I   W A R S Z A W S K I E J', pd)
##
##    def test__pd_faculty__1(self):
##        pd = parser_.PzHeaderParser._pd_faculty[r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA']
##        self.assertRegexFullMatch('WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA', pd)
##        self.assertRegexFullMatch('W Y D Z I A Ł    M E C H A N I C Z N Y   E N E R G E T Y K I     I   L O T N I C T W A', pd)
##
##    def test__pd_faculty__2(self):
##        pd = parser_.PzHeaderParser._pd_faculty[r'WYDZIAŁ GEODEZJI I KARTOGRAFII']
##        self.assertRegexFullMatch('WYDZIAŁ GEODEZJI I KARTOGRAFII', pd)
##        self.assertRegexFullMatch('W Y D Z I A Ł    G E O D E Z J I     I   K A R T O G R A F I I', pd)
##
##    def test__match__1(self):
##        header = \
##"""\
##                                                                                        POLITECHNIKA WARSZAWSKA
##                                       WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA
##                                                                                                             DZIEKANAT
##                                                                      ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125
##                                           tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail:dziekanat@meil.pw.edu.pl
##"""
##        groups = dict()
##        parser = parser_.PzHeaderParser()
##        iterator = self.mkBufferedIterator(header.splitlines())
##        expect = {
##            'university'        : 'POLITECHNIKA WARSZAWSKA',
##            'faculty'           : 'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA',
##            'contact_name'      : 'DZIEKANAT',
##            'street_prefix'     : 'ul.',
##            'street_name'       : 'Nowowiejska',
##            'street_number'     : '24',
##            'postoffice_zip'    : '00-665',
##            'postoffice_town'   : 'Warszawa',
##            'edifice'           : 'Gmach Lotniczy',
##            'room'              : 'pok. 125',
##            'address'           : 'ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125',
##            'phone_prefix'      : 'tel.:',
##            'phone_numbers'     : '(022) 621 53 10, (022) 234 73 54',
##            'phone'             : 'tel.: (022) 621 53 10, (022) 234 73 54',
##            'faxtel_prefix'     : 'fax/tel.:',
##            'faxtel_numbers'    : '(022) 625 73 51',
##            'faxtel'            : 'fax/tel.: (022) 625 73 51',
##            'email_prefix'      : 'e-mail:',
##            'email_address_localpart' : 'dziekanat',
##            'email_address_domain' : 'meil.pw.edu.pl',
##            'email_address'     : 'dziekanat@meil.pw.edu.pl',
##            'email'             : 'e-mail:dziekanat@meil.pw.edu.pl',
##            'contact'           : 'tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail:dziekanat@meil.pw.edu.pl'
##        }
##        self.assertTrue(parser.match(iterator, groupdict = groups))
##        #
##        self.maxDiff = None
##        self.assertEqual(expect, groups)
##
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##    def test__match__2(self):
##        header = \
##"""\
##                                     P  O   L  I  T  E  C   H  N   I K   A     W   A  R   S  Z  A   W   S  K   A
##                             WYDZIAŁ                  GEODEZJI                   I   KARTOGRAFII
##
##                                          Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl
##                                               tel. (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl
##"""
##        groups = dict()
##        parser = parser_.PzHeaderParser()
##        iterator = self.mkBufferedIterator(header.splitlines())
##        expect = {
##            'university'                : 'POLITECHNIKA WARSZAWSKA',
##            'faculty'                   : 'WYDZIAŁ GEODEZJI I KARTOGRAFII',
##            'street_prefix'             : None,
##            'street_name'               : 'Plac Politechniki',
##            'street_number'             : '1',
##            'postoffice_zip'            : '00-661',
##            'postoffice_town'           : 'Warszawa',
###            'edifice'                   : None,
##            'room'                      : 'p. 301',
##            'website'                   : 'www.gik.pw.edu.pl',
##            'address'                   : 'Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl',
##            'phone_prefix'              : 'tel.',
##            'phone_numbers'             : '(+48) 22 234 72 23',
##            'phone'                     : 'tel. (+48) 22 234 72 23',
##            'faxtel_prefix'             : None,
##            'faxtel_numbers'            : None,
##            'faxtel'                    : None,
##            'email_prefix'              : 'e-mail:',
##            'email_address_localpart'   : 'dziekan',
##            'email_address_domain'      : 'gik.pw.edu.pl',
##            'email_address'             : 'dziekan@gik.pw.edu.pl',
##            'email'                     : 'e-mail: dziekan@gik.pw.edu.pl',
##            'contact'                   : 'tel. (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl'
##        }
##        self.assertTrue(parser.match(iterator, groupdict = groups))
##        #
##        self.maxDiff = None
##        self.assertEqual(expect, groups)
##
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##class Test__PzFooterParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzFooterParser, veetou.parser.Parser))
##
##    def test__re_sig_dots__1(self):
##        r = parser_.PzFooterParser._re_sig_dots
##        s = "................"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('sig_dots'), s)
##
##    def test__re_sig_prompt__1(self):
##        r = parser_.PzFooterParser._re_sig_prompt
##        s = "Podpis kierownika"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('sig_prompt'), s)
##
##    def test__re_pagination__1(self):
##        r = parser_.PzFooterParser._re_pagination
##        s = "Strona 1 z 2"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('pagination'), s)
##        self.assertEqual(m.group('page_number'), '1')
##        self.assertEqual(m.group('pages_total'), '2')
##
##    def test__re_title__1(self):
##        r = parser_.PzFooterParser._re_title
##        s = "Gospodarowanie surowcami mineralnymi (GP.NMS300S). Protokół: 2013Z/E-1/252"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('title'), s)
##        self.assertEqual(m.group('subj_name'), 'Gospodarowanie surowcami mineralnymi')
##        self.assertEqual(m.group('subj_code'), 'GP.NMS300S')
##        self.assertEqual(m.group('semester_code'), '2013Z')
##        self.assertEqual(m.group('serie'), 'E-1')
##        self.assertEqual(m.group('number'), '252')
##
##    def test__re_title__2(self):
##        r = parser_.PzFooterParser._re_title
##        s = "Engineering Physics (ML.ANW104). Protokół: 2015 Z/B-3/1039"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('title'), s)
##        self.assertEqual(m.group('subj_name'), 'Engineering Physics')
##        self.assertEqual(m.group('subj_code'), 'ML.ANW104')
##        self.assertEqual(m.group('semester_code'), '2015 Z')
##        self.assertEqual(m.group('serie'), 'B-3')
##        self.assertEqual(m.group('number'), '1039')
##
##    def test__re_pagination_and_title_1(self):
##        r = parser_.PzFooterParser._re_pagination_and_title
##        s = "Strona 1 z 2                       Gospodarowanie surowcami mineralnymi (GP.NMS300S). Protokół: 2013Z/E-1/252"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('pagination_and_title'), s)
##        self.assertEqual(m.group('pagination'), 'Strona 1 z 2')
##        self.assertEqual(m.group('page_number'), '1')
##        self.assertEqual(m.group('pages_total'), '2')
##        self.assertEqual(m.group('title'), 'Gospodarowanie surowcami mineralnymi (GP.NMS300S). Protokół: 2013Z/E-1/252')
##        self.assertEqual(m.group('subj_name'), 'Gospodarowanie surowcami mineralnymi')
##        self.assertEqual(m.group('subj_code'), 'GP.NMS300S')
##        self.assertEqual(m.group('semester_code'), '2013Z')
##        self.assertEqual(m.group('serie'), 'E-1')
##        self.assertEqual(m.group('number'), '252')
##
##    def test__re_pagination_and_title_2(self):
##        r = parser_.PzFooterParser._re_pagination_and_title
##        s = "Strona 1 z 2                       Engineering Physics (ML.ANW104). Protokół: 2015 Z/B-3/1039"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('pagination_and_title'), s)
##        self.assertEqual(m.group('pagination'), 'Strona 1 z 2')
##        self.assertEqual(m.group('page_number'), '1')
##        self.assertEqual(m.group('pages_total'), '2')
##        self.assertEqual(m.group('title'), 'Engineering Physics (ML.ANW104). Protokół: 2015 Z/B-3/1039')
##        self.assertEqual(m.group('subj_name'), 'Engineering Physics')
##        self.assertEqual(m.group('subj_code'), 'ML.ANW104')
##        self.assertEqual(m.group('semester_code'), '2015 Z')
##        self.assertEqual(m.group('serie'), 'B-3')
##        self.assertEqual(m.group('number'), '1039')
##
##    def test__re_generator_line__1(self):
##        r = parser_.PzFooterParser._re_generator_line
##        s = "Wygenerowano z użyciem Karramba LoL Office, www.karramba.pl"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('generator_line'), s)
##        self.assertEqual(m.group('generator'), 'Karramba LoL Office, www.karramba.pl')
##        self.assertEqual(m.group('generator_name'), 'Karramba LoL Office')
##        self.assertEqual(m.group('generator_home'), 'www.karramba.pl')
##
##    def test__match__1(self):
##        footer = \
##"""\
##                                                                                                                   ........................
##                                                                                                                      podpis kierownika
##       Strona 1 z 3                                                   Gospodarowanie surowcami mineralnymi (GP.SMS238). Protokół: 2013Z/E-1/118
##       Wygenerowano z użyciem Karramba Lo'L, www.karramba.pl
##"""
##        groups = dict()
##        parser = parser_.PzFooterParser()
##        iterator = self.mkBufferedIterator(footer.splitlines())
##        self.assertTrue(parser.match(iterator, groupdict = groups))
##        expect = {
##            'sig_dots'             : '........................',
##            'sig_prompt'           : 'podpis kierownika',
##            'pagination_and_title' : 'Strona 1 z 3                                                   Gospodarowanie surowcami mineralnymi (GP.SMS238). Protokół: 2013Z/E-1/118',
##            'pagination'           : 'Strona 1 z 3',
##            'title'                : 'Gospodarowanie surowcami mineralnymi (GP.SMS238). Protokół: 2013Z/E-1/118',
##            'page_number'          : '1',
##            'pages_total'          : '3',
##            'subj_name'            : 'Gospodarowanie surowcami mineralnymi',
##            'subj_code'            : 'GP.SMS238',
##            'semester_code'        : '2013Z',
##            'serie'                : 'E-1',
##            'number'               : '118',
##            'generator_line'       : "Wygenerowano z użyciem Karramba Lo'L, www.karramba.pl",
##            'generator'            : "Karramba Lo'L, www.karramba.pl",
##            'generator_name'       : "Karramba Lo'L",
##            'generator_home'       : "www.karramba.pl"
##        }
##        #
##        self.maxDiff = None
##        self.assertEqual(expect, groups)
##
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##
##class Test__PzPreambleParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzPreambleParser, veetou.parser.Parser))
##
##    def test__re_town_and_datetime__1(self):
##        r = parser_.PzPreambleParser._re_town_and_datetime
##        s = 'Warszawa, 08.02.2014, 13:09:53'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('town_and_datetime'), s)
##        self.assertEqual(m.group('town'), 'Warszawa')
##        self.assertEqual(m.group('date'), '08.02.2014')
##        self.assertEqual(m.group('time'), '13:09:53')
##
##    def test__re_title_line__1(self):
##        r = parser_.PzPreambleParser._re_title_line
##        s = 'Protokół zaliczeń (egzamin) 2015 Z/B-1/197'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('title_line'), s)
##        self.assertEqual(m.group('title'), 'Protokół zaliczeń')
##        self.assertEqual(m.group('exam'), 'egzamin')
##        self.assertEqual(m.group('semester_code'), '2015 Z')
##        self.assertEqual(m.group('serie'), 'B-1')
##        self.assertEqual(m.group('number'), '197')
##
##    def test__re_title_line__2(self):
##        r = parser_.PzPreambleParser._re_title_line
##        s = 'Protokół zaliczeń (bez egzaminu) 2013Z/E-1/252'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('title_line'), s)
##        self.assertEqual(m.group('title'), 'Protokół zaliczeń')
##        self.assertEqual(m.group('exam'), 'bez egzaminu')
##        self.assertEqual(m.group('semester_code'), '2013Z')
##        self.assertEqual(m.group('serie'), 'E-1')
##        self.assertEqual(m.group('number'), '252')
##
##    def test__re_return_line__1(self):
##        r = parser_.PzPreambleParser._re_return_line
##        s = 'Termin zwrotu 02.02.2016'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('return_line'), s)
##        self.assertEqual(m.group('return_desc'), 'Termin zwrotu')
##        self.assertEqual(m.group('return_date'), '02.02.2016')
##
##    def test__re_subj_name_line__1(self):
##        r = parser_.PzPreambleParser._re_subj_name_line
##        s = 'Nazwa przedmiotu: Advanced Aero Engines Laboratory'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('subj_name_line'), s)
##        self.assertEqual(m.group('subj_name'), 'Advanced Aero Engines Laboratory')
##
##    def test__re_subj_code_line__1(self):
##        r = parser_.PzPreambleParser._re_subj_code_line
##        s = 'Nr katalogowy: ML.ANS600'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('subj_code_line'), s)
##        self.assertEqual(m.group('subj_code'), 'ML.ANS600')
##
##    def test__re_subj_code_line__2(self):
##        r = parser_.PzPreambleParser._re_subj_code_line
##        s = 'Nr katalogowy: GK.NIK113'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('subj_code_line'), s)
##        self.assertEqual(m.group('subj_code'), 'GK.NIK113')
##
##    def test__re_subj_code_line__3(self):
##        r = parser_.PzPreambleParser._re_subj_code_line
##        s = 'Nr katalogowy: GP.SMS238'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('subj_code_line'), s)
##        self.assertEqual(m.group('subj_code'), 'GP.SMS238')
##
##    def test__re_department__1(self):
##        r = parser_.PzPreambleParser._re_department
##        s = 'Zakład Silników Lotniczych'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('department'), s)
##
##    def test__re_department__2(self):
##        r = parser_.PzPreambleParser._re_department
##        s = 'Katedra Gospodarki Przestrzennej i Nauk o Środowisku Przyrodnicznym'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('department'), s)
##
##    def test__re_department__3(self):
##        r = parser_.PzPreambleParser._re_department
##        s = 'Wydział Mechaniczny Energetyki i Lotnictwa'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('department'), s)
##
##    def test__re_subj_tutor_line__1(self):
##        r = parser_.PzPreambleParser._re_subj_tutor_line
##        s = 'Kierownik przedmiotu: dr hab. inż. Kazimierz Kowalski'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('subj_tutor_line'), s)
##        self.assertEqual(m.group('subj_tutor'), 'dr hab. inż. Kazimierz Kowalski')
##
##    def test__re_subj_tutor_line__2(self):
##        r = parser_.PzPreambleParser._re_subj_tutor_line
##        s = 'Kierownik przedmiotu: dr hab. inż. Natenczas Woyski, prof. PW'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('subj_tutor_line'), s)
##        self.assertEqual(m.group('subj_tutor'), 'dr hab. inż. Natenczas Woyski, prof. PW')
##
##    def test__re_subj_grades_line__1(self):
##        r = parser_.PzPreambleParser._re_subj_grades_line
##        s = "Dopuszczalne oceny:'2.0', '3.0', '3.5', '4.0', '4.5', '5.0'"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('subj_grades_line'), s)
##        self.assertEqual(m.group('subj_grades'), "'2.0', '3.0', '3.5', '4.0', '4.5', '5.0'")
##
##    def test__re_subj_grades_line__2(self):
##        r = parser_.PzPreambleParser._re_subj_grades_line
##        s = "Dopuszczalne oceny:'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('subj_grades_line'), s)
##        self.assertEqual(m.group('subj_grades'), "'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'")
##
##    def test__re_subj_grades_line__3(self):
##        r = parser_.PzPreambleParser._re_subj_grades_line
##        s = "Dopuszczalne oceny:'Zal', 'Nzal', 'Zw'"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('subj_grades_line'), s)
##        self.assertEqual(m.group('subj_grades'), "'Zal', 'Nzal', 'Zw'")
##
##    def test__match__1(self):
##        preamble = \
##"""\
##                                                                                                         Warszawa, 02.02.2016, 14:08:26
##                                          Protokół zaliczeń (bez egzaminu) 2015 Z/B-1/197
##                                                          Termin zwrotu 02.02.2016
##       Nazwa przedmiotu: Advanced Aero Engines Laboratory
##       Nr katalogowy: ML.ANS600
##       Zakład Silników Lotniczych
##       Kierownik przedmiotu: dr hab. inż. Natenczas Woyski
##       Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'. Wszyscy studenci na liście muszą mieć wystawioną ocenę.
##"""
##        groups = dict()
##        parser = parser_.PzPreambleParser()
##        iterator = self.mkBufferedIterator(preamble.splitlines())
##        expect = {
##            'town_and_datetime' : 'Warszawa, 02.02.2016, 14:08:26',
##            'title_line'        :  'Protokół zaliczeń (bez egzaminu) 2015 Z/B-1/197',
##            'return_line'       :  'Termin zwrotu 02.02.2016',
##            'subj_name_line'    :  'Nazwa przedmiotu: Advanced Aero Engines Laboratory',
##            'subj_code_line'    :  'Nr katalogowy: ML.ANS600',
##            'department'        :  'Zakład Silników Lotniczych',
##            'subj_tutor_line'   :  'Kierownik przedmiotu: dr hab. inż. Natenczas Woyski',
##            'subj_grades_line'  :  "Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
##            'subj_cond_line'    :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę",
##            'town'              :  'Warszawa',
##            'date'              :  '02.02.2016',
##            'time'              :  '14:08:26',
##            'title'             :  'Protokół zaliczeń',
##            'exam'              :  'bez egzaminu',
##            'semester_code'     :  '2015 Z',
##            'serie'             :  'B-1',
##            'number'            :  '197',
##            'return_desc'       :  'Termin zwrotu',
##            'return_date'       :  '02.02.2016',
##            'subj_name'         :  'Advanced Aero Engines Laboratory',
##            'subj_code'         :  'ML.ANS600',
##            'subj_tutor'        :  'dr hab. inż. Natenczas Woyski',
##            'subj_grades'       :  "'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
##            'subj_cond'         :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę"
##        }
##        #
##        self.assertTrue(parser.match(iterator, groupdict = groups))
##        #
##        self.maxDiff = None
##        self.assertEqual(expect, groups)
##
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##    def test__match__2(self):
##        preamble = \
##"""\
##                                                                                                         Warszawa, 08.02.2014, 13:34:30
##                                              Protokół zaliczeń (egzamin) 2013Z/E-1/118
##                                                         Termin zwrotu 17.02.2014
##       Nazwa przedmiotu: Gospodarowanie surowcami mineralnymi
##       Nr katalogowy: GP.SMS238
##       Katedra Gospodarki Przestrzennej i Nauk o Środowisku Przyrodnicznym
##       Kierownik przedmiotu: dr hab. inż. Natenczas Woyski
##       Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'
##       Wszyscy studenci na liście muszą mieć wystawioną ocenę
##"""
##        groups = dict()
##        parser = parser_.PzPreambleParser()
##        iterator = self.mkBufferedIterator(preamble.splitlines())
##        expect = {
##            'town_and_datetime' : 'Warszawa, 08.02.2014, 13:34:30',
##            'title_line'       :  'Protokół zaliczeń (egzamin) 2013Z/E-1/118',
##            'return_line'      :  'Termin zwrotu 17.02.2014',
##            'subj_name_line'   :  'Nazwa przedmiotu: Gospodarowanie surowcami mineralnymi',
##            'subj_code_line'   :  'Nr katalogowy: GP.SMS238',
##            'department'       :  'Katedra Gospodarki Przestrzennej i Nauk o Środowisku Przyrodnicznym',
##            'subj_tutor_line'  :  'Kierownik przedmiotu: dr hab. inż. Natenczas Woyski',
##            'subj_grades_line' :  "Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
##            'subj_cond_line'   :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę",
##            'town'             :  'Warszawa',
##            'date'             :  '08.02.2014',
##            'time'             :  '13:34:30',
##            'title'            :  'Protokół zaliczeń',
##            'exam'             :  'egzamin',
##            'semester_code'    :  '2013Z',
##            'serie'            :  'E-1',
##            'number'           :  '118',
##            'return_desc'      :  'Termin zwrotu',
##            'return_date'      :  '17.02.2014',
##            'subj_name'        :  'Gospodarowanie surowcami mineralnymi',
##            'subj_code'        :  'GP.SMS238',
##            'subj_tutor'       :  'dr hab. inż. Natenczas Woyski',
##            'subj_grades'      :  "'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
##            'subj_cond'        :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę"
##        }
##        #
##        self.assertTrue(parser.match(iterator, groupdict = groups))
##        #
##        self.maxDiff = None
##        self.assertEqual(expect, groups)
##
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##class Test__PzTableParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzTableParser, veetou.parser.Parser))
##
##    def test__tbody_parser__1(self):
##        parser = parser_.PzTableParser()
##        self.assertIsInstance(parser.tbody_parser, parser_.PzTbodyParser)
##        self.assertIs(parser.tbody_parser, parser._tbody_parser)
##        self.assertTrue(parser.tbody_parser in parser.children)
##
##    def test__tbody_parser_setter__1(self):
##        parser = parser_.PzTableParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.tbody_parser = 'foo'
##
##    def test__th_parser__1(self):
##        parser = parser_.PzTableParser()
##        self.assertIsInstance(parser.th_parser, parser_.PzThParser)
##        self.assertIs(parser.th_parser, parser._th_parser)
##        self.assertTrue(parser.th_parser in parser.children)
##
##    def test__th_parser_setter__1(self):
##        parser = parser_.PzTableParser()
##        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
##            parser.th_parser = 'foo'
##
##class Test__PzAddressParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzAddressParser, veetou.parser.Parser))
##
##    def test__re_street__1(self):
##        r = parser_.PzAddressParser._re_street
##        self.assertRegexFullMatch("ul. Nowowiejska 24", r)
##        m = re.fullmatch(r, "ul. Nowowiejska 24")
##        self.assertEqual(m.group('street_prefix'), 'ul.')
##        self.assertEqual(m.group('street_name'), 'Nowowiejska')
##        self.assertEqual(m.group('street_number'), '24')
##
##    def test__re_street__2(self):
##        r = parser_.PzAddressParser._re_street
##        self.assertRegexFullMatch("pl. Narutowicza 11/2", r)
##        m = re.fullmatch(r, "pl. Narutowicza 11/2")
##        self.assertEqual(m.group('street_prefix'), 'pl.')
##        self.assertEqual(m.group('street_name'), 'Narutowicza')
##        self.assertEqual(m.group('street_number'), '11/2')
##
##    def test__re_street__3(self):
##        r = parser_.PzAddressParser._re_street
##        self.assertRegexFullMatch('ul.Świętego Maksymiliana   Kolbe 23 - 30', r)
##        m = re.fullmatch(r,'ul.Świętego Maksymiliana   Kolbe 23 - 30')
##        self.assertEqual(m.group('street_prefix'), 'ul.')
##        self.assertEqual(m.group('street_name'), 'Świętego Maksymiliana   Kolbe')
##        self.assertEqual(m.group('street_number'), '23 - 30')
##
##    def test__re_postoffice__1(self):
##        r = parser_.PzAddressParser._re_postoffice
##        self.assertRegexFullMatch('00-665 Warszawa', r)
##        m = re.fullmatch(r,'00-665 Warszawa')
##        self.assertEqual(m.group('postoffice_zip'), '00-665')
##        self.assertEqual(m.group('postoffice_town'), 'Warszawa')
##
##    def test__re_postoffice__2(self):
##        r = parser_.PzAddressParser._re_postoffice
##        self.assertRegexFullMatch('21-500 Biała Podlaska', r)
##        m = re.fullmatch(r,'21-500 Biała Podlaska')
##        self.assertEqual(m.group('postoffice_zip'), '21-500')
##        self.assertEqual(m.group('postoffice_town'), 'Biała Podlaska')
##
##    def test__re_postoffice__3(self):
##        r = parser_.PzAddressParser._re_postoffice
##        self.assertRegexFullMatch('43-300 Bielsko-Biała', r)
##        m = re.fullmatch(r,'43-300 Bielsko-Biała')
##        self.assertEqual(m.group('postoffice_zip'), '43-300')
##        self.assertEqual(m.group('postoffice_town'), 'Bielsko-Biała')
##
##    def test__re_edifice__1(self):
##        r = parser_.PzAddressParser._re_edifice
##        self.assertRegexFullMatch('Gmach Lotniczy', r)
##        m = re.fullmatch(r,'Gmach Lotniczy')
##        self.assertEqual(m.group('edifice'), 'Gmach Lotniczy')
##
##    def test__re_edifice__2(self):
##        r = parser_.PzAddressParser._re_edifice
##        self.assertRegexFullMatch('Budynek Żółtogęsią-Jaźniowy 12', r)
##        m = re.fullmatch(r,'Budynek Żółtogęsią-Jaźniowy 12')
##        self.assertEqual(m.group('edifice'), 'Budynek Żółtogęsią-Jaźniowy 12')
##
##    def test__re_room__1(self):
##        r = parser_.PzAddressParser._re_room
##        self.assertRegexFullMatch('124', r)
##        m = re.fullmatch(r,'124')
##        self.assertEqual(m.group('room'), '124')
##
##    def test__re_room__2(self):
##        r = parser_.PzAddressParser._re_room
##        self.assertRegexFullMatch('p. 124', r)
##        m = re.fullmatch(r,'p. 124')
##        self.assertEqual(m.group('room'), 'p. 124')
##
##    def test__re_room__3(self):
##        r = parser_.PzAddressParser._re_room
##        self.assertRegexFullMatch('pok. 124', r)
##        m = re.fullmatch(r,'pok. 124')
##        self.assertEqual(m.group('room'), 'pok. 124')
##
##    def test__re_website__1(self):
##        r = parser_.PzAddressParser._re_website
##        self.assertRegexFullMatch('www.pl', r)
##        m = re.fullmatch(r,'www.pl')
##        self.assertEqual(m.group('website'), 'www.pl')
##
##    def test__re_website__2(self):
##        r = parser_.PzAddressParser._re_website
##        self.assertRegexFullMatch('meil.pw.edu.pl', r)
##        m = re.fullmatch(r,'meil.pw.edu.pl')
##        self.assertEqual(m.group('website'), 'meil.pw.edu.pl')
##
##    def test__re_website__3(self):
##        r = parser_.PzAddressParser._re_website
##        self.assertRegexFullMatch('http://pw.edu.pl', r)
##        m = re.fullmatch(r,'http://pw.edu.pl')
##        self.assertEqual(m.group('website'), 'http://pw.edu.pl')
##
##    def test__match__1(self):
##        groups = dict()
##        address = '     ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125       '
##        parser = parser_.PzAddressParser()
##        iterator = self.mkBufferedIterator((address,))
##        self.assertTrue(parser.match(iterator, groupdict = groups))
##        #
##        self.assertEqual(groups['address'], 'ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125')
##        self.assertEqual(groups['street_prefix'], 'ul.')
##        self.assertEqual(groups['street_name'], 'Nowowiejska')
##        self.assertEqual(groups['street_number'], '24')
##        self.assertEqual(groups['postoffice_zip'], '00-665')
##        self.assertEqual(groups['postoffice_town'], 'Warszawa')
##        self.assertEqual(groups['edifice'], 'Gmach Lotniczy')
##        self.assertEqual(groups['room'], 'pok. 125')
##        #
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##
##    def test__match__2(self):
##        groups = dict()
##        address = '     Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl      '
##        parser = parser_.PzAddressParser()
##        iterator = self.mkBufferedIterator((address,))
##        self.assertTrue(parser.match(iterator, groupdict = groups))
##        #
##        self.assertIs(groups['street_prefix'], None)
##        self.assertEqual(groups['street_name'], 'Plac Politechniki')
##        self.assertEqual(groups['street_number'], '1')
##        self.assertEqual(groups['postoffice_zip'], '00-661')
##        self.assertEqual(groups['postoffice_town'], 'Warszawa')
##        self.assertEqual(groups['room'], 'p. 301')
##        #
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##class Test__PzContactParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzContactParser, veetou.parser.Parser))
##
##    def test__re_phone__1(self):
##        r = parser_.PzContactParser._re_phone
##        self.assertRegexFullMatch('tel. (+48) 22 234 72 23', r)
##        m = re.fullmatch(r, 'tel. (+48) 22 234 72 23')
##        self.assertEqual(m.group('phone'), 'tel. (+48) 22 234 72 23')
##        self.assertEqual(m.group('phone_prefix'), 'tel.')
##        self.assertEqual(m.group('phone_numbers'), '(+48) 22 234 72 23')
##
##    def test__re_phone__2(self):
##        r = parser_.PzContactParser._re_phone
##        self.assertRegexFullMatch('tel.: (022) 621 53 10, (022) 234 73 54', r)
##        m = re.fullmatch(r, 'tel.: (022) 621 53 10, (022) 234 73 54')
##        self.assertEqual(m.group('phone'), 'tel.: (022) 621 53 10, (022) 234 73 54')
##        self.assertEqual(m.group('phone_prefix'), 'tel.:')
##        self.assertEqual(m.group('phone_numbers'), '(022) 621 53 10, (022) 234 73 54')
##
##    def test__re_faxtel__1(self):
##        r = parser_.PzContactParser._re_faxtel
##        self.assertRegexFullMatch('fax. (+48) 22 234 72 23', r)
##        m = re.fullmatch(r, 'fax. (+48) 22 234 72 23')
##        self.assertEqual(m.group('faxtel'), 'fax. (+48) 22 234 72 23')
##        self.assertEqual(m.group('faxtel_prefix'), 'fax.')
##        self.assertEqual(m.group('faxtel_numbers'), '(+48) 22 234 72 23')
##
##    def test__re_faxtel__2(self):
##        r = parser_.PzContactParser._re_faxtel
##        self.assertRegexFullMatch('fax/tel.: (022) 625 73 51', r)
##        m = re.fullmatch(r, 'fax/tel.: (022) 621 73 51')
##        self.assertEqual(m.group('faxtel'), 'fax/tel.: (022) 621 73 51')
##        self.assertEqual(m.group('faxtel_prefix'), 'fax/tel.:')
##        self.assertEqual(m.group('faxtel_numbers'), '(022) 621 73 51')
##
##    def test__re_faxtel__3(self):
##        r = parser_.PzContactParser._re_faxtel
##        self.assertRegexFullMatch('fax/tel.: (022) 621 53 10, (022) 234 73 54', r)
##        m = re.fullmatch(r, 'fax/tel.: (022) 621 53 10, (022) 234 73 54')
##        self.assertEqual(m.group('faxtel'), 'fax/tel.: (022) 621 53 10, (022) 234 73 54')
##        self.assertEqual(m.group('faxtel_prefix'), 'fax/tel.:')
##        self.assertEqual(m.group('faxtel_numbers'), '(022) 621 53 10, (022) 234 73 54')
##
##    def test__re_email__1(self):
##        r = parser_.PzContactParser._re_email
##        self.assertRegexFullMatch('e-mail: p-1.tomulik@meil.pw.edu.pl', r)
##        m = re.fullmatch(r, 'e-mail: p-1.tomulik@meil.pw.edu.pl')
##        self.assertEqual(m.group('email'), 'e-mail: p-1.tomulik@meil.pw.edu.pl')
##        self.assertEqual(m.group('email_prefix'), 'e-mail:')
##        self.assertEqual(m.group('email_address'), 'p-1.tomulik@meil.pw.edu.pl')
##        self.assertEqual(m.group('email_address_localpart'), 'p-1.tomulik')
##        self.assertEqual(m.group('email_address_domain'), 'meil.pw.edu.pl')
##
##    def test__re_contact__1(self):
##        r = parser_.PzContactParser._re_contact
##        s = 'tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail: dziekanat@meil.pw.edu.pl'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('contact'), s)
##        self.assertEqual(m.group('phone'), 'tel.: (022) 621 53 10, (022) 234 73 54')
##        self.assertEqual(m.group('phone_prefix'), 'tel.:')
##        self.assertEqual(m.group('phone_numbers'), '(022) 621 53 10, (022) 234 73 54')
##        self.assertEqual(m.group('faxtel'), 'fax/tel.: (022) 625 73 51')
##        self.assertEqual(m.group('faxtel_prefix'), 'fax/tel.:')
##        self.assertEqual(m.group('faxtel_numbers'), '(022) 625 73 51')
##        self.assertEqual(m.group('email'), 'e-mail: dziekanat@meil.pw.edu.pl')
##        self.assertEqual(m.group('email_prefix'), 'e-mail:')
##        self.assertEqual(m.group('email_address'), 'dziekanat@meil.pw.edu.pl')
##        self.assertEqual(m.group('email_address_localpart'), 'dziekanat')
##        self.assertEqual(m.group('email_address_domain'), 'meil.pw.edu.pl')
##
##    def test__re_contact__2(self):
##        r = parser_.PzContactParser._re_contact
##        s = 'tel.: (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl'
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('contact'), s)
##        self.assertEqual(m.group('phone'), 'tel.: (+48) 22 234 72 23')
##        self.assertEqual(m.group('phone_prefix'), 'tel.:')
##        self.assertEqual(m.group('phone_numbers'), '(+48) 22 234 72 23')
##        self.assertIs(m.group('faxtel'), None)
##        self.assertIs(m.group('faxtel_prefix'), None)
##        self.assertIs(m.group('faxtel_numbers'), None)
##        self.assertEqual(m.group('email'), 'e-mail: dziekan@gik.pw.edu.pl')
##        self.assertEqual(m.group('email_prefix'), 'e-mail:')
##        self.assertEqual(m.group('email_address'), 'dziekan@gik.pw.edu.pl')
##        self.assertEqual(m.group('email_address_localpart'), 'dziekan')
##        self.assertEqual(m.group('email_address_domain'), 'gik.pw.edu.pl')
##
##    def test__match__1(self):
##        groups = dict()
##        contact = '     tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail: dziekanat@meil.pw.edu.pl     '
##        parser = parser_.PzContactParser()
##        iterator = self.mkBufferedIterator((contact,))
##        self.assertTrue(parser.match(iterator, groupdict = groups))
##        #
##        self.assertEqual(groups['contact'], contact.strip())
##        self.assertEqual(groups['phone'], 'tel.: (022) 621 53 10, (022) 234 73 54')
##        self.assertEqual(groups['phone_prefix'], 'tel.:')
##        self.assertEqual(groups['phone_numbers'], '(022) 621 53 10, (022) 234 73 54')
##        self.assertEqual(groups['faxtel'], 'fax/tel.: (022) 625 73 51')
##        self.assertEqual(groups['faxtel_prefix'], 'fax/tel.:')
##        self.assertEqual(groups['faxtel_numbers'], '(022) 625 73 51')
##        self.assertEqual(groups['email'], 'e-mail: dziekanat@meil.pw.edu.pl')
##        self.assertEqual(groups['email_prefix'], 'e-mail:')
##        self.assertEqual(groups['email_address'], 'dziekanat@meil.pw.edu.pl')
##        self.assertEqual(groups['email_address_localpart'], 'dziekanat')
##        self.assertEqual(groups['email_address_domain'], 'meil.pw.edu.pl')
##        #
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##    def test__match__2(self):
##        groups = dict()
##        contact = '     tel.: (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl      '
##        parser = parser_.PzContactParser()
##        iterator = self.mkBufferedIterator((contact,))
##        self.assertTrue(parser.match(iterator, groupdict = groups))
##        #
##        self.assertEqual(groups['contact'], contact.strip())
##        self.assertEqual(groups['phone'], 'tel.: (+48) 22 234 72 23')
##        self.assertEqual(groups['phone_prefix'], 'tel.:')
##        self.assertEqual(groups['phone_numbers'], '(+48) 22 234 72 23')
##        self.assertIs(groups['faxtel'], None)
##        self.assertIs(groups['faxtel_prefix'], None)
##        self.assertIs(groups['faxtel_numbers'], None)
##        self.assertEqual(groups['email'], 'e-mail: dziekan@gik.pw.edu.pl')
##        self.assertEqual(groups['email_prefix'], 'e-mail:')
##        self.assertEqual(groups['email_address'], 'dziekan@gik.pw.edu.pl')
##        self.assertEqual(groups['email_address_localpart'], 'dziekan')
##        self.assertEqual(groups['email_address_domain'], 'gik.pw.edu.pl')
##        #
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##
##class Test__PzThParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzThParser, veetou.parser.Parser))
##
##    def test__lre_th0__1(self):
##        r = parser_.PzThParser._lre_th[0]
##        s = "Ocena"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('th_0'), s)
##
##    def test__lre_th1__1(self):
##        r = parser_.PzThParser._lre_th[1]
##        s = "z"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('th_1'), s)
##
##    def test__lre_th2__1(self):
##        r = parser_.PzThParser._lre_th[2]
##        s = "Lp.   Student   Nr albumu   Uwagi"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('th_2'), s)
##
##    def test__lre_th2__2(self):
##        r = parser_.PzThParser._lre_th[2]
##        s = "Lp.   Student   Nr albumu   z   Uwagi"
##        self.assertRegexFullMatch(s, r)
##        m = re.fullmatch(r, s)
##        self.assertEqual(m.group('th_2'), s)
##
##    def test__lre_th3__1(self):
##        pieces = [ 'z projektu', 'z wykładu', 'z ćwiczeń', 'końcowa', 'z przedmiotu']
##        r = parser_.PzThParser._lre_th[3]
##        for n in range(1,6):
##            for perm in itertools.permutations(pieces, n):
##                s = ' '.join(perm)
##                self.assertRegexFullMatch(s, r)
##                m = re.fullmatch(r, s)
##                self.assertEqual(m.group('th_3'), s)
##
##    def test__lre_th3__2(self):
##        pieces = [ 'z projektu', 'z wykładu', 'z ćwiczeń', 'końcowa', 'przedmiotu']
##        r = parser_.PzThParser._lre_th[3]
##        for n in range(1,6):
##            for perm in itertools.permutations(pieces, n):
##                s = ' '.join(perm)
##                self.assertRegexFullMatch(s, r)
##                m = re.fullmatch(r, s)
##                self.assertEqual(m.group('th_3'), s)
##
##    def test__lre_th4__1(self):
##        pieces = [ 'P', 'N' ]
##        r = parser_.PzThParser._lre_th[4]
##        for n in range(2,3):
##            for perm in itertools.permutations(pieces, n):
##                s = '   '.join(perm)
##                self.assertRegexFullMatch(s, r)
##                m = re.fullmatch(r, s)
##                self.assertEqual(m.group('th_4'), s)
##
##    def test__match__1(self):
##        th = \
##"""\
##                                                               Ocena
##        Lp.               Student                 Nr albumu      z            Uwagi
##                                                             przedmiotu
##"""
##        groups = dict()
##        th_grade_fields = []
##        parser = parser_.PzThParser()
##        iterator = self.mkBufferedIterator(th.splitlines())
##        expect = {
##            r'th_0' : 'Ocena',
##            r'th_2' : 'Lp.               Student                 Nr albumu      z            Uwagi',
##            r'th_3' : 'przedmiotu',
##        }
##        self.assertTrue(parser.match(iterator, groupdict = groups, th_grade_fields = th_grade_fields))
##        #
##        self.maxDiff = None
##        self.assertEqual(expect, groups)
##        self.assertEqual(th_grade_fields, ['subj_grade'])
##
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##    def test__match__2(self):
##        th = \
##"""\
##                                                            Ocena
##                                                               z
##        Lp.               Student               Nr albumu                    Uwagi
##                                                          przedmiotu
##                                                            P    N
##"""
##        groups = dict()
##        th_grade_fields = []
##        parser = parser_.PzThParser()
##        iterator = self.mkBufferedIterator(th.splitlines())
##        expect = {
##            r'th_0' : 'Ocena',
##            r'th_1' : 'z',
##            r'th_2' : 'Lp.               Student               Nr albumu                    Uwagi',
##            r'th_3' : 'przedmiotu',
##            r'th_4' : 'P    N'
##        }
##        self.assertTrue(parser.match(iterator, groupdict = groups, th_grade_fields = th_grade_fields))
##        #
##        self.maxDiff = None
##        self.assertEqual(expect, groups)
##        self.assertEqual(th_grade_fields, ['subj_grade_p', 'subj_grade_n'])
##
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##class Test__TbodyParser(PzParserTestCase):
##    def test__subclass__1(self):
##        self.assertTrue(issubclass(parser_.PzTbodyParser, veetou.parser.Parser))
##
##    def test__geometry__1(self):
##        self.maxDiff = None
##        lines = [
###000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
###012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. Keczetna Szamot Nafets              256701       3,5        5,0       4,0",
##"          2. Myżob Anilorak                      254104       3,0        5,0       3,5",
##"          3. Akslowogułd Atarzogałm              256127       4,5        3,5       4,5",
##"          4. Tifołog Awe                          256110      3,0        4,5       3,5",
##"          5. Aksńeimak Ailatan Atarzogłam         256421      3,5        4,5       4,0",
##"         12. Kaiwodw Anilewe Aneladgam           222250       3,0        4,5       3,5",
##"         13. Kurotkiw Annaoj Aniluap              259288      3,5        5,0       4,0"
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        geom = parser_.PzTbodyParser.geometry(iterator, 3)
##        expect = [[9, 12], [13, 41], [49, 56], [62, 65], [73, 76], [83, 86], [86, 86]]
##        self.assertEqual(geom, expect)
##        split = list(parser_.PzTbodyParser.decompose(iterator, 3))
##        split_expect = [
##            ['1.',  'Keczetna Szamot Nafets',       '256701',  '3,5', '5,0', '4,0', ''],
##            ['2.',  'Myżob Anilorak',               '254104',  '3,0', '5,0', '3,5', ''],
##            ['3.',  'Akslowogułd Atarzogałm',       '256127',  '4,5', '3,5', '4,5', ''],
##            ['4.',  'Tifołog Awe',                  '256110', '3,0', '4,5', '3,5', ''],
##            ['5.',  'Aksńeimak Ailatan Atarzogłam', '256421', '3,5', '4,5', '4,0', ''],
##            ['12.', 'Kaiwodw Anilewe Aneladgam',    '222250',  '3,0', '4,5', '3,5', ''],
##            ['13.', 'Kurotkiw Annaoj Aniluap',      '259288', '3,5', '5,0', '4,0', '']
##        ]
##        self.assertEqual(split, split_expect)
##
##    def test__geometry__2(self):
##        lines = [
###000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
###012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. Kasab Aglo                          264236       2,0        2,0",
##"          2. Keb Szotrab                         264437       4,0        4,0",
##"         24. Akszurg Aneladgam                   264876       3,0        3,0",
##"         25. Lezg Atram                          264478       2,0        2,0",
##"         26. Aksńawi Anilorak                    264281       2,0        2,0",
##"    ",
##"Bleah bleah bleah"
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        geom = parser_.PzTbodyParser.geometry(iterator, 2)
##        expect = [[9, 12], [13, 30], [49, 55], [62, 65], [73, 76], [76, 76]]
##        self.assertEqual(geom, expect)
##        split = list(parser_.PzTbodyParser.decompose(iterator, 2))
##        split_expect = [
##            ['1.',  'Kasab Aglo',        '264236', '2,0', '2,0', ''],
##            ['2.',  'Keb Szotrab',       '264437', '4,0', '4,0', ''],
##            ['24.', 'Akszurg Aneladgam', '264876', '3,0', '3,0', ''],
##            ['25.', 'Lezg Atram',        '264478', '2,0', '2,0', ''],
##            ['26.', 'Aksńawi Anilorak',  '264281', '2,0', '2,0', '']
##        ]
##        self.assertEqual(split, split_expect)
##
##        self.assertEqual(next(iterator), lines[-2])
##
##    def test__geometry__3(self):
##        lines = [
###000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
###012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. Kishuka Bharadwaj                    281566   2.0",
##"          2. Sulegna Ikswonazyrzk Nathalie       287489    3.0",
##"         15. Nav-Ekebneroh Echevarria Franz      284331    5.0",
##"             Alexander",
##"         16. Velisav Aili                        252325    4.0",
##"         17. S V RDATKDTRSCGRDFA                 275238    3.0",
##"             Shaguwnxfdj",
##"         18. Namaz Raamma                        285132    3.0"
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        geom = parser_.PzTbodyParser.geometry(iterator, 2)
##        expect = [[9, 12], [13, 43], [49, 56], [59, 62], [62, 62], [62, 62]]
##        self.assertEqual(geom, expect)
##        split = list(parser_.PzTbodyParser.decompose(iterator, 2))
##        split_expect = [
##            ['1.',  'Kishuka Bharadwaj',                   '281566',    '2.0', '', ''],
##            ['2.',  'Sulegna Ikswonazyrzk Nathalie',       '287489',    '3.0', '', ''],
##            ['15.', 'Nav-Ekebneroh Echevarria Franz',      '284331',    '5.0', '', ''],
##            ['',    'Alexander',                           '',          '',    '', ''],
##            ['16.', 'Velisav Aili',                        '252325',    '4.0', '', ''],
##            ['17.', 'S V RDATKDTRSCGRDFA',                 '275238',    '3.0', '', ''],
##            ['',    'Shaguwnxfdj',                         '',          '',    '', ''],
##            ['18.', 'Namaz Raamma',                        '285132',    '3.0', '', '']
##        ]
##        self.assertEqual(split, split_expect)
##
##    def test__geometry__4(self):
##        self.maxDiff = None
##        lines = [
###0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
###0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. Kishuka Bharadwaj                    281566   2.0",
##"          2. Sulegna Ikswonazyrzk Nathalie       287489    3.0",
##"         15. Nav-Ekebneroh Echevarria Franz      284331    5.0          I do have some remarks",
##"             Alexander",
##"         16. Velisav Aili                        252325          4.0",
##"         17. S V RDATKDTRSCGRDFA                 275238    3.0",
##"             Shaguwnxfdj                                               Other remarks",
##"         18. Namaz Raamma                        285132    3.0   3.5"
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        geom = parser_.PzTbodyParser.geometry(iterator, 2)
##        expect = [[9, 12], [13, 43], [49, 56], [59, 62], [65, 68], [71, 94]]
##        self.assertEqual(geom, expect)
##        split = list(parser_.PzTbodyParser.decompose(iterator, 2))
##        split_expect = [
##            ['1.',  'Kishuka Bharadwaj',                   '281566',   '2.0',  '',    ''],
##            ['2.' , 'Sulegna Ikswonazyrzk Nathalie',       '287489',    '3.0', '',    ''],
##            ['15.', 'Nav-Ekebneroh Echevarria Franz',      '284331',    '5.0', '',    'I do have some remarks'],
##            ['',    'Alexander'                     ,      '',          '',    '',    ''],
##            ['16.', 'Velisav Aili',                        '252325',    '',    '4.0', ''],
##            ['17.', 'S V RDATKDTRSCGRDFA',                 '275238',    '3.0', '',    ''],
##            ['',    'Shaguwnxfdj',                         '',          '',    '',    'Other remarks'],
##            ['18.', 'Namaz Raamma',                        '285132',    '3.0', '3.5', '']
##        ]
##        self.assertEqual(split, split_expect)
##
##    def test__geometry__5(self):
##        self.maxDiff = None
##        lines = [
###0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
###0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. LAWARGA Mahbush                       252345",
##"         11. ISEDIPOG Alab Iluram Anhsirn          248092",
##"             Vaday",
##"         12. Hagwsedfx Iilotana                    K-3589",
##"         23. MANRXAQA REVSAGWZCDF Aynag             5227",
##"             Dasarp",
##"         31. Cziworteip Fotszyrzk Trebor           244151",
##"         32. Sazalp Lanreb Rasec Otsugua           283329",
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        geom = parser_.PzTbodyParser.geometry(iterator, 1)
##        expect = [[9, 12], [13, 41], [51, 57], [57, 57], [57, 57]]
##        self.assertEqual(geom, expect)
##        split = list(parser_.PzTbodyParser.decompose(iterator, 1))
##        split_expect = [
##            [ '1.',  'LAWARGA Mahbush',              '252345', '', '' ],
##            [ '11.', 'ISEDIPOG Alab Iluram Anhsirn', '248092', '', '' ],
##            [ '',    'Vaday',                        '',       '', '' ],
##            [ '12.', 'Hagwsedfx Iilotana',           'K-3589', '', '' ],
##            [ '23.', 'MANRXAQA REVSAGWZCDF Aynag',   '5227',   '', '' ],
##            [ '',    'Dasarp',                       '',       '', '' ],
##            [ '31.', 'Cziworteip Fotszyrzk Trebor',  '244151', '', '' ],
##            [ '32.', 'Sazalp Lanreb Rasec Otsugua',  '283329', '', '' ]
##        ]
##        self.assertEqual(split, split_expect)
##
##    def test__geometry__6(self):
##        self.maxDiff = None
##        lines = [
###0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
###0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. LAWARGA Mahbush                       252345",
##"         11. ISEDIPOG Alab Iluram Anhsirn          248092",
##"             Vaday",
##"         12. Hagwsedfx Iilotana                    K-3589",
##"         23. MANRXAQA REVSAGWZCDF Aynag             5227",
##"             Dasarp",
##"         31. Cziworteip Fotszyrzk Trebor           244151",
##"         32. Sazalp Lanreb Rasec Otsugua           283329",
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        geom = parser_.PzTbodyParser.geometry(iterator, 2)
##        expect = [[9, 12], [13, 41], [51, 57], [57, 57], [57, 57], [57, 57]]
##        self.assertEqual(geom, expect)
##        split = list(parser_.PzTbodyParser.decompose(iterator, 2))
##        split_expect = [
##            [ '1.',  'LAWARGA Mahbush',              '252345', '', '', '' ],
##            [ '11.', 'ISEDIPOG Alab Iluram Anhsirn', '248092', '', '', '' ],
##            [ '',    'Vaday',                        '',       '', '', '' ],
##            [ '12.', 'Hagwsedfx Iilotana',           'K-3589', '', '', '' ],
##            [ '23.', 'MANRXAQA REVSAGWZCDF Aynag',   '5227',   '', '', '' ],
##            [ '',    'Dasarp',                       '',       '', '', '' ],
##            [ '31.', 'Cziworteip Fotszyrzk Trebor',  '244151', '', '', '' ],
##            [ '32.', 'Sazalp Lanreb Rasec Otsugua',  '283329', '', '', '' ]
##        ]
##        self.assertEqual(split, split_expect)
##
##    def test__records__0(self):
##        lines = [
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        grades = ['subj_grade_lecture', 'subj_grade_project', 'subj_grade_final']
##        expect = [ ]
##        records = list(parser_.PzTbodyParser.records(iterator, grades))
##        self.maxDiff = None
##        self.assertEqual(records, expect)
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##    def test__records__1(self):
##        lines = [
###000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
###012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. Keczetna Szamot Nafets              256701       3,5        5,0       4,0",
##"          2. Myżob Anilorak                      254104       3,0        5,0       3,5",
##"          3. Akslowogułd Atarzogałm              256127       4,5        3,5       4,5",
##"          4. Tifołog Awe                          256110      3,0        4,5       3,5",
##"          5. Aksńeimak Ailatan Atarzogłam         256421      3,5        4,5       4,0",
##"         12. Kaiwodw Anilewe Aneladgam           222250       3,0        4,5       3,5",
##"         13. Kurotkiw Annaoj Aniluap              259288      3,5        5,0       4,0"
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        grades = ['subj_grade_lecture', 'subj_grade_project', 'subj_grade_final']
##        expect = [
##            {
##              'tr_ord'             : '1.',
##              'tr_ord_no'          : '1',
##              'tr_student_name'    : 'Keczetna Szamot Nafets',
##              'student_name'       : 'Keczetna Szamot Nafets',
##              'last_name'          : 'Keczetna',
##              'first_name'         : 'Szamot Nafets',
##              'tr_student_index'   : '256701',
##              'student_index'      : '256701',
##              'subj_grade_lecture' : '3,5',
##              'subj_grade_project' : '5,0',
##              'subj_grade_final'   : '4,0',
##              'tr_remarks'         : None
##            },
##            {
##              'tr_ord'             : '2.',
##              'tr_ord_no'          : '2',
##              'tr_student_name'    : 'Myżob Anilorak',
##              'student_name'       : 'Myżob Anilorak',
##              'last_name'          : 'Myżob',
##              'first_name'         : 'Anilorak',
##              'tr_student_index'   : '254104',
##              'student_index'      : '254104',
##              'subj_grade_lecture' : '3,0',
##              'subj_grade_project' : '5,0',
##              'subj_grade_final'   : '3,5',
##              'tr_remarks'         : None
##            },
##            {
##              'tr_ord'             : '3.',
##              'tr_ord_no'          : '3',
##              'tr_student_name'    : 'Akslowogułd Atarzogałm',
##              'student_name'       : 'Akslowogułd Atarzogałm',
##              'last_name'          : 'Akslowogułd',
##              'first_name'         : 'Atarzogałm',
##              'tr_student_index'   : '256127',
##              'student_index'      : '256127',
##              'subj_grade_lecture' : '4,5',
##              'subj_grade_project' : '3,5',
##              'subj_grade_final'   : '4,5',
##              'tr_remarks'         : None
##            },
##            {
##              'tr_ord'             : '4.',
##              'tr_ord_no'          : '4',
##              'tr_student_name'    : 'Tifołog Awe',
##              'student_name'       : 'Tifołog Awe',
##              'last_name'          : 'Tifołog',
##              'first_name'         : 'Awe',
##              'tr_student_index'   : '256110',
##              'student_index'      : '256110',
##              'subj_grade_lecture' : '3,0',
##              'subj_grade_project' : '4,5',
##              'subj_grade_final'   : '3,5',
##              'tr_remarks'         : None
##            },
##            {
##              'tr_ord'             : '5.',
##              'tr_ord_no'          : '5',
##              'tr_student_name'    : 'Aksńeimak Ailatan Atarzogłam',
##              'student_name'       : 'Aksńeimak Ailatan Atarzogłam',
##              'last_name'          : 'Aksńeimak',
##              'first_name'         : 'Ailatan Atarzogłam',
##              'tr_student_index'   : '256421',
##              'student_index'      : '256421',
##              'subj_grade_lecture' : '3,5',
##              'subj_grade_project' : '4,5',
##              'subj_grade_final'   : '4,0',
##              'tr_remarks'         : None
##            },
##            {
##              'tr_ord'             : '12.',
##              'tr_ord_no'          : '12',
##              'tr_student_name'    : 'Kaiwodw Anilewe Aneladgam',
##              'student_name'       : 'Kaiwodw Anilewe Aneladgam',
##              'last_name'          : 'Kaiwodw',
##              'first_name'         : 'Anilewe Aneladgam',
##              'tr_student_index'   : '222250',
##              'student_index'      : '222250',
##              'subj_grade_lecture' : '3,0',
##              'subj_grade_project' : '4,5',
##              'subj_grade_final'   : '3,5',
##              'tr_remarks'         : None
##            },
##            {
##              'tr_ord'             : '13.',
##              'tr_ord_no'          : '13',
##              'tr_student_name'    : 'Kurotkiw Annaoj Aniluap',
##              'student_name'       : 'Kurotkiw Annaoj Aniluap',
##              'last_name'          : 'Kurotkiw',
##              'first_name'         : 'Annaoj Aniluap',
##              'tr_student_index'   : '259288',
##              'student_index'      : '259288',
##              'subj_grade_lecture' : '3,5',
##              'subj_grade_project' : '5,0',
##              'subj_grade_final'   : '4,0',
##              'tr_remarks'         : None
##            }
##        ]
##        records = list(parser_.PzTbodyParser.records(iterator, grades))
##        self.maxDiff = None
##        self.assertEqual(records, expect)
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##    def test__records__2(self):
##        lines = [
###000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
###012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. Kasab Aglo                          264236       2,0        2,0",
##"          2. Keb Szotrab                         264437       4,0        4,0",
##"         24. Akszurg Aneladgam                   264876       3,0        3,0",
##"         25. Lezg Atram                          264478       2,0        2,0",
##"         26. Aksńawi Anilorak                    264281       2,0        2,0"
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        grades = ['subj_grade_lecture', 'subj_grade_final']
##        expect = [
##            {
##              'tr_ord'             : '1.',
##              'tr_ord_no'          : '1',
##              'tr_student_name'    : 'Kasab Aglo',
##              'student_name'       : 'Kasab Aglo',
##              'last_name'          : 'Kasab',
##              'first_name'         : 'Aglo',
##              'tr_student_index'   : '264236',
##              'student_index'      : '264236',
##              'subj_grade_lecture' : '2,0',
##              'subj_grade_final'   : '2,0',
##              'tr_remarks'         : None
##            },
##            {
##              'tr_ord'             : '2.',
##              'tr_ord_no'          : '2',
##              'tr_student_name'    : 'Keb Szotrab',
##              'student_name'       : 'Keb Szotrab',
##              'last_name'          : 'Keb',
##              'first_name'         : 'Szotrab',
##              'tr_student_index'   : '264437',
##              'student_index'      : '264437',
##              'subj_grade_lecture' : '4,0',
##              'subj_grade_final'   : '4,0',
##              'tr_remarks'         : None
##            },
##            {
##              'tr_ord'             : '24.',
##              'tr_ord_no'          : '24',
##              'tr_student_name'    : 'Akszurg Aneladgam',
##              'student_name'       : 'Akszurg Aneladgam',
##              'last_name'          : 'Akszurg',
##              'first_name'         : 'Aneladgam',
##              'tr_student_index'   : '264876',
##              'student_index'      : '264876',
##              'subj_grade_lecture' : '3,0',
##              'subj_grade_final'   : '3,0',
##              'tr_remarks'         : None
##            },
##            {
##              'tr_ord'             : '25.',
##              'tr_ord_no'          : '25',
##              'tr_student_name'    : 'Lezg Atram',
##              'student_name'       : 'Lezg Atram',
##              'last_name'          : 'Lezg',
##              'first_name'         : 'Atram',
##              'tr_student_index'   : '264478',
##              'student_index'      : '264478',
##              'subj_grade_lecture' : '2,0',
##              'subj_grade_final'   : '2,0',
##              'tr_remarks'         : None
##            },
##            {
##              'tr_ord'             : '26.',
##              'tr_ord_no'          : '26',
##              'tr_student_name'    : 'Aksńawi Anilorak',
##              'student_name'       : 'Aksńawi Anilorak',
##              'last_name'          : 'Aksńawi',
##              'first_name'         : 'Anilorak',
##              'tr_student_index'   : '264281',
##              'student_index'      : '264281',
##              'subj_grade_lecture' : '2,0',
##              'subj_grade_final'   : '2,0',
##              'tr_remarks'         : None
##            },
##        ]
##        records = list(parser_.PzTbodyParser.records(iterator, grades))
##        self.maxDiff = None
##        self.assertEqual(records, expect)
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##    def test__records__3(self):
##        lines = [
###000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
###012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. Kishuka Bharadwaj                    281566   2.0",
##"          2. Sulegna Ikswonazyrzk Nathalie       287489    3.0",
##"         15. Nav-Ekebneroh Echevarria Franz      284331    5.0",
##"             Alexander",
##"         16. Velisav Aili                        252325    4.0",
##"         17. S V RDATKDTRSCGRDFA                 275238    3.0",
##"             Shaguwnxfdj",
##"         18. Namaz Raamma                        285132    3.0"
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        grades = ['subj_grade_p', 'subj_grade_n']
##        expect = [
##            {
##              'tr_ord'          : '1.',
##              'tr_ord_no'       : '1',
##              'tr_student_name' : 'Kishuka Bharadwaj',
##              'student_name'    : 'Kishuka Bharadwaj',
##              'last_name'       : 'Kishuka',
##              'first_name'      : 'Bharadwaj',
##              'tr_student_index': '281566',
##              'student_index'   : '281566',
##              'subj_grade_p'    : '2.0',
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '2.',
##              'tr_ord_no'       : '2',
##              'tr_student_name' : 'Sulegna Ikswonazyrzk Nathalie',
##              'student_name'    : 'Sulegna Ikswonazyrzk Nathalie',
##              'last_name'       : 'Sulegna',
##              'first_name'      : 'Ikswonazyrzk Nathalie',
##              'tr_student_index': '287489',
##              'student_index'   : '287489',
##              'subj_grade_p'    : '3.0',
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '15.',
##              'tr_ord_no'       : '15',
##              'tr_student_name' : 'Nav-Ekebneroh Echevarria Franz Alexander',
##              'student_name'    : 'Nav-Ekebneroh Echevarria Franz Alexander',
##              'last_name'       : 'Nav-Ekebneroh',
##              'first_name'      : 'Echevarria Franz Alexander',
##              'tr_student_index': '284331',
##              'student_index'   : '284331',
##              'subj_grade_p'    : '5.0',
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '16.',
##              'tr_ord_no'       : '16',
##              'tr_student_name' : 'Velisav Aili',
##              'student_name'    : 'Velisav Aili',
##              'last_name'       : 'Velisav',
##              'first_name'      : 'Aili',
##              'tr_student_index': '252325',
##              'student_index'   : '252325',
##              'subj_grade_p'    : '4.0',
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '17.',
##              'tr_ord_no'       : '17',
##              'tr_student_name' : 'S V RDATKDTRSCGRDFA Shaguwnxfdj',
##              'student_name'    : 'S V RDATKDTRSCGRDFA Shaguwnxfdj',
##              'last_name'       : 'S',
##              'first_name'      : 'V RDATKDTRSCGRDFA Shaguwnxfdj',
##              'tr_student_index': '275238',
##              'student_index'   : '275238',
##              'subj_grade_p'    : '3.0',
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '18.',
##              'tr_ord_no'       : '18',
##              'tr_student_name' : 'Namaz Raamma',
##              'student_name'    : 'Namaz Raamma',
##              'last_name'       : 'Namaz',
##              'first_name'      : 'Raamma',
##              'tr_student_index': '285132',
##              'student_index'   : '285132',
##              'subj_grade_p'    : '3.0',
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##        ]
##        records = list(parser_.PzTbodyParser.records(iterator, grades))
##        self.maxDiff = None
##        self.assertEqual(records, expect)
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##    def test__records__4(self):
##        lines = [
###0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
###0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. Kishuka Bharadwaj                    281566   2.0",
##"          2. Sulegna Ikswonazyrzk Nathalie       287489    3.0",
##"         15. Nav-Ekebneroh Echevarria Franz      284331    5.0          I do have some remarks",
##"             Alexander",
##"         16. Velisav Aili                        252325          4.0",
##"         17. S V RDATKDTRSCGRDFA                 275238    3.0",
##"             Shaguwnxfdj                                               Other remarks",
##"         18. Namaz Raamma                        285132    3.0   3.5"
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        grades = ['subj_grade_p', 'subj_grade_n']
##        expect = [
##            {
##              'tr_ord'          : '1.',
##              'tr_ord_no'       : '1',
##              'tr_student_name' : 'Kishuka Bharadwaj',
##              'student_name'    : 'Kishuka Bharadwaj',
##              'last_name'       : 'Kishuka',
##              'first_name'      : 'Bharadwaj',
##              'tr_student_index': '281566',
##              'student_index'   : '281566',
##              'subj_grade_p'    : '2.0',
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '2.',
##              'tr_ord_no'       : '2',
##              'tr_student_name' : 'Sulegna Ikswonazyrzk Nathalie',
##              'student_name'    : 'Sulegna Ikswonazyrzk Nathalie',
##              'last_name'       : 'Sulegna',
##              'first_name'      : 'Ikswonazyrzk Nathalie',
##              'tr_student_index': '287489',
##              'student_index'   : '287489',
##              'subj_grade_p'    : '3.0',
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '15.',
##              'tr_ord_no'       : '15',
##              'tr_student_name' : 'Nav-Ekebneroh Echevarria Franz Alexander',
##              'student_name'    : 'Nav-Ekebneroh Echevarria Franz Alexander',
##              'last_name'       : 'Nav-Ekebneroh',
##              'first_name'      : 'Echevarria Franz Alexander',
##              'tr_student_index': '284331',
##              'student_index'   : '284331',
##              'subj_grade_p'    : '5.0',
##              'subj_grade_n'    : None,
##              'tr_remarks'      : 'I do have some remarks'
##            },
##            {
##              'tr_ord'          : '16.',
##              'tr_ord_no'       : '16',
##              'tr_student_name' : 'Velisav Aili',
##              'student_name'    : 'Velisav Aili',
##              'last_name'       : 'Velisav',
##              'first_name'      : 'Aili',
##              'tr_student_index': '252325',
##              'student_index'   : '252325',
##              'subj_grade_p'    : None,
##              'subj_grade_n'    : '4.0',
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '17.',
##              'tr_ord_no'       : '17',
##              'tr_student_name' : 'S V RDATKDTRSCGRDFA Shaguwnxfdj',
##              'student_name'    : 'S V RDATKDTRSCGRDFA Shaguwnxfdj',
##              'last_name'       : 'S',
##              'first_name'      : 'V RDATKDTRSCGRDFA Shaguwnxfdj',
##              'tr_student_index': '275238',
##              'student_index'   : '275238',
##              'subj_grade_p'    : '3.0',
##              'subj_grade_n'    : None,
##              'tr_remarks'      : 'Other remarks'
##            },
##            {
##              'tr_ord'          : '18.',
##              'tr_ord_no'       : '18',
##              'tr_student_name' : 'Namaz Raamma',
##              'student_name'    : 'Namaz Raamma',
##              'last_name'       : 'Namaz',
##              'first_name'      : 'Raamma',
##              'tr_student_index': '285132',
##              'student_index'   : '285132',
##              'subj_grade_p'    : '3.0',
##              'subj_grade_n'    : '3.5',
##              'tr_remarks'      : None
##            },
##        ]
##        records = list(parser_.PzTbodyParser.records(iterator, grades))
##        self.maxDiff = None
##        self.assertEqual(records, expect)
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##    def test__records__5(self):
##        lines = [
###0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
###0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. LAWARGA Mahbush                       252345",
##"         11. ISEDIPOG Alab Iluram Anhsirn          248092",
##"             Vaday",
##"         12. Hagwsedfx Iilotana                    K-3589",
##"         23. MANRXAQA REVSAGWZCDF Aynag             5227",
##"             Dasarp",
##"         31. Cziworteip Fotszyrzk Trebor           244151",
##"         32. Sazalp Lanreb Rasec Otsugua           283329",
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        grades = ['subj_grade']
##        expect = [
##            {
##              'tr_ord'          : '1.',
##              'tr_ord_no'       : '1',
##              'tr_student_name' : 'LAWARGA Mahbush',
##              'student_name'    : 'LAWARGA Mahbush',
##              'last_name'       : 'LAWARGA',
##              'first_name'      : 'Mahbush',
##              'tr_student_index': '252345',
##              'student_index'   : '252345',
##              'subj_grade'      : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '11.',
##              'tr_ord_no'       : '11',
##              'tr_student_name' : 'ISEDIPOG Alab Iluram Anhsirn Vaday',
##              'student_name'    : 'ISEDIPOG Alab Iluram Anhsirn Vaday',
##              'last_name'       : 'ISEDIPOG',
##              'first_name'      : 'Alab Iluram Anhsirn Vaday',
##              'tr_student_index': '248092',
##              'student_index'   : '248092',
##              'subj_grade'      : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '12.',
##              'tr_ord_no'       : '12',
##              'tr_student_name' : 'Hagwsedfx Iilotana',
##              'student_name'    : 'Hagwsedfx Iilotana',
##              'last_name'       : 'Hagwsedfx',
##              'first_name'      : 'Iilotana',
##              'tr_student_index': 'K-3589',
##              'student_index'   : 'K-3589',
##              'subj_grade'      : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '23.',
##              'tr_ord_no'       : '23',
##              'tr_student_name' : 'MANRXAQA REVSAGWZCDF Aynag Dasarp',
##              'student_name'    : 'MANRXAQA REVSAGWZCDF Aynag Dasarp',
##              'last_name'       : 'MANRXAQA',
##              'first_name'      : 'REVSAGWZCDF Aynag Dasarp',
##              'tr_student_index': '5227',
##              'student_index'   : '5227',
##              'subj_grade'      : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '31.',
##              'tr_ord_no'       : '31',
##              'tr_student_name' : 'Cziworteip Fotszyrzk Trebor',
##              'student_name'    : 'Cziworteip Fotszyrzk Trebor',
##              'last_name'       : 'Cziworteip',
##              'first_name'      : 'Fotszyrzk Trebor',
##              'tr_student_index': '244151',
##              'student_index'   : '244151',
##              'subj_grade'      : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '32.',
##              'tr_ord_no'       : '32',
##              'tr_student_name' : 'Sazalp Lanreb Rasec Otsugua',
##              'student_name'    : 'Sazalp Lanreb Rasec Otsugua',
##              'last_name'       : 'Sazalp',
##              'first_name'      : 'Lanreb Rasec Otsugua',
##              'tr_student_index': '283329',
##              'student_index'   : '283329',
##              'subj_grade'      : None,
##              'tr_remarks'      : None
##            },
##        ]
##        records = list(parser_.PzTbodyParser.records(iterator, grades))
##        self.assertEqual(records, expect)
##        with self.assertRaises(StopIteration):
##            next(iterator)
##
##    def test__records__6(self):
##        lines = [
###0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
###0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
##"          1. LAWARGA Mahbush                       252345",
##"         11. ISEDIPOG Alab Iluram Anhsirn          248092",
##"             Vaday",
##"         12. Hagwsedfx Iilotana                    K-3589",
##"         23. MANRXAQA REVSAGWZCDF Aynag             5227",
##"             Dasarp",
##"         31. Cziworteip Fotszyrzk Trebor           244151",
##"         32. Sazalp Lanreb Rasec Otsugua           283329",
##        ]
##        iterator = self.mkBufferedIterator(lines)
##        grades = ['subj_grade_p', 'subj_grade_n']
##        expect = [
##            {
##              'tr_ord'          : '1.',
##              'tr_ord_no'       : '1',
##              'tr_student_name' : 'LAWARGA Mahbush',
##              'student_name'    : 'LAWARGA Mahbush',
##              'last_name'       : 'LAWARGA',
##              'first_name'      : 'Mahbush',
##              'tr_student_index': '252345',
##              'student_index'   : '252345',
##              'subj_grade_p'    : None,
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '11.',
##              'tr_ord_no'       : '11',
##              'tr_student_name' : 'ISEDIPOG Alab Iluram Anhsirn Vaday',
##              'student_name'    : 'ISEDIPOG Alab Iluram Anhsirn Vaday',
##              'last_name'       : 'ISEDIPOG',
##              'first_name'      : 'Alab Iluram Anhsirn Vaday',
##              'tr_student_index': '248092',
##              'student_index'   : '248092',
##              'subj_grade_p'    : None,
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '12.',
##              'tr_ord_no'       : '12',
##              'tr_student_name' : 'Hagwsedfx Iilotana',
##              'student_name'    : 'Hagwsedfx Iilotana',
##              'last_name'       : 'Hagwsedfx',
##              'first_name'      : 'Iilotana',
##              'tr_student_index': 'K-3589',
##              'student_index'   : 'K-3589',
##              'subj_grade_p'    : None,
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '23.',
##              'tr_ord_no'       : '23',
##              'tr_student_name' : 'MANRXAQA REVSAGWZCDF Aynag Dasarp',
##              'student_name'    : 'MANRXAQA REVSAGWZCDF Aynag Dasarp',
##              'last_name'       : 'MANRXAQA',
##              'first_name'      : 'REVSAGWZCDF Aynag Dasarp',
##              'tr_student_index': '5227',
##              'student_index'   : '5227',
##              'subj_grade_p'    : None,
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '31.',
##              'tr_ord_no'       : '31',
##              'tr_student_name' : 'Cziworteip Fotszyrzk Trebor',
##              'student_name'    : 'Cziworteip Fotszyrzk Trebor',
##              'last_name'       : 'Cziworteip',
##              'first_name'      : 'Fotszyrzk Trebor',
##              'tr_student_index': '244151',
##              'student_index'   : '244151',
##              'subj_grade_p'    : None,
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##            {
##              'tr_ord'          : '32.',
##              'tr_ord_no'       : '32',
##              'tr_student_name' : 'Sazalp Lanreb Rasec Otsugua',
##              'student_name'    : 'Sazalp Lanreb Rasec Otsugua',
##              'last_name'       : 'Sazalp',
##              'first_name'      : 'Lanreb Rasec Otsugua',
##              'tr_student_index': '283329',
##              'student_index'   : '283329',
##              'subj_grade_p'    : None,
##              'subj_grade_n'    : None,
##              'tr_remarks'      : None
##            },
##        ]
##        records = list(parser_.PzTbodyParser.records(iterator, grades))
##        self.maxDiff = None
##        self.assertEqual(records, expect)
##        with self.assertRaises(StopIteration):
##            next(iterator)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
