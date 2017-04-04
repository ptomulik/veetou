#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import re
import veetou_legacy.parsing as tested


class Test__dict_re(unittest.TestCase):
    def assertRegexMatch(self, s, r, msg=None):
        try: p = r.pattern
        except AttributeError: p = r
        try: f = r.flags
        except AttributeError: f = 0
        r = re.compile(r'^' + p + '$', f)
        self.assertRegex(s, r, msg)
    def test_POLITECHNIKA_WARSZAWSKA(self):
        r = tested._dict_re[r'POLITECHNIKA WARSZAWSKA']
        self.assertRegexMatch('POLITECHNIKA WARSZAWSKA', r)
        self.assertRegexMatch('POLITECHNIKI WARSZAWSKIEJ', r)
        #self.assertRegexMatch('Politechnika Warszawska', r)
        self.assertRegexMatch('P O L I T E C H N I K A    W  A  R  S  Z  A  W  S  K  A', r)
        self.assertRegexMatch('P O L I T E C H N I K I    W  A  R  S  Z  A  W  S  K  I E J', r)

    def test_WYDZIAL_MECHANICZNY_ENERGETYKI_I_LOTNICTWA(self):
        r = tested._dict_re[r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA']
        self.assertRegexMatch('WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA', r)
        #self.assertRegexMatch('Wydział Mechaniczny Energetyki i Lotnictwa', r)
        self.assertRegexMatch('W Y D Z I A Ł   M E C H A N I C Z N Y   E N E R G E T Y K I   I   L O T N I C T W A', r)

    def test_WYDZIAL_GEODEZJI_I_KARTOGRAFII(self):
        r = tested._dict_re[r'WYDZIAŁ GEODEZJI I KARTOGRAFII']
        self.assertRegexMatch('WYDZIAŁ GEODEZJI I KARTOGRAFII', r)
        #self.assertRegexMatch('Wydział Geodezji i Kartografii', r)
        self.assertRegexMatch('W Y D Z I A Ł   G E O D E Z J I  I  K A R T O G R A F I I', r)

    def test_DZIEKANAT(self):
        r = tested._dict_re[r'DZIEKANAT']
        self.assertRegexMatch('DZIEKANAT', r)
        #self.assertRegexMatch('Dziekanat', r)
        self.assertRegexMatch('D Z I E K A N A T', r)

    def test_pz_address_street__1(self):
        r = tested._dict_re[r'pz_address_street']
        self.assertRegexMatch('ul. Nowowiejska 24', r)
        m = re.match(r,'ul. Nowowiejska 24')
        self.assertEqual(m.group('pz_address_street_prefix'), 'ul.')
        self.assertEqual(m.group('pz_address_street_name'), 'Nowowiejska')
        self.assertEqual(m.group('pz_address_street_number'), '24')


    def test_pz_address_street__2(self):
        r = tested._dict_re[r'pz_address_street']
        self.assertRegexMatch('pl. Narutowicza 11/2', r)
        m = re.match(r,'pl. Narutowicza 11/2')
        self.assertEqual(m.group('pz_address_street_prefix'), 'pl.')
        self.assertEqual(m.group('pz_address_street_name'), 'Narutowicza')
        self.assertEqual(m.group('pz_address_street_number'), '11/2')

    def test_pz_address_street__3(self):
        r = tested._dict_re[r'pz_address_street']
        self.assertRegexMatch('Sienkiewicza 11A', r)
        m = re.match(r,'Sienkiewicza 11A')
        self.assertIs(m.group('pz_address_street_prefix'), None)
        self.assertEqual(m.group('pz_address_street_name'), 'Sienkiewicza')
        self.assertEqual(m.group('pz_address_street_number'), '11A')

    def test_pz_address_street__4(self):
        r = tested._dict_re[r'pz_address_street']
        self.assertRegexMatch('Pana Michała Wołodyjowskiego 123-125', r)
        m = re.match(r,'Pana Michała Wołodyjowskiego 123-125')
        self.assertIs(m.group('pz_address_street_prefix'), None)
        self.assertEqual(m.group('pz_address_street_name'), 'Pana Michała Wołodyjowskiego')
        self.assertEqual(m.group('pz_address_street_number'), '123-125')

    def test_pz_address_street__5(self):
        r = tested._dict_re[r'pz_address_street']
        self.assertRegexMatch('ul.Świętego Maksymiliana   Kolbe 23 - 30', r)
        m = re.match(r,'ul.Świętego Maksymiliana   Kolbe 23 - 30')
        self.assertEqual(m.group('pz_address_street_prefix'), 'ul.')
        self.assertEqual(m.group('pz_address_street_name'), 'Świętego Maksymiliana   Kolbe')
        self.assertEqual(m.group('pz_address_street_number'), '23 - 30')

    def test_pz_address_postoffice__1(self):
        r = tested._dict_re[r'pz_address_postoffice']
        self.assertRegexMatch('00-665 Warszawa', r)
        m = re.match(r,'00-665 Warszawa')
        self.assertEqual(m.group('pz_address_postoffice_zip'), '00-665')
        self.assertEqual(m.group('pz_address_postoffice_town'), 'Warszawa')

    def test_pz_address_postoffice__2(self):
        r = tested._dict_re[r'pz_address_postoffice']
        self.assertRegexMatch('21-500 Biała Podlaska', r)
        m = re.match(r,'21-500 Biała Podlaska')
        self.assertEqual(m.group('pz_address_postoffice_zip'), '21-500')
        self.assertEqual(m.group('pz_address_postoffice_town'), 'Biała Podlaska')

    def test_pz_address_postoffice__3(self):
        r = tested._dict_re[r'pz_address_postoffice']
        self.assertRegexMatch('43-300 Bielsko-Biała', r)
        m = re.match(r,'43-300 Bielsko-Biała')
        self.assertEqual(m.group('pz_address_postoffice_zip'), '43-300')
        self.assertEqual(m.group('pz_address_postoffice_town'), 'Bielsko-Biała')

    def test_pz_address_edifice__1(self):
        r = tested._dict_re[r'pz_address_edifice']
        self.assertRegexMatch('Gmach Lotniczy', r)
        m = re.match(r,'Gmach Lotniczy')
        self.assertEqual(m.group('pz_address_edifice'), 'Gmach Lotniczy')

    def test_pz_address_edifice__2(self):
        r = tested._dict_re[r'pz_address_edifice']
        self.assertRegexMatch('Budynek Żółtogęsią-Jaźniowy 12', r)
        m = re.match(r,'Budynek Żółtogęsią-Jaźniowy 12')
        self.assertEqual(m.group('pz_address_edifice'), 'Budynek Żółtogęsią-Jaźniowy 12')

    def test_pz_address_room__1(self):
        r = tested._dict_re[r'pz_address_room']
        self.assertRegexMatch('124', r)
        m = re.match(r,'124')
        self.assertEqual(m.group('pz_address_room'), '124')

    def test_pz_address_room__2(self):
        r = tested._dict_re[r'pz_address_room']
        self.assertRegexMatch('p. 124', r)
        m = re.match(r,'p. 124')
        self.assertEqual(m.group('pz_address_room'), 'p. 124')

    def test_pz_address_room__3(self):
        r = tested._dict_re[r'pz_address_room']
        self.assertRegexMatch('pok. 124', r)
        m = re.match(r,'pok. 124')
        self.assertEqual(m.group('pz_address_room'), 'pok. 124')

    def test_pz_address_website__1(self):
        r = tested._dict_re[r'pz_address_website']
        self.assertRegexMatch('www.pl', r)
        m = re.match(r,'www.pl')
        self.assertEqual(m.group('pz_address_website'), 'www.pl')

    def test_pz_address_website__2(self):
        r = tested._dict_re[r'pz_address_website']
        self.assertRegexMatch('meil.pw.edu.pl', r)
        m = re.match(r,'meil.pw.edu.pl')
        self.assertEqual(m.group('pz_address_website'), 'meil.pw.edu.pl')

    def test_pz_address_website__3(self):
        r = tested._dict_re[r'pz_address_website']
        self.assertRegexMatch('http://pw.edu.pl', r)
        m = re.match(r,'http://pw.edu.pl')
        self.assertEqual(m.group('pz_address_website'), 'http://pw.edu.pl')

    def test_pz_header_address__1(self):
        r = tested._dict_re[r'pz_header_address']
        self.assertRegexMatch('ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125', r)
        m = re.match(r,'ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125')
        self.assertEqual(m.group('pz_header_address'), 'ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125')
        self.assertEqual(m.group('pz_address_street_prefix_0'), 'ul.')
        self.assertEqual(m.group('pz_address_street_name_0'), 'Nowowiejska')
        self.assertEqual(m.group('pz_address_street_number_0'), '24')
        self.assertEqual(m.group('pz_address_postoffice_zip_0'), '00-665')
        self.assertEqual(m.group('pz_address_postoffice_town_0'), 'Warszawa')
        self.assertEqual(m.group('pz_address_edifice_0'), 'Gmach Lotniczy')
        self.assertEqual(m.group('pz_address_room_0'), 'pok. 125')

    def test_pz_header_address__2(self):
        r = tested._dict_re[r'pz_header_address']
        self.assertRegexMatch('Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl', r)
        m = re.match(r, 'Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl')
        self.assertEqual(m.group('pz_header_address'), 'Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl')
        self.assertIs(m.group('pz_address_street_prefix_1'), None)
        self.assertEqual(m.group('pz_address_street_name_1'), 'Plac Politechniki')
        self.assertEqual(m.group('pz_address_street_number_1'), '1')
        self.assertEqual(m.group('pz_address_postoffice_zip_1'), '00-661')
        self.assertEqual(m.group('pz_address_postoffice_town_1'), 'Warszawa')
        self.assertEqual(m.group('pz_address_room_1'), 'p. 301')

    def test_pz_phone__1(self):
        r = tested._dict_re[r'pz_phone']
        self.assertRegexMatch('tel. (+48) 22 234 72 23', r)
        m = re.match(r, 'tel. (+48) 22 234 72 23')
        self.assertEqual(m.group('pz_phone'), 'tel. (+48) 22 234 72 23')
        self.assertEqual(m.group('pz_phone_prefix'), 'tel.')
        self.assertEqual(m.group('pz_phone_numbers'), '(+48) 22 234 72 23')

    def test_pz_phone__2(self):
        r = tested._dict_re[r'pz_phone']
        self.assertRegexMatch('tel.: (022) 621 53 10, (022) 234 73 54', r)
        m = re.match(r, 'tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('pz_phone'), 'tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('pz_phone_prefix'), 'tel.:')
        self.assertEqual(m.group('pz_phone_numbers'), '(022) 621 53 10, (022) 234 73 54')

    def test_pz_faxtel__1(self):
        r = tested._dict_re[r'pz_faxtel']
        self.assertRegexMatch('fax. (+48) 22 234 72 23', r)
        m = re.match(r, 'fax. (+48) 22 234 72 23')
        self.assertEqual(m.group('pz_faxtel'), 'fax. (+48) 22 234 72 23')
        self.assertEqual(m.group('pz_faxtel_prefix'), 'fax.')
        self.assertEqual(m.group('pz_faxtel_numbers'), '(+48) 22 234 72 23')

    def test_pz_faxtel__2(self):
        r = tested._dict_re[r'pz_faxtel']
        self.assertRegexMatch('fax/tel.: (022) 625 73 51', r)
        m = re.match(r, 'fax/tel.: (022) 621 73 51')
        self.assertEqual(m.group('pz_faxtel'), 'fax/tel.: (022) 621 73 51')
        self.assertEqual(m.group('pz_faxtel_prefix'), 'fax/tel.:')
        self.assertEqual(m.group('pz_faxtel_numbers'), '(022) 621 73 51')

    def test_pz_faxtel__3(self):
        r = tested._dict_re[r'pz_faxtel']
        self.assertRegexMatch('fax/tel.: (022) 621 53 10, (022) 234 73 54', r)
        m = re.match(r, 'fax/tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('pz_faxtel'), 'fax/tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('pz_faxtel_prefix'), 'fax/tel.:')
        self.assertEqual(m.group('pz_faxtel_numbers'), '(022) 621 53 10, (022) 234 73 54')

    def test_pz_email__1(self):
        r = tested._dict_re[r'pz_email']
        self.assertRegexMatch('e-mail: p-1.tomulik@meil.pw.edu.pl', r)
        m = re.match(r, 'e-mail: p-1.tomulik@meil.pw.edu.pl')
        self.assertEqual(m.group('pz_email'), 'e-mail: p-1.tomulik@meil.pw.edu.pl')
        self.assertEqual(m.group('pz_email_prefix'), 'e-mail:')
        self.assertEqual(m.group('pz_email_address'), 'p-1.tomulik@meil.pw.edu.pl')
        self.assertEqual(m.group('pz_email_address_localpart'), 'p-1.tomulik')
        self.assertEqual(m.group('pz_email_address_domain'), 'meil.pw.edu.pl')

    def test_pz_header_contact__1(self):
        r = tested._dict_re[r'pz_header_contact']
        s = 'tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail: dziekanat@meil.pw.edu.pl'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_header_contact'), s)
        self.assertEqual(m.group('pz_phone'), 'tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('pz_phone_prefix'), 'tel.:')
        self.assertEqual(m.group('pz_phone_numbers'), '(022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('pz_faxtel'), 'fax/tel.: (022) 625 73 51')
        self.assertEqual(m.group('pz_faxtel_prefix'), 'fax/tel.:')
        self.assertEqual(m.group('pz_faxtel_numbers'), '(022) 625 73 51')
        self.assertEqual(m.group('pz_email'), 'e-mail: dziekanat@meil.pw.edu.pl')
        self.assertEqual(m.group('pz_email_prefix'), 'e-mail:')
        self.assertEqual(m.group('pz_email_address'), 'dziekanat@meil.pw.edu.pl')
        self.assertEqual(m.group('pz_email_address_localpart'), 'dziekanat')
        self.assertEqual(m.group('pz_email_address_domain'), 'meil.pw.edu.pl')

    def test_pz_header_contact__2(self):
        r = tested._dict_re[r'pz_header_contact']
        s = 'tel.: (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_header_contact'), s)
        self.assertEqual(m.group('pz_phone'), 'tel.: (+48) 22 234 72 23')
        self.assertEqual(m.group('pz_phone_prefix'), 'tel.:')
        self.assertEqual(m.group('pz_phone_numbers'), '(+48) 22 234 72 23')
        self.assertIs(m.group('pz_faxtel'), None)
        self.assertIs(m.group('pz_faxtel_prefix'), None)
        self.assertIs(m.group('pz_faxtel_numbers'), None)
        self.assertEqual(m.group('pz_email'), 'e-mail: dziekan@gik.pw.edu.pl')
        self.assertEqual(m.group('pz_email_prefix'), 'e-mail:')
        self.assertEqual(m.group('pz_email_address'), 'dziekan@gik.pw.edu.pl')
        self.assertEqual(m.group('pz_email_address_localpart'), 'dziekan')
        self.assertEqual(m.group('pz_email_address_domain'), 'gik.pw.edu.pl')

    def test_pz_preamble_town_and_datetime__1(self):
        r = tested._dict_re[r'pz_preamble_town_and_datetime']
        s = 'Warszawa, 08.02.2014, 13:09:53'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_town_and_datetime'), s)
        self.assertEqual(m.group('pz_town'), 'Warszawa')
        self.assertEqual(m.group('pz_date'), '08.02.2014')
        self.assertEqual(m.group('pz_time'), '13:09:53')

    def test_pz_preamble_title__1(self):
        r = tested._dict_re[r'pz_preamble_title']
        s = 'Protokół zaliczeń (egzamin) 2015 Z/B-1/197'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_title'), s)
        self.assertEqual(m.group('pz_title'), 'Protokół zaliczeń')
        self.assertEqual(m.group('pz_exam'), 'egzamin')
        self.assertEqual(m.group('pz_semester'), '2015 Z')
        self.assertEqual(m.group('pz_serie'), 'B-1')
        self.assertEqual(m.group('pz_number'), '197')

    def test_pz_preamble_title__2(self):
        r = tested._dict_re[r'pz_preamble_title']
        s = 'Protokół zaliczeń (bez egzaminu) 2013Z/E-1/252'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_title'), s)
        self.assertEqual(m.group('pz_title'), 'Protokół zaliczeń')
        self.assertEqual(m.group('pz_exam'), 'bez egzaminu')
        self.assertEqual(m.group('pz_semester'), '2013Z')
        self.assertEqual(m.group('pz_serie'), 'E-1')
        self.assertEqual(m.group('pz_number'), '252')

    def test_pz_preamble_return__1(self):
        r = tested._dict_re[r'pz_preamble_return']
        s = 'Termin zwrotu 02.02.2016'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_return'), s)
        self.assertEqual(m.group('pz_return_desc'), 'Termin zwrotu')
        self.assertEqual(m.group('pz_return_date'), '02.02.2016')

    def test_pz_preamble_subj_name__1(self):
        r = tested._dict_re[r'pz_preamble_subj_name']
        s = 'Nazwa przedmiotu: Advanced Aero Engines Laboratory'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_subj_name'), s)
        self.assertEqual(m.group('pz_subj_name'), 'Advanced Aero Engines Laboratory')

    def test_pz_preamble_subj_code__1(self):
        r = tested._dict_re[r'pz_preamble_subj_code']
        s = 'Nr katalogowy: ML.ANS600'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_subj_code'), s)
        self.assertEqual(m.group('pz_subj_code'), 'ML.ANS600')

    def test_pz_preamble_subj_code__2(self):
        r = tested._dict_re[r'pz_preamble_subj_code']
        s = 'Nr katalogowy: GK.NIK113'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_subj_code'), s)
        self.assertEqual(m.group('pz_subj_code'), 'GK.NIK113')

    def test_pz_preamble_subj_code__3(self):
        r = tested._dict_re[r'pz_preamble_subj_code']
        s = 'Nr katalogowy: GP.SMS238'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_subj_code'), s)
        self.assertEqual(m.group('pz_subj_code'), 'GP.SMS238')

    def test_pz_preamble_department__1(self):
        r = tested._dict_re[r'pz_preamble_department']
        s = 'Zakład Silników Lotniczych'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_department'), s)

    def test_pz_preamble_department__2(self):
        r = tested._dict_re[r'pz_preamble_department']
        s = 'Katedra Gospodarki Przestrzennej i Nauk o Środowisku Przyrodnicznym'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_department'), s)

    def test_pz_preamble_department__2(self):
        r = tested._dict_re[r'pz_preamble_department']
        s = 'Wydział Mechaniczny Energetyki i Lotnictwa'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_department'), s)


    def test_pz_preamble_subj_tutor__1(self):
        r = tested._dict_re[r'pz_preamble_subj_tutor']
        s = 'Kierownik przedmiotu: dr hab. inż. Kazimierz Kowalski'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_subj_tutor'), s)
        self.assertEqual(m.group('pz_subj_tutor'), 'dr hab. inż. Kazimierz Kowalski')

    def test_pz_preamble_subj_tutor__2(self):
        r = tested._dict_re[r'pz_preamble_subj_tutor']
        s = 'Kierownik przedmiotu: dr hab. inż. Natenczas Woyski, prof. PW'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_subj_tutor'), s)
        self.assertEqual(m.group('pz_subj_tutor'), 'dr hab. inż. Natenczas Woyski, prof. PW')

    def test_pz_preamble_subj_grades__1(self):
        r = tested._dict_re[r'pz_preamble_subj_grades']
        s = "Dopuszczalne oceny:'2.0', '3.0', '3.5', '4.0', '4.5', '5.0'"
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_subj_grades'), s)
        self.assertEqual(m.group('pz_subj_grades'), "'2.0', '3.0', '3.5', '4.0', '4.5', '5.0'")

    def test_pz_preamble_subj_grades__2(self):
        r = tested._dict_re[r'pz_preamble_subj_grades']
        s = "Dopuszczalne oceny:'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'"
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_subj_grades'), s)
        self.assertEqual(m.group('pz_subj_grades'), "'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'")

    def test_pz_preamble_subj_grades__3(self):
        r = tested._dict_re[r'pz_preamble_subj_grades']
        s = "Dopuszczalne oceny:'Zal', 'Nzal', 'Zw'"
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('pz_preamble_subj_grades'), s)
        self.assertEqual(m.group('pz_subj_grades'), "'Zal', 'Nzal', 'Zw'")

