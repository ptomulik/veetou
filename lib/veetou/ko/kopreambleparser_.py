# -*- coding: utf8 -*-
"""`veetou.ko.kopreambleparser_`

Provides the KoPreambleParser class
"""

from ..parser import PreambleParser
from ..parser import reentrant
from ..parser import ifullmatch
from ..parser import ilookahead
from ..parser import fullmatch

from ..parser.patterns_ import _re_word
from ..parser.patterns_ import _re_worda
from ..parser.patterns_ import _rg_student_name_stretched
from ..parser.patterns_ import _rg_student_index
from ..parser.patterns_ import _rg_semester_code

import re

__all__ = ( 'KoPreambleParser', )

_rg_studies_field = r'(?P<studies_field>%s( +%s)*)' % (_re_word, _re_worda)
_rg_semester_number = r'(?P<semester_number>%s(?: +%s)*)' % (_re_worda, _re_worda)
_rg_studies_specialty = '(?P<studies_specialty>%s(?: +%s)*)' % (_re_word, _re_worda)

_rg_studies_modetier = r'(?P<studies_modetier>Studia(?: +%s)+)' % _re_word
_rg_title = r'(?P<title>Karta +okresowych +osiągnięć +studenta)'
_rg_student_info = r'%s *- *%s' % (_rg_student_index, _rg_student_name_stretched)

_rg_semester_and_field = r'(?:Semestr +akademicki: *%s +Kierunek: *%s?)' % (_rg_semester_code, _rg_studies_field)
_rg_semester_number_and_studies_specialty = r'(?:Semestr +studiów: *%s +Specjalność: *%s?)' % (_rg_semester_number, _rg_studies_specialty)

class KoPreambleParser(PreambleParser):

    __slots__ = ()


    _seq1 = (   re.compile(_rg_studies_modetier),
                re.compile(_rg_title),
                re.compile(_rg_student_info),
                re.compile(_rg_semester_and_field) )
    _rg_last =  re.compile(_rg_semester_number_and_studies_specialty)

    @property
    def table(self):
        return 'preambles'

    @property
    def endpoint(self):
        return 'preamble'

    def match_preamble(self, iterator, **kw):
        for pattern in self._seq1:
            if not reentrant(ifullmatch, iterator, pattern, strip=True, **kw):
                return False
        # last row may be wrapped (only the last?)
        strings = []
        tmp = iterator.state()
        for line in ilookahead(iterator, lambda s : bool(s.strip()), 2):
            strings.append(line.strip())
        unwrapped =  ' '.join(strings)
        if not fullmatch(self._rg_last, unwrapped, strip=True, **kw):
            iterator.restore(tmp)
            return False
        return True

    def refine_preamble(self, data):
        def refine(key, fcn):
            if isinstance(data.get(key), str):
                data[key] = fcn(data[key])
        refine('semester_code', lambda s : s.replace(' ', ''))

    def parse_preamble(self, iterator, kw):
        if not self.match_preamble(iterator, groupdict = kw):
            return False
        self.refine_preamble(kw)
        return True

    def parse_before_children(self, iterator, kw):
        return self.parse_preamble(iterator, kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
