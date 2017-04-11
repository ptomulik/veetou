# -*- coding: utf8 -*-

import re

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
_re_contact_address_street_info = \
        r'(?:(?P<contact_address_street_prefix>ul\.?|pl\.?) *)?' + \
        r'(?P<contact_address_street_name>\w+(?: +\w+)*)' + \
        r' +(?P<contact_address_street_number>\d+(?:(?: *[/-] *\d+)|(?:(?: */ *)?\w+))?)'
_re_contact_address_postoffice_info = \
        r'(?P<contact_address_postoffice_zip>\d\d *- *\d\d\d)' + \
        r' +(?P<contact_address_postoffice_town>\w+(?:(?: +| *- *)\w+){,2})'
_re_contact_address_edifice_info = \
        r'(?P<contact_address_edifice>(?:[Gg]mach|[Bb]udynek)(?: +\w+)(?:(?:(?: +)|(?: ?- ?))\w+)*)'
_re_contact_address_room_info = \
        r'(?P<contact_address_room>(?:p\.?|pok\.?)? *\d+)'
_re_contact_address_website_info = \
        r'(?P<contact_address_website>(?:https?://)?(?:\w+(?:\.\w+)*)\.(?:com|org|pl|eu))'

_contact_address_info_field_names = [
    'contact_address_street_prefix',
    'contact_address_street_name',
    'contact_address_street_number',
    'contact_address_postoffice_zip',
    'contact_address_postoffice_town',
    'contact_address_edifice',
    'contact_address_room',
    'contact_address_website'
]

_re_contact_address_info_field_name = \
    r'(?P<field_name>' + r'|'.join(_contact_address_info_field_names) + r')'

# Found on MEiL 'karta postepow' and 'protokol zaliczen'
_re_contact_address_variant0 = r', *'.join([
    _re_contact_address_street_info,
    _re_contact_address_postoffice_info,
    _re_contact_address_edifice_info,
    _re_contact_address_room_info
])

# Found on GiK 'protokol zaliczen'
_re_contact_address_variant1 = r', *'.join([
    _re_contact_address_street_info,
    _re_contact_address_room_info,
    _re_contact_address_postoffice_info,
    _re_contact_address_website_info
])


_re_contact_address_variants = [
    r'(?:' + _rrg(_re_contact_address_variant0, suffix = '_0') + r')',
    r'(?:' + _rrg(_re_contact_address_variant1, suffix = '_1') + r')'
]

_re_contact_address = r'(?P<contact_address>' + r'|'.join(_re_contact_address_variants) + ')'

_re_contact_phone_prefix_info  = r'(?P<contact_phone_prefix>tel\.:?)'
_re_contact_phone_number_info  = r'(?:\(\+?\d{2,3}\))?(?: {,1}\d{1,3})+'
_re_contact_phone_numbers_info = r'(?P<contact_phone_numbers>(?:' + \
                                _re_contact_phone_number_info + \
                                r')(?:, *' + \
                                _re_contact_phone_number_info + \
                                 r')*)'

_re_contact_phone = \
    r'(?P<contact_phone>' + _re_contact_phone_prefix_info + \
    r' *' + _re_contact_phone_numbers_info + r')'

_re_contact_faxtel_prefix_info  = r'(?P<contact_faxtel_prefix>fax(?: {0,1}/ {0,1}tel)?\.:?)'
_re_contact_faxtel_number_info  = r'(?:\(\+?\d{2,3}\))?(?: {,1}\d{1,3})+'
_re_contact_faxtel_numbers_info = r'(?P<contact_faxtel_numbers>(?:' + \
                                _re_contact_faxtel_number_info + \
                                r')(?:, *' + \
                                _re_contact_faxtel_number_info + \
                                 r')*)'

_re_contact_faxtel = \
    r'(?P<contact_faxtel>' + _re_contact_faxtel_prefix_info + \
    r' *' + _re_contact_faxtel_numbers_info + r')'

_re_contact_email_prefix_info = r'(?P<contact_email_prefix>(?:e-?mail:))'
_re_contact_email_address_localpart_info = r'(?P<contact_email_address_localpart>[a-zA-Z0-9_.+-]+)'
_re_contact_email_address_domain_info = r'(?P<contact_email_address_domain>[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)'
_re_contact_email_address_info = \
    r'(?P<contact_email_address>' + \
    _re_contact_email_address_localpart_info + r'@' + \
    _re_contact_email_address_domain_info + r')'

_re_contact_email = \
    r'(?P<contact_email>' + \
    _re_contact_email_prefix_info + r' *' + \
    _re_contact_email_address_info + \
    r')'

_re_electronic_contact = \
    r'(?P<electronic_contact>' + \
        _re_contact_phone + \
        r'(?:, *' + _re_contact_faxtel + r')?' + \
        r', *' + _re_contact_email + \
    r')'

_re_stamp_town = r'(?P<stamp_town>\w+(?:(?: +| *- *)\w+){,2})'
_re_stamp_date = r'(?P<stamp_date>\d{1,2}\.\d{1,2}\.\d{4})'
_re_stamp_time = r'(?P<stamp_time>\d{2}:\d{2}:\d{2})'
_re_stamp_town_and_datetime = r'(?P<stamp_town_and_datetime>' +\
r', *'.join([
    _re_stamp_town,
    _re_stamp_date,
    _re_stamp_time
]) + r')'

