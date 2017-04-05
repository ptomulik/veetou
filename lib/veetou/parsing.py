# -*- coding: utf8 -*-

import re

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
#_re_pl_zip_code = r'\d\d *- *\d\d\d'
_re_contact_address_street_info = r'(?:(?P<contact_address_street_prefix>ul\.?|pl\.?) *)?(?P<contact_address_street_name>\w+(?: +\w+)*) +(?P<contact_address_street_number>\d+(?:(?: *[/-] *\d+)|(?:(?: */ *)?\w+))?)'
_re_contact_address_postoffice_info = r'(?P<contact_address_postoffice_zip>\d\d *- *\d\d\d) +(?P<contact_address_postoffice_town>\w+(?:(?: +| *- *)\w+){,2})'
_re_contact_address_room_info = r'(?P<contact_address_room>(?:p\.?|pok\.?)? *\d+)'
_re_contact_address_website_info = r'(?P<contact_address_website>(?:https?://)?(?:\w+(?:\.\w+)*)\.(?:com|org|pl|eu))'
_re_contact_address = r'(?P<contact_address>' + \
        r', *'.join( [  _re_contact_address_street_info,
                        _re_contact_address_postoffice_info,
                        _re_contact_address_room_info] + r', *' r')'

# Dictionary of regular expressions for certain purposes
_re_dict = {
    r'POLITECHNIKA WARSZAWSKA' : re.compile(r'P *O *L *I *T *E *C *H *N *I *K *A +W *A *R *S *Z *A *W *S *K *A', re.I),
    r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA' : re.compile(r'W *Y *D *Z *I *A *Ł +M *E *C *H *A *N *I *C *Z *N *Y +E *N *E *R *G *E *T *Y *K *I +I +L *O *T *N *I *C *T *W *A', re.I),
    r'WYDZIAŁ GEODEZJI I KARTOGRAFII' : re.compile(r'W *Y *D *Z *I *A *Ł +G *E *O *D *E *Z *J *I +I +K *A *R *T *O *G *R *A *F *I *I', re.I),
    r'DZIEKANAT' : re.compile(r'D *Z *I *E *K *A *N *A *T', re.I),
    r'contact_address_street_info' : re.compile(_re_contact_address_street_info),
    r'contact_address_postoffice_info' : re.compile(_re_contact_address_postoffice_info),
    r'contact_address_room_info' : re.compile(_re_contact_address_room_info),
    r'contact_address_website_info' : re.compile(_re_contact_address_website_info),
}

_re_groups = {
    'universities' : {
        r'POLITECHNIKA WARSZAWSKA' : _re_dict[r'POLITECHNIKA WARSZAWSKA']
    },
    'faculties' : {
        r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA' : _re_dict[r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA'],
        r'WYDZIAŁ GEODEZJI I KARTOGRAFII'  : _re_dict[r'WYDZIAŁ GEODEZJI I KARTOGRAFII']
    },
    'contact_names' : {
        r'DZIEKANAT' : _re_dict[r'DZIEKANAT']
    }
}

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
