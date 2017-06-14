# -*- coding: utf8 -*-
"""`veetou.ko.kotbodyparser_`

Provides the KoTbodyParser class
"""

from . import kotrparser_

from ..input import InputLine
from ..parser import TbodyParser
from ..parser import ParserError
from ..parser import Colspan
from ..parser import reentrant
from ..parser import ifullmatch
from ..parser import fullmatch
from ..parser import skipemptylines

from ..parser.patterns_ import _rg_subj_code
from ..parser.patterns_ import _rg_subj_name
from ..parser.patterns_ import _rg_subj_tutor
from ..parser.patterns_ import _rg_subj_grade
from ..parser.patterns_ import _rg_subj_grade_date
from ..parser.patterns_ import _re_word

from .kopatterns_ import _rg_ects_line

import re
import sys

__all__ = ( 'KoTbodyParser', )

_re_subj_hours = r'(?:\d{1,4})'
_re_subj_ects = r'(?:\d{1,4})'

_rg_subj_credit_kind = r'(?P<subj_credit_kind>Egz\.?|Zal\.?)'
_rg_subj_hours = r'(?P<subj_hours>%s)' % _re_subj_hours
_rg_subj_hours_w = r'(?P<subj_hours_w>%s)' % _re_subj_hours
_rg_subj_hours_c = r'(?P<subj_hours_c>%s)' % _re_subj_hours
_rg_subj_hours_l = r'(?P<subj_hours_l>%s)' % _re_subj_hours
_rg_subj_hours_p = r'(?P<subj_hours_p>%s)' % _re_subj_hours
_rg_subj_hours_s = r'(?P<subj_hours_s>%s)' % _re_subj_hours
_rg_subj_ects = r'(?P<subj_ects>%s)' % _re_subj_ects
_rg_subj_tutor_cs = r'(?P<subj_tutor>%s\.?,?(?: {1,2}%s\.?)*)' % (_re_word,_re_word)
_rg_no_subj_declared = r'(?P<remark>Brak zadeklarowanych przedmiotów)'

class KoTbodyParser(TbodyParser):

    __slots__ = ('_colspans', '_colspan_finder', '_td_patterns', '_sheet_ects_data')

    def __init__(self, **kw):
        super().__init__(**kw)
        self._colspan_finder = self.mk_colspan_finder()
        self._sheet_ects_data = dict()

    @property
    def colspan_finder(self):
        return self._colspan_finder

    @property
    def colspans(self):
        return self._colspans

    @property
    def td_patterns(self):
        return self._td_patterns

    @property
    def sheet_ects_data(self):
        return self._sheet_ects_data

    @property
    def table(self):
        return self.prefixed_table

    @property
    def endpoint(self):
        return self.prefixed_endpoint

    @property
    def junctions(self):
        return (self.root.page_parser.endpoint,)

    def create_tr_parser(self, **kw):
        return kotrparser_.KoTrParser(**kw)

    def mk_colspan_finder(self):
        pairs = (   ('subj_code',_rg_subj_code),
                    ('subj_name', _rg_subj_name),
                    ('subj_hours_w', _rg_subj_hours_w),
                    ('subj_hours_c', _rg_subj_hours_c),
                    ('subj_hours_l', _rg_subj_hours_l),
                    ('subj_hours_p', _rg_subj_hours_p),
                    ('subj_hours_s', _rg_subj_hours_s),
                    ('subj_credit_kind', _rg_subj_credit_kind),
                    ('subj_ects', _rg_subj_ects),
                    ('subj_tutor', _rg_subj_tutor_cs),
                    ('subj_grade', _rg_subj_grade),
                    ('subj_grade_date', _rg_subj_grade_date) )
        groups, patterns = zip(*pairs)
        spaces = (r' *',) + 11 * (r' {1,25}',) + (r' *',)
        initial = ( (10, 10),
                    (30, 30),
                    (55, 55),
                    (61, 61),
                    (67, 67),
                    (72, 72),
                    (78, 78),
                    (84, 84),
                    (91, 91),
                    (106,106),
                    (122,122),
                    (130,130) )

        return Colspan(12, patterns, groups, spaces, initial)

    def mk_td_patterns(self):
        patterns = (
                _rg_subj_code,
                _rg_subj_name,
                r'(?P<subj_hours_w>%s)' % _re_subj_hours,
                r'(?P<subj_hours_c>%s)' % _re_subj_hours,
                r'(?P<subj_hours_l>%s)' % _re_subj_hours,
                r'(?P<subj_hours_p>%s)' % _re_subj_hours,
                r'(?P<subj_hours_s>%s)' % _re_subj_hours,
                _rg_subj_credit_kind,
                _rg_subj_ects,
                _rg_subj_tutor,
                r'(?:%s)?' % _rg_subj_grade,
                r'(?:%s)?' % _rg_subj_grade_date
        )
        return tuple(map(re.compile, patterns))

    def match_ects_lines(self, iterator, **kw):
        tmp = iterator.state()
        line = skipemptylines(iterator,1)
        if line:
            next(iterator)
            if fullmatch(_rg_ects_line, line, strip=True, **kw):
                skipemptylines(iterator,1)
                return True
        iterator.restore(tmp)
        return False

    def parse(self, iterator, **kw):
        self._td_patterns = self.mk_td_patterns()
        return super().parse(iterator, **kw)

    def parse_before_children(self, iterator, kw):
        if reentrant(ifullmatch, iterator, _rg_no_subj_declared, strip=True,
                     unwrap=3, unwrap_sep=' ', groupdict = kw):
            self.next_tbody_parsed()
            return True
        return super().parse_before_children(iterator, kw)

    def parse_with_children(self, iterator, kw):
        while not self.tbody_complete:
            while self.match_ects_lines(iterator, groupdict = self.sheet_ects_data): pass
            tmp = iterator.state()
            self._colspans = self.find_colspans(iterator, self.colspan_finder)
            if super().parse_with_children(iterator, kw):
                self._tbody_complete = False
            elif iterator.state() == tmp:
                # we've tried but there is no more parts of tbody....
                self._tbody_complete = True
            else:
                return False
        while self.match_ects_lines(iterator, groupdict = self.sheet_ects_data): pass
        return True

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
