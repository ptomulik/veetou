# -*- coding: utf8 -*-

import re
import sys
import veetou_legacy.parsing
##import veetou_legacy.firstnames

class ProtokolZaliczen(object):
    pass

class ProtokolZaliczenParser(object):
    def __init__(self):
        pass

    def reset(self):
        pass

    def _try_empty(self, line):
        pass

    def _try_university(self, line):
        pass

## class ProtokolZaliczen(object):
## 
##     _universities = [
##         r'POLITECHNIKA +WARSZAWSKA'
##     ]
##     _faculties = [
##         r'WYDZIAŁ +MECHANICZNY +ENERGETYKI +I +LOTNICTWA',
## ##        r'W *Y *D *Z *I *A *Ł +G *E *O *D *E *Z *J *I +I +K *A *R *T *O *G *R *A *F *I *I',
##         r'WYDZIAŁ +GEODEZJI +I +KARTOGRAFII',
##     ]
##     _contact_names = [
##         r'DZIEKANAT'
##     ]
##     # Expressions that match at most one line from the page
##     _re_page_header = [
##         re.compile(r'^ *(?P<university>' + r'|'.join(_universities) + r') *$'),
##         re.compile(r'^ *(?P<faculty>' + r'|'.join(_faculties) + r') *$'),
##         re.compile(r'^ *(?P<contact_name>' + r'|'.join(_contact_names) + r') *$')
##         re.compile(r'^ *(?P<contact_address>(?:ul\. +)?(?:\w+(?: \w+)* +\d+), *(?:\d\d-\d\d\d) +(?:\w+(?: \w+)*)(?:,.*)?) *$')
##     ]
##     _re_proto = [
## ##        re.compile(r'^ *(?P<faculty>WYDZIAŁ(?: +\S+)+) *$'),
## ##        re.compile(r'^ *(?P<university>POLITECHN(:?\w+)(?: +\w+)+) *$'),
## ##        re.compile(r'^ *(?P<course>Studia(?: +\S+)+) *$'),
## ##        re.compile(r'^ *(?P<title>Karta(?: +\S+)+) *$'),
## ##        re.compile(
## ##            r'^ *(?P<student_id>\d+)' + r' *- *' +
## ##            r'(?:(?P<first_name>(?:[^\W\d_]|-)+( +(?:[^\W\d_]|-)+)*) +)?' +
## ##            r'(?P<last_name>(?:[^\W\d_]|-)+) *$'
## ##        ),
## ##        re.compile(
## ##            r'^ *Semestr +akademicki: *(?P<semester>\S+(?: +\S+)*) *' +
## ##            r'Kierunek: *(?P<study_field>\S+( +\S+)*) *$'
## ##        ),
## ##        re.compile(
## ##            r'^ *Semestr +studiów: *(?P<term>\S+(?: +\S+)*) *' +
## ##            r'Specjalność: *(?P<speciality>\S+(?: +\S+)*) *$'
## ##        ),
## ##        re.compile(r'^ *Wymiar +godzin +(?:Forma)? *$'),
## ##        re.compile(r'^ *Nr katalogowy +Nazwa przedmiotu +ECTS +Prowadzący +Ocena +Data *$'),
## ##        re.compile(r'^ *W +C +L +P +S +zalicz: *$'),
## ##        re.compile(r'^ *Punkty +ECTS +obowiązkowe: *(?P<ects_mandatory>\d+) *$'),
## ##        re.compile(r'^ *Punkty +ECTS +pozostałe: *(?P<ects_other>\d+) *$'),
## ##        re.compile(r'^ *Razem +punkty +ECTS: *(?P<ects_total>\d+) *$'),
## ##        re.compile(r'^ *Uzyskane punkty ECTS: *(?P<ects_attained>\d+) *$'),
## ##        re.compile(r'^ *(?P<page>\d+)/(?P<pages>\d+) *$'),
## ##        re.compile(r'^ *(?P<footer>Wygenerowano( +\S+)+) *$')
##     ]
## ##    _re_specextra = re.compile(r'^ {52,80}(?P<speciality>\S+(?: {1,2}\S+)*)? *$')
## ##
## ##    _re_subject = re.compile(
## ##        r'^ *(?P<subj_code>ML\.\w+)' +                                              # code
## ##        r'(?: {1,38}(?P<subj_name>\S+(?: {1,2}\S+)*))?' +                           # name
## ##        r' +(?P<subj_w>\d+) +(?P<subj_c>\d+) +(?P<subj_l>\d+) +(?P<subj_p>\d+) +(?P<subj_s>\d+)' +           # hours
## ##        r' +(?P<subj_credit_kind>Egz\.?|Zal\.?)' +                                       # credit type
## ##        r' +(?P<subj_ects>\d+)' +                                                   # ECTS
## ##        r'(?: {1,20}(?P<subj_tutor>(?:[^\W\d_],?|-)+\.?(?: {1,2}(?:[^\W\d_],?|-)+\.?)*))?' + # tutor
## ##        r'( +(?P<subj_grade>\S{3,5}))?' +                                                # grade
## ##        r'( +(?P<subj_grade_date>\d\d\.\d\d\.\d\d\d\d))? *$'                                   # date
## ##    )
## ##    _re_subjextra = re.compile(r'^ {8,48}(?P<subj_name>\S+(?: {1,2}\S+)*)?(?: {36,100}(?P<subj_tutor>\S+(?: {1,2}\S+)*))? *$')
## ##
## ##    _re_firstname = re.compile(r'\b(?:' + r'|'.join(veetou_legacy.firstnames.name_list) + r')\b')
## ##    _re_tutprefix = re.compile(r'\b(?:prof|nzw|dr|phd|hab|doc|mgr|inż|lic)\b')
## 
##     # These fields appear on every page
##     _all_page_header_fields = [
##         'university',
##         'faculty',
##         'contact_name',
##         'contact_address',
##         'contact_phone',
##         'contact_faxtel',
##         'contact_email'
##     ]
##     # These fields appear only once for each protocol
##     _all_proto_fields = [
##         'proto_title',
##         'proto_semester',
##         'proto_kind',
##         'proto_number',
##         'proto_return_date',
##         'subj_name',
##         'subj_code',
##         'subj_department',
##         'subj_tutor',
##         'subj_def_grades',
##         'subj_req_line',
##     ]
##     _all_page_footer_fields = [
##         'footer_sig_line1',
##         'footer_sig_line2',
##         'footer_pageno',
##         'footer_subj_name',
##         'footer_subj_code',
##         'footer_proto_semester',
##         'footer_proto_kind',
##         'footer_proto_number',
##         'footer_generator'
##     ]
##     _all_record_fields = [
##         'row_number',
##         'first_name',
##         'last_name',
##         'student_id',
##         'subj_grade',
##         'subj_grade_lecture',
##         'subj_grade_excercise',
##         'subj_grade_final',
##         'subj_grade_p',
##         'subj_grade_n',
##         'remarks',
##     ]
## 
##     _all_fields = _all_page_header_fields + \
##                   _all_proto_fields + \
##                   _all_page_footer_fields + \
##                   _all_record_fields
## 
##     _all_field_titles = {
##         'university'            : 'Uczelnia',
##         'faculty'               : 'Wydział',
##         'contact_name'          : 'Jednostka Kontaktowa',
##         'contact_address'       : 'Adres',
##         'contact_phone'         : 'Telefon',
##         'contact_faxtel'        : 'Fax/Tel',
##         'contact_email'         : 'E-mail',
##         'proto_title'           : 'Tytuł',
##         'proto_semester'        : 'Semestr akademicki',
##         'proto_kind'            : 'Typ protokołu',
##         'proto_number'          : 'Numer protokołu',
##         'proto_return_date'     : 'Termin zwrotu',
##         'subj_name'             : 'Nazwa przedmiotu',
##         'subj_code'             : 'Nr katalogowy (VERBIS)',
##         'subj_department'       : 'Zakład',
##         'subj_tutor'            : 'Prowadzący',
##         'subj_def_grades'       : 'Dopuszczalne oceny',
##         'subj_req_line'         : 'Wymagania',
##         'footer_sig_line1'      : 'Podpis 1',
##         'footer_sig_line2'      : 'Podpis 2',
##         'footer_pageno'         : 'Strona protokołu',
##         'footer_subj_name'      : 'Nazwa przedmiotu (stopka)',
##         'footer_subj_code'      : 'Nr katalogowy VERBIS (stopka)',
##         'footer_proto_semester' : 'Semestr akademicki (stopka)',
##         'footer_proto_kind'     : 'Typ protokołu (stopka)',
##         'footer_proto_number'   : 'Numer protokołu (stopka)',
##         'footer_generator'      : 'Generator',
##         'row_number'            : 'Numer wiersza',
##         'first_name'            : 'Imię',
##         'last_name'             : 'Nazwisko',
##         'student_id'            : 'Nr albumu',
##         'subj_grade'            : 'Ocena',
##         'subj_grade_lecture'    : 'Ocena z wykładu',
##         'subj_grade_excercise'  : 'Ocena z ćwiczeń',
##         'subj_grade_final'      : 'Ocena końcowa',
##         'subj_grade_p'          : 'Ocena P',
##         'subj_grade_n'          : 'Ocena N',
##         'remarks'               : 'Uwagi'
##     }
## 
##     _subject_word_sequences = [
## ##        r'\w+ I',
## ##        r'\w+ II',
## ##        r'\w+ III',
## ##        r'\w+ IV',
## ##        r'(?:metody|systemy) CAD/CAM/CAE',
## ##        r'Problemy cywilizacji Zachodu',
## ##        r'Fuel Cycles',
## ##        r'języku C\+\+',
## ##        r'Public Relations',
## ##        r'Modelling and Process Identification',
## ##        r'in Heat Transfer',
## ##        r'Differential Equations',
## ##        r'Education and Sports',
## ##        r'Nuclear Power Industry',
## ##        r'CAD/CAM/CAE Systems',
##     ]
## 
##     _re_subject_word_sequence = re.compile(r'\b(?:' + r'|'.join(_subject_word_sequences) + r')\b')
## 
##     _default_subjects_table_fields = [
## ##        'student_id',
## ##        'first_name',
## ##        'last_name',
## ##        'semester',
## ##        'study_field',
## ##        'term',
## ##        'speciality',
## ##        'subj_code',
## ##        'subj_name',
## ##        'subj_w',
## ##        'subj_c',
## ##        'subj_l',
## ##        'subj_p',
## ##        'subj_s',
## ##        'subj_credit_kind',
## ##        'subj_ects',
## ##        'subj_tutor',
## ##        'subj_grade',
## ##        'subj_grade_date',
## ##        'file',
## ##        'page'
##     ]
## 
## ##    @staticmethod
## ##    def default_subjects_table_fields():
## ##        return ProtokolZaliczen._default_subjects_table_fields[:]
## ##
##     @staticmethod
##     def all_fields():
##         return ProtokolZaliczen._all_fields[:]
## 
##     @staticmethod
##     def all_field_titles():
##         return ProtokolZaliczen._all_field_titles.copy()
## ##
## ##    def __init__(self, **kw):
## ##        self.reset(**kw)
## ##
## ##    def reset(self, **kw):
## ##        self.subjects_table_fields = kw.get('subjects_table_fields')
## ##        self.subjects_table_columns = kw.get('subjects_table_columns', self._all_field_titles)
## ##        self.card = kw.get('card', dict())
## ##        self.subjects = kw.get('subjects', [])
## ##        self.maps = kw.get('maps', veetou_legacy.maps.Maps())
## ##        self._subject_names = []
## ##        self._subject_tutors = []
## ##        self.parsed_lines = []
## ##        self.remaining_lines = []
## ##        self.file = kw.get('file', None)
## ##        self.page = kw.get('page', None)
## ##        self.pages = kw.get('pages', None)
## ##
## ##    def _remove_empty_lines(self):
## ##        self.remaining_lines[:] = [ x for x in self.remaining_lines if not re.match(r'^[ \t]*$', x)]
## ##
## ##    def _extract_card(self):
## ##        re_card = ProtokolZaliczen._re_proto[:]
## ##        re_specextra = ProtokolZaliczen._re_specextra
## ##        stack = []
## ##        # extract card
## ##        for line in self.remaining_lines:
## ##            m = None
## ##            for r in re_card:
## ##                m = r.match(line)
## ##                if m:
## ##                    gd = m.groupdict()
## ##                    self.card.update(gd)
## ##                    re_card.remove(r)
## ##                    self.parsed_lines.append(line)
## ##                    stack.append(gd)
## ##                    break
## ##            if m is None:
## ##                if (len(stack) > 0) and stack[-1].get('speciality'):
## ##                    # we're one line after the "term ... speciality" line
## ##                    m = re_specextra.match(line)
## ##                    if m:
## ##                        if m.group('speciality'):
## ##                            self.card['speciality'] = ' '.join([self.card['speciality'], m.group('speciality')])
## ##                        self.parsed_lines.append(line)
## ##                        stack.append(dict()) # finish the "term ... specialty" lookahead
## ##            if m is None:
## ##                stack.append(dict())
## ##
## ##        if self.file:
## ##            self.card['file'] = str(self.file)
## ##        if self.page:
## ##            self.card['page'] = str(self.page)
## ##        if self.page:
## ##            self.card['pages'] = str(self.pages)
## ##        self.remaining_lines[:] = [ x for x in self.remaining_lines if not x in self.parsed_lines ]
## ##
## ##    def _extract_subjects(self):
## ##        r = ProtokolZaliczen._re_subject
## ##        n = ProtokolZaliczen._re_subjextra
## ##        for line in self.remaining_lines:
## ##            mn = n.match(line)
## ##            mr = r.match(line)
## ##            if mr:
## ##                gd = mr.groupdict()
## ##                if gd['subj_name']:
## ##                    self._subject_names.append(gd['subj_name'])
## ##                if gd['subj_tutor']:
## ##                    self._subject_tutors.append(gd['subj_tutor'])
## ##                self.subjects.append(gd)
## ##                self.parsed_lines.append(line)
## ##                cross = True
## ##            elif mn:
## ##                gd = mn.groupdict()
## ##                if gd['subj_name']:
## ##                    self._subject_names.append(gd['subj_name'])
## ##                if gd['subj_tutor']:
## ##                    self._subject_tutors.append(gd['subj_tutor'])
## ##                self.parsed_lines.append(line)
## ##        self.remaining_lines[:] = [ x for x in self.remaining_lines if not x in self.parsed_lines ]
## ##
## ##    def _subject_names_heuristics(self):
## ##        names = []
## ##        current = ''
## ##        re_word_sequence = ProtokolZaliczen._re_subject_word_sequence
## ##        for part in self._subject_names:
## ##            if not current:
## ##                current = part
## ##            elif len(part) > 0:
## ##                new = ' '.join([current, part])
## ##                if not part[0].isupper() or re_word_sequence.search(new) and \
## ##                   not re_word_sequence.search(current) and \
## ##                   not re_word_sequence.search(part):
## ##                    current = new
## ##                else:
## ##                    names.append(current)
## ##                    current = part
## ##        if current:
## ##            names.append(current)
## ##        if len(self.subjects) == len(names):
## ##            for i in range(0,len(names)):
## ##                self.subjects[i]['subj_name'] = names[i]
## ##            self._subject_names = names[:]
## ##        else:
## ##            sys.stderr.write("%s: page %s: warning: could not match subject names (found %d) to subjects (found %d)\n" % (self.card.get('file', self.file), self.card.get('page','(unknown)'), len(names), len(self.subjects)))
## ##            sys.stderr.write("tutors:   %r\n" % names)
## ##            sys.stderr.write("subjects: %r\n" % [s['subj_code'] for s in self.subjects])
## ##
## ##    def _subject_tutors_heuristics(self):
## ##        tutors = []
## ##        current = u''
## ##
## ##        re_tutprefix = ProtokolZaliczen._re_tutprefix
## ##        re_firstname = ProtokolZaliczen._re_firstname
## ##        for part in self._subject_tutors:
## ##            if not current:
## ##                current = part
## ##            elif len(part) > 0:
## ##                if re_firstname.search(current) and not current.endswith(',') and \
## ##                  (re_tutprefix.match(part) \
## ##                   or (not re_firstname.match(current.split(' ')[-1]) \
## ##                       and re_firstname.match(part))):
## ##                    tutors.append(current)
## ##                    current = part
## ##                else:
## ##                    if current.endswith('-') or part.startswith('-'):
## ##                        current = ''.join([current, part])
## ##                    else:
## ##                        current = ' '.join([current, part])
## ##        if current and re_firstname.search(current):
## ##            tutors.append(current)
## ##        if len(self.subjects) == len(tutors):
## ##            for i in range(0,len(tutors)):
## ##                self.subjects[i]['subj_tutor'] = tutors[i]
## ##            self._subject_tutors = tutors[:]
## ##        else:
## ##            sys.stderr.write("%s: page %s: warning: could not match tutors (found %d) to subjects (found %d)\n" % (self.card.get('file', self.file), self.card.get('page','(unknown)'), len(tutors), len(self.subjects)))
## ##            sys.stderr.write("tutors:   %r\n" % tutors)
## ##            sys.stderr.write("subjects: %r\n" % [s['subj_code'] for s in self.subjects])
## ##
## ##    def _normalize_strings(self):
## ##        def normalize(s):
## ##            return re.sub('\s+', ' ', str(s or ''))
## ##        self.card = { k: normalize(v) for k,v in self.card.items() }
## ##        for i in range(0,len(self.subjects)):
## ##            self.subjects[i] = { k: normalize(v) for k,v in self.subjects[i].items() }
## ##
## ##    def parse_txt(self, lines):
## ##        self.remaining_lines = lines[:]
## ##        self._remove_empty_lines()
## ##        self._extract_card()
## ##        self._extract_subjects()
## ##        if len(self.subjects) > 0:
## ##            self._subject_names_heuristics()
## ##            self._subject_tutors_heuristics()
## ##        self._normalize_strings()
## ##
## ##    def parse_csv(self, lines):
## ##        pass
## ##
## ##    def _subjects_table_fields(self, **kw):
## ##        maps = kw.get('maps', self.maps)
## ##        fields = kw.get('fields', self.subjects_table_fields)
## ##        exclude = kw.get('exclude_fields', [])
## ##        include = kw.get('include_fields', [])
## ##        if fields is None:
## ##            fields = []
## ##            for f in self._default_subjects_table_fields:
## ##                fields.append(f)
## ##                if f in maps:
## ##                    fields.extend(maps[f].valuenames)
## ##        fields[:] = [ f for f in fields if f not in exclude or f in include ]
## ##        fields.extend([f for f in include if not f in fields])
## ##        return fields
## ##
## ##    def _subjects_table_columns(self, fields, **kw):
## ##        maps = kw.get('maps', self.maps)
## ##        columns = self.subjects_table_columns.copy()
## ##        columns.update(maps.colnames)
## ##        columns.update(kw.get('columns', dict()))
## ##        return [ str(columns.get(k,k)) for k in fields ]
## ##
## ##    def _generate_values(self, fields, maps, row):
## ##        values = []
## ##        for f in fields:
## ##            values.append(str(row[f] or ''))
## ##            if f in maps:
## ##                for val in maps[f].get(row[f], maps[f].default()):
## ##                    values.append(str(val or ''))
## ##        return values
## ##
## ##
## ##    def generate_subjects_header(self, **kw):
## ##        fields = self._subjects_table_fields(**kw)
## ##        if kw.get('raw'):
## ##            return fields
## ##        try: del kw['fields']
## ##        except KeyError: pass
## ##        return self._subjects_table_columns(fields, **kw)
## ##
## ##    def generate_subjects_rows(self, **kw):
## ##        fields = self._subjects_table_fields(**kw)
## ##        maps = kw.get('maps', self.maps)
## ##        rows = []
## ##        for subject in self.subjects:
## ##            fullrow = subject.copy()
## ##            fullrow.update(self.card)
## ##            mapped = dict()
## ##            for f,v in fullrow.items():
## ##                mapped.update(maps.get(f,dict()).get(v,dict()))
## ##            fullrow.update(mapped)
## ##            rows.append([str(fullrow.get(k) or '') for k in fields])
## ##        return rows
## 


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
