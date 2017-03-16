# -*- coding: utf8 -*-

import re
import sys
import veetou.firstnames

class KartaZaliczen(object):

    # Expressions that match at most one line from the page
    _re_card = [
        re.compile(r'^ *(?P<faculty>WYDZIAŁ(?: +\S+)+) *$'),
        re.compile(r'^ *(?P<university>POLITECHN(:?\w+)(?: +\w+)+) *$'),
        re.compile(r'^ *(?P<tour>Studia(?: +\S+)+) *$'),
        re.compile(r'^ *(?P<title>Karta(?: +\S+)+) *$'),
        re.compile(
            r'^ *(?P<student_id>\d+)' + r' *- *' +
            r'(?:(?P<first_name>(?:[^\W\d_]|-)+( +(?:[^\W\d_]|-)+)*) +)?' +
            r'(?P<last_name>(?:[^\W\d_]|-)+) *$'
        ),
        re.compile(
            r'^ *Semestr +akademicki: *(?P<semester>\S+(?: +\S+)*) *' +
            r'Kierunek: *(?P<course>\S+( +\S+)*) *$'
        ),
        re.compile(
            r'^ *Semestr +studiów: *(?P<term>\S+(?: +\S+)*) *' +
            r'Specjalność: *(?P<speciality>\S+(?: +\S+)*) *$'
        ),
        re.compile(r'^ *Wymiar +godzin +(?:Forma)? *$'),
        re.compile(r'^ *Nr katalogowy +Nazwa przedmiotu +ECTS +Prowadzący +Ocena +Data *$'),
        re.compile(r'^ *W +C +L +P +S +zalicz: *$'),
        re.compile(r'^ *Punkty +ECTS +obowiązkowe: *(?P<ects_mandatory>\d+) *$'),
        re.compile(r'^ *Punkty +ECTS +pozostałe: *(?P<ects_other>\d+) *$'),
        re.compile(r'^ *Razem +punkty +ECTS: *(?P<ects_total>\d+) *$'),
        re.compile(r'^ *Uzyskane punkty ECTS: *(?P<ects_attained>\d+) *$'),
        re.compile(r'^ *(?P<page>\d+)/(?P<pages>\d+) *$'),
        re.compile(r'^ *(?P<footer>Wygenerowano( +\S+)+) *$')
    ]
    _re_specextra = re.compile(r'^ {52,80}(?P<speciality>\S+(?: {1,2}\S+)*)? *$')

    _re_subject = re.compile(
        r'^ *(?P<subj_code>ML\.\w+)' +                                              # code
        r'(?: {1,38}(?P<subj_name>\S+(?: {1,2}\S+)*))?' +                           # name
        r' +(?P<subj_w>\d+) +(?P<subj_c>\d+) +(?P<subj_l>\d+) +(?P<subj_p>\d+) +(?P<subj_s>\d+)' +           # hours
        r' +(?P<subj_credit_kind>Egz\.?|Zal\.?)' +                                       # credit type
        r' +(?P<subj_ects>\d+)' +                                                   # ECTS
        r'(?: {1,20}(?P<subj_tutor>(?:[^\W\d_]|-)+\.?(?: {1,2}(?:[^\W\d_]|-)+\.?)*))?' + # tutor
        r'( +(?P<subj_grade>\S{3,5}))?' +                                                # grade
        r'( +(?P<subj_grade_date>\d\d\.\d\d\.\d\d\d\d))? *$'                                   # date
    )
    _re_subjextra = re.compile(r'^ {8,48}(?P<subj_name>\S+(?: {1,2}\S+)*)?(?: {36,100}(?P<subj_tutor>\S+(?: {1,2}\S+)*))? *$')

    _re_firstname = re.compile(r'\b(?:' + r'|'.join(veetou.firstnames.name_list) + r')\b')
    _re_tutprefix = re.compile(r'\b(?:prof|nzw|dr|phd|hab|doc|mgr|inż|lic)\b')

    _all_card_fields = [
        'faculty',
        'university',
        'tour',
        'title',
        'student_id',
        'first_name',
        'last_name',
        'semester',
        'course',
        'term',
        'speciality',
        'ects_mandatory',
        'ects_other',
        'ects_total',
        'ects_attained',
        'file',
        'page',
        'pages',
        'footer',
    ]

    _all_subject_fields = [
        'subj_code',
        'subj_name',
        'subj_w',
        'subj_c',
        'subj_l',
        'subj_p',
        'subj_s',
        'subj_credit_kind',
        'subj_ects',
        'subj_tutor',
        'subj_grade',
        'subj_grade_date',
    ]

    _all_fields = _all_card_fields + _all_subject_fields

    _all_field_names = {
        # card
        'faculty'           : 'Wydział',
        'university'        : 'Uczelnia',
        'tour'              : 'Tura studiów',
        'title'             : 'Tytuł karty',
        'student_id'        : 'Nr albumu',
        'first_name'        : 'Imię',
        'last_name'         : 'Nazwisko',
        'semester'          : 'Semestr akademicki',
        'course'            : 'Kierunek',
        'term'              : 'Semestr studiów',
        'speciality'        : 'Specjalność',
        'ects_mandatory'    : 'Punkty ECTS obowiązkowe',
        'ects_other'        : 'Punkty ECTS pozostałe',
        'ects_total'        : 'Razem punkty ECTS',
        'ects_attained'     : 'Uzyskane punkty ECTS',
        'file'              : 'Plik',
        'page'              : 'Nr strony',
        'pages'             : 'Liczba stron',
        'footer'            : 'Stopka',
        # subject
        'subj_code'         : 'Nr katalogowy (VERBIS)',
        'subj_name'         : 'Nazwa',
        'subj_w'            : 'W',
        'subj_c'            : 'C',
        'subj_l'            : 'L',
        'subj_p'            : 'P',
        'subj_s'            : 'S',
        'subj_credit_kind'  : 'Forma zaliczenia',
        'subj_ects'         : 'ECTS',
        'subj_tutor'        : 'Prowadzący',
        'subj_grade'        : 'Ocena',
        'subj_grade_date'   : 'Data oceny',

    }

    _subject_couples = [
        r'\w+ I',
        r'\w+ II',
        r'\w+ III',
        r'\w+ IV',
        r'(?:metody|systemy) CAD/CAM/CAE',
        r'Problemy cywilizacji Zachodu',
        r'Fuel Cycles',
        r'języku C\+\+',
        r'Public Relations',
        r'Modelling and Process Identification',
        r'in Heat Transfer',
        r'Differential Equations',
        r'Education and Sports',
        r'Nuclear Power Industry',
        r'CAD/CAM/CAE Systems',
    ]

    _re_subject_couple = re.compile(r'\b(?:' + r'|'.join(_subject_couples) + r')\b')

    _default_subjects_table_fields = [
        'student_id',
        'first_name',
        'last_name',
        'semester',
        'course',
        'term',
        'speciality',
        'subj_code',
        'subj_name',
        'subj_w',
        'subj_c',
        'subj_l',
        'subj_p',
        'subj_s',
        'subj_credit_kind',
        'subj_ects',
        'subj_tutor',
        'subj_grade',
        'subj_grade_date',
        'file',
        'page'
    ]

    def __init__(self, **kw):
        self.reset(**kw)

    def reset(self, **kw):
        self.subjects_table_fields = kw.get('subjects_table_fields', self._default_subjects_table_fields)
        self.subjects_table_columns = kw.get('subjects_table_columns', self._all_field_names)
        self.card = kw.get('card', dict())
        self.subjects = kw.get('subjects', [])
        self._subject_names = []
        self._subject_tutors = []
        self.parsed_lines = []
        self.remaining_lines = []
        self.file = kw.get('file', None)
        self.page = kw.get('page', None)
        self.pages = kw.get('pages', None)

    def _remove_empty_lines(self):
        self.remaining_lines[:] = [ x for x in self.remaining_lines if not re.match(r'^[ \t]*$', x)]

    def _extract_card(self):
        re_card = KartaZaliczen._re_card[:]
        re_specextra = KartaZaliczen._re_specextra
        stack = []
        # extract card
        for line in self.remaining_lines:
            m = None
            for r in re_card:
                m = r.match(line)
                if m:
                    gd = m.groupdict()
                    self.card.update(gd)
                    re_card.remove(r)
                    self.parsed_lines.append(line)
                    stack.append(gd)
                    break
            if m is None:
                if (len(stack) > 0) and stack[-1].get('speciality'):
                    # we're one line after the "term ... speciality" line
                    m = re_specextra.match(line)
                    if m:
                        if m.group('speciality'):
                            self.card['speciality'] = ' '.join([self.card['speciality'], m.group('speciality')])
                        self.parsed_lines.append(line)
                        stack.append(dict()) # finish the "term ... specialty" lookahead
            if m is None:
                stack.append(dict())

        if self.file:
            self.card['file'] = str(self.file)
        if self.page:
            self.card['page'] = str(self.page)
        if self.page:
            self.card['pages'] = str(self.pages)
        self.remaining_lines[:] = [ x for x in self.remaining_lines if not x in self.parsed_lines ]

    def _extract_subjects(self):
        r = KartaZaliczen._re_subject
        n = KartaZaliczen._re_subjextra
        for line in self.remaining_lines:
            mn = n.match(line)
            mr = r.match(line)
            if mr:
                gd = mr.groupdict()
                if gd['subj_name']:
                    self._subject_names.append(gd['subj_name'])
                if gd['subj_tutor']:
                    self._subject_tutors.append(gd['subj_tutor'])
                self.subjects.append(gd)
                self.parsed_lines.append(line)
                cross = True
            elif mn:
                gd = mn.groupdict()
                if gd['subj_name']:
                    self._subject_names.append(gd['subj_name'])
                if gd['subj_tutor']:
                    self._subject_tutors.append(gd['subj_tutor'])
                self.parsed_lines.append(line)
        self.remaining_lines[:] = [ x for x in self.remaining_lines if not x in self.parsed_lines ]

    def _subject_names_heuristics(self):
        names = []
        current = ''
        re_couple = KartaZaliczen._re_subject_couple
        for part in self._subject_names:
            if not current:
                current = part
            elif len(part) > 0:
                new = ' '.join([current, part])
                if not part[0].isupper() or re_couple.search(new) and \
                   not re_couple.search(current) and \
                   not re_couple.search(part):
                    current = new
                else:
                    names.append(current)
                    current = part
        if current:
            names.append(current)
        if len(self.subjects) == len(names):
            for i in range(0,len(names)):
                self.subjects[i]['subj_name'] = names[i]
            self._subject_names = names[:]
        else:
            sys.stderr.write("%s: page %s: warning: could not match subject names (found %d) to subjects (found %d)\n" % (self.card.get('file', self.file), self.card.get('page','(unknown)'), len(names), len(self.subjects)))
            sys.stderr.write("%r\n" % names)

    def _subject_tutors_heuristics(self):
        tutors = []
        current = u''

        re_tutprefix = KartaZaliczen._re_tutprefix
        re_firstname = KartaZaliczen._re_firstname
        for part in self._subject_tutors:
            if not current:
                current = part
            elif len(part) > 0:
                if re_firstname.search(current) and (re_tutprefix.match(part) \
                   or (not re_firstname.match(current.split(' ')[-1]) \
                       and re_firstname.match(part))):
                    tutors.append(current)
                    current = part
                else:
                    if current.endswith('-') or part.startswith('-'):
                        current = ''.join([current, part])
                    else:
                        current = ' '.join([current, part])
        if current and re_firstname.search(current):
            tutors.append(current)
        if len(self.subjects) == len(tutors):
            for i in range(0,len(tutors)):
                self.subjects[i]['subj_tutor'] = tutors[i]
            self._subject_tutors = tutors[:]
        else:
            sys.stderr.write("%s: page %s: warning: could not match tutors (found %d) to subjects (found %d)\n" % (self.card.get('file', self.file), self.card.get('page','(unknown)'), len(tutors), len(self.subjects)))
            sys.stderr.write("%r\n" % tutors)

    def _normalize_strings(self):
        def normalize(s):
            return re.sub('\s+', ' ', str(s or ''))
        self.card = { k: normalize(v) for k,v in self.card.items() }
        for i in range(0,len(self.subjects)):
            self.subjects[i] = { k: normalize(v) for k,v in self.subjects[i].items() }

    def parse(self, lines):
        self.remaining_lines = lines[:]
        self._remove_empty_lines()
        self._extract_card()
        self._extract_subjects()
        if len(self.subjects) > 0:
            self._subject_names_heuristics()
            self._subject_tutors_heuristics()
        self._normalize_strings()

    def generate_subjects_header(self, **kw):
        fields = kw.get('fields', self.subjects_table_fields)
        if kw.get('raw'):
            return fields
        else:
            columns = self.subjects_table_columns.copy()
            columns.update(kw.get('columns', {}))
            return [ str(columns.get(k,k)) for k in fields ]

    def generate_subjects_table(self, **kw):
        fields = kw.get('fields', self.subjects_table_fields)
        table = []
        for subject in self.subjects:
            fullrow = subject.copy()
            fullrow.update(self.card)
            table.append([ str(fullrow[k] or '') for k in fields ])
        return table



# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
