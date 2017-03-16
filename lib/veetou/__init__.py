# -*- coding: utf8 -*-

import re
import sys
import veetou.firstnames

class KartaZaliczen(object):

    # Expressions that match at most one line from the page
    _re_summary = [
        re.compile(r'^ *(?P<faculty>WYDZIAŁ(?: +\S+)+) *$'),
        re.compile(r'^ *(?P<university>POLITECHN(:?\w+)(?: +\w+)+) *$'),
        re.compile(r'^ *(?P<tour>Studia(?: +\S+)+) *$'),
        re.compile(r'^ *(?P<title>Karta(?: +\S+)+) *$'),
        re.compile(r'^ *(?P<student_id>\d+) *- *(?:(?P<first_name>\S+( +\S+)*) +)?(?P<last_name>\S+) *$'),
        re.compile(r'^ *Semestr +akademicki: *(?P<semester>\S+(?: +\S+)*) *Kierunek: *(?P<course>\S+( +\S+)*) *$'),
        re.compile(r'^ *Semestr +studiów: *(?P<term>\S+(?: +\S+)*) *Specjalność: *(?P<speciality>\S+(?: +\S+)*) *$'),
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

    _re_subject = re.compile(r'^ *(?P<code>ML\.\S+)(?: {1,38}(?P<name>\S+(?: {1,4}\S+)*))? +(?P<w>\d+) +(?P<c>\d+) +(?P<l>\d+) +(?P<p>\d+) +(?P<s>\d+) +(?P<credit_type>Egz\.?|Zal\.?) +(?P<ects>\d+)(?: {1,20}(?P<tutor>\S+(?: {1,3}\S+)*))?( +(?P<grade>\S{3,5}))?( +(?P<date>\d\d\.\d\d\.\d\d\d\d))? *$')
    _re_nearby = re.compile(r'^ {8,48}(?P<name>\S+(?: {1,3}\S+)*)?(?: {36,100}(?P<tutor>\S+(?: {1,3}\S+)*))? *$')

    _re_firstname = re.compile(r'\b(?:' + r'|'.join(veetou.firstnames.name_list) + r')\b')
    _re_tutprefix = re.compile(r'\b(?:prof|nzw|dr|phd|hab|doc|mgr|inż|lic)\b')

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

    _default_subject_fields = [
        'student_id',
        'first_name',
        'last_name',
        'semester',
        'course',
        'term',
        'speciality',
        'code',
        'name',
        'w',
        'c',
        'l',
        'p',
        's',
        'credit_type',
        'ects',
        'tutor',
        'grade',
        'date',
        'file',
        'page'
    ]

    _default_subject_columns = {
        'student_id'    : 'Nr albumu',
        'first_name'    : 'Imię',
        'last_name'     : 'Nazwisko',
        'semester'      : 'Semestr akademicki',
        'course'        : 'Kierunek',
        'term'          : 'Semestr studiów',
        'speciality'    : 'Specjalność',
        'code'          : 'Nr katalogowy (VERBIS)',
        'name'          : 'Nazwa',
        'w'             : 'W',
        'c'             : 'C',
        'l'             : 'L',
        'p'             : 'P',
        's'             : 'S',
        'credit_type'   : 'Forma zalicz',
        'ects'          : 'ECTS',
        'tutor'         : 'Prowadzący',
        'grade'         : 'Ocena',
        'date'          : 'Data',
        'file'          : 'Plik',
        'page'          : 'Strona'
    }

    def __init__(self, **kw):
        self.reset(**kw)

    def reset(self, **kw):
        self.subject_fields = kw.get('subject_fields', KartaZaliczen._default_subject_fields)
        self.subject_columns = kw.get('subject_columns', KartaZaliczen._default_subject_columns)
        self.summary = kw.get('summary', dict())
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

    def _extract_summary(self):
        re_summary = KartaZaliczen._re_summary[:]
        # extract summary
        for line in self.remaining_lines:
           m = None
           for r in re_summary:
               m = r.match(line)
               if m:
                   self.summary.update(m.groupdict())
                   re_summary.remove(r)
                   self.parsed_lines.append(line)
                   break
        if self.file:
            self.summary['file'] = str(self.file)
        if self.page:
            self.summary['page'] = str(self.page)
        if self.page:
            self.summary['pages'] = str(self.pages)
        self.remaining_lines[:] = [ x for x in self.remaining_lines if not x in self.parsed_lines ]

    def _extract_subjects(self):
        r = KartaZaliczen._re_subject
        n = KartaZaliczen._re_nearby
        for line in self.remaining_lines:
            mn = n.match(line)
            mr = r.match(line)
            if mr:
                gd = mr.groupdict()
                if gd['name']:
                    self._subject_names.append(gd['name'])
                if gd['tutor']:
                    self._subject_tutors.append(gd['tutor'])
                self.subjects.append(gd)
                self.parsed_lines.append(line)
                cross = True
            elif mn:
                gd = mn.groupdict()
                if gd['name']:
                    self._subject_names.append(gd['name'])
                if gd['tutor']:
                    self._subject_tutors.append(gd['tutor'])
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
                self.subjects[i]['name'] = names[i]
            self._subject_names = names[:]
        else:
            sys.stderr.write("%s: page %s: warning: could not match subject names (found %d) to subjects (found %d)\n" % (self.summary.get('file', self.file), self.summary.get('page','(unknown)'), len(names), len(self.subjects)))
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
                self.subjects[i]['tutor'] = tutors[i]
            self._subject_tutors = tutors[:]
        else:
            sys.stderr.write("%s: page %s: warning: could not match tutors (found %d) to subjects (found %d)\n" % (self.summary.get('file', self.file), self.summary.get('page','(unknown)'), len(tutors), len(self.subjects)))
            sys.stderr.write("%r\n" % tutors)

    def parse(self, lines):
        self.remaining_lines = lines[:]
        self._remove_empty_lines()
        self._extract_summary()
        self._extract_subjects()
        if len(self.subjects) > 0:
            self._subject_names_heuristics()
            self._subject_tutors_heuristics()

    def generate_subjects_header(self, **kw):
        fields = kw.get('fields', self.subject_fields)
        columns = self.subject_columns.copy()
        columns.update(kw.get('columns', {}))
        return [ str(columns.get(k,k)) for k in fields ]

    def generate_subjects_table(self, **kw):
        fields = kw.get('fields', self.subject_fields)
        table = []
        for subject in self.subjects:
            fullrow = subject.copy()
            fullrow.update(self.summary)
            table.append([ str(fullrow[k] or '') for k in fields ])
        return table



# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