class Test__predefined_phrases(unittest.TestCase):
    def test_university(self):
        items = [ r'POLITECHNIKA WARSZAWSKA' ]
        self.assertEqual(tested._predefined_phrases['university'], items)
        for item in items:
            self.assertIsInstance(tested._dict_re[item], str)

    def test_faculty(self):
        items = [
            r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA',
            r'WYDZIAŁ GEODEZJI I KARTOGRAFII'
        ]
        self.assertEqual(tested._predefined_phrases['faculty'], items)
        for item in items:
            self.assertIsInstance(tested._dict_re[item], str)

    def test_contact_name(self):
        items = [ r'DZIEKANAT' ]
        self.assertEqual(tested._predefined_phrases['contact_name'], items)
        for item in items:
            self.assertIsInstance(tested._dict_re[item], str)


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

class Test__try_pz_header_address_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_header_address_line("I don't match anything"), dict())

    def test_MEiL_DZIEKANAT(self):
        line = "     ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125   "
        expect = {
            'pz_address_street_prefix'     : 'ul.',
            'pz_address_street_name'       : 'Nowowiejska',
            'pz_address_street_number'     : '24',
            'pz_address_postoffice_zip'    : '00-665',
            'pz_address_postoffice_town'   : 'Warszawa',
            'pz_address_edifice'           : 'Gmach Lotniczy',
            'pz_address_room'              : 'pok. 125',
            'pz_address_website'           : None,
            'pz_header_address'                   : 'ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125'
        }
        self.assertEqual(expect, tested.try_pz_header_address_line(line))

    def test_GIK_301(self):
        line = "     Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl   "
        expect = {
            'pz_address_street_prefix'     : None,
            'pz_address_street_name'       : 'Plac Politechniki',
            'pz_address_street_number'     : '1',
            'pz_address_postoffice_zip'    : '00-661',
            'pz_address_postoffice_town'   : 'Warszawa',
            'pz_address_edifice'           : None,
            'pz_address_room'              : 'p. 301',
            'pz_address_website'           : 'www.gik.pw.edu.pl',
            'pz_header_address'                   : 'Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl'
        }
        self.assertEqual(expect, tested.try_pz_header_address_line(line))

