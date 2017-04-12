#!/usr/bin/env python 3
# -*- coding: utf8 -*-


import unittest
import re
import veetou.parsing as tested


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

    def test_contact_address_street_info__1(self):
        r = tested._dict_re[r'contact_address_street_info']
        self.assertRegexMatch('ul. Nowowiejska 24', r)
        m = re.match(r,'ul. Nowowiejska 24')
        self.assertEqual(m.group('contact_address_street_prefix'), 'ul.')
        self.assertEqual(m.group('contact_address_street_name'), 'Nowowiejska')
        self.assertEqual(m.group('contact_address_street_number'), '24')


    def test_contact_address_street_info__2(self):
        r = tested._dict_re[r'contact_address_street_info']
        self.assertRegexMatch('pl. Narutowicza 11/2', r)
        m = re.match(r,'pl. Narutowicza 11/2')
        self.assertEqual(m.group('contact_address_street_prefix'), 'pl.')
        self.assertEqual(m.group('contact_address_street_name'), 'Narutowicza')
        self.assertEqual(m.group('contact_address_street_number'), '11/2')

    def test_contact_address_street_info__3(self):
        r = tested._dict_re[r'contact_address_street_info']
        self.assertRegexMatch('Sienkiewicza 11A', r)
        m = re.match(r,'Sienkiewicza 11A')
        self.assertIs(m.group('contact_address_street_prefix'), None)
        self.assertEqual(m.group('contact_address_street_name'), 'Sienkiewicza')
        self.assertEqual(m.group('contact_address_street_number'), '11A')

    def test_contact_address_street_info__4(self):
        r = tested._dict_re[r'contact_address_street_info']
        self.assertRegexMatch('Pana Michała Wołodyjowskiego 123-125', r)
        m = re.match(r,'Pana Michała Wołodyjowskiego 123-125')
        self.assertIs(m.group('contact_address_street_prefix'), None)
        self.assertEqual(m.group('contact_address_street_name'), 'Pana Michała Wołodyjowskiego')
        self.assertEqual(m.group('contact_address_street_number'), '123-125')

    def test_contact_address_street_info__5(self):
        r = tested._dict_re[r'contact_address_street_info']
        self.assertRegexMatch('ul.Świętego Maksymiliana   Kolbe 23 - 30', r)
        m = re.match(r,'ul.Świętego Maksymiliana   Kolbe 23 - 30')
        self.assertEqual(m.group('contact_address_street_prefix'), 'ul.')
        self.assertEqual(m.group('contact_address_street_name'), 'Świętego Maksymiliana   Kolbe')
        self.assertEqual(m.group('contact_address_street_number'), '23 - 30')

    def test_contact_address_postoffice_info__1(self):
        r = tested._dict_re[r'contact_address_postoffice_info']
        self.assertRegexMatch('00-665 Warszawa', r)
        m = re.match(r,'00-665 Warszawa')
        self.assertEqual(m.group('contact_address_postoffice_zip'), '00-665')
        self.assertEqual(m.group('contact_address_postoffice_town'), 'Warszawa')

    def test_contact_address_postoffice_info__2(self):
        r = tested._dict_re[r'contact_address_postoffice_info']
        self.assertRegexMatch('21-500 Biała Podlaska', r)
        m = re.match(r,'21-500 Biała Podlaska')
        self.assertEqual(m.group('contact_address_postoffice_zip'), '21-500')
        self.assertEqual(m.group('contact_address_postoffice_town'), 'Biała Podlaska')

    def test_contact_address_postoffice_info__3(self):
        r = tested._dict_re[r'contact_address_postoffice_info']
        self.assertRegexMatch('43-300 Bielsko-Biała', r)
        m = re.match(r,'43-300 Bielsko-Biała')
        self.assertEqual(m.group('contact_address_postoffice_zip'), '43-300')
        self.assertEqual(m.group('contact_address_postoffice_town'), 'Bielsko-Biała')

    def test_contact_address_edifice_info__1(self):
        r = tested._dict_re[r'contact_address_edifice_info']
        self.assertRegexMatch('Gmach Lotniczy', r)
        m = re.match(r,'Gmach Lotniczy')
        self.assertEqual(m.group('contact_address_edifice'), 'Gmach Lotniczy')

    def test_contact_address_edifice_info__2(self):
        r = tested._dict_re[r'contact_address_edifice_info']
        self.assertRegexMatch('Budynek Żółtogęsią-Jaźniowy 12', r)
        m = re.match(r,'Budynek Żółtogęsią-Jaźniowy 12')
        self.assertEqual(m.group('contact_address_edifice'), 'Budynek Żółtogęsią-Jaźniowy 12')

    def test_contact_address_room_info__1(self):
        r = tested._dict_re[r'contact_address_room_info']
        self.assertRegexMatch('124', r)
        m = re.match(r,'124')
        self.assertEqual(m.group('contact_address_room'), '124')

    def test_contact_address_room_info__2(self):
        r = tested._dict_re[r'contact_address_room_info']
        self.assertRegexMatch('p. 124', r)
        m = re.match(r,'p. 124')
        self.assertEqual(m.group('contact_address_room'), 'p. 124')

    def test_contact_address_room_info__3(self):
        r = tested._dict_re[r'contact_address_room_info']
        self.assertRegexMatch('pok. 124', r)
        m = re.match(r,'pok. 124')
        self.assertEqual(m.group('contact_address_room'), 'pok. 124')

    def test_contact_address_website_info__1(self):
        r = tested._dict_re[r'contact_address_website_info']
        self.assertRegexMatch('www.pl', r)
        m = re.match(r,'www.pl')
        self.assertEqual(m.group('contact_address_website'), 'www.pl')

    def test_contact_address_website_info__2(self):
        r = tested._dict_re[r'contact_address_website_info']
        self.assertRegexMatch('meil.pw.edu.pl', r)
        m = re.match(r,'meil.pw.edu.pl')
        self.assertEqual(m.group('contact_address_website'), 'meil.pw.edu.pl')

    def test_contact_address_website_info__3(self):
        r = tested._dict_re[r'contact_address_website_info']
        self.assertRegexMatch('http://pw.edu.pl', r)
        m = re.match(r,'http://pw.edu.pl')
        self.assertEqual(m.group('contact_address_website'), 'http://pw.edu.pl')

    def test_contact_address__1(self):
        r = tested._dict_re[r'contact_address']
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
        r = tested._dict_re[r'contact_address']
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
        r = tested._dict_re[r'contact_phone']
        self.assertRegexMatch('tel. (+48) 22 234 72 23', r)
        m = re.match(r, 'tel. (+48) 22 234 72 23')
        self.assertEqual(m.group('contact_phone'), 'tel. (+48) 22 234 72 23')
        self.assertEqual(m.group('contact_phone_prefix'), 'tel.')
        self.assertEqual(m.group('contact_phone_numbers'), '(+48) 22 234 72 23')

    def test_contact_phone__2(self):
        r = tested._dict_re[r'contact_phone']
        self.assertRegexMatch('tel.: (022) 621 53 10, (022) 234 73 54', r)
        m = re.match(r, 'tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('contact_phone'), 'tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('contact_phone_prefix'), 'tel.:')
        self.assertEqual(m.group('contact_phone_numbers'), '(022) 621 53 10, (022) 234 73 54')

    def test_contact_faxtel__1(self):
        r = tested._dict_re[r'contact_faxtel']
        self.assertRegexMatch('fax. (+48) 22 234 72 23', r)
        m = re.match(r, 'fax. (+48) 22 234 72 23')
        self.assertEqual(m.group('contact_faxtel'), 'fax. (+48) 22 234 72 23')
        self.assertEqual(m.group('contact_faxtel_prefix'), 'fax.')
        self.assertEqual(m.group('contact_faxtel_numbers'), '(+48) 22 234 72 23')

    def test_contact_faxtel__2(self):
        r = tested._dict_re[r'contact_faxtel']
        self.assertRegexMatch('fax/tel.: (022) 625 73 51', r)
        m = re.match(r, 'fax/tel.: (022) 621 73 51')
        self.assertEqual(m.group('contact_faxtel'), 'fax/tel.: (022) 621 73 51')
        self.assertEqual(m.group('contact_faxtel_prefix'), 'fax/tel.:')
        self.assertEqual(m.group('contact_faxtel_numbers'), '(022) 621 73 51')

    def test_contact_faxtel__3(self):
        r = tested._dict_re[r'contact_faxtel']
        self.assertRegexMatch('fax/tel.: (022) 621 53 10, (022) 234 73 54', r)
        m = re.match(r, 'fax/tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('contact_faxtel'), 'fax/tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('contact_faxtel_prefix'), 'fax/tel.:')
        self.assertEqual(m.group('contact_faxtel_numbers'), '(022) 621 53 10, (022) 234 73 54')

    def test_contact_email__1(self):
        r = tested._dict_re[r'contact_email']
        self.assertRegexMatch('e-mail: p-1.tomulik@meil.pw.edu.pl', r)
        m = re.match(r, 'e-mail: p-1.tomulik@meil.pw.edu.pl')
        self.assertEqual(m.group('contact_email'), 'e-mail: p-1.tomulik@meil.pw.edu.pl')
        self.assertEqual(m.group('contact_email_prefix'), 'e-mail:')
        self.assertEqual(m.group('contact_email_address'), 'p-1.tomulik@meil.pw.edu.pl')
        self.assertEqual(m.group('contact_email_address_localpart'), 'p-1.tomulik')
        self.assertEqual(m.group('contact_email_address_domain'), 'meil.pw.edu.pl')

    def test_electronic_contact__1(self):
        r = tested._dict_re[r'electronic_contact']
        s = 'tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail: dziekanat@meil.pw.edu.pl'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('electronic_contact'), s)
        self.assertEqual(m.group('contact_phone'), 'tel.: (022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('contact_phone_prefix'), 'tel.:')
        self.assertEqual(m.group('contact_phone_numbers'), '(022) 621 53 10, (022) 234 73 54')
        self.assertEqual(m.group('contact_faxtel'), 'fax/tel.: (022) 625 73 51')
        self.assertEqual(m.group('contact_faxtel_prefix'), 'fax/tel.:')
        self.assertEqual(m.group('contact_faxtel_numbers'), '(022) 625 73 51')
        self.assertEqual(m.group('contact_email'), 'e-mail: dziekanat@meil.pw.edu.pl')
        self.assertEqual(m.group('contact_email_prefix'), 'e-mail:')
        self.assertEqual(m.group('contact_email_address'), 'dziekanat@meil.pw.edu.pl')
        self.assertEqual(m.group('contact_email_address_localpart'), 'dziekanat')
        self.assertEqual(m.group('contact_email_address_domain'), 'meil.pw.edu.pl')

    def test_electronic_contact__2(self):
        r = tested._dict_re[r'electronic_contact']
        s = 'tel.: (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('electronic_contact'), s)
        self.assertEqual(m.group('contact_phone'), 'tel.: (+48) 22 234 72 23')
        self.assertEqual(m.group('contact_phone_prefix'), 'tel.:')
        self.assertEqual(m.group('contact_phone_numbers'), '(+48) 22 234 72 23')
        self.assertIs(m.group('contact_faxtel'), None)
        self.assertIs(m.group('contact_faxtel_prefix'), None)
        self.assertIs(m.group('contact_faxtel_numbers'), None)
        self.assertEqual(m.group('contact_email'), 'e-mail: dziekan@gik.pw.edu.pl')
        self.assertEqual(m.group('contact_email_prefix'), 'e-mail:')
        self.assertEqual(m.group('contact_email_address'), 'dziekan@gik.pw.edu.pl')
        self.assertEqual(m.group('contact_email_address_localpart'), 'dziekan')
        self.assertEqual(m.group('contact_email_address_domain'), 'gik.pw.edu.pl')

    def test_stamp_town_and_datetime__1(self):
        r = tested._dict_re[r'stamp_town_and_datetime']
        s = 'Warszawa, 08.02.2014, 13:09:53'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('stamp_town_and_datetime'), s)
        self.assertEqual(m.group('stamp_town'), 'Warszawa')
        self.assertEqual(m.group('stamp_date'), '08.02.2014')
        self.assertEqual(m.group('stamp_time'), '13:09:53')

    def test_proza_label__1(self):
        r = tested._dict_re[r'proza_label']
        s = 'Protokół zaliczeń (egzamin) 2015 Z/B-1/197'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_label'), s)
        self.assertEqual(m.group('proza_label_title'), 'Protokół zaliczeń')
        self.assertEqual(m.group('proza_label_exam'), 'egzamin')
        self.assertEqual(m.group('proza_label_semester'), '2015 Z')
        self.assertEqual(m.group('proza_label_serie'), 'B-1')
        self.assertEqual(m.group('proza_label_number'), '197')

    def test_proza_label__2(self):
        r = tested._dict_re[r'proza_label']
        s = 'Protokół zaliczeń (bez egzaminu) 2013Z/E-1/252'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_label'), s)
        self.assertEqual(m.group('proza_label_title'), 'Protokół zaliczeń')
        self.assertEqual(m.group('proza_label_exam'), 'bez egzaminu')
        self.assertEqual(m.group('proza_label_semester'), '2013Z')
        self.assertEqual(m.group('proza_label_serie'), 'E-1')
        self.assertEqual(m.group('proza_label_number'), '252')

    def test_proza_return__1(self):
        r = tested._dict_re[r'proza_return']
        s = 'Termin zwrotu 02.02.2016'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_return'), s)
        self.assertEqual(m.group('proza_return_desc'), 'Termin zwrotu')
        self.assertEqual(m.group('proza_return_date'), '02.02.2016')

    def test_proza_preamble_subj_name__1(self):
        r = tested._dict_re[r'proza_preamble_subj_name']
        s = 'Nazwa przedmiotu: Advanced Aero Engines Laboratory'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_subj_name'), s)
        self.assertEqual(m.group('proza_subj_name'), 'Advanced Aero Engines Laboratory')

    def test_proza_preamble_subj_code__1(self):
        r = tested._dict_re[r'proza_preamble_subj_code']
        s = 'Nr katalogowy: ML.ANS600'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_subj_code'), s)
        self.assertEqual(m.group('proza_subj_code'), 'ML.ANS600')

    def test_proza_preamble_subj_code__2(self):
        r = tested._dict_re[r'proza_preamble_subj_code']
        s = 'Nr katalogowy: GK.NIK113'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_subj_code'), s)
        self.assertEqual(m.group('proza_subj_code'), 'GK.NIK113')

    def test_proza_preamble_subj_code__3(self):
        r = tested._dict_re[r'proza_preamble_subj_code']
        s = 'Nr katalogowy: GP.SMS238'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_subj_code'), s)
        self.assertEqual(m.group('proza_subj_code'), 'GP.SMS238')

    def test_proza_preamble_department__1(self):
        r = tested._dict_re[r'proza_preamble_department']
        s = 'Zakład Silników Lotniczych'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_department'), s)

    def test_proza_preamble_department__2(self):
        r = tested._dict_re[r'proza_preamble_department']
        s = 'Katedra Gospodarki Przestrzennej i Nauk o Środowisku Przyrodnicznym'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_department'), s)

    def test_proza_preamble_department__2(self):
        r = tested._dict_re[r'proza_preamble_department']
        s = 'Wydział Mechaniczny Energetyki i Lotnictwa'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_department'), s)


    def test_proza_preamble_subj_tutor__1(self):
        r = tested._dict_re[r'proza_preamble_subj_tutor']
        s = 'Kierownik przedmiotu: dr hab. inż. Kazimierz Kowalski'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_subj_tutor'), s)
        self.assertEqual(m.group('proza_subj_tutor'), 'dr hab. inż. Kazimierz Kowalski')

    def test_proza_preamble_subj_tutor__2(self):
        r = tested._dict_re[r'proza_preamble_subj_tutor']
        s = 'Kierownik przedmiotu: dr hab. inż. Natenczas Woyski, prof. PW'
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_subj_tutor'), s)
        self.assertEqual(m.group('proza_subj_tutor'), 'dr hab. inż. Natenczas Woyski, prof. PW')

    def test_proza_preamble_subj_grades__1(self):
        r = tested._dict_re[r'proza_preamble_subj_grades']
        s = "Dopuszczalne oceny:'2.0', '3.0', '3.5', '4.0', '4.5', '5.0'"
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_subj_grades'), s)
        self.assertEqual(m.group('proza_subj_grades'), "'2.0', '3.0', '3.5', '4.0', '4.5', '5.0'")

    def test_proza_preamble_subj_grades__2(self):
        r = tested._dict_re[r'proza_preamble_subj_grades']
        s = "Dopuszczalne oceny:'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'"
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_subj_grades'), s)
        self.assertEqual(m.group('proza_subj_grades'), "'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'")

    def test_proza_preamble_subj_grades__3(self):
        r = tested._dict_re[r'proza_preamble_subj_grades']
        s = "Dopuszczalne oceny:'Zal', 'Nzal', 'Zw'"
        self.assertRegexMatch(s, r)
        m = re.match(r, s)
        self.assertEqual(m.group('proza_preamble_subj_grades'), s)
        self.assertEqual(m.group('proza_subj_grades'), "'Zal', 'Nzal', 'Zw'")

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

