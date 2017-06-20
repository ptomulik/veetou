# -*- coding: utf8 -*-
"""`veetou.pz.pzpreambleparser_`

Provides the PzPreambleParser class
"""

from ..parser import PreambleParser
from ..parser import reentrant
from ..parser import ifullmatch

from ..parser.patterns_ import _rg_sheet_id
from ..parser.patterns_ import _rg_subj_name
from ..parser.patterns_ import _rg_subj_code
from ..parser.patterns_ import _re_subj_grade

import re

__all__ = ( 'PzPreambleParser', )

_rg_town = r'(?P<town>\w+(?:(?: +| *- *)\w+){,2})'
_rg_date = r'(?P<date>\d{1,2}\.\d{1,2}\.\d{4})'
_rg_time = r'(?P<time>\d{2}:\d{2}:\d{2})'
_rg_town_and_datetime = r'(?P<town_and_datetime>%s, *%s(?:, *%s)?)' % (_rg_town, _rg_date, _rg_time)
_rg_title = r'(?P<title>Protokół zaliczeń)'
_rg_exam = r'(?P<exam>(?:egzamin|bez egzaminu))'
_rg_title_line = r'(?P<title_line>%s {,3}\(%s\) {,3}%s)' % (_rg_title, _rg_exam, _rg_sheet_id)

_rg_return_desc = r'(?P<return_desc>Termin zwrotu)'
_re_return_date = r'(?P<return_date>\d{2}\.\d{2}\.(?:19\d{2}|20[0-1]\d))'
_re_return_line = r'(?P<return_line>%s:? {1,2}%s)' % (_rg_return_desc, _re_return_date)

_rg_subj_tutor = r'(?P<subj_tutor>(?:[^\W\d_],?|-)+\.?(?: {1,2}(?:[^\W\d_],?|-)+\.?)*)'
_rg_subj_grades = r'(?P<subj_grades>%s(?:, {,2}%s)*)' % (_re_subj_grade, _re_subj_grade)
_rg_subj_cond = r'(?P<subj_cond>(?:' + r'|'.join([
        r'(?:Wszyscy studenci na liście muszą mieć wystawioną ocenę)'
    ]) + r'))'

_rg_subj_name_line = r'(?P<subj_name_line>Nazwa przedmiotu: {,2}%s)' % _rg_subj_name
_rg_subj_code_line = r'(?P<subj_code_line>Nr katalogowy: {,2}%s)' % _rg_subj_code
_rg_subj_department = r'(?P<subj_department>(?:(?:Wydział|Instytut|Zakład|Katedra|Studium) {1,2}\S+(?: {1,2}\S+)*)|INNE)'
_rg_subj_tutor_line = r'(?P<subj_tutor_line>Kierownik przedmiotu: {,2}%s)' % _rg_subj_tutor
_rg_subj_grades_line = r'(?P<subj_grades_line>Dopuszczalne oceny: {,2}%s)\.?' % _rg_subj_grades
_rg_subj_cond_line = r'(?P<subj_cond_line>%s)\.?' % _rg_subj_cond
_rg_subj_grades_and_cond_line = r'%s(?: +%s)?' % (_rg_subj_grades_line, _rg_subj_cond_line)

class PzPreambleParser(PreambleParser):

    __slots__ = ()


    _seq1 = (   re.compile(_rg_town_and_datetime),
                re.compile(_rg_title_line),
                re.compile(_re_return_line),
                re.compile(_rg_subj_name_line),
                re.compile(_rg_subj_code_line),
                re.compile(_rg_subj_department),
                re.compile(_rg_subj_tutor_line) )


    @property
    def table(self):
        return self.prefixed_table

    @property
    def endpoint(self):
        return self.prefixed_endpoint

    @property
    def junctions(self):
        return (self.root.sheet_parser.endpoint,)

    def match_before_children(self, iterator, **kw):
        for pattern in self._seq1:
            if not reentrant(ifullmatch, iterator, pattern, strip=True, **kw):
                return False
        if reentrant(ifullmatch, iterator, _rg_subj_grades_line, strip=True, **kw):
            return reentrant(ifullmatch, iterator, _rg_subj_cond_line, strip=True, **kw)
        else:
            return reentrant(ifullmatch, iterator, _rg_subj_grades_and_cond_line, strip=True, **kw)

    def refine_preamble(self, data):
        def refine(key, fcn):
            if isinstance(data.get(key), str):
                data[key] = fcn(data[key])
        isodate = lambda s : re.sub(r'\b(\d{2})\.(\d{2})\.(\d{4})\b', r'\3-\2-\1', s)
        refine('semester_code', lambda s : s.replace(' ', ''))
        refine('date', isodate)
        refine('return_date', isodate)
        refine('town_and_datetime', isodate)

    def parse_before_children(self, iterator, kw):
        if not self.match_before_children(iterator, groupdict = kw):
            return False
        self.refine_preamble(kw)
        return True

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