# 'pzal' is an abbreviation for protokolzaliczen
_re_pzal_label_title = r'(?P<pzal_label_title>Protokół zaliczeń)'
_re_pzal_label_exam = r'(?P<pzal_label_exam>(?:egzamin|bez egzaminu))'
_re_pzal_label_semester = r'(?P<pzal_label_semester>\d{4} *[ZL])'
_re_pzal_label_serie = r'(?P<pzal_label_serie>[A-Z]-\d{1,2})'
_re_pzal_label_number = r'(?P<pzal_label_number>\d{1,4})'
_re_pzal_label = r'(?P<pzal_label>' + \
        _re_pzal_label_title + r' {,3}\(' + \
        _re_pzal_label_exam + r'\) {,3}' + \
        _re_pzal_label_semester + r' ?/ ?' + \
        _re_pzal_label_serie + r' ?/ ?' + \
        _re_pzal_label_number + r')'

_dict_re_contact_address = {
    r'contact_address_street_info'      : _re_contact_address_street_info,
    r'contact_address_postoffice_info'  : _re_contact_address_postoffice_info,
    r'contact_address_edifice_info'     : _re_contact_address_edifice_info,
    r'contact_address_room_info'        : _re_contact_address_room_info,
    r'contact_address_website_info'     : _re_contact_address_website_info,
    r'contact_address'                  : _re_contact_address,
}

_dict_re_contact_phone = {
    r'contact_phone_prefix'         : _re_contact_phone_prefix_info,
    r'contact_phone_numbers'        : _re_contact_phone_numbers_info,
    r'contact_phone'                : _re_contact_phone
}

_dict_re_contact_faxtel = {
    r'contact_faxtel_prefix'         : _re_contact_faxtel_prefix_info,
    r'contact_faxtel_numbers'        : _re_contact_faxtel_numbers_info,
    r'contact_faxtel'                : _re_contact_faxtel
}

_dict_re_contact_email = {
    'contact_email_prefix'              : _re_contact_email_prefix_info,
    'contact_email_address_localpart'   : _re_contact_email_address_localpart_info,
    'contact_email_address_domain'      : _re_contact_email_address_domain_info,
    'contact_email_address'             : _re_contact_email_address_info,
    'contact_email'                     : _re_contact_email
}

_dict_re_electronic_contact = {
    'electronic_contact'                : _re_electronic_contact
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

_dict_re_stamp_town_and_datetime = {
    r'stamp_town'               : _re_stamp_town,
    r'stamp_date'               : _re_stamp_date,
    r'stamp_time'               : _re_stamp_time,
    r'stamp_town_and_datetime'  : _re_stamp_town_and_datetime
}

_dict_re_pzal_label = {
    r'pzal_label_title'     : _re_pzal_label_title,
    r'pzal_label_exam'      : _re_pzal_label_exam,
    r'pzal_label_semester'  : _re_pzal_label_semester,
    r'pzal_label_serie'     : _re_pzal_label_serie,
    r'pzal_label_number'    : _re_pzal_label_number,
    r'pzal_label'           : _re_pzal_label
}

# Dictionary of regular expressions for certain purposes
_dict_re = dict()
_dict_re.update(_dict_re_university)
_dict_re.update(_dict_re_faculty)
_dict_re.update(_dict_re_contact_name)
_dict_re.update(_dict_re_contact_address)
_dict_re.update(_dict_re_contact_phone)
_dict_re.update(_dict_re_contact_faxtel)
_dict_re.update(_dict_re_contact_email)
_dict_re.update(_dict_re_electronic_contact)
_dict_re.update(_dict_re_stamp_town_and_datetime)
_dict_re.update(_dict_re_pzal_label)

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

def try_predefined_phrase_line(name, line):
    result = dict()
    for phrase in _predefined_phrases[name]:
        expr = r'^ *' + _dict_re[phrase] + ' *$'
        if re.match(expr, line):
            result[name] = phrase
            break
    return result

def try_predefined_regex_line(name, line):
    result = dict()
    m = re.match(r'^ *' + _dict_re[name] + ' *$', line)
    if m:
        result = m.groupdict().copy()
    return result

def try_university_line(line):
    return try_predefined_phrase_line('university', line)

def try_faculty_line(line):
    return try_predefined_phrase_line('faculty', line)

def try_contact_name_line(line):
    return try_predefined_phrase_line('contact_name', line)

def try_contact_address_line(line):
    result = dict()
    m = re.match(r'^ *' + _dict_re['contact_address'] + ' *$', line)
    if m:
        result = { k : None for k in _contact_address_info_field_names }
        for k,v in m.groupdict().items():
            if v is not None:
                m2 = re.match(r'^' + _re_contact_address_info_field_name + '(?:_[0-9]+)?$', k)
                if m2:
                    result[m2.group('field_name')] = v
        result['contact_address'] = m.group('contact_address')
    return result

def try_electronic_contact_line(line):
    return try_predefined_regex_line('electronic_contact', line)

def try_stamp_town_and_datetime_line(line):
    return try_predefined_regex_line('stamp_town_and_datetime', line)

def try_pzal_label_line(line):
    return try_predefined_regex_line('pzal_label', line)

def try_lines_in_sequence(status, lines, **kw):
    optional = kw.get('optional', [])
    parser_functions = kw.get('parser_functions', [])
    parser_messages = kw.get('parser_messages', [])
    parser_index = 0
    result = dict()
    for line in lines:
        done = False
        while (not done) and (parser_index < len(parser_functions)):
            # try consecutive parsers
            if re.match(r'^\s*$', line):
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


def try_pzal_page_header(status, lines, **kw):
    kw['parser_functions'] = [
            try_university_line,                # 0
            try_faculty_line,                   # 1
            try_contact_name_line,              # 2
            try_contact_address_line,           # 3
            try_electronic_contact_line         # 4
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



# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