class Test__try_electronic_contact_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_electronic_contact_line("I don't match anything"), dict())

    def test__MEiL__1(self):
        line = "        tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail:dziekanat@meil.pw.edu.pl  "
        expect = {
            'contact_phone_prefix'              : 'tel.:',
            'contact_phone_numbers'             : '(022) 621 53 10, (022) 234 73 54',
            'contact_phone'                     : 'tel.: (022) 621 53 10, (022) 234 73 54',
            'contact_faxtel_prefix'             : 'fax/tel.:',
            'contact_faxtel_numbers'            : '(022) 625 73 51',
            'contact_faxtel'                    : 'fax/tel.: (022) 625 73 51',
            'contact_email_prefix'              : 'e-mail:',
            'contact_email_address_localpart'   : 'dziekanat',
            'contact_email_address_domain'      : 'meil.pw.edu.pl',
            'contact_email_address'             : 'dziekanat@meil.pw.edu.pl',
            'contact_email'                     : 'e-mail:dziekanat@meil.pw.edu.pl',
            'electronic_contact'                : 'tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail:dziekanat@meil.pw.edu.pl'
        }
        self.assertEqual(expect, tested.try_electronic_contact_line(line))

    def test__GiK__1(self):
        line = "        tel. (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl  "
        expect = {
            'contact_phone_prefix'              : 'tel.',
            'contact_phone_numbers'             : '(+48) 22 234 72 23',
            'contact_phone'                     : 'tel. (+48) 22 234 72 23',
            'contact_faxtel_prefix'             : None,
            'contact_faxtel_numbers'            : None,
            'contact_faxtel'                    : None,
            'contact_email_prefix'              : 'e-mail:',
            'contact_email_address_localpart'   : 'dziekan',
            'contact_email_address_domain'      : 'gik.pw.edu.pl',
            'contact_email_address'             : 'dziekan@gik.pw.edu.pl',
            'contact_email'                     : 'e-mail: dziekan@gik.pw.edu.pl',
            'electronic_contact'                : 'tel. (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl'
        }
        self.assertEqual(expect, tested.try_electronic_contact_line(line))

