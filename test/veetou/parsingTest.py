#!/usr/bin/env python 3
# -*- coding: utf8 -*-


import unittest
import re
import veetou.parsing as tested


class Test__re_dict(unittest.TestCase):
    def assertRegexMatch(self, s, r, msg=None):
        try: p = r.pattern
        except AttributeError: p = r
        try: f = r.flags
        except AttributeError: f = 0
        r = re.compile(r'^' + p + '$', f)
        self.assertRegex(s, r, msg)
    def test_POLITECHNIKA_WARSZAWSKA(self):
        r = tested._re_dict[r'POLITECHNIKA WARSZAWSKA']
        self.assertRegexMatch('POLITECHNIKA WARSZAWSKA', r)
        self.assertRegexMatch('POLITECHNIKI WARSZAWSKIEJ', r)
        #self.assertRegexMatch('Politechnika Warszawska', r)
        self.assertRegexMatch('P O L I T E C H N I K A    W  A  R  S  Z  A  W  S  K  A', r)
        self.assertRegexMatch('P O L I T E C H N I K I    W  A  R  S  Z  A  W  S  K  I E J', r)

    def test_WYDZIAL_MECHANICZNY_ENERGETYKI_I_LOTNICTWA(self):
        r = tested._re_dict[r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA']
        self.assertRegexMatch('WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA', r)
        #self.assertRegexMatch('Wydział Mechaniczny Energetyki i Lotnictwa', r)
        self.assertRegexMatch('W Y D Z I A Ł   M E C H A N I C Z N Y   E N E R G E T Y K I   I   L O T N I C T W A', r)

    def test_WYDZIAL_GEODEZJI_I_KARTOGRAFII(self):
        r = tested._re_dict[r'WYDZIAŁ GEODEZJI I KARTOGRAFII']
        self.assertRegexMatch('WYDZIAŁ GEODEZJI I KARTOGRAFII', r)
        #self.assertRegexMatch('Wydział Geodezji i Kartografii', r)
        self.assertRegexMatch('W Y D Z I A Ł   G E O D E Z J I  I  K A R T O G R A F I I', r)

    def test_DZIEKANAT(self):
        r = tested._re_dict[r'DZIEKANAT']
        self.assertRegexMatch('DZIEKANAT', r)
        #self.assertRegexMatch('Dziekanat', r)
        self.assertRegexMatch('D Z I E K A N A T', r)

    def test_contact_address_street_info__1(self):
        r = tested._re_dict[r'contact_address_street_info']
        self.assertRegexMatch('ul. Nowowiejska 24', r)
        m = re.match(r,'ul. Nowowiejska 24')
        self.assertEqual(m.group('contact_address_street_prefix'), 'ul.')
        self.assertEqual(m.group('contact_address_street_name'), 'Nowowiejska')
        self.assertEqual(m.group('contact_address_street_number'), '24')


    def test_contact_address_street_info__2(self):
        r = tested._re_dict[r'contact_address_street_info']
        self.assertRegexMatch('pl. Narutowicza 11/2', r)
        m = re.match(r,'pl. Narutowicza 11/2')
        self.assertEqual(m.group('contact_address_street_prefix'), 'pl.')
        self.assertEqual(m.group('contact_address_street_name'), 'Narutowicza')
        self.assertEqual(m.group('contact_address_street_number'), '11/2')

    def test_contact_address_street_info__3(self):
        r = tested._re_dict[r'contact_address_street_info']
        self.assertRegexMatch('Sienkiewicza 11A', r)
        m = re.match(r,'Sienkiewicza 11A')
        self.assertIs(m.group('contact_address_street_prefix'), None)
        self.assertEqual(m.group('contact_address_street_name'), 'Sienkiewicza')
        self.assertEqual(m.group('contact_address_street_number'), '11A')

    def test_contact_address_street_info__4(self):
        r = tested._re_dict[r'contact_address_street_info']
        self.assertRegexMatch('Pana Michała Wołodyjowskiego 123-125', r)
        m = re.match(r,'Pana Michała Wołodyjowskiego 123-125')
        self.assertIs(m.group('contact_address_street_prefix'), None)
        self.assertEqual(m.group('contact_address_street_name'), 'Pana Michała Wołodyjowskiego')
        self.assertEqual(m.group('contact_address_street_number'), '123-125')

    def test_contact_address_street_info__5(self):
        r = tested._re_dict[r'contact_address_street_info']
        self.assertRegexMatch('ul.Świętego Maksymiliana   Kolbe 23 - 30', r)
        m = re.match(r,'ul.Świętego Maksymiliana   Kolbe 23 - 30')
        self.assertEqual(m.group('contact_address_street_prefix'), 'ul.')
        self.assertEqual(m.group('contact_address_street_name'), 'Świętego Maksymiliana   Kolbe')
        self.assertEqual(m.group('contact_address_street_number'), '23 - 30')

    def test_contact_address_postoffice_info__1(self):
        r = tested._re_dict[r'contact_address_postoffice_info']
        self.assertRegexMatch('00-665 Warszawa', r)
        m = re.match(r,'00-665 Warszawa')
        self.assertEqual(m.group('contact_address_postoffice_zip'), '00-665')
        self.assertEqual(m.group('contact_address_postoffice_town'), 'Warszawa')

    def test_contact_address_postoffice_info__2(self):
        r = tested._re_dict[r'contact_address_postoffice_info']
        self.assertRegexMatch('21-500 Biała Podlaska', r)
        m = re.match(r,'21-500 Biała Podlaska')
        self.assertEqual(m.group('contact_address_postoffice_zip'), '21-500')
        self.assertEqual(m.group('contact_address_postoffice_town'), 'Biała Podlaska')

    def test_contact_address_postoffice_info__3(self):
        r = tested._re_dict[r'contact_address_postoffice_info']
        self.assertRegexMatch('43-300 Bielsko-Biała', r)
        m = re.match(r,'43-300 Bielsko-Biała')
        self.assertEqual(m.group('contact_address_postoffice_zip'), '43-300')
        self.assertEqual(m.group('contact_address_postoffice_town'), 'Bielsko-Biała')

    def test_contact_address_edifice_info__1(self):
        r = tested._re_dict[r'contact_address_edifice_info']
        self.assertRegexMatch('Gmach Lotniczy', r)
        m = re.match(r,'Gmach Lotniczy')
        self.assertEqual(m.group('contact_address_edifice'), 'Gmach Lotniczy')

    def test_contact_address_edifice_info__2(self):
        r = tested._re_dict[r'contact_address_edifice_info']
        self.assertRegexMatch('Budynek Żółtogęsią-Jaźniowy 12', r)
        m = re.match(r,'Budynek Żółtogęsią-Jaźniowy 12')
        self.assertEqual(m.group('contact_address_edifice'), 'Budynek Żółtogęsią-Jaźniowy 12')

    def test_contact_address_room_info__1(self):
        r = tested._re_dict[r'contact_address_room_info']
        self.assertRegexMatch('124', r)
        m = re.match(r,'124')
        self.assertEqual(m.group('contact_address_room'), '124')

    def test_contact_address_room_info__2(self):
        r = tested._re_dict[r'contact_address_room_info']
        self.assertRegexMatch('p. 124', r)
        m = re.match(r,'p. 124')
        self.assertEqual(m.group('contact_address_room'), 'p. 124')

    def test_contact_address_room_info__3(self):
        r = tested._re_dict[r'contact_address_room_info']
        self.assertRegexMatch('pok. 124', r)
        m = re.match(r,'pok. 124')
        self.assertEqual(m.group('contact_address_room'), 'pok. 124')

    def test_contact_address_website_info__1(self):
        r = tested._re_dict[r'contact_address_website_info']
        self.assertRegexMatch('www.pl', r)
        m = re.match(r,'www.pl')
        self.assertEqual(m.group('contact_address_website'), 'www.pl')

    def test_contact_address_website_info__2(self):
        r = tested._re_dict[r'contact_address_website_info']
        self.assertRegexMatch('meil.pw.edu.pl', r)
        m = re.match(r,'meil.pw.edu.pl')
        self.assertEqual(m.group('contact_address_website'), 'meil.pw.edu.pl')

    def test_contact_address_website_info__3(self):
        r = tested._re_dict[r'contact_address_website_info']
        self.assertRegexMatch('http://pw.edu.pl', r)
        m = re.match(r,'http://pw.edu.pl')
        self.assertEqual(m.group('contact_address_website'), 'http://pw.edu.pl')

    def test_contact_address__1(self):
        r = tested._re_dict[r'contact_address']
        self.assertRegexMatch('ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125', r)
        m = re.match(r,'ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125')
        self.assertEqual(m.group('contact_address'), 'ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125')
        self.assertEqual(m.group('contact_address_street_prefix_0'), 'ul.')
        self.assertEqual(m.group('contact_address_street_name_0'), 'Nowowiejska')
        self.assertEqual(m.group('contact_address_street_number_0'), '24')
        self.assertEqual(m.group('contact_address_postoffice_zip_0'), '00-665')
        self.assertEqual(m.group('contact_address_postoffice_town_0'), 'Warszawa')
        self.assertEqual(m.group('contact_address_edifice_0'), 'Gmach Lotniczy')
        self.assertEqual(m.group('contact_address_room_0'), 'pok. 125')

    def test_contact_address__2(self):
        r = tested._re_dict[r'contact_address']
        self.assertRegexMatch('Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl', r)
        m = re.match(r, 'Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl')
        self.assertEqual(m.group('contact_address'), 'Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl')
        self.assertIs(m.group('contact_address_street_prefix_1'), None)
        self.assertEqual(m.group('contact_address_street_name_1'), 'Plac Politechniki')
        self.assertEqual(m.group('contact_address_street_number_1'), '1')
        self.assertEqual(m.group('contact_address_postoffice_zip_1'), '00-661')
        self.assertEqual(m.group('contact_address_postoffice_town_1'), 'Warszawa')
        self.assertEqual(m.group('contact_address_room_1'), 'p. 301')

    def test_contact_phone__1(self):
        r = tested._re_dict[r'contact_phone']
        self.assertRegexMatch('tel. (+48) 22 234 72 23', r)
        m = re.match(r, 'tel. (+48) 22 234 72 23')
        self.assertEqual(m.group('contact_phone'), 'tel. (+48) 22 234 72 23')
        self.assertEqual(m.group('contact_phone_prefix'), 'tel.')
        self.assertEqual(m.group('contact_phone_numbers'), '(+48) 22 234 72 23')

    def test_contact_phone__2(self):
        r = tested._re_dict[r'contact_phone']
        self.assertRegexMatch('tel.: (022) 621 53 10, (022) 234 73 54', r)
        m = re.match(r, 'tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('contact_phone'), 'tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('contact_phone_prefix'), 'tel.:')
        self.assertEqual(m.group('contact_phone_numbers'), '(022) 621 53 10, (022) 234 73 54')

    def test_contact_faxtel__1(self):
        r = tested._re_dict[r'contact_faxtel']
        self.assertRegexMatch('fax. (+48) 22 234 72 23', r)
        m = re.match(r, 'fax. (+48) 22 234 72 23')
        self.assertEqual(m.group('contact_faxtel'), 'fax. (+48) 22 234 72 23')
        self.assertEqual(m.group('contact_faxtel_prefix'), 'fax.')
        self.assertEqual(m.group('contact_faxtel_numbers'), '(+48) 22 234 72 23')

    def test_contact_faxtel__2(self):
        r = tested._re_dict[r'contact_faxtel']
        self.assertRegexMatch('fax/tel.: (022) 625 73 51', r)
        m = re.match(r, 'fax/tel.: (022) 621 73 51')
        self.assertEqual(m.group('contact_faxtel'), 'fax/tel.: (022) 621 73 51')
        self.assertEqual(m.group('contact_faxtel_prefix'), 'fax/tel.:')
        self.assertEqual(m.group('contact_faxtel_numbers'), '(022) 621 73 51')

    def test_contact_faxtel__3(self):
        r = tested._re_dict[r'contact_faxtel']
        self.assertRegexMatch('fax/tel.: (022) 621 53 10, (022) 234 73 54', r)
        m = re.match(r, 'fax/tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('contact_faxtel'), 'fax/tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('contact_faxtel_prefix'), 'fax/tel.:')
        self.assertEqual(m.group('contact_faxtel_numbers'), '(022) 621 53 10, (022) 234 73 54')

class Test__predefined_phrases(unittest.TestCase):
    def test_university(self):
        items = [ r'POLITECHNIKA WARSZAWSKA' ]
        self.assertEqual(tested._predefined_phrases['university'], items)
        for item in items:
            self.assertIsInstance(tested._re_dict[item], str)

    def test_faculty(self):
        items = [
            r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA',
            r'WYDZIAŁ GEODEZJI I KARTOGRAFII'
        ]
        self.assertEqual(tested._predefined_phrases['faculty'], items)
        for item in items:
            self.assertIsInstance(tested._re_dict[item], str)

    def test_contact_name(self):
        items = [ r'DZIEKANAT' ]
        self.assertEqual(tested._predefined_phrases['contact_name'], items)
        for item in items:
            self.assertIsInstance(tested._re_dict[item], str)


class Test__try_university_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_university_line("I don't match anything"), dict())

    def test__POLITECHNIKA_WARSZAWSKA(self):
        expect = { 'university' : "POLITECHNIKA WARSZAWSKA" }
        self.assertEqual(tested.try_university_line("   POLITECHNIKA WARSZAWSKA     "), expect)
        self.assertEqual(tested.try_university_line("   POLITECHNIKI WARSZAWSKIEJ       "), expect)
        self.assertEqual(tested.try_university_line("   P O L I T E C H N I K A   W A R S Z A W S K A       "), expect)
        self.assertEqual(tested.try_university_line("   P O L I T E C H N I K I   W A R S Z A W S K I E J       "), expect)

