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
        self.assertRegexMatch('Politechnika Warszawska', r)
        self.assertRegexMatch('P O L I T E C H N I K A    W  A  R  S  Z  A  W  S  K  A', r)

    def test_WYDZIAL_MECHANICZNY_ENERGETYKI_I_LOTNICTWA(self):
        r = tested._re_dict[r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA']
        self.assertRegexMatch('WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA', r)
        self.assertRegexMatch('Wydział Mechaniczny Energetyki i Lotnictwa', r)
        self.assertRegexMatch('W Y D Z I A Ł   M E C H A N I C Z N Y   E N E R G E T Y K I   I   L O T N I C T W A', r)

    def test_WYDZIAL_GEODEZJI_I_KARTOGRAFII(self):
        r = tested._re_dict[r'WYDZIAŁ GEODEZJI I KARTOGRAFII']
        self.assertRegexMatch('WYDZIAŁ GEODEZJI I KARTOGRAFII', r)
        self.assertRegexMatch('Wydział Geodezji i Kartografii', r)
        self.assertRegexMatch('W Y D Z I A Ł   G E O D E Z J I  I  K A R T O G R A F I I', r)

    def test_DZIEKANAT(self):
        r = tested._re_dict[r'DZIEKANAT']
        self.assertRegexMatch('DZIEKANAT', r)
        self.assertRegexMatch('Dziekanat', r)
        self.assertRegexMatch('D Z I E K A N A T', r)

    def test_contact_address_street_info__1(self):
        r = tested._re_dict[r'contact_address_street_info']
        self.assertRegexMatch('ul. Nowowiejska 24', r)
        m = r.match('ul. Nowowiejska 24')
        self.assertEqual(m.group('contact_address_street_prefix'), 'ul.')
        self.assertEqual(m.group('contact_address_street_name'), 'Nowowiejska')
        self.assertEqual(m.group('contact_address_street_number'), '24')


    def test_contact_address_street_info__2(self):
        r = tested._re_dict[r'contact_address_street_info']
        self.assertRegexMatch('pl. Narutowicza 11/2', r)
        m = r.match('pl. Narutowicza 11/2')
        self.assertEqual(m.group('contact_address_street_prefix'), 'pl.')
        self.assertEqual(m.group('contact_address_street_name'), 'Narutowicza')
        self.assertEqual(m.group('contact_address_street_number'), '11/2')

    def test_contact_address_street_info__3(self):
        r = tested._re_dict[r'contact_address_street_info']
        self.assertRegexMatch('Sienkiewicza 11A', r)
        m = r.match('Sienkiewicza 11A')
        self.assertIs(m.group('contact_address_street_prefix'), None)
        self.assertEqual(m.group('contact_address_street_name'), 'Sienkiewicza')
        self.assertEqual(m.group('contact_address_street_number'), '11A')

    def test_contact_address_street_info__4(self):
        r = tested._re_dict[r'contact_address_street_info']
        self.assertRegexMatch('Pana Michała Wołodyjowskiego 123-125', r)
        m = r.match('Pana Michała Wołodyjowskiego 123-125')
        self.assertIs(m.group('contact_address_street_prefix'), None)
        self.assertEqual(m.group('contact_address_street_name'), 'Pana Michała Wołodyjowskiego')
        self.assertEqual(m.group('contact_address_street_number'), '123-125')

    def test_contact_address_street_info__5(self):
        r = tested._re_dict[r'contact_address_street_info']
        self.assertRegexMatch('ul.Świętego Maksymiliana   Kolbe 23 - 30', r)
        m = r.match('ul.Świętego Maksymiliana   Kolbe 23 - 30')
        self.assertEqual(m.group('contact_address_street_prefix'), 'ul.')
        self.assertEqual(m.group('contact_address_street_name'), 'Świętego Maksymiliana   Kolbe')
        self.assertEqual(m.group('contact_address_street_number'), '23 - 30')

    def test_contact_address_postoffice_info__1(self):
        r = tested._re_dict[r'contact_address_postoffice_info']
        self.assertRegexMatch('00-665 Warszawa', r)
        m = r.match('00-665 Warszawa')
        self.assertEqual(m.group('contact_address_postoffice_zip'), '00-665')
        self.assertEqual(m.group('contact_address_postoffice_town'), 'Warszawa')

    def test_contact_address_postoffice_info__2(self):
        r = tested._re_dict[r'contact_address_postoffice_info']
        self.assertRegexMatch('21-500 Biała Podlaska', r)
        m = r.match('21-500 Biała Podlaska')
        self.assertEqual(m.group('contact_address_postoffice_zip'), '21-500')
        self.assertEqual(m.group('contact_address_postoffice_town'), 'Biała Podlaska')

    def test_contact_address_postoffice_info__3(self):
        r = tested._re_dict[r'contact_address_postoffice_info']
        self.assertRegexMatch('43-300 Bielsko-Biała', r)
        m = r.match('43-300 Bielsko-Biała')
        self.assertEqual(m.group('contact_address_postoffice_zip'), '43-300')
        self.assertEqual(m.group('contact_address_postoffice_town'), 'Bielsko-Biała')

    def test_contact_address_room_info__1(self):
        r = tested._re_dict[r'contact_address_room_info']
        self.assertRegexMatch('124', r)
        m = r.match('124')
        self.assertEqual(m.group('contact_address_room'), '124')

    def test_contact_address_room_info__2(self):
        r = tested._re_dict[r'contact_address_room_info']
        self.assertRegexMatch('p. 124', r)
        m = r.match('p. 124')
        self.assertEqual(m.group('contact_address_room'), 'p. 124')

    def test_contact_address_room_info__3(self):
        r = tested._re_dict[r'contact_address_room_info']
        self.assertRegexMatch('pok. 124', r)
        m = r.match('pok. 124')
        self.assertEqual(m.group('contact_address_room'), 'pok. 124')

    def test_contact_address_website_info__1(self):
        r = tested._re_dict[r'contact_address_website_info']
        self.assertRegexMatch('www.pl', r)
        m = r.match('www.pl')
        self.assertEqual(m.group('contact_address_website'), 'www.pl')

    def test_contact_address_website_info__2(self):
        r = tested._re_dict[r'contact_address_website_info']
        self.assertRegexMatch('meil.pw.edu.pl', r)
        m = r.match('meil.pw.edu.pl')
        self.assertEqual(m.group('contact_address_website'), 'meil.pw.edu.pl')

    def test_contact_address_website_info__3(self):
        r = tested._re_dict[r'contact_address_website_info']
        self.assertRegexMatch('http://pw.edu.pl', r)
        m = r.match('http://pw.edu.pl')
        self.assertEqual(m.group('contact_address_website'), 'http://pw.edu.pl')

class Test__re_groups(unittest.TestCase):
    def test_universities(self):
        keys = [ r'POLITECHNIKA WARSZAWSKA' ]
        for k in keys:
            self.assertIs(tested._re_groups['universities'][k], tested._re_dict[k])

    def test_faculties(self):
        keys = [
            r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA',
            r'WYDZIAŁ GEODEZJI I KARTOGRAFII'
        ]
        for k in keys:
            self.assertIs(tested._re_groups['faculties'][k], tested._re_dict[k])

    def test_contact_names(self):
        keys = [ r'DZIEKANAT' ]
        for k in keys:
            self.assertIs(tested._re_groups['contact_names'][k], tested._re_dict[k])




if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