class Test__try_stamp_town_and_datetime_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_stamp_town_and_datetime_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Warszawa, 08.02.2014, 13:09:53  "
        expect = {
            'stamp_town'    : 'Warszawa',
            'stamp_date'    : '08.02.2014',
            'stamp_time'    : '13:09:53',
            'stamp_town_and_datetime'   : 'Warszawa, 08.02.2014, 13:09:53'
        }
        self.assertEqual(expect, tested.try_stamp_town_and_datetime_line(line))

    def test__2(self):
        line = "        Szklarska Poręba, 08.02.2014, 13:09:53  "
        expect = {
            'stamp_town'    : 'Szklarska Poręba',
            'stamp_date'    : '08.02.2014',
            'stamp_time'    : '13:09:53',
            'stamp_town_and_datetime'   : 'Szklarska Poręba, 08.02.2014, 13:09:53'
        }
        self.assertEqual(expect, tested.try_stamp_town_and_datetime_line(line))

    def test__3(self):
        line = "        Bielsko-Biała, 08.02.2014, 13:09:53  "
        expect = {
            'stamp_town'    : 'Bielsko-Biała',
            'stamp_date'    : '08.02.2014',
            'stamp_time'    : '13:09:53',
            'stamp_town_and_datetime'   : 'Bielsko-Biała, 08.02.2014, 13:09:53'
        }
        self.assertEqual(expect, tested.try_stamp_town_and_datetime_line(line))

