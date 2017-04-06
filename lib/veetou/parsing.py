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

_dict_re_contact_address = {
    r'contact_address_street_info'      : _re_contact_address_street_info,
    r'contact_address_postoffice_info'  : _re_contact_address_postoffice_info,
    r'contact_address_edifice_info'     : _re_contact_address_edifice_info,
    r'contact_address_room_info'        : _re_contact_address_room_info,
    r'contact_address_website_info'     : _re_contact_address_website_info,
    r'contact_address'                  : _re_contact_address,
}

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

_dict_re_contact_phone = {
    r'contact_phone_prefix'         : _re_contact_phone_prefix_info,
    r'contact_phone_numbers'        : _re_contact_phone_numbers_info,
    r'contact_phone'                : _re_contact_phone
}

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

_dict_re_contact_faxtel = {
    r'contact_faxtel_prefix'         : _re_contact_faxtel_prefix_info,
    r'contact_faxtel_numbers'        : _re_contact_faxtel_numbers_info,
    r'contact_faxtel'                : _re_contact_faxtel
}

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

_dict_re_contact_email = {
    'contact_email_prefix'              : _re_contact_email_prefix_info,
    'contact_email_address_localpart'   : _re_contact_email_address_localpart_info,
    'contact_email_address_domain'      : _re_contact_email_address_domain_info,
    'contact_email_address'             : _re_contact_email_address_info,
    'contact_email'                     : _re_contact_email
}

_re_electronic_contact = \
    r'(?P<electronic_contact>' + \
        _re_contact_phone + \
        r'(?:, *' + _re_contact_faxtel + r')?' + \
        r', *' + _re_contact_email + \
    r')'

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

def try_predefined_phrase_line(name, line):
    result = dict()
    for phrase in _predefined_phrases[name]:
        expr = r'^ *' + _dict_re[phrase] + ' *$'
        if re.match(expr, line):
            result[name] = phrase
            break
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
    result = dict()
    m = re.match(r'^ *' + _dict_re['electronic_contact'] + ' *$', line)
    if m:
        result = m.groupdict().copy()
    return result

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