class Test__try_pz_header_contact_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_header_contact_line("I don't match anything"), dict())

    def test__MEiL__1(self):
        line = "        tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail:dziekanat@meil.pw.edu.pl  "
        expect = {
            'pz_phone_prefix'              : 'tel.:',
            'pz_phone_numbers'             : '(022) 621 53 10, (022) 234 73 54',
            'pz_phone'                     : 'tel.: (022) 621 53 10, (022) 234 73 54',
            'pz_faxtel_prefix'             : 'fax/tel.:',
            'pz_faxtel_numbers'            : '(022) 625 73 51',
            'pz_faxtel'                    : 'fax/tel.: (022) 625 73 51',
            'pz_email_prefix'              : 'e-mail:',
            'pz_email_address_localpart'   : 'dziekanat',
            'pz_email_address_domain'      : 'meil.pw.edu.pl',
            'pz_email_address'             : 'dziekanat@meil.pw.edu.pl',
            'pz_email'                     : 'e-mail:dziekanat@meil.pw.edu.pl',
            'pz_header_contact'                : 'tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail:dziekanat@meil.pw.edu.pl'
        }
        self.assertEqual(expect, tested.try_pz_header_contact_line(line))

    def test__GiK__1(self):
        line = "        tel. (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl  "
        expect = {
            'pz_phone_prefix'              : 'tel.',
            'pz_phone_numbers'             : '(+48) 22 234 72 23',
            'pz_phone'                     : 'tel. (+48) 22 234 72 23',
            'pz_faxtel_prefix'             : None,
            'pz_faxtel_numbers'            : None,
            'pz_faxtel'                    : None,
            'pz_email_prefix'              : 'e-mail:',
            'pz_email_address_localpart'   : 'dziekan',
            'pz_email_address_domain'      : 'gik.pw.edu.pl',
            'pz_email_address'             : 'dziekan@gik.pw.edu.pl',
            'pz_email'                     : 'e-mail: dziekan@gik.pw.edu.pl',
            'pz_header_contact'                : 'tel. (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl'
        }
        self.assertEqual(expect, tested.try_pz_header_contact_line(line))

class Test__try_pz_preamble_town_and_datetime_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_preamble_town_and_datetime_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Warszawa, 08.02.2014, 13:09:53  "
        expect = {
            'pz_town'    : 'Warszawa',
            'pz_date'    : '08.02.2014',
            'pz_time'    : '13:09:53',
            'pz_preamble_town_and_datetime'   : 'Warszawa, 08.02.2014, 13:09:53'
        }
        self.assertEqual(expect, tested.try_pz_preamble_town_and_datetime_line(line))

    def test__2(self):
        line = "        Szklarska Poręba, 08.02.2014, 13:09:53  "
        expect = {
            'pz_town'    : 'Szklarska Poręba',
            'pz_date'    : '08.02.2014',
            'pz_time'    : '13:09:53',
            'pz_preamble_town_and_datetime'   : 'Szklarska Poręba, 08.02.2014, 13:09:53'
        }
        self.assertEqual(expect, tested.try_pz_preamble_town_and_datetime_line(line))

    def test__3(self):
        line = "        Bielsko-Biała, 08.02.2014, 13:09:53  "
        expect = {
            'pz_town'    : 'Bielsko-Biała',
            'pz_date'    : '08.02.2014',
            'pz_time'    : '13:09:53',
            'pz_preamble_town_and_datetime'   : 'Bielsko-Biała, 08.02.2014, 13:09:53'
        }
        self.assertEqual(expect, tested.try_pz_preamble_town_and_datetime_line(line))

class Test__try_pz_preamble_title_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_preamble_title_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Protokół zaliczeń (egzamin) 2013Z/E-1/118       "
        expect = {
            'pz_preamble_title'            : 'Protokół zaliczeń (egzamin) 2013Z/E-1/118',
            'pz_title'      : 'Protokół zaliczeń',
            'pz_exam'       : 'egzamin',
            'pz_semester'   : '2013Z',
            'pz_serie'      : 'E-1',
            'pz_number'     : '118'
        }
        self.assertEqual(expect, tested.try_pz_preamble_title_line(line))

    def test__2(self):
        line = "        Protokół zaliczeń (bez egzaminu) 2015 Z/B-1/197       "
        expect = {
            'pz_preamble_title'      : 'Protokół zaliczeń (bez egzaminu) 2015 Z/B-1/197',
            'pz_title'      : 'Protokół zaliczeń',
            'pz_exam'       : 'bez egzaminu',
            'pz_semester'   : '2015 Z',
            'pz_serie'      : 'B-1',
            'pz_number'     : '197'
        }
        self.assertEqual(expect, tested.try_pz_preamble_title_line(line))

class Test__try_pz_preamble_subj_name_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_preamble_subj_name_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Nazwa przedmiotu: Health and Safety Training       "
        expect = {
            'pz_preamble_subj_name'  : 'Nazwa przedmiotu: Health and Safety Training',
            'pz_subj_name'           : 'Health and Safety Training'
        }
        self.assertEqual(expect, tested.try_pz_preamble_subj_name_line(line))

class Test__try_pz_preamble_subj_code_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_preamble_subj_code_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Nr katalogowy: ML.ANW71       "
        expect = {
            'pz_preamble_subj_code'  : 'Nr katalogowy: ML.ANW71',
            'pz_subj_code'           : 'ML.ANW71'
        }
        self.assertEqual(expect, tested.try_pz_preamble_subj_code_line(line))

class Test__try_pz_preamble_department_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_preamble_department_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Wydział Mechaniczny Energetyki i Lotnictwa       "
        expect = {
            'pz_preamble_department'  : 'Wydział Mechaniczny Energetyki i Lotnictwa'
        }
        self.assertEqual(expect, tested.try_pz_preamble_department_line(line))

class Test__try_pz_preamble_subj_tutor_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_preamble_subj_tutor_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Kierownik przedmiotu: prof. dr hab inż. Wacław Jaki, prof. PW   "
        expect = {
            'pz_preamble_subj_tutor'  : 'Kierownik przedmiotu: prof. dr hab inż. Wacław Jaki, prof. PW',
            'pz_subj_tutor'           : 'prof. dr hab inż. Wacław Jaki, prof. PW'
        }
        self.assertEqual(expect, tested.try_pz_preamble_subj_tutor_line(line))

class Test__try_pz_preamble_subj_grades_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_preamble_subj_grades_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Dopuszczalne oceny: '2.0', '3.0', '3.5', '4.0', '4.5', '5.0'   "
        expect = {
            'pz_preamble_subj_grades'  : "Dopuszczalne oceny: '2.0', '3.0', '3.5', '4.0', '4.5', '5.0'",
            'pz_subj_grades'           : "'2.0', '3.0', '3.5', '4.0', '4.5', '5.0'"
        }
        self.assertEqual(expect, tested.try_pz_preamble_subj_grades_line(line))

class Test__try_pz_preamble_subj_cond_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_preamble_subj_cond_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Wszyscy studenci na liście muszą mieć wystawioną ocenę.     "
        expect = {
            'pz_preamble_subj_cond'  : "Wszyscy studenci na liście muszą mieć wystawioną ocenę",
            'pz_subj_cond'           : "Wszyscy studenci na liście muszą mieć wystawioną ocenę",
        }
        self.assertEqual(expect, tested.try_pz_preamble_subj_cond_line(line))

class Test__try_pz_footer_sig_dots_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_footer_sig_dots_line("I don't match anything"), dict())

    def test__1(self):
        line = "                                                      ........................"
        expect = {
            'pz_footer_sig_dots' : "........................",
        }
        self.assertEqual(expect, tested.try_pz_footer_sig_dots_line(line))

class Test__try_pz_footer_sig_prompt_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_footer_sig_prompt_line("I don't match anything"), dict())

    def test__1(self):
        line = "                                                     podpis kierownika"
        expect = {
            'pz_footer_sig_prompt' : "podpis kierownika"
        }
        self.assertEqual(expect, tested.try_pz_footer_sig_prompt_line(line))

class Test__try_pz_footer_pagination_and_title_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_pz_footer_pagination_and_title_line("I don't match anything"), dict())

    def test__1(self):
        self.maxDiff = None
        line = "       Strona 1 z 3                                                   Gospodarowanie surowcami mineralnymi (GP.SMS238). Protokół: 2013Z/E-1/118     "

        expect = {
                'pz_footer_pagination_and_title' : "Strona 1 z 3                                                   Gospodarowanie surowcami mineralnymi (GP.SMS238). Protokół: 2013Z/E-1/118",
                'pz_footer_pagination'           : "Strona 1 z 3",
                'pz_footer_title'                : 'Gospodarowanie surowcami mineralnymi (GP.SMS238). Protokół: 2013Z/E-1/118',
                'pz_page_number'                 : '1',
                'pz_pages_total'                 : '3',
                'pz_subj_name'                   : 'Gospodarowanie surowcami mineralnymi',
                'pz_subj_code'                   : 'GP.SMS238',
                'pz_semester'                    : '2013Z',
                'pz_serie'                       : 'E-1',
                'pz_number'                      : '118'
        }
        self.assertEqual(expect, tested.try_pz_footer_pagination_and_title_line(line))

class Test__try_pz_page_header(unittest.TestCase):
    def test__MEiL_1(self):
        header = \