class Test__try_proza_label_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_proza_label_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Protokół zaliczeń (egzamin) 2013Z/E-1/118       "
        expect = {
            'proza_label'            : 'Protokół zaliczeń (egzamin) 2013Z/E-1/118',
            'proza_label_title'      : 'Protokół zaliczeń',
            'proza_label_exam'       : 'egzamin',
            'proza_label_semester'   : '2013Z',
            'proza_label_serie'      : 'E-1',
            'proza_label_number'     : '118'
        }
        self.assertEqual(expect, tested.try_proza_label_line(line))

    def test__2(self):
        line = "        Protokół zaliczeń (bez egzaminu) 2015 Z/B-1/197       "
        expect = {
            'proza_label'            : 'Protokół zaliczeń (bez egzaminu) 2015 Z/B-1/197',
            'proza_label_title'      : 'Protokół zaliczeń',
            'proza_label_exam'       : 'bez egzaminu',
            'proza_label_semester'   : '2015 Z',
            'proza_label_serie'      : 'B-1',
            'proza_label_number'     : '197'
        }
        self.assertEqual(expect, tested.try_proza_label_line(line))

class Test__try_proza_preamble_subj_name_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_proza_preamble_subj_name_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Nazwa przedmiotu: Health and Safety Training       "
        expect = {
            'proza_preamble_subj_name'  : 'Nazwa przedmiotu: Health and Safety Training',
            'proza_subj_name'           : 'Health and Safety Training'
        }
        self.assertEqual(expect, tested.try_proza_preamble_subj_name_line(line))