class Test__try_faculty_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_faculty_line("I don't match anything"), dict())

    def test_WYDZIAL_MECHANICZNY_ENERGETYKI_I_LOTNICTWA(self):
        expect = { 'faculty' : "WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA" }
        self.assertEqual(tested.try_faculty_line("  WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA  "), expect)
        self.assertEqual(tested.try_faculty_line("  W Y D Z I A Ł  M E C H A NI C Z NY   E NE  R G E T Y K I   I   L O T NI C T W A    "), expect)

    def test_WYDZIAL_GEODEZJI_I_KARTOGRAFII(self):
        expect = { 'faculty' : "WYDZIAŁ GEODEZJI I KARTOGRAFII" }
        self.assertEqual(tested.try_faculty_line("  WYDZIAŁ GEODEZJI I KARTOGRAFII  "), expect)
        self.assertEqual(tested.try_faculty_line("  W Y D Z I A Ł  G E O D E Z J I   I   K A R TO G R A F I I      "), expect)

class Test__try_contact_name_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_contact_name_line("I don't match anything"), dict())

    def test_DZIEKANAT(self):
        expect = { 'contact_name' : "DZIEKANAT" }
        self.assertEqual(tested.try_contact_name_line("     DZIEKANAT       "), expect)
        self.assertEqual(tested.try_contact_name_line("     D Z I E K A N A T     "), expect)