"""
                                                                                        POLITECHNIKA WARSZAWSKA
                                       WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA
                                                                                                             DZIEKANAT
                                                                      ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125
                                           tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail:dziekanat@meil.pw.edu.pl
"""
        lines = header.splitlines()
        expect = {
            'university'                        : 'POLITECHNIKA WARSZAWSKA',
            'faculty'                           : 'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA',
            'contact_name'                      : 'DZIEKANAT',
            'pz_address_street_prefix'     : 'ul.',
            'pz_address_street_name'       : 'Nowowiejska',
            'pz_address_street_number'     : '24',
            'pz_address_postoffice_zip'    : '00-665',
            'pz_address_postoffice_town'   : 'Warszawa',
            'pz_address_edifice'           : 'Gmach Lotniczy',
            'pz_address_room'              : 'pok. 125',
            'pz_address_website'           : None,
            'pz_header_address'                   : 'ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125',
            'pz_phone_prefix'              : 'tel.:',
            'pz_phone_numbers'             : '(022) 621 53 10, (022) 234 73 54',
            'pz_phone'                     : 'tel.: (022) 621 53 10, (022) 234 73 54',
            'pz_faxtel_prefix'             : 'fax/tel.:',
            'pz_faxtel_numbers'            : '(022) 625 73 51',
            'pz_faxtel'                    : 'fax/tel.: (022) 625 73 51',
            'pz_email_prefix'              : 'e-mail:',
            'pz_email_address_localpart'   : 'dziekanat',
            'pz_email_address_domain'      : 'meil.pw.edu.pl',
            'pz_email_address'             : 'dziekanat@meil.pw.edu.pl',
            'pz_email'                     : 'e-mail:dziekanat@meil.pw.edu.pl',
            'pz_header_contact'                : 'tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail:dziekanat@meil.pw.edu.pl'
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_page_header(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 6)
        self.maxDiff = None
        self.assertEqual(expect, result)

    def test__GiK_1(self):
        header = \
"""
                                     P  O   L  I  T  E  C   H  N   I K   A     W   A  R   S  Z  A   W   S  K   A
                             WYDZIAŁ                  GEODEZJI                   I   KARTOGRAFII

                                          Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl
                                               tel. (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl
"""
        lines = header.splitlines()
        expect = {
            'university'                        : 'POLITECHNIKA WARSZAWSKA',
            'faculty'                           : 'WYDZIAŁ GEODEZJI I KARTOGRAFII',
            'pz_address_street_prefix'       : None,
            'pz_address_street_name'         : 'Plac Politechniki',
            'pz_address_street_number'       : '1',
            'pz_address_postoffice_zip'      : '00-661',
            'pz_address_postoffice_town'     : 'Warszawa',
            'pz_address_edifice'             : None,
            'pz_address_room'                : 'p. 301',
            'pz_address_website'             : 'www.gik.pw.edu.pl',
            'pz_header_address'              : 'Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl',
            'pz_phone_prefix'              : 'tel.',
            'pz_phone_numbers'             : '(+48) 22 234 72 23',
            'pz_phone'                     : 'tel. (+48) 22 234 72 23',
            'pz_faxtel_prefix'             : None,
            'pz_faxtel_numbers'            : None,
            'pz_faxtel'                    : None,
            'pz_email_prefix'              : 'e-mail:',
            'pz_email_address_localpart'   : 'dziekan',
            'pz_email_address_domain'      : 'gik.pw.edu.pl',
            'pz_email_address'             : 'dziekan@gik.pw.edu.pl',
            'pz_email'                     : 'e-mail: dziekan@gik.pw.edu.pl',
            'pz_header_contact'                : 'tel. (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl'
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_page_header(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 6)
        self.maxDiff = None
        self.assertEqual(expect, result)

class Test__try_pz_preamble(unittest.TestCase):
    def test__MEIL__1(self):
        preamble = \
"""
                                                                                                         Warszawa, 02.02.2016, 14:08:26
                                          Protokół zaliczeń (bez egzaminu) 2015 Z/B-1/197
                                                          Termin zwrotu 02.02.2016
       Nazwa przedmiotu: Advanced Aero Engines Laboratory
       Nr katalogowy: ML.ANS600
       Zakład Silników Lotniczych
       Kierownik przedmiotu: dr hab. inż. Natenczas Woyski
       Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'. Wszyscy studenci na liście muszą mieć wystawioną ocenę.
"""
        lines = preamble.splitlines()
        expect = {
            'pz_preamble_town_and_datetime' : 'Warszawa, 02.02.2016, 14:08:26',
            'pz_preamble_title'       :  'Protokół zaliczeń (bez egzaminu) 2015 Z/B-1/197',
            'pz_preamble_return'      :  'Termin zwrotu 02.02.2016',
            'pz_preamble_subj_name'   :  'Nazwa przedmiotu: Advanced Aero Engines Laboratory',
            'pz_preamble_subj_code'   :  'Nr katalogowy: ML.ANS600',
            'pz_preamble_department'  :  'Zakład Silników Lotniczych',
            'pz_preamble_subj_tutor'  :  'Kierownik przedmiotu: dr hab. inż. Natenczas Woyski',
            'pz_preamble_subj_grades' :  "Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
            'pz_preamble_subj_cond'   :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę",
            'pz_town'                 :  'Warszawa',
            'pz_date'                 :  '02.02.2016',
            'pz_time'                 :  '14:08:26',
            'pz_title'                :  'Protokół zaliczeń',
            'pz_exam'                 :  'bez egzaminu',
            'pz_semester'             :  '2015 Z',
            'pz_serie'                :  'B-1',
            'pz_number'               :  '197',
            'pz_return_desc'          :  'Termin zwrotu',
            'pz_return_date'          :  '02.02.2016',
            'pz_subj_name'            :  'Advanced Aero Engines Laboratory',
            'pz_subj_code'            :  'ML.ANS600',
            'pz_subj_tutor'           :  'dr hab. inż. Natenczas Woyski',
            'pz_subj_grades'          :  "'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
            'pz_subj_cond'            :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę"
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_preamble(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 9)
        self.maxDiff = None
        self.assertEqual(expect, result)

    def test__GiK__1(self):
        preamble = \
"""
                                                                                                         Warszawa, 08.02.2014, 13:34:30
                                              Protokół zaliczeń (egzamin) 2013Z/E-1/118
                                                         Termin zwrotu 17.02.2014
       Nazwa przedmiotu: Gospodarowanie surowcami mineralnymi
       Nr katalogowy: GP.SMS238
       Katedra Gospodarki Przestrzennej i Nauk o Środowisku Przyrodnicznym
       Kierownik przedmiotu: dr hab. inż. Natenczas Woyski
       Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'
       Wszyscy studenci na liście muszą mieć wystawioną ocenę
"""
        lines = preamble.splitlines()
        expect = {
            'pz_preamble_town_and_datetime' : 'Warszawa, 08.02.2014, 13:34:30',
            'pz_preamble_title'       :  'Protokół zaliczeń (egzamin) 2013Z/E-1/118',
            'pz_preamble_return'      :  'Termin zwrotu 17.02.2014',
            'pz_preamble_subj_name'   :  'Nazwa przedmiotu: Gospodarowanie surowcami mineralnymi',
            'pz_preamble_subj_code'   :  'Nr katalogowy: GP.SMS238',
            'pz_preamble_department'  :  'Katedra Gospodarki Przestrzennej i Nauk o Środowisku Przyrodnicznym',
            'pz_preamble_subj_tutor'  :  'Kierownik przedmiotu: dr hab. inż. Natenczas Woyski',
            'pz_preamble_subj_grades' :  "Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
            'pz_preamble_subj_cond'   :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę",
            'pz_town'                 :  'Warszawa',
            'pz_date'                 :  '08.02.2014',
            'pz_time'                 :  '13:34:30',
            'pz_title'                :  'Protokół zaliczeń',
            'pz_exam'                 :  'egzamin',
            'pz_semester'             :  '2013Z',
            'pz_serie'                :  'E-1',
            'pz_number'               :  '118',
            'pz_return_desc'          :  'Termin zwrotu',
            'pz_return_date'          :  '17.02.2014',
            'pz_subj_name'            :  'Gospodarowanie surowcami mineralnymi',
            'pz_subj_code'            :  'GP.SMS238',
            'pz_subj_tutor'           :  'dr hab. inż. Natenczas Woyski',
            'pz_subj_grades'          :  "'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
            'pz_subj_cond'            :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę"
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_preamble(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 10)
        self.maxDiff = None
        self.assertEqual(expect, result)

class Test__try_pz_page_footer(unittest.TestCase):
    def test__MEIL__1(self):
        footer = \
"""
                                                                                                                   ........................
                                                                                                                      podpis kierownika
       Strona 1 z 3                                                   Gospodarowanie surowcami mineralnymi (GP.SMS238). Protokół: 2013Z/E-1/118
       Wygenerowano z użyciem Verbis Dean's Office, www.verbis.pl
"""
        lines = footer.splitlines()
        expect = {
            'pz_footer_sig_dots'             : '........................',
            'pz_footer_sig_prompt'           : 'podpis kierownika',
            'pz_footer_pagination_and_title' : 'Strona 1 z 3                                                   Gospodarowanie surowcami mineralnymi (GP.SMS238). Protokół: 2013Z/E-1/118',
            'pz_footer_pagination'           : 'Strona 1 z 3',
            'pz_footer_title'                : 'Gospodarowanie surowcami mineralnymi (GP.SMS238). Protokół: 2013Z/E-1/118',
            'pz_page_number'                 : '1',
            'pz_pages_total'                 : '3',
            'pz_subj_name'                   : 'Gospodarowanie surowcami mineralnymi',
            'pz_subj_code'                   : 'GP.SMS238',
            'pz_semester'                    : '2013Z',
            'pz_serie'                       : 'E-1',
            'pz_number'                      : '118',
            'pz_footer_generator'            : "Wygenerowano z użyciem Verbis Dean's Office, www.verbis.pl",
            'pz_generator'                   : "Verbis Dean's Office, www.verbis.pl",
            'pz_generator_name'              : "Verbis Dean's Office",
            'pz_generator_home'              : "www.verbis.pl"
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_page_footer(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 5)
        self.maxDiff = None
        self.assertEqual(expect, result)

class Test__try_pz_table_header(unittest.TestCase):
    def test__MEiL_1(self):
        header = \
"""\
                                                               Ocena
        Lp.               Student                 Nr albumu      z            Uwagi
                                                             przedmiotu
"""
        lines = header.splitlines()
        expect = {
            r'pz_table_header_0' : 'Ocena',
            r'pz_table_header_2' : 'Lp.               Student                 Nr albumu      z            Uwagi',
            r'pz_table_header_3' : 'przedmiotu',
            r'pz_table_header_subj_grade_fields' : ['pz_subj_grade']
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_table_header(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 3)
        self.maxDiff = None
        self.assertEqual(expect, result)

    def test__MEiL_2(self):
        header = \
"""\
                                                            Ocena
                                                               z
        Lp.               Student               Nr albumu                    Uwagi
                                                          przedmiotu
                                                            P    N
"""
        lines = header.splitlines()
        expect = {
            r'pz_table_header_0' : 'Ocena',
            r'pz_table_header_1' : 'z',
            r'pz_table_header_2' : 'Lp.               Student               Nr albumu                    Uwagi',
            r'pz_table_header_3' : 'przedmiotu',
            r'pz_table_header_4' : 'P    N',
            r'pz_table_header_subj_grade_fields' : ['pz_subj_grade_p', 'pz_subj_grade_n']
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_table_header(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 5)
        self.maxDiff = None
        self.assertEqual(expect, result)

    def test__GiK_1(self):
        header = \
"""\
                                                                  Ocena
        Lp.               Student               Nr albumu                              Uwagi
                                                           z wykładu  końcowa
"""
        lines = header.splitlines()
        expect = {
            r'pz_table_header_0' : 'Ocena',
            r'pz_table_header_2' : 'Lp.               Student               Nr albumu                              Uwagi',
            r'pz_table_header_3' : 'z wykładu  końcowa',
            r'pz_table_header_subj_grade_fields' : ['pz_subj_grade_lecture', 'pz_subj_grade_final']
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_table_header(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 3)
        self.maxDiff = None
        self.assertEqual(expect, result)

    def test__GiK_2(self):
        header = \
"""\
                                                                       Ocena
        Lp.               Student               Nr albumu                                         Uwagi
                                                           z wykładu  z projektu końcowa
"""
        lines = header.splitlines()
        expect = {
            r'pz_table_header_0' : 'Ocena',
            r'pz_table_header_2' : 'Lp.               Student               Nr albumu                                         Uwagi',
            r'pz_table_header_3' : 'z wykładu  z projektu końcowa',
            r'pz_table_header_subj_grade_fields' : ['pz_subj_grade_lecture', 'pz_subj_grade_project', 'pz_subj_grade_final']
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_table_header(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 3)
        self.maxDiff = None
        self.assertEqual(expect, result)

    def test__GiK_3(self):
        header = \
"""\
                                                                  Ocena
        Lp.               Student               Nr albumu                              Uwagi
                                                           z projektu końcowa
"""
        lines = header.splitlines()
        expect = {
            r'pz_table_header_0' : 'Ocena',
            r'pz_table_header_2' : 'Lp.               Student               Nr albumu                              Uwagi',
            r'pz_table_header_3' : 'z projektu końcowa',
            r'pz_table_header_subj_grade_fields' : ['pz_subj_grade_project', 'pz_subj_grade_final']
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_table_header(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 3)
        self.maxDiff = None
        self.assertEqual(expect, result)

    def test__GiK_4(self):
        header = \
"""\
                                                                       Ocena
        Lp.               Student               Nr albumu                                         Uwagi
                                                           z wykładu  z ćwiczeń  końcowa
"""
        lines = header.splitlines()
        expect = {
            r'pz_table_header_0' : 'Ocena',
            r'pz_table_header_2' : 'Lp.               Student               Nr albumu                                         Uwagi',
            r'pz_table_header_3' : 'z wykładu  z ćwiczeń  końcowa',
            r'pz_table_header_subj_grade_fields' : ['pz_subj_grade_lecture', 'pz_subj_grade_class', 'pz_subj_grade_final']
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_pz_table_header(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 3)
        self.maxDiff = None
        self.assertEqual(expect, result)

class Test__pz_find_table_geometry(unittest.TestCase):
    def test__GiK_1(self):
        self.maxDiff = None
        lines = [
#000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
#012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. Keczetna Szamot Nafets              256701       3,5        5,0       4,0",
"          2. Myżob Anilorak                      254104       3,0        5,0       3,5",
"          3. Akslowogułd Atarzogałm              256127       4,5        3,5       4,5",
"          4. Tifołog Awe                          256110      3,0        4,5       3,5",
"          5. Aksńeimak Ailatan Atarzogłam         256421      3,5        4,5       4,0",
"         12. Kaiwodw Anilewe Aneladgam           222250       3,0        4,5       3,5",
"         13. Kurotkiw Annaoj Aniluap              259288      3,5        5,0       4,0"
        ]
        geom = tested.pz_find_table_geometry(lines, grade_cols_count = 3)
        expect = [[9, 12], [13, 41], [49, 56], [62, 65], [73, 76], [83, 86], [86, 86]]
        self.assertEqual(geom, expect)
        split = tested.pz_split_table_columns(lines, geom)
        split_expect = [
            ['1.',  'Keczetna Szamot Nafets',       '256701',  '3,5', '5,0', '4,0', ''],
            ['2.',  'Myżob Anilorak',               '254104',  '3,0', '5,0', '3,5', ''],
            ['3.',  'Akslowogułd Atarzogałm',       '256127',  '4,5', '3,5', '4,5', ''],
            ['4.',  'Tifołog Awe',                  '256110', '3,0', '4,5', '3,5', ''],
            ['5.',  'Aksńeimak Ailatan Atarzogłam', '256421', '3,5', '4,5', '4,0', ''],
            ['12.', 'Kaiwodw Anilewe Aneladgam',    '222250',  '3,0', '4,5', '3,5', ''],
            ['13.', 'Kurotkiw Annaoj Aniluap',      '259288', '3,5', '5,0', '4,0', '']
        ]
        self.assertEqual(split, split_expect)

    def test__GiK_2(self):
        lines = [
#000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
#012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. Kasab Aglo                          264236       2,0        2,0",
"          2. Keb Szotrab                         264437       4,0        4,0",
"         24. Akszurg Aneladgam                   264876       3,0        3,0",
"         25. Lezg Atram                          264478       2,0        2,0",
"         26. Aksńawi Anilorak                    264281       2,0        2,0"
        ]
        geom = tested.pz_find_table_geometry(lines, grade_cols_count = 2)
        expect = [[9, 12], [13, 30], [49, 55], [62, 65], [73, 76], [76, 76]]
        self.assertEqual(geom, expect)
        split = tested.pz_split_table_columns(lines, geom)
        split_expect = [
            ['1.',  'Kasab Aglo',        '264236', '2,0', '2,0', ''],
            ['2.',  'Keb Szotrab',       '264437', '4,0', '4,0', ''],
            ['24.', 'Akszurg Aneladgam', '264876', '3,0', '3,0', ''],
            ['25.', 'Lezg Atram',        '264478', '2,0', '2,0', ''],
            ['26.', 'Aksńawi Anilorak',  '264281', '2,0', '2,0', '']
        ]
        self.assertEqual(split, split_expect)

    def test__MEiL_1(self):
        lines = [
#000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
#012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. Kishuka Bharadwaj                    281566   2.0",
"          2. Sulegna Ikswonazyrzk Nathalie       287489    3.0",
"         15. Nav-Ekebneroh Echevarria Franz      284331    5.0",
"             Alexander",
"         16. Velisav Aili                        252325    4.0",
"         17. S V RDATKDTRSCGRDFA                 275238    3.0",
"             Shaguwnxfdj",
"         18. Namaz Raamma                        285132    3.0"
        ]
        geom = tested.pz_find_table_geometry(lines, grade_cols_count = 2)
        expect = [[9, 12], [13, 43], [49, 56], [59, 62], [62, 62], [62, 62]]
        self.assertEqual(geom, expect)
        split = tested.pz_split_table_columns(lines, geom)
        split_expect = [
            ['1.',  'Kishuka Bharadwaj',                   '281566',    '2.0', '', ''],
            ['2.',  'Sulegna Ikswonazyrzk Nathalie',       '287489',    '3.0', '', ''],
            ['15.', 'Nav-Ekebneroh Echevarria Franz',      '284331',    '5.0', '', ''],
            ['',    'Alexander',                           '',          '',    '', ''],
            ['16.', 'Velisav Aili',                        '252325',    '4.0', '', ''],
            ['17.', 'S V RDATKDTRSCGRDFA',                 '275238',    '3.0', '', ''],
            ['',    'Shaguwnxfdj',                         '',          '',    '', ''],
            ['18.', 'Namaz Raamma',                        '285132',    '3.0', '', '']
        ]
        self.assertEqual(split, split_expect)

    def test__MEiL_2(self):
        self.maxDiff = None
        lines = [
#0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
#0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. Kishuka Bharadwaj                    281566   2.0",
"          2. Sulegna Ikswonazyrzk Nathalie       287489    3.0",
"         15. Nav-Ekebneroh Echevarria Franz      284331    5.0          I do have some remarks",
"             Alexander",
"         16. Velisav Aili                        252325          4.0",
"         17. S V RDATKDTRSCGRDFA                 275238    3.0",
"             Shaguwnxfdj                                               Other remarks",
"         18. Namaz Raamma                        285132    3.0   3.5"
        ]
        geom = tested.pz_find_table_geometry(lines, grade_cols_count = 2)
        expect = [[9, 12], [13, 43], [49, 56], [59, 62], [65, 68], [71, 94]]
        self.assertEqual(geom, expect)
        split = tested.pz_split_table_columns(lines, geom)
        split_expect = [
            ['1.',  'Kishuka Bharadwaj',                   '281566',   '2.0',  '',    ''],
            ['2.' , 'Sulegna Ikswonazyrzk Nathalie',       '287489',    '3.0', '',    ''],
            ['15.', 'Nav-Ekebneroh Echevarria Franz',      '284331',    '5.0', '',    'I do have some remarks'],
            ['',    'Alexander'                     ,      '',          '',    '',    ''],
            ['16.', 'Velisav Aili',                        '252325',    '',    '4.0', ''],
            ['17.', 'S V RDATKDTRSCGRDFA',                 '275238',    '3.0', '',    ''],
            ['',    'Shaguwnxfdj',                         '',          '',    '',    'Other remarks'],
            ['18.', 'Namaz Raamma',                        '285132',    '3.0', '3.5', '']
        ]
        self.assertEqual(split, split_expect)

    def test__MEiL_3(self):
        self.maxDiff = None
        lines = [
#0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
#0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. LAWARGA Mahbush                       252345",
"         11. ISEDIPOG Alab Iluram Anhsirn          248092",
"             Vaday",
"         12. Hagwsedfx Iilotana                    K-3589",
"         23. MANRXAQA REVSAGWZCDF Aynag             5227",
"             Dasarp",
"         31. Cziworteip Fotszyrzk Trebor           244151",
"         32. Sazalp Lanreb Rasec Otsugua           283329",
        ]
        geom = tested.pz_find_table_geometry(lines, grade_cols_count = 1)
        expect = [[9, 12], [13, 41], [51, 57], [57, 57], [57, 57]]
        self.assertEqual(geom, expect)
        split = tested.pz_split_table_columns(lines, geom)
        split_expect = [
            [ '1.',  'LAWARGA Mahbush',              '252345', '', '' ],
            [ '11.', 'ISEDIPOG Alab Iluram Anhsirn', '248092', '', '' ],
            [ '',    'Vaday',                        '',       '', '' ],
            [ '12.', 'Hagwsedfx Iilotana',           'K-3589', '', '' ],
            [ '23.', 'MANRXAQA REVSAGWZCDF Aynag',   '5227',   '', '' ],
            [ '',    'Dasarp',                       '',       '', '' ],
            [ '31.', 'Cziworteip Fotszyrzk Trebor',  '244151', '', '' ],
            [ '32.', 'Sazalp Lanreb Rasec Otsugua',  '283329', '', '' ]
        ]
        self.assertEqual(split, split_expect)

    def test__MEiL_4(self):
        self.maxDiff = None
        lines = [
#0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
#0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. LAWARGA Mahbush                       252345",
"         11. ISEDIPOG Alab Iluram Anhsirn          248092",
"             Vaday",
"         12. Hagwsedfx Iilotana                    K-3589",
"         23. MANRXAQA REVSAGWZCDF Aynag             5227",
"             Dasarp",
"         31. Cziworteip Fotszyrzk Trebor           244151",
"         32. Sazalp Lanreb Rasec Otsugua           283329",
        ]
        geom = tested.pz_find_table_geometry(lines, grade_cols_count = 2)
        expect = [[9, 12], [13, 41], [51, 57], [57, 57], [57, 57], [57, 57]]
        self.assertEqual(geom, expect)
        split = tested.pz_split_table_columns(lines, geom)
        split_expect = [
            [ '1.',  'LAWARGA Mahbush',              '252345', '', '', '' ],
            [ '11.', 'ISEDIPOG Alab Iluram Anhsirn', '248092', '', '', '' ],
            [ '',    'Vaday',                        '',       '', '', '' ],
            [ '12.', 'Hagwsedfx Iilotana',           'K-3589', '', '', '' ],
            [ '23.', 'MANRXAQA REVSAGWZCDF Aynag',   '5227',   '', '', '' ],
            [ '',    'Dasarp',                       '',       '', '', '' ],
            [ '31.', 'Cziworteip Fotszyrzk Trebor',  '244151', '', '', '' ],
            [ '32.', 'Sazalp Lanreb Rasec Otsugua',  '283329', '', '', '' ]
        ]
        self.assertEqual(split, split_expect)

class Test__parse_pz_table_rows(unittest.TestCase):
    def test__GiK_1(self):
        self.maxDiff = None
        lines = [
#000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
#012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. Keczetna Szamot Nafets              256701       3,5        5,0       4,0",
"          2. Myżob Anilorak                      254104       3,0        5,0       3,5",
"          3. Akslowogułd Atarzogałm              256127       4,5        3,5       4,5",
"          4. Tifołog Awe                          256110      3,0        4,5       3,5",
"          5. Aksńeimak Ailatan Atarzogłam         256421      3,5        4,5       4,0",
"         12. Kaiwodw Anilewe Aneladgam           222250       3,0        4,5       3,5",
"         13. Kurotkiw Annaoj Aniluap              259288      3,5        5,0       4,0"
        ]
        grades  = ['pz_subj_grade_lecture', 'pz_subj_grade_project', 'pz_subj_grade_final']
        expect = [
            {
              'pz_table_row_order'           : '1.',
              'pz_order_number'              : '1',
              'pz_table_row_student_name'    : 'Keczetna Szamot Nafets',
              'pz_student_name'              : 'Keczetna Szamot Nafets',
              'pz_last_name'                 : 'Keczetna',
              'pz_first_name'                : 'Szamot Nafets',
              'pz_table_row_student_id'      : '256701',
              'pz_student_id'                : '256701',
              'pz_subj_grade_lecture'        : '3,5',
              'pz_subj_grade_project'        : '5,0',
              'pz_subj_grade_final'          : '4,0',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '2.',
              'pz_order_number'              : '2',
              'pz_table_row_student_name'    : 'Myżob Anilorak',
              'pz_student_name'              : 'Myżob Anilorak',
              'pz_last_name'                 : 'Myżob',
              'pz_first_name'                : 'Anilorak',
              'pz_table_row_student_id'      : '254104',
              'pz_student_id'                : '254104',
              'pz_subj_grade_lecture'        : '3,0',
              'pz_subj_grade_project'        : '5,0',
              'pz_subj_grade_final'          : '3,5',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '3.',
              'pz_order_number'              : '3',
              'pz_table_row_student_name'    : 'Akslowogułd Atarzogałm',
              'pz_student_name'              : 'Akslowogułd Atarzogałm',
              'pz_last_name'                 : 'Akslowogułd',
              'pz_first_name'                : 'Atarzogałm',
              'pz_table_row_student_id'      : '256127',
              'pz_student_id'                : '256127',
              'pz_subj_grade_lecture'        : '4,5',
              'pz_subj_grade_project'        : '3,5',
              'pz_subj_grade_final'          : '4,5',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '4.',
              'pz_order_number'              : '4',
              'pz_table_row_student_name'    : 'Tifołog Awe',
              'pz_student_name'              : 'Tifołog Awe',
              'pz_last_name'                 : 'Tifołog',
              'pz_first_name'                : 'Awe',
              'pz_table_row_student_id'      : '256110',
              'pz_student_id'                : '256110',
              'pz_subj_grade_lecture'        : '3,0',
              'pz_subj_grade_project'        : '4,5',
              'pz_subj_grade_final'          : '3,5',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '5.',
              'pz_order_number'              : '5',
              'pz_table_row_student_name'    : 'Aksńeimak Ailatan Atarzogłam',
              'pz_student_name'              : 'Aksńeimak Ailatan Atarzogłam',
              'pz_last_name'                 : 'Aksńeimak',
              'pz_first_name'                : 'Ailatan Atarzogłam',
              'pz_table_row_student_id'      : '256421',
              'pz_student_id'                : '256421',
              'pz_subj_grade_lecture'        : '3,5',
              'pz_subj_grade_project'        : '4,5',
              'pz_subj_grade_final'          : '4,0',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '12.',
              'pz_order_number'              : '12',
              'pz_table_row_student_name'    : 'Kaiwodw Anilewe Aneladgam',
              'pz_student_name'              : 'Kaiwodw Anilewe Aneladgam',
              'pz_last_name'                 : 'Kaiwodw',
              'pz_first_name'                : 'Anilewe Aneladgam',
              'pz_table_row_student_id'      : '222250',
              'pz_student_id'                : '222250',
              'pz_subj_grade_lecture'        : '3,0',
              'pz_subj_grade_project'        : '4,5',
              'pz_subj_grade_final'          : '3,5',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '13.',
              'pz_order_number'              : '13',
              'pz_table_row_student_name'    : 'Kurotkiw Annaoj Aniluap',
              'pz_student_name'              : 'Kurotkiw Annaoj Aniluap',
              'pz_last_name'                 : 'Kurotkiw',
              'pz_first_name'                : 'Annaoj Aniluap',
              'pz_table_row_student_id'      : '259288',
              'pz_student_id'                : '259288',
              'pz_subj_grade_lecture'        : '3,5',
              'pz_subj_grade_project'        : '5,0',
              'pz_subj_grade_final'          : '4,0',
              'pz_table_row_remarks'         : None
            }
        ]
        status = tested.ParsingStatus()
        records = tested.parse_pz_table_rows(status, lines, grades)
        self.assertEqual(records, expect)
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertEqual(status.current_line, 7)

    def test__GiK_2(self):
        lines = [
#000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
#012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. Kasab Aglo                          264236       2,0        2,0",
"          2. Keb Szotrab                         264437       4,0        4,0",
"         24. Akszurg Aneladgam                   264876       3,0        3,0",
"         25. Lezg Atram                          264478       2,0        2,0",
"         26. Aksńawi Anilorak                    264281       2,0        2,0"
        ]
        grades  = ['pz_subj_grade_lecture', 'pz_subj_grade_final']
        expect = [
            {
              'pz_table_row_order'           : '1.',
              'pz_order_number'              : '1',
              'pz_table_row_student_name'    : 'Kasab Aglo',
              'pz_student_name'              : 'Kasab Aglo',
              'pz_last_name'                 : 'Kasab',
              'pz_first_name'                : 'Aglo',
              'pz_table_row_student_id'      : '264236',
              'pz_student_id'                : '264236',
              'pz_subj_grade_lecture'        : '2,0',
              'pz_subj_grade_final'          : '2,0',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '2.',
              'pz_order_number'              : '2',
              'pz_table_row_student_name'    : 'Keb Szotrab',
              'pz_student_name'              : 'Keb Szotrab',
              'pz_last_name'                 : 'Keb',
              'pz_first_name'                : 'Szotrab',
              'pz_table_row_student_id'      : '264437',
              'pz_student_id'                : '264437',
              'pz_subj_grade_lecture'        : '4,0',
              'pz_subj_grade_final'          : '4,0',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '24.',
              'pz_order_number'              : '24',
              'pz_table_row_student_name'    : 'Akszurg Aneladgam',
              'pz_student_name'              : 'Akszurg Aneladgam',
              'pz_last_name'                 : 'Akszurg',
              'pz_first_name'                : 'Aneladgam',
              'pz_table_row_student_id'      : '264876',
              'pz_student_id'                : '264876',
              'pz_subj_grade_lecture'        : '3,0',
              'pz_subj_grade_final'          : '3,0',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '25.',
              'pz_order_number'              : '25',
              'pz_table_row_student_name'    : 'Lezg Atram',
              'pz_student_name'              : 'Lezg Atram',
              'pz_last_name'                 : 'Lezg',
              'pz_first_name'                : 'Atram',
              'pz_table_row_student_id'      : '264478',
              'pz_student_id'                : '264478',
              'pz_subj_grade_lecture'        : '2,0',
              'pz_subj_grade_final'          : '2,0',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '26.',
              'pz_order_number'              : '26',
              'pz_table_row_student_name'    : 'Aksńawi Anilorak',
              'pz_student_name'              : 'Aksńawi Anilorak',
              'pz_last_name'                 : 'Aksńawi',
              'pz_first_name'                : 'Anilorak',
              'pz_table_row_student_id'      : '264281',
              'pz_student_id'                : '264281',
              'pz_subj_grade_lecture'        : '2,0',
              'pz_subj_grade_final'          : '2,0',
              'pz_table_row_remarks'         : None
            },
        ]
        status = tested.ParsingStatus()
        records = tested.parse_pz_table_rows(status, lines, grades)
        self.assertEqual(records, expect)
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertEqual(status.current_line, 5)

    def test__MEiL_1(self):
        self.maxDiff = None
        lines = [
#000000000011111111112222222222333333333344444444445555555555666666666677777777778888888888
#012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. Kishuka Bharadwaj                    281566   2.0",
"          2. Sulegna Ikswonazyrzk Nathalie       287489    3.0",
"         15. Nav-Ekebneroh Echevarria Franz      284331    5.0",
"             Alexander",
"         16. Velisav Aili                        252325    4.0",
"         17. S V RDATKDTRSCGRDFA                 275238    3.0",
"             Shaguwnxfdj",
"         18. Namaz Raamma                        285132    3.0"
        ]
        grades  = ['pz_subj_grade_p', 'pz_subj_grade_n']
        expect = [
            {
              'pz_table_row_order'           : '1.',
              'pz_order_number'              : '1',
              'pz_table_row_student_name'    : 'Kishuka Bharadwaj',
              'pz_student_name'              : 'Kishuka Bharadwaj',
              'pz_last_name'                 : 'Kishuka',
              'pz_first_name'                : 'Bharadwaj',
              'pz_table_row_student_id'      : '281566',
              'pz_student_id'                : '281566',
              'pz_subj_grade_p'              : '2.0',
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '2.',
              'pz_order_number'              : '2',
              'pz_table_row_student_name'    : 'Sulegna Ikswonazyrzk Nathalie',
              'pz_student_name'              : 'Sulegna Ikswonazyrzk Nathalie',
              'pz_last_name'                 : 'Sulegna',
              'pz_first_name'                : 'Ikswonazyrzk Nathalie',
              'pz_table_row_student_id'      : '287489',
              'pz_student_id'                : '287489',
              'pz_subj_grade_p'              : '3.0',
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '15.',
              'pz_order_number'              : '15',
              'pz_table_row_student_name'    : 'Nav-Ekebneroh Echevarria Franz Alexander',
              'pz_student_name'              : 'Nav-Ekebneroh Echevarria Franz Alexander',
              'pz_last_name'                 : 'Nav-Ekebneroh',
              'pz_first_name'                : 'Echevarria Franz Alexander',
              'pz_table_row_student_id'      : '284331',
              'pz_student_id'                : '284331',
              'pz_subj_grade_p'              : '5.0',
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '16.',
              'pz_order_number'              : '16',
              'pz_table_row_student_name'    : 'Velisav Aili',
              'pz_student_name'              : 'Velisav Aili',
              'pz_last_name'                 : 'Velisav',
              'pz_first_name'                : 'Aili',
              'pz_table_row_student_id'      : '252325',
              'pz_student_id'                : '252325',
              'pz_subj_grade_p'              : '4.0',
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '17.',
              'pz_order_number'              : '17',
              'pz_table_row_student_name'    : 'S V RDATKDTRSCGRDFA Shaguwnxfdj',
              'pz_student_name'              : 'S V RDATKDTRSCGRDFA Shaguwnxfdj',
              'pz_last_name'                 : 'S',
              'pz_first_name'                : 'V RDATKDTRSCGRDFA Shaguwnxfdj',
              'pz_table_row_student_id'      : '275238',
              'pz_student_id'                : '275238',
              'pz_subj_grade_p'              : '3.0',
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '18.',
              'pz_order_number'              : '18',
              'pz_table_row_student_name'    : 'Namaz Raamma',
              'pz_student_name'              : 'Namaz Raamma',
              'pz_last_name'                 : 'Namaz',
              'pz_first_name'                : 'Raamma',
              'pz_table_row_student_id'      : '285132',
              'pz_student_id'                : '285132',
              'pz_subj_grade_p'              : '3.0',
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
        ]
        status = tested.ParsingStatus()
        records = tested.parse_pz_table_rows(status, lines, grades)
        self.assertEqual(records, expect)
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertEqual(status.current_line, 8)

    def test__MEiL_2(self):
        self.maxDiff = None
        lines = [
#0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
#0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. Kishuka Bharadwaj                    281566   2.0",
"          2. Sulegna Ikswonazyrzk Nathalie       287489    3.0",
"         15. Nav-Ekebneroh Echevarria Franz      284331    5.0          I do have some remarks",
"             Alexander",
"         16. Velisav Aili                        252325          4.0",
"         17. S V RDATKDTRSCGRDFA                 275238    3.0",
"             Shaguwnxfdj                                               Other remarks",
"         18. Namaz Raamma                        285132    3.0   3.5"
        ]
        grades  = ['pz_subj_grade_p', 'pz_subj_grade_n']
        expect = [
            {
              'pz_table_row_order'           : '1.',
              'pz_order_number'              : '1',
              'pz_table_row_student_name'    : 'Kishuka Bharadwaj',
              'pz_student_name'              : 'Kishuka Bharadwaj',
              'pz_last_name'                 : 'Kishuka',
              'pz_first_name'                : 'Bharadwaj',
              'pz_table_row_student_id'      : '281566',
              'pz_student_id'                : '281566',
              'pz_subj_grade_p'              : '2.0',
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '2.',
              'pz_order_number'              : '2',
              'pz_table_row_student_name'    : 'Sulegna Ikswonazyrzk Nathalie',
              'pz_student_name'              : 'Sulegna Ikswonazyrzk Nathalie',
              'pz_last_name'                 : 'Sulegna',
              'pz_first_name'                : 'Ikswonazyrzk Nathalie',
              'pz_table_row_student_id'      : '287489',
              'pz_student_id'                : '287489',
              'pz_subj_grade_p'              : '3.0',
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '15.',
              'pz_order_number'              : '15',
              'pz_table_row_student_name'    : 'Nav-Ekebneroh Echevarria Franz Alexander',
              'pz_student_name'              : 'Nav-Ekebneroh Echevarria Franz Alexander',
              'pz_last_name'                 : 'Nav-Ekebneroh',
              'pz_first_name'                : 'Echevarria Franz Alexander',
              'pz_table_row_student_id'      : '284331',
              'pz_student_id'                : '284331',
              'pz_subj_grade_p'              : '5.0',
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : 'I do have some remarks'
            },
            {
              'pz_table_row_order'           : '16.',
              'pz_order_number'              : '16',
              'pz_table_row_student_name'    : 'Velisav Aili',
              'pz_student_name'              : 'Velisav Aili',
              'pz_last_name'                 : 'Velisav',
              'pz_first_name'                : 'Aili',
              'pz_table_row_student_id'      : '252325',
              'pz_student_id'                : '252325',
              'pz_subj_grade_p'              : None,
              'pz_subj_grade_n'              : '4.0',
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '17.',
              'pz_order_number'              : '17',
              'pz_table_row_student_name'    : 'S V RDATKDTRSCGRDFA Shaguwnxfdj',
              'pz_student_name'              : 'S V RDATKDTRSCGRDFA Shaguwnxfdj',
              'pz_last_name'                 : 'S',
              'pz_first_name'                : 'V RDATKDTRSCGRDFA Shaguwnxfdj',
              'pz_table_row_student_id'      : '275238',
              'pz_student_id'                : '275238',
              'pz_subj_grade_p'              : '3.0',
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : 'Other remarks'
            },
            {
              'pz_table_row_order'           : '18.',
              'pz_order_number'              : '18',
              'pz_table_row_student_name'    : 'Namaz Raamma',
              'pz_student_name'              : 'Namaz Raamma',
              'pz_last_name'                 : 'Namaz',
              'pz_first_name'                : 'Raamma',
              'pz_table_row_student_id'      : '285132',
              'pz_student_id'                : '285132',
              'pz_subj_grade_p'              : '3.0',
              'pz_subj_grade_n'              : '3.5',
              'pz_table_row_remarks'         : None
            },
        ]
        status = tested.ParsingStatus()
        records = tested.parse_pz_table_rows(status, lines, grades)
        self.assertEqual(records, expect)
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertEqual(status.current_line, 8)

    def test__MEiL_3(self):
        self.maxDiff = None
        lines = [
#0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
#0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. LAWARGA Mahbush                       252345",
"         11. ISEDIPOG Alab Iluram Anhsirn          248092",
"             Vaday",
"         12. Hagwsedfx Iilotana                    K-3589",
"         23. MANRXAQA REVSAGWZCDF Aynag             5227",
"             Dasarp",
"         31. Cziworteip Fotszyrzk Trebor           244151",
"         32. Sazalp Lanreb Rasec Otsugua           283329",
        ]
        grades  = ['pz_subj_grade']
        expect = [
            {
              'pz_table_row_order'           : '1.',
              'pz_order_number'              : '1',
              'pz_table_row_student_name'    : 'LAWARGA Mahbush',
              'pz_student_name'              : 'LAWARGA Mahbush',
              'pz_last_name'                 : 'LAWARGA',
              'pz_first_name'                : 'Mahbush',
              'pz_table_row_student_id'      : '252345',
              'pz_student_id'                : '252345',
              'pz_subj_grade'                : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '11.',
              'pz_order_number'              : '11',
              'pz_table_row_student_name'    : 'ISEDIPOG Alab Iluram Anhsirn Vaday',
              'pz_student_name'              : 'ISEDIPOG Alab Iluram Anhsirn Vaday',
              'pz_last_name'                 : 'ISEDIPOG',
              'pz_first_name'                : 'Alab Iluram Anhsirn Vaday',
              'pz_table_row_student_id'      : '248092',
              'pz_student_id'                : '248092',
              'pz_subj_grade'                : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '12.',
              'pz_order_number'              : '12',
              'pz_table_row_student_name'    : 'Hagwsedfx Iilotana',
              'pz_student_name'              : 'Hagwsedfx Iilotana',
              'pz_last_name'                 : 'Hagwsedfx',
              'pz_first_name'                : 'Iilotana',
              'pz_table_row_student_id'      : 'K-3589',
              'pz_student_id'                : 'K-3589',
              'pz_subj_grade'                : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '23.',
              'pz_order_number'              : '23',
              'pz_table_row_student_name'    : 'MANRXAQA REVSAGWZCDF Aynag Dasarp',
              'pz_student_name'              : 'MANRXAQA REVSAGWZCDF Aynag Dasarp',
              'pz_last_name'                 : 'MANRXAQA',
              'pz_first_name'                : 'REVSAGWZCDF Aynag Dasarp',
              'pz_table_row_student_id'      : '5227',
              'pz_student_id'                : '5227',
              'pz_subj_grade'                : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '31.',
              'pz_order_number'              : '31',
              'pz_table_row_student_name'    : 'Cziworteip Fotszyrzk Trebor',
              'pz_student_name'              : 'Cziworteip Fotszyrzk Trebor',
              'pz_last_name'                 : 'Cziworteip',
              'pz_first_name'                : 'Fotszyrzk Trebor',
              'pz_table_row_student_id'      : '244151',
              'pz_student_id'                : '244151',
              'pz_subj_grade'                : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '32.',
              'pz_order_number'              : '32',
              'pz_table_row_student_name'    : 'Sazalp Lanreb Rasec Otsugua',
              'pz_student_name'              : 'Sazalp Lanreb Rasec Otsugua',
              'pz_last_name'                 : 'Sazalp',
              'pz_first_name'                : 'Lanreb Rasec Otsugua',
              'pz_table_row_student_id'      : '283329',
              'pz_student_id'                : '283329',
              'pz_subj_grade'                : None,
              'pz_table_row_remarks'         : None
            },
        ]
        status = tested.ParsingStatus()
        records = tested.parse_pz_table_rows(status, lines, grades)
        self.assertEqual(records, expect)
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertEqual(status.current_line, 8)

    def test__MEiL_4(self):
        self.maxDiff = None
        lines = [
#0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999
#0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
"          1. LAWARGA Mahbush                       252345",
"         11. ISEDIPOG Alab Iluram Anhsirn          248092",
"             Vaday",
"         12. Hagwsedfx Iilotana                    K-3589",
"         23. MANRXAQA REVSAGWZCDF Aynag             5227",
"             Dasarp",
"         31. Cziworteip Fotszyrzk Trebor           244151",
"         32. Sazalp Lanreb Rasec Otsugua           283329",
        ]
        grades  = ['pz_subj_grade_p', 'pz_subj_grade_n']
        expect = [
            {
              'pz_table_row_order'           : '1.',
              'pz_order_number'              : '1',
              'pz_table_row_student_name'    : 'LAWARGA Mahbush',
              'pz_student_name'              : 'LAWARGA Mahbush',
              'pz_last_name'                 : 'LAWARGA',
              'pz_first_name'                : 'Mahbush',
              'pz_table_row_student_id'      : '252345',
              'pz_student_id'                : '252345',
              'pz_subj_grade_p'              : None,
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '11.',
              'pz_order_number'              : '11',
              'pz_table_row_student_name'    : 'ISEDIPOG Alab Iluram Anhsirn Vaday',
              'pz_student_name'              : 'ISEDIPOG Alab Iluram Anhsirn Vaday',
              'pz_last_name'                 : 'ISEDIPOG',
              'pz_first_name'                : 'Alab Iluram Anhsirn Vaday',
              'pz_table_row_student_id'      : '248092',
              'pz_student_id'                : '248092',
              'pz_subj_grade_p'              : None,
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '12.',
              'pz_order_number'              : '12',
              'pz_table_row_student_name'    : 'Hagwsedfx Iilotana',
              'pz_student_name'              : 'Hagwsedfx Iilotana',
              'pz_last_name'                 : 'Hagwsedfx',
              'pz_first_name'                : 'Iilotana',
              'pz_table_row_student_id'      : 'K-3589',
              'pz_student_id'                : 'K-3589',
              'pz_subj_grade_p'              : None,
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '23.',
              'pz_order_number'              : '23',
              'pz_table_row_student_name'    : 'MANRXAQA REVSAGWZCDF Aynag Dasarp',
              'pz_student_name'              : 'MANRXAQA REVSAGWZCDF Aynag Dasarp',
              'pz_last_name'                 : 'MANRXAQA',
              'pz_first_name'                : 'REVSAGWZCDF Aynag Dasarp',
              'pz_table_row_student_id'      : '5227',
              'pz_student_id'                : '5227',
              'pz_subj_grade_p'              : None,
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '31.',
              'pz_order_number'              : '31',
              'pz_table_row_student_name'    : 'Cziworteip Fotszyrzk Trebor',
              'pz_student_name'              : 'Cziworteip Fotszyrzk Trebor',
              'pz_last_name'                 : 'Cziworteip',
              'pz_first_name'                : 'Fotszyrzk Trebor',
              'pz_table_row_student_id'      : '244151',
              'pz_student_id'                : '244151',
              'pz_subj_grade_p'              : None,
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
            {
              'pz_table_row_order'           : '32.',
              'pz_order_number'              : '32',
              'pz_table_row_student_name'    : 'Sazalp Lanreb Rasec Otsugua',
              'pz_student_name'              : 'Sazalp Lanreb Rasec Otsugua',
              'pz_last_name'                 : 'Sazalp',
              'pz_first_name'                : 'Lanreb Rasec Otsugua',
              'pz_table_row_student_id'      : '283329',
              'pz_student_id'                : '283329',
              'pz_subj_grade_p'              : None,
              'pz_subj_grade_n'              : None,
              'pz_table_row_remarks'         : None
            },
        ]
        status = tested.ParsingStatus()
        records = tested.parse_pz_table_rows(status, lines, grades)
        self.assertEqual(records, expect)
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertEqual(status.current_line, 8)

class Test__parse_pz_table(unittest.TestCase):
    def test__GiK_1(self):
        header = \
        self.maxDiff = None
        lines = [
"                                                                       Ocena",
"        Lp.               Student               Nr albumu                                         Uwagi",
"                                                           z wykładu  z projektu końcowa",
"          1. Keczetna Szamot Nafets              256701       3,5        5,0       4,0",
"          2. Myżob Anilorak                      254104       3,0        5,0       3,5",
"          3. Akslowogułd Atarzogałm              256127       4,5        3,5       4,5",
"          4. Tifołog Awe                          256110      3,0        4,5       3,5",
"          5. Aksńeimak Ailatan Atarzogłam         256421      3,5        4,5       4,0",
"         12. Kaiwodw Anilewe Aneladgam           222250       3,0        4,5       3,5",
"         13. Kurotkiw Annaoj Aniluap              259288      3,5        5,0       4,0"
        ]
        grades  = ['pz_subj_grade_lecture', 'pz_subj_grade_project', 'pz_subj_grade_final']
        expect = {
            'pz_table_header'  : {
                'pz_table_header_0'  : 'Ocena',
                'pz_table_header_2'  : 'Lp.               Student               Nr albumu                                         Uwagi',
                'pz_table_header_3'  : 'z wykładu  z projektu końcowa',
                'pz_table_header_subj_grade_fields' : ['pz_subj_grade_lecture', 'pz_subj_grade_project', 'pz_subj_grade_final']
            },
            'pz_table_content' : [
                {
                  'pz_table_row_order'           : '1.',
                  'pz_order_number'              : '1',
                  'pz_table_row_student_name'    : 'Keczetna Szamot Nafets',
                  'pz_student_name'              : 'Keczetna Szamot Nafets',
                  'pz_last_name'                 : 'Keczetna',
                  'pz_first_name'                : 'Szamot Nafets',
                  'pz_table_row_student_id'      : '256701',
                  'pz_student_id'                : '256701',
                  'pz_subj_grade_lecture'        : '3,5',
                  'pz_subj_grade_project'        : '5,0',
                  'pz_subj_grade_final'          : '4,0',
                  'pz_table_row_remarks'         : None
                },
                {
                  'pz_table_row_order'           : '2.',
                  'pz_order_number'              : '2',
                  'pz_table_row_student_name'    : 'Myżob Anilorak',
                  'pz_student_name'              : 'Myżob Anilorak',
                  'pz_last_name'                 : 'Myżob',
                  'pz_first_name'                : 'Anilorak',
                  'pz_table_row_student_id'      : '254104',
                  'pz_student_id'                : '254104',
                  'pz_subj_grade_lecture'        : '3,0',
                  'pz_subj_grade_project'        : '5,0',
                  'pz_subj_grade_final'          : '3,5',
                  'pz_table_row_remarks'         : None
                },
                {
                  'pz_table_row_order'           : '3.',
                  'pz_order_number'              : '3',
                  'pz_table_row_student_name'    : 'Akslowogułd Atarzogałm',
                  'pz_student_name'              : 'Akslowogułd Atarzogałm',
                  'pz_last_name'                 : 'Akslowogułd',
                  'pz_first_name'                : 'Atarzogałm',
                  'pz_table_row_student_id'      : '256127',
                  'pz_student_id'                : '256127',
                  'pz_subj_grade_lecture'        : '4,5',
                  'pz_subj_grade_project'        : '3,5',
                  'pz_subj_grade_final'          : '4,5',
                  'pz_table_row_remarks'         : None
                },
                {
                  'pz_table_row_order'           : '4.',
                  'pz_order_number'              : '4',
                  'pz_table_row_student_name'    : 'Tifołog Awe',
                  'pz_student_name'              : 'Tifołog Awe',
                  'pz_last_name'                 : 'Tifołog',
                  'pz_first_name'                : 'Awe',
                  'pz_table_row_student_id'      : '256110',
                  'pz_student_id'                : '256110',
                  'pz_subj_grade_lecture'        : '3,0',
                  'pz_subj_grade_project'        : '4,5',
                  'pz_subj_grade_final'          : '3,5',
                  'pz_table_row_remarks'         : None
                },
                {
                  'pz_table_row_order'           : '5.',
                  'pz_order_number'              : '5',
                  'pz_table_row_student_name'    : 'Aksńeimak Ailatan Atarzogłam',
                  'pz_student_name'              : 'Aksńeimak Ailatan Atarzogłam',
                  'pz_last_name'                 : 'Aksńeimak',
                  'pz_first_name'                : 'Ailatan Atarzogłam',
                  'pz_table_row_student_id'      : '256421',
                  'pz_student_id'                : '256421',
                  'pz_subj_grade_lecture'        : '3,5',
                  'pz_subj_grade_project'        : '4,5',
                  'pz_subj_grade_final'          : '4,0',
                  'pz_table_row_remarks'         : None
                },
                {
                  'pz_table_row_order'           : '12.',
                  'pz_order_number'              : '12',
                  'pz_table_row_student_name'    : 'Kaiwodw Anilewe Aneladgam',
                  'pz_student_name'              : 'Kaiwodw Anilewe Aneladgam',
                  'pz_last_name'                 : 'Kaiwodw',
                  'pz_first_name'                : 'Anilewe Aneladgam',
                  'pz_table_row_student_id'      : '222250',
                  'pz_student_id'                : '222250',
                  'pz_subj_grade_lecture'        : '3,0',
                  'pz_subj_grade_project'        : '4,5',
                  'pz_subj_grade_final'          : '3,5',
                  'pz_table_row_remarks'         : None
                },
                {
                  'pz_table_row_order'           : '13.',
                  'pz_order_number'              : '13',
                  'pz_table_row_student_name'    : 'Kurotkiw Annaoj Aniluap',
                  'pz_student_name'              : 'Kurotkiw Annaoj Aniluap',
                  'pz_last_name'                 : 'Kurotkiw',
                  'pz_first_name'                : 'Annaoj Aniluap',
                  'pz_table_row_student_id'      : '259288',
                  'pz_student_id'                : '259288',
                  'pz_subj_grade_lecture'        : '3,5',
                  'pz_subj_grade_project'        : '5,0',
                  'pz_subj_grade_final'          : '4,0',
                  'pz_table_row_remarks'         : None
                }
            ]
        }
        status = tested.ParsingStatus()
        result = tested.parse_pz_table(status, lines)
        self.assertEqual(result, expect)
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertEqual(status.current_line, 10)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