class Test__try_proza_preamble_subj_code_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_proza_preamble_subj_code_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Nr katalogowy: ML.ANW71       "
        expect = {
            'proza_preamble_subj_code'  : 'Nr katalogowy: ML.ANW71',
            'proza_subj_code'           : 'ML.ANW71'
        }
        self.assertEqual(expect, tested.try_proza_preamble_subj_code_line(line))

class Test__try_proza_preamble_department_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_proza_preamble_department_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Wydział Mechaniczny Energetyki i Lotnictwa       "
        expect = {
            'proza_preamble_department'  : 'Wydział Mechaniczny Energetyki i Lotnictwa'
        }
        self.assertEqual(expect, tested.try_proza_preamble_department_line(line))

class Test__try_proza_preamble_subj_tutor_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_proza_preamble_subj_tutor_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Kierownik przedmiotu: prof. dr hab inż. Wacław Jaki, prof. PW   "
        expect = {
            'proza_preamble_subj_tutor'  : 'Kierownik przedmiotu: prof. dr hab inż. Wacław Jaki, prof. PW',
            'proza_subj_tutor'           : 'prof. dr hab inż. Wacław Jaki, prof. PW'
        }
        self.assertEqual(expect, tested.try_proza_preamble_subj_tutor_line(line))

class Test__try_proza_preamble_subj_grades_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_proza_preamble_subj_grades_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Dopuszczalne oceny: '2.0', '3.0', '3.5', '4.0', '4.5', '5.0'   "
        expect = {
            'proza_preamble_subj_grades'  : "Dopuszczalne oceny: '2.0', '3.0', '3.5', '4.0', '4.5', '5.0'",
            'proza_subj_grades'           : "'2.0', '3.0', '3.5', '4.0', '4.5', '5.0'"
        }
        self.assertEqual(expect, tested.try_proza_preamble_subj_grades_line(line))

