# -*- coding: utf8 -*-

import re
import itertools
import sys

# Rename group names in a regular expressions
def _rrg(s, **kw):
    prefix = kw.get('prefix', '')
    suffix = kw.get('suffix', '')
    return re.sub(r'\?P<([A-Za-z0-9_]+)>', '?P<%s\\1%s>' % (prefix,suffix), s)

# Sequences of words occuring in subject names (that we found get split between
# consecutive lines).
subject_name_word_sequences = {
    'MEiL' : [
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
}


# Miscellaneous
_re_pz_address_street = \
        r'(?:(?P<pz_address_street_prefix>ul\.?|pl\.?) *)?' + \
        r'(?P<pz_address_street_name>\w+(?: +\w+)*)' + \
        r' +(?P<pz_address_street_number>\d+(?:(?: *[/-] *\d+)|(?:(?: */ *)?\w+))?)'
_re_pz_address_postoffice = \
        r'(?P<pz_address_postoffice_zip>\d\d *- *\d\d\d)' + \
        r' +(?P<pz_address_postoffice_town>\w+(?:(?: +| *- *)\w+){,2})'
_re_pz_address_edifice = \
        r'(?P<pz_address_edifice>(?:[Gg]mach|[Bb]udynek)(?: +\w+)(?:(?:(?: +)|(?: ?- ?))\w+)*)'
_re_pz_address_room = \
        r'(?P<pz_address_room>(?:p\.?|pok\.?)? *\d+)'
_re_pz_address_website = \
        r'(?P<pz_address_website>(?:https?://)?(?:\w+(?:\.\w+)*)\.(?:com|org|pl|eu))'

_pz_address_field_names = [
    'pz_address_street_prefix',
    'pz_address_street_name',
    'pz_address_street_number',
    'pz_address_postoffice_zip',
    'pz_address_postoffice_town',
    'pz_address_edifice',
    'pz_address_room',
    'pz_address_website'
]

_re_pz_address_field_name = \
    r'(?P<field_name>' + r'|'.join(_pz_address_field_names) + r')'

# Found on MEiL 'karta postepow' and 'protokol zaliczen'
_re_pz_address_variant0 = r', *'.join([
    _re_pz_address_street,
    _re_pz_address_postoffice,
    _re_pz_address_edifice,
    _re_pz_address_room
])

# Found on GiK 'protokol zaliczen'
_re_pz_address_variant1 = r', *'.join([
    _re_pz_address_street,
    _re_pz_address_room,
    _re_pz_address_postoffice,
    _re_pz_address_website
])


_re_pz_address_variants = [
    r'(?:' + _rrg(_re_pz_address_variant0, suffix = '_0') + r')',
    r'(?:' + _rrg(_re_pz_address_variant1, suffix = '_1') + r')'
]

_re_pz_header_address = r'(?P<pz_header_address>' + r'|'.join(_re_pz_address_variants) + ')'

_re_pz_phone_prefix  = r'(?P<pz_phone_prefix>tel\.:?)'
_re_pz_phone_number  = r'(?:\(\+?\d{2,3}\))?(?: {,1}\d{1,3})+'
_re_pz_phone_numbers = r'(?P<pz_phone_numbers>(?:' + \
                                _re_pz_phone_number + \
                                r')(?:, *' + \
                                _re_pz_phone_number + \
                                 r')*)'

_re_pz_phone = \
    r'(?P<pz_phone>' + _re_pz_phone_prefix + \
    r' *' + _re_pz_phone_numbers + r')'

_re_pz_faxtel_prefix  = r'(?P<pz_faxtel_prefix>fax(?: {0,1}/ {0,1}tel)?\.:?)'
_re_pz_faxtel_number  = r'(?:\(\+?\d{2,3}\))?(?: {,1}\d{1,3})+'
_re_pz_faxtel_numbers = r'(?P<pz_faxtel_numbers>(?:' + \
                                _re_pz_faxtel_number + \
                                r')(?:, *' + \
                                _re_pz_faxtel_number + \
                                 r')*)'

_re_pz_faxtel = \
    r'(?P<pz_faxtel>' + _re_pz_faxtel_prefix + \
    r' *' + _re_pz_faxtel_numbers + r')'

_re_pz_email_prefix = r'(?P<pz_email_prefix>(?:e-?mail:))'
_re_pz_email_address_localpart = r'(?P<pz_email_address_localpart>[a-zA-Z0-9_.+-]+)'
_re_pz_email_address_domain = r'(?P<pz_email_address_domain>[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)'
_re_pz_email_address = \
    r'(?P<pz_email_address>' + \
    _re_pz_email_address_localpart + r'@' + \
    _re_pz_email_address_domain + r')'

_re_pz_email = \
    r'(?P<pz_email>' + \
    _re_pz_email_prefix + r' *' + \
    _re_pz_email_address + \
    r')'

_re_pz_header_contact = \
    r'(?P<pz_header_contact>' + \
        _re_pz_phone + \
        r'(?:, *' + _re_pz_faxtel + r')?' + \
        r', *' + _re_pz_email + \
    r')'

# 'pz' is an abbreviation for protokolzaliczen
_re_pz_town = r'(?P<pz_town>\w+(?:(?: +| *- *)\w+){,2})'
_re_pz_date = r'(?P<pz_date>\d{1,2}\.\d{1,2}\.\d{4})'
_re_pz_time = r'(?P<pz_time>\d{2}:\d{2}:\d{2})'
_re_pz_preamble_town_and_datetime = r'(?P<pz_preamble_town_and_datetime>' + \
r', *'.join([
    _re_pz_town,
    _re_pz_date,
    _re_pz_time
]) + r')'

_re_pz_title = r'(?P<pz_title>Protokół zaliczeń)'
_re_pz_exam = r'(?P<pz_exam>(?:egzamin|bez egzaminu))'
_re_pz_semester = r'(?P<pz_semester>\d{4} *[ZL])'
_re_pz_serie = r'(?P<pz_serie>[A-Z]-\d{1,2})'
_re_pz_number = r'(?P<pz_number>\d{1,4})'
_re_pz_preamble_title = r'(?P<pz_preamble_title>' + \
        _re_pz_title + r' {,3}\(' + \
        _re_pz_exam + r'\) {,3}' + \
        _re_pz_semester + r' ?/ ?' + \
        _re_pz_serie + r' ?/ ?' + \
        _re_pz_number + r')'

_re_pz_return_desc = r'(?P<pz_return_desc>Termin zwrotu)'
_re_pz_return_date = r'(?P<pz_return_date>\d{2}\.\d{2}\.(?:19\d{2}|20[0-1]\d))'
_re_pz_preamble_return =  r'(?P<pz_preamble_return>' + \
        _re_pz_return_desc + r':? {1,2}' + \
        _re_pz_return_date + r')'

_re_pz_subj_name  = r'(?P<pz_subj_name>\S+(?: {1,2}\S+)*)'
_re_pz_subj_code  = r'(?P<pz_subj_code>(?:ML|GK|GP)\.\w+)'
_re_pz_subj_tutor = r'(?P<pz_subj_tutor>(?:[^\W\d_],?|-)+\.?(?: {1,2}(?:[^\W\d_],?|-)+\.?)*)'
_re_pz_subj_grade = r'\'?(?:(?:\d(?:[,\.]\d)?)|Nzal|Zal|Zw)\'?'
_re_pz_subj_grades = \
        r'(?P<pz_subj_grades>' + \
        _re_pz_subj_grade + r'(?:, {,2}' +  _re_pz_subj_grade + r')*' + \
        r')'
_re_pz_subj_cond = r'(?P<pz_subj_cond>(?:' + r'|'.join([
        r'(?:Wszyscy studenci na liście muszą mieć wystawioną ocenę)'
    ]) + r'))'

_re_pz_preamble_subj_name = \
        r'(?P<pz_preamble_subj_name>Nazwa przedmiotu: {,2}' + \
        _re_pz_subj_name + r')'

_re_pz_preamble_subj_code = \
        r'(?P<pz_preamble_subj_code>Nr katalogowy: {,2}' + \
        _re_pz_subj_code + \
        r')'
_re_pz_preamble_department = \
        r'(?P<pz_preamble_department>(?:Wydział|Instytut|Zakład|Katedra) {1,2}\S+(?: {1,2}\S+)*)'

_re_pz_preamble_subj_tutor = \
        r'(?P<pz_preamble_subj_tutor>Kierownik przedmiotu: {,2}' + \
        _re_pz_subj_tutor + \
        r')'
_re_pz_preamble_subj_grades = \
        r'(?P<pz_preamble_subj_grades>Dopuszczalne oceny: {,2}' + \
        _re_pz_subj_grades + r')\.?'

_re_pz_preamble_subj_cond = \
        r'(?P<pz_preamble_subj_cond>' \
        + _re_pz_subj_cond + r')\.?'

_re_pz_preamble_subj_grades_and_cond = \
        _re_pz_preamble_subj_grades + r'(?: +' + _re_pz_preamble_subj_cond + r')?'

_re_pz_footer_sig_dots = '(?P<pz_footer_sig_dots>\.{6,})'

_re_pz_footer_sig_prompt = '(?P<pz_footer_sig_prompt>[pP]odpis(?: {1,2}\w+)*)'

_re_pz_footer_pagination = \
        r'(?P<pz_footer_pagination>Strona {1,2}' + \
        r'(?P<pz_page_number>\d+)' + \
        r' {1,2}z {1,2}' + \
        r'(?P<pz_pages_total>\d+))'

_re_pz_footer_title = \
        r'(?P<pz_footer_title>' + \
            _re_pz_subj_name + r' {1,2}\(' + \
            _re_pz_subj_code + \
        r'\)\.? {1,2}Protokół: {,2}' +  \
            _re_pz_semester + r' ?/ ?' + \
            _re_pz_serie + r' ?/ ?' + \
            _re_pz_number + r')'

_re_pz_footer_pagination_and_title = \
        r'(?P<pz_footer_pagination_and_title>' + \
            _re_pz_footer_pagination + \
        r' {2,}' + \
            _re_pz_footer_title + \
        r')'

_re_pz_generator_name = r"(?P<pz_generator_name>[\w']+(?: {1,2}[\w']+)*)"
_re_pz_generator_home = r'(?P<pz_generator_home>(?:https?://)?(?:\w+(?:\.\w+)*)\.(?:com|org|pl|eu))'
_re_pz_generator = \
        r'(?P<pz_generator>' + \
            _re_pz_generator_name + r', {,2}' + \
            _re_pz_generator_home + \
        r')'
_re_pz_footer_generator = \
        r'(?P<pz_footer_generator>' + \
            r'Wygenerowano z użyciem ' + \
            _re_pz_generator + \
        r')'

_list_re_pz_table_header_3_pieces = [
    r'[Zz] [Pp]rojektu',
    r'[Zz] [Ww]ykładu',
    r'[Zz] [Ćć]wiczeń',
    r'[Kk]ońcowa',
    r'(?:[Zz] )?[Pp]rzedmiotu'
]

_list_re_pz_table_header_4_pieces = [
    r'P',
    r'N'
]

def _make_re_from_permuted_pieces(pieces, **kw):
    alternatives = []
    nmin = kw.get('nmin', 1)
    nmax = kw.get('nmax', len(pieces))
    space = kw.get('space', r' +')
    op = kw.get('op', r'|')
    for n in range(nmin,nmax+1):
        for perm in itertools.permutations(pieces, n):
            alternatives.append(r'(?:' + space.join(perm) + ')')
    return op.join(alternatives)

_re_pz_table_header_3 = _make_re_from_permuted_pieces(_list_re_pz_table_header_3_pieces)
_re_pz_table_header_4 = _make_re_from_permuted_pieces(_list_re_pz_table_header_4_pieces, nmin = 2, space = r' {3,}')


_list_re_pz_table_header = [
    r'(?P<pz_table_header_0>Ocena)',
    r'(?P<pz_table_header_1>z)',
    r'(?P<pz_table_header_2>Lp. {3,}Student {3,}Nr {1,2}albumu(?: {3,}z)? {3,}Uwagi)',
    r'(?P<pz_table_header_3>' + _re_pz_table_header_3 + r')',
    r'(?P<pz_table_header_4>' + _re_pz_table_header_4 + r')'
]

_re_pz_first_name = \
        r'(?P<pz_first_name>(?:[^\W\d_]|-)+(?: {1,2}(?:[^\W\d_]|-)+)*)'

_re_pz_last_name = \
        r'(?P<pz_last_name>(?:[^\W\d_]|-)+)'

_re_pz_student_name = \
        r'(?P<pz_student_name>' + _re_pz_last_name + r' {1,2}' + \
        _re_pz_first_name + r')'

_re_pz_student_id = r'(?P<pz_student_id>(?:[A-Z]-)?\d+)'


_re_pz_table_row_order = r'(?P<pz_table_row_order>(?P<pz_order_number>\d+)\.)'
_re_pz_table_row_student_name = r'(?P<pz_table_row_student_name>' + _re_pz_student_name + r')'
_re_pz_table_row_student_id = r'(?P<pz_table_row_student_id>' + _re_pz_student_id + r')'
_re_pz_table_row_remarks = r'(?P<pz_table_row_remarks>(?:\S+)(?: {1,2}\S+)*)'

_dict_re_pz_header = {
    r'pz_address_street'             : _re_pz_address_street,
    r'pz_address_postoffice'         : _re_pz_address_postoffice,
    r'pz_address_edifice'            : _re_pz_address_edifice,
    r'pz_address_room'               : _re_pz_address_room,
    r'pz_address_website'            : _re_pz_address_website,
    r'pz_phone_prefix'               : _re_pz_phone_prefix,
    r'pz_phone_numbers'              : _re_pz_phone_numbers,
    r'pz_phone'                      : _re_pz_phone,
    r'pz_faxtel_prefix'              : _re_pz_faxtel_prefix,
    r'pz_faxtel_numbers'             : _re_pz_faxtel_numbers,
    r'pz_faxtel'                     : _re_pz_faxtel,
    r'pz_email_prefix'               : _re_pz_email_prefix,
    r'pz_email_address_localpart'    : _re_pz_email_address_localpart,
    r'pz_email_address_domain'       : _re_pz_email_address_domain,
    r'pz_email_address'              : _re_pz_email_address,
    r'pz_email'                      : _re_pz_email,
    r'pz_header_address'             : _re_pz_header_address,
    r'pz_header_contact'             : _re_pz_header_contact
}


_dict_re_university = {
    r'POLITECHNIKA WARSZAWSKA' : \
        r'(?:(?:P *O *L *I *T *E *C *H *N *I *K *A +W *A *R *S *Z *A *W *S *K *A)|' + \
        r'(?:P *O *L *I *T *E *C *H *N *I *K *I +W *A *R *S *Z *A *W *S *K *I *E *J))'
}

_dict_re_faculty = {
    r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA' : \
        r'W *Y *D *Z *I *A *Ł +M *E *C *H *A *N *I *C *Z *N *Y +E *N *E *R *G *E *T *Y *K *I +I +L *O *T *N *I *C *T *W *A',
    r'WYDZIAŁ GEODEZJI I KARTOGRAFII' : \
        r'W *Y *D *Z *I *A *Ł +G *E *O *D *E *Z *J *I +I +K *A *R *T *O *G *R *A *F *I *I'
}

_dict_re_contact_name = {
    r'DZIEKANAT' : r'D *Z *I *E *K *A *N *A *T',
}

_dict_re_pz_preamble = {
    r'pz_town'                           : _re_pz_town,
    r'pz_date'                           : _re_pz_date,
    r'pz_time'                           : _re_pz_time,
    r'pz_title'                          : _re_pz_title,
    r'pz_exam'                           : _re_pz_exam,
    r'pz_semester'                       : _re_pz_semester,
    r'pz_serie'                          : _re_pz_serie,
    r'pz_number'                         : _re_pz_number,
    r'pz_return_desc'                    : _re_pz_return_desc,
    r'pz_return_date'                    : _re_pz_return_date,
    r'pz_subj_name'                      : _re_pz_subj_name,
    r'pz_subj_code'                      : _re_pz_subj_code,
    r'pz_subj_tutor'                     : _re_pz_subj_tutor,
    r'pz_subj_grades'                    : _re_pz_subj_grades,
    r'pz_subj_cond'                      : _re_pz_subj_cond,
    r'pz_preamble_town_and_datetime'     : _re_pz_preamble_town_and_datetime,
    r'pz_preamble_title'                 : _re_pz_preamble_title,
    r'pz_preamble_return'                : _re_pz_preamble_return,
    r'pz_preamble_subj_name'             : _re_pz_preamble_subj_name,
    r'pz_preamble_subj_code'             : _re_pz_preamble_subj_code,
    r'pz_preamble_department'            : _re_pz_preamble_department,
    r'pz_preamble_subj_tutor'            : _re_pz_preamble_subj_tutor,
    r'pz_preamble_subj_grades'           : _re_pz_preamble_subj_grades,
    r'pz_preamble_subj_cond'             : _re_pz_preamble_subj_cond,
    r'pz_preamble_subj_grades_and_cond'  : _re_pz_preamble_subj_grades_and_cond
}

_dict_re_pz_footer = {
    r'pz_footer_sig_dots'                : _re_pz_footer_sig_dots,
    r'pz_footer_sig_prompt'              : _re_pz_footer_sig_prompt,
    r'pz_footer_pagination'              : _re_pz_footer_pagination,
    r'pz_footer_title'                   : _re_pz_footer_title,
    r'pz_footer_pagination_and_title'    : _re_pz_footer_pagination_and_title,
    r'pz_generator_name'                 : _re_pz_generator_name,
    r'pz_generator_home'                 : _re_pz_generator_home,
    r'pz_generator'                      : _re_pz_generator,
    r'pz_footer_generator'               : _re_pz_footer_generator
}

# Dictionary of regular expressions for certain purposes
_dict_re = dict()
_dict_re.update(_dict_re_university)
_dict_re.update(_dict_re_faculty)
_dict_re.update(_dict_re_contact_name)
_dict_re.update(_dict_re_pz_header)
_dict_re.update(_dict_re_pz_preamble)
_dict_re.update(_dict_re_pz_footer)

_predefined_phrases = {
    'university' : [
        r'POLITECHNIKA WARSZAWSKA'
    ],
    'faculty' : [
        r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA',
        r'WYDZIAŁ GEODEZJI I KARTOGRAFII'
    ],
    'contact_name' : [
        r'DZIEKANAT'
    ]
}

class ParsingStatus(object):
    def __init__(self, **kw):
        self.current_page = kw.get('current_page', 0)
        self.current_line = kw.get('current_line', 0)
        self.error = kw.get('error', False)
        self.error_msg = kw.get('error_msg', None)

def try_regex_line(regex, line):
    result = dict()
    m = re.match(r'^ *' + regex + r' *$', line)
    if m:
        result = m.groupdict().copy()
    return result

def try_predefined_phrase_line(name, line):
    result = dict()
    for phrase in _predefined_phrases[name]:
        expr = r'^ *' + _dict_re[phrase] + ' *$'
        if re.match(expr, line):
            result[name] = phrase
            break
    return result

def try_predefined_regex_line(name, line):
    return try_regex_line(_dict_re[name], line)

def try_university_line(line):
    return try_predefined_phrase_line('university', line)

def try_faculty_line(line):
    return try_predefined_phrase_line('faculty', line)

def try_contact_name_line(line):
    return try_predefined_phrase_line('contact_name', line)

def try_pz_header_address_line(line):
    result = dict()
    m = re.match(r'^ *' + _dict_re['pz_header_address'] + ' *$', line)
    if m:
        result = { k : None for k in _pz_address_field_names }
        for k,v in m.groupdict().items():
            if v is not None:
                m2 = re.match(r'^' + _re_pz_address_field_name + '(?:_[0-9]+)?$', k)
                if m2:
                    result[m2.group('field_name')] = v
        result['pz_header_address'] = m.group('pz_header_address')
    return result

def try_pz_header_contact_line(line):
    return try_predefined_regex_line('pz_header_contact', line)

def try_pz_preamble_town_and_datetime_line(line):
    return try_predefined_regex_line('pz_preamble_town_and_datetime', line)

def try_pz_preamble_title_line(line):
    return try_predefined_regex_line('pz_preamble_title', line)

def try_pz_preamble_return_line(line):
    return try_predefined_regex_line('pz_preamble_return', line)

def try_pz_preamble_subj_name_line(line):
    return try_predefined_regex_line('pz_preamble_subj_name', line)

def try_pz_preamble_subj_code_line(line):
    return try_predefined_regex_line('pz_preamble_subj_code', line)

def try_pz_preamble_department_line(line):
    return try_predefined_regex_line('pz_preamble_department', line)

def try_pz_preamble_subj_tutor_line(line):
    return try_predefined_regex_line('pz_preamble_subj_tutor', line)

def try_pz_preamble_subj_grades_line(line):
    return try_predefined_regex_line('pz_preamble_subj_grades', line)

def try_pz_preamble_subj_cond_line(line):
    return try_predefined_regex_line('pz_preamble_subj_cond', line)

def try_pz_preamble_subj_grades_and_cond_line(line):
    return try_predefined_regex_line('pz_preamble_subj_grades_and_cond', line)

def try_pz_footer_sig_dots_line(line):
    return try_predefined_regex_line('pz_footer_sig_dots', line)

def try_pz_footer_sig_prompt_line(line):
    return try_predefined_regex_line('pz_footer_sig_prompt', line)

def try_pz_footer_pagination_and_title_line(line):
    return try_predefined_regex_line('pz_footer_pagination_and_title', line)

def try_pz_footer_generator_line(line):
    return try_predefined_regex_line('pz_footer_generator', line)

def try_lines_in_sequence(status, lines, **kw):
    optional = kw.get('optional', [])
    parser_functions = kw.get('parser_functions', [])
    parser_messages = kw.get('parser_messages', [])
    skip_empty_lines = kw.get('skip_empty_lines', True)
    parser_index = 0
    result = dict()
    for line in lines:
        done = False
        while (not done) and (parser_index < len(parser_functions)):
            # try consecutive parsers
            if skip_empty_lines and re.match(r'^\s*$', line):
                status.current_line += 1
                break
            r = parser_functions[parser_index](line)
            if not r:
                if parser_index not in optional:
                    status.error = True
                    status.error_msg = 'expected: %s, got: %r' % (parser_messages[parser_index], line)
                    return result
                else:
                    parser_index += 1
            else:
                status.current_line += 1
                parser_index += 1
                result.update(r)
                done = True
    return result


def try_pz_page_header(status, lines, **kw):
    kw['parser_functions'] = [
            try_university_line,                # 0
            try_faculty_line,                   # 1
            try_contact_name_line,              # 2
            try_pz_header_address_line,      # 3
            try_pz_header_contact_line       # 4
    ]
    kw['parser_messages'] = [
            'university name',                  # 0
            'faculty name',                     # 1
            'contact name',                     # 2
            'contact address',                  # 3
            'electronic contact address',       # 4
    ]
    kw['optional'] = [ 2 ]
    return try_lines_in_sequence(status, lines, **kw)

def try_pz_preamble(status, lines, **kw):
    kw['parser_functions'] = [
            try_pz_preamble_town_and_datetime_line,
            try_pz_preamble_title_line,
            try_pz_preamble_return_line,
            try_pz_preamble_subj_name_line,
            try_pz_preamble_subj_code_line,
            try_pz_preamble_department_line,
            try_pz_preamble_subj_tutor_line,
            try_pz_preamble_subj_grades_and_cond_line,
            try_pz_preamble_subj_cond_line
    ]
    kw['parser_messages'] = [
            'town, date and time',
            'title and labels',
            'return date',
            'subject name',
            'subject code',
            'department name',
            'subject tutor',
            'list of allowed grades',
            'validity condition',
    ]
    kw['optional'] = [ 8 ]
    return try_lines_in_sequence(status, lines, **kw)

def try_pz_page_footer(status, lines, **kw):
    kw['parser_functions'] = [
            try_pz_footer_sig_dots_line,                 # 0
            try_pz_footer_sig_prompt_line,               # 1
            try_pz_footer_pagination_and_title_line,     # 2
            try_pz_footer_generator_line                 # 3
    ]
    kw['parser_messages'] = [
            'dotted field for signature',                   # 0
            'signer label',                                 # 1
            'pagination and title info',                    # 2
            'generator info'                                # 3
    ]
    kw['optional'] = [ ]
    return try_lines_in_sequence(status, lines, **kw)

def try_pz_table_header(status, lines, **kw):
    kw['parser_functions'] = [
        lambda line : try_regex_line(_list_re_pz_table_header[0],line), # 0
        lambda line : try_regex_line(_list_re_pz_table_header[1],line), # 1
        lambda line : try_regex_line(_list_re_pz_table_header[2],line), # 2
        lambda line : try_regex_line(_list_re_pz_table_header[3],line), # 3
        lambda line : try_regex_line(_list_re_pz_table_header[4],line)  # 4
    ]
    kw['parser_messages'] = [
        'table header first line',  # 0
        'table header second line', # 1
        'table header third line',  # 2
        'table header fourth line'  # 3
        'table header fifth line'   # 4
    ]
    kw['optional'] = [ 1, 4 ]
    kw['skip_empty_lines'] = False
    result = try_lines_in_sequence(status, lines, **kw)
    if result:
        extra = dict()
        fieldmix = [
            (r'[Zz] [Pp]rojektu',           'pz_subj_grade_project'),
            (r'[Zz] [Ww]ykładu',            'pz_subj_grade_lecture'),
            (r'[Zz] [Ćć]wiczeń',            'pz_subj_grade_class'),
            (r'[Kk]ońcowa',                 'pz_subj_grade_final'),
            (r'(?:[Zz] )?[Pp]rzedmiotu',    'pz_subj_grade'),
            (r'P',                          'pz_subj_grade_p'),
            (r'N',                          'pz_subj_grade_n')
        ]
        # try to elaborate what kind of partial grades are in the table
        for i in (4,3):
            hdr = result.get('pz_table_header_%d' % i)
            if hdr:
                fields = {}
                for pair in fieldmix:
                    m = re.search(r'\b' + pair[0] + r'\b', hdr)
                    if m:
                        fields[m.start()] = pair[1]
                if fields:
                    extra['pz_table_header_subj_grade_fields'] = [fields[k] for k in sorted(fields)]
                    break
        result.update(extra)
    return result

def pz_find_table_geometry(lines, **kw):
    grade_cols_count = kw.get('grade_cols_count', 1)
    _re_grade = r'(?P<pz_subj_grade>' + _re_pz_subj_grade + r')'
    ncols = 4 + grade_cols_count
    geom = ncols * [ [sys.maxsize, -(sys.maxsize-1)] ]
    geom = [ x.copy() for x in geom ]
    regexs = [
        _re_pz_table_row_order,
        _re_pz_table_row_student_name,
        _re_pz_table_row_student_id
    ] + (grade_cols_count * [ _re_grade ]) + [
        _re_pz_table_row_remarks
    ]
    groups = [
        'pz_table_row_order',
        'pz_table_row_student_name',
        'pz_table_row_student_id',
    ] + (grade_cols_count * [ 'pz_subj_grade' ]) + [
        'pz_table_row_remarks'
    ]
    lenmax = max([len(x) for x in lines])
    for line in lines:
        lm = 0
        if re.match(r'^ *$', line):
            break
        for i in range(0,len(regexs)):
            m = re.match(r'^ *' + regexs[i], line[lm:])
            if m:
                s = lm + m.start(groups[i])
                e = lm + m.end(groups[i])
                if not ((geom[i][0]< geom[i][1]) and (s > geom[i][1])):
                    if s < geom[i][0]: geom[i][0] = s
                    if e > geom[i][1]: geom[i][1] = e
            lm = max(geom[i][1], lm)

    for i in range(0, ncols):
        if geom[i][0] > geom[i][1]:
            geom[i][0] = lenmax
            geom[i][1] = lenmax
        if geom[i][0] >= lenmax: geom[i][0] = lenmax
        if geom[i][1] >= lenmax: geom[i][1] = lenmax
    return geom

def pz_split_table_columns(lines, geom):
    result = []
    for line in lines:
        columns = []
        for g in geom:
            columns.append(line[g[0]:g[1]].strip())
        result.append(columns)
    return result

def parse_pz_table_rows(status, lines, grade_fields, **kw):
    grade_cols_count = len(grade_fields)
    kw['grade_cols_count'] = grade_cols_count

    ncols = 4 + grade_cols_count

    records = []
    regexs = [
        _re_pz_table_row_order,
        _re_pz_table_row_student_name,
        _re_pz_table_row_student_id
    ] + [ r'(?P<' +  f + r'>' + _re_pz_subj_grade + r')' for f in grade_fields ]  + [
        _re_pz_table_row_remarks
    ]

    required = [
        True,
        True,
        True,
    ] +  grade_cols_count * [ False ]  + [
        False
    ]

    geom = pz_find_table_geometry(lines, **kw)
    rows = pz_split_table_columns(lines, geom)
    row = None
    for r in rows:
        if r[0]:
            if row:
                rec = dict()
                for i in range(0, ncols):
                    if required[i]:
                        regex = regexs[i]
                    else:
                        regex = r'(?:' + regexs[i] + r')?'
                    m = re.match(regex, row[i])
                    if not m:
                        status.error = True
                        status.error_msg = 'expected: table column %d, got: %r' % (i+1, r[i])
                        return records
                    rec.update(m.groupdict())
                records.append(rec)
            row = r[:]
        else:
            if not row:
                status.error = True
                status.error_msg = 'expected: table row starting with #., got %r' % r
                return records
            for i in range(1, ncols):
                if r[i]:
                    if row[i]:
                        row[i] = r' '.join([row[i], r[i]])
                    else:
                        row[i] = r[i]
        status.current_line += 1
    if row:
        rec = dict()
        for i in range(0, ncols):
            if required[i]:
                regex = regexs[i]
            else:
                regex = r'(?:' + regexs[i] + r')?'
            m = re.match(regex, row[i])
            if not m:
                status.error = True
                status.error_msg = 'expected: table column %d, got: %r' % (i+1, r[i])
                return records
            rec.update(m.groupdict())
        records.append(rec)
    return records


def parse_pz_table(status, lines, **kw):
    result = dict()
    current_line = status.current_line
    header = try_pz_table_header(status, lines, **kw)
    if header and not status.error:
        line_offset = status.current_line - current_line
        grade_fields = header.get('pz_table_header_subj_grade_fields', ['pz_subj_grade'])
        content = parse_pz_table_rows(status, lines[line_offset:], grade_fields, **kw)
        result['pz_table_content'] = content
    result['pz_table_header'] = header
    return result


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
