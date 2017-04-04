# -*- coding: utf8 -*-
"""`veetou.parser.patterns_`

Common regular expressions used by XxYyyParser classes
"""

from .functions_ import scatter
import re

__all__ = ()

# patterns without any predefined groups
_re_letter = r'[^\W\d_]'
_re_alnum = r'[^\W_]'
_re_word = r'(?:%s+)' % _re_letter # word made of letters only
_re_worda = r'(?:%s%s*)' % (_re_alnum, _re_alnum)
_re_name_word = r'(?:%s(?:\'%s)?)' % (_re_word, _re_word)
_re_name_piece = r'(?:(?:%s(?: {,1}- {,1}%s)*)|(?:(?:%s\.)|%s)+)' % (_re_name_word, _re_name_word, _re_letter, _re_name_word)
_re_first_name = r'(?:%s(?:(?:, {,2})|(?: {1,2})%s)*)' % (_re_name_piece, _re_name_piece)
_re_first_name_stretched = r'(?:%s(?:(?:, *)|(?: +)%s)*)' % (_re_name_piece, _re_name_piece)
_re_subj_grade = r'\'?(?:(?:\d(?:[,\.]\d)?)|Nzal|Zal|Zw)\'?'
_re_tutprefix = r'(?:prof\.|nzw\.|dr|phd|hab\.|doc\.|mgr|inż\.|lic\.)'
_re_tutsuffix = r'(?:prof\. PW)'

# patterns with some groups predefined
_rg_subj_name = r'(?P<subj_name>\S+(?: {1,2}\S+)*)'
_rg_subj_code = r'(?P<subj_code>(?:ML|GK|GP)\.\w+)'
_rg_subj_grade = r'(?P<subj_grade>%s)' % _re_subj_grade
_rg_subj_grade_date = r'(?P<subj_grade_date>\d{2}\.\d{2}\.\d{4})'
_rg_sheet_number = r'(?P<sheet_number>\d{1,4})'
_rg_sheet_serie = r'(?P<sheet_serie>[A-Z]-\d{1,2})'
_rg_semester_code = r'(?P<semester_code>\d{4} *[ZL])'
_rg_sheet_id = r'(?P<sheet_id>%s ?/ ?%s ?/ ?%s)' % (_rg_semester_code, _rg_sheet_serie, _rg_sheet_number)
_rg_first_name = r'(?P<first_name>%s)' % _re_first_name
_rg_first_name_stretched = r'(?P<first_name>%s)' % _re_first_name_stretched
_rg_last_name = r'(?P<last_name>%s)' % _re_name_piece
_rg_student_name = r'(?P<student_name>%s(?: {1,2}%s)?)' % (_rg_last_name, _rg_first_name)
_rg_student_name_stretched = r'(?P<student_name>%s +%s)' % (_rg_first_name_stretched, _rg_last_name)
_rg_student_index = r'(?P<student_index>(?:(?:[A-Z]-)?\d{3,6})(?:/PZ)?)'
_rg_tr_ord = r'(?P<tr_ord>(?P<tr_ord_no>\d+)\.)'
_rg_tr_remarks = r'(?P<tr_remarks>(?:\S+)(?: {1,2}\S+)*)'
_rg_tutprefixes = r'(?P<tutor_prefixes>%s(?: {1,2}%s)*)' % (_re_tutprefix, _re_tutprefix)
_rg_tutor = r'(?:(?:%s {1,2})?(?P<tutor_first_name>%s) {1,2}(?P<tutor_last_name>%s)(?:, {1,2}(?P<tutor_suffix>%s))?)' % (_rg_tutprefixes, _re_first_name, _re_name_piece, _re_tutsuffix)
_rg_subj_tutor = r'(?P<subj_tutor>%s)' % _rg_tutor


# pattern-dictionaries (for matchdict, fullmatchdict, etc...)
_rd_university = {
    r'POLITECHNIKA WARSZAWSKA' : re.compile(r'(?:' + \
        r'(?:' + scatter(r'POLITECHNIKA WARSZAWSKA', 4) + ')|' + \
        r'(?:' + scatter(r'POLITECHNIKI WARSZAWSKIEJ', 4) + ')' + \
    ')')
}

_rd_faculty = {
    r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA' : \
        re.compile(scatter(r'WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA', 4)),
    r'WYDZIAŁ GEODEZJI I KARTOGRAFII' : \
        re.compile(scatter(r'WYDZIAŁ GEODEZJI I KARTOGRAFII', 4))
}

_rd_contact_name = {
    r'DZIEKANAT' : scatter(r'DZIEKANAT', 4)
}

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