class Test__try_proza_preamble_subj_cond_line(unittest.TestCase):
    def test__nonmatching(self):
        self.assertEqual(tested.try_proza_preamble_subj_cond_line("I don't match anything"), dict())

    def test__1(self):
        line = "        Wszyscy studenci na liście muszą mieć wystawioną ocenę.     "
        expect = {
            'proza_preamble_subj_cond'  : "Wszyscy studenci na liście muszą mieć wystawioną ocenę",
            'proza_subj_cond'           : "Wszyscy studenci na liście muszą mieć wystawioną ocenę",
        }
        self.assertEqual(expect, tested.try_proza_preamble_subj_cond_line(line))

class Test__try_proza_page_header(unittest.TestCase):
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
            'contact_address_street_prefix'     : 'ul.',
            'contact_address_street_name'       : 'Nowowiejska',
            'contact_address_street_number'     : '24',
            'contact_address_postoffice_zip'    : '00-665',
            'contact_address_postoffice_town'   : 'Warszawa',
            'contact_address_edifice'           : 'Gmach Lotniczy',
            'contact_address_room'              : 'pok. 125',
            'contact_address_website'           : None,
            'contact_address'                   : 'ul. Nowowiejska 24, 00-665 Warszawa, Gmach Lotniczy, pok. 125',
            'contact_phone_prefix'              : 'tel.:',
            'contact_phone_numbers'             : '(022) 621 53 10, (022) 234 73 54',
            'contact_phone'                     : 'tel.: (022) 621 53 10, (022) 234 73 54',
            'contact_faxtel_prefix'             : 'fax/tel.:',
            'contact_faxtel_numbers'            : '(022) 625 73 51',
            'contact_faxtel'                    : 'fax/tel.: (022) 625 73 51',
            'contact_email_prefix'              : 'e-mail:',
            'contact_email_address_localpart'   : 'dziekanat',
            'contact_email_address_domain'      : 'meil.pw.edu.pl',
            'contact_email_address'             : 'dziekanat@meil.pw.edu.pl',
            'contact_email'                     : 'e-mail:dziekanat@meil.pw.edu.pl',
            'electronic_contact'                : 'tel.: (022) 621 53 10, (022) 234 73 54, fax/tel.: (022) 625 73 51, e-mail:dziekanat@meil.pw.edu.pl'
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_proza_page_header(status, lines)
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
            'contact_address_street_prefix'     : None,
            'contact_address_street_name'       : 'Plac Politechniki',
            'contact_address_street_number'     : '1',
            'contact_address_postoffice_zip'    : '00-661',
            'contact_address_postoffice_town'   : 'Warszawa',
            'contact_address_edifice'           : None,
            'contact_address_room'              : 'p. 301',
            'contact_address_website'           : 'www.gik.pw.edu.pl',
            'contact_address'                   : 'Plac Politechniki 1, p. 301, 00-661 Warszawa, www.gik.pw.edu.pl',
            'contact_phone_prefix'              : 'tel.',
            'contact_phone_numbers'             : '(+48) 22 234 72 23',
            'contact_phone'                     : 'tel. (+48) 22 234 72 23',
            'contact_faxtel_prefix'             : None,
            'contact_faxtel_numbers'            : None,
            'contact_faxtel'                    : None,
            'contact_email_prefix'              : 'e-mail:',
            'contact_email_address_localpart'   : 'dziekan',
            'contact_email_address_domain'      : 'gik.pw.edu.pl',
            'contact_email_address'             : 'dziekan@gik.pw.edu.pl',
            'contact_email'                     : 'e-mail: dziekan@gik.pw.edu.pl',
            'electronic_contact'                : 'tel. (+48) 22 234 72 23, e-mail: dziekan@gik.pw.edu.pl'
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_proza_page_header(status, lines)
        #
        self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 6)
        self.maxDiff = None
        self.assertEqual(expect, result)