class Test__try_contact_address_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_contact_address_line("I don't match anything"), dict())

    def test_MEiL_DZIEKANAT(self):
        line = "     ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125   "
        expect = {
            'contact_address_street_prefix'     : 'ul.',
            'contact_address_street_name'       : 'Nowowiejska',
            'contact_address_street_number'     : '24',
            'contact_address_postoffice_zip'    : '00-665',
            'contact_address_postoffice_town'   : 'Warszawa',
            'contact_address_edifice'           : 'Gmach Lotniczy',
            'contact_address_room'              : 'pok. 125',
            'contact_address_website'           : None,
            'contact_address'                   : 'ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125'
        }
        self.assertEqual(expect, tested.try_contact_address_line(line))

    def test_GIK_301(self):
        line = "     Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl   "
        expect = {
            'contact_address_street_prefix'     : None,
            'contact_address_street_name'       : 'Plac Politechniki',
            'contact_address_street_number'     : '1',
            'contact_address_postoffice_zip'    : '00-661',
            'contact_address_postoffice_town'   : 'Warszawa',
            'contact_address_edifice'           : None,
            'contact_address_room'              : 'p. 301',
            'contact_address_website'           : 'www.gik.pw.edu.pl',
            'contact_address'                   : 'Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl'
        }
        self.assertEqual(expect, tested.try_contact_address_line(line))

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