class Test__try_proza_preamble(unittest.TestCase):
    def test__MEIL__1(self):
        header = \
"""
       Nazwa przedmiotu: Advanced Aero Engines Laboratory
       Nr katalogowy: ML.ANS600
       Zakład Silników Lotniczych
       Kierownik przedmiotu: dr hab. inż. Natenczas Woyski
       Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'. Wszyscy studenci na liście muszą mieć wystawioną ocenę.
"""
        lines = header.splitlines()
        expect = {
            'proza_preamble_subj_name'   :  'Nazwa przedmiotu: Advanced Aero Engines Laboratory',
            'proza_preamble_subj_code'   :  'Nr katalogowy: ML.ANS600',
            'proza_preamble_department'  :  'Zakład Silników Lotniczych',
            'proza_preamble_subj_tutor'  :  'Kierownik przedmiotu: dr hab. inż. Natenczas Woyski',
            'proza_preamble_subj_grades' :  "Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
            'proza_preamble_subj_cond'   :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę",
            'proza_subj_name'            :  'Advanced Aero Engines Laboratory',
            'proza_subj_code'            :  'ML.ANS600',
            'proza_subj_tutor'           :  'dr hab. inż. Natenczas Woyski',
            'proza_subj_grades'          :  "'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
            'proza_subj_cond'            :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę"
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_proza_preamble(status, lines)
        #
        #self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 6)
        self.maxDiff = None
        self.assertEqual(expect, result)

    def test__GiK__1(self):
        header = \
"""
       Nazwa przedmiotu: Gospodarowanie surowcami mineralnymi
       Nr katalogowy: GP.SMS238
       Katedra Gospodarki Przestrzennej i Nauk o Środowisku Przyrodnicznym
       Kierownik przedmiotu: dr hab. inż. Natenczas Woyski
       Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'
       Wszyscy studenci na liście muszą mieć wystawioną ocenę
"""
        lines = header.splitlines()
        expect = {
            'proza_preamble_subj_name'   :  'Nazwa przedmiotu: Gospodarowanie surowcami mineralnymi',
            'proza_preamble_subj_code'   :  'Nr katalogowy: GP.SMS238',
            'proza_preamble_department'  :  'Katedra Gospodarki Przestrzennej i Nauk o Środowisku Przyrodnicznym',
            'proza_preamble_subj_tutor'  :  'Kierownik przedmiotu: dr hab. inż. Natenczas Woyski',
            'proza_preamble_subj_grades' :  "Dopuszczalne oceny: '2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
            'proza_preamble_subj_cond'   :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę",
            'proza_subj_name'            :  'Gospodarowanie surowcami mineralnymi',
            'proza_subj_code'            :  'GP.SMS238',
            'proza_subj_tutor'           :  'dr hab. inż. Natenczas Woyski',
            'proza_subj_grades'          :  "'2,0', '3,0', '3,5', '4,0', '4,5', '5,0'",
            'proza_subj_cond'            :  "Wszyscy studenci na liście muszą mieć wystawioną ocenę"
        }
        #
        status = tested.ParsingStatus()
        result = tested.try_proza_preamble(status, lines)
        #
        #self.assertIs(status.error, False)
        self.assertIs(status.error_msg, None)
        self.assertIs(status.current_line, 7)
        self.maxDiff = None
        self.assertEqual(expect, result)


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
