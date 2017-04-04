# -*- coding: utf8 -*-
"""`veetou.pz.pztbodyparser_`

Provides the PzTbodyParser class
"""

from . import pztrparser_

from ..input import InputLine
from ..parser import TbodyParser
from ..parser import ParserError
from ..parser import Colspan

from ..parser.patterns_ import _re_subj_grade
from ..parser.patterns_ import _rg_tr_ord
from ..parser.patterns_ import _rg_student_name
from ..parser.patterns_ import _rg_student_index
from ..parser.patterns_ import _rg_tr_remarks
from ..parser.patterns_ import _rg_subj_grade

import re

__all__ = ( 'PzTbodyParser', )

class PzTbodyParser(TbodyParser):

    __slots__ = ('_colspans', '_td_patterns')

    @property
    def colspan_finder(self):
        return self._colspan_finder

    @property
    def colspans(self):
        return self._colspans

    @property
    def td_patterns(self):
        return self._td_patterns

    def create_tr_parser(self, **kw):
        return pztrparser_.PzTrParser(**kw)

    def mk_colspan_finder(self, grade_cols_count):
        groups =    ( 'tr_ord', 'student_name', 'student_index') + \
                    ( grade_cols_count * ('subj_grade',) ) + \
                    ( 'tr_remarks',)
        patterns =  ( _rg_tr_ord, _rg_student_name, _rg_student_index, ) + \
                    ( grade_cols_count * (_rg_subj_grade,) ) + \
                    ( _rg_tr_remarks, )
        return Colspan(4 + grade_cols_count, patterns, groups)


    def mk_cs_patterns(self, grade_cols_count):
        patterns = (
                ('tr_ord',              _rg_tr_ord),
                ('student_name',        _rg_student_name),
                ('student_index',       _rg_student_index),
        ) + (grade_cols_count * (('subj_grade', _rg_subj_grade),)) + (
                ('tr_remarks',          _rg_tr_remarks),
        )
        return patterns

    def mk_td_patterns(self, grade_fields):
        patterns = (
                _rg_tr_ord,
                _rg_student_name,
                _rg_student_index,
        ) + tuple( (r'(?:(?P<%s>%s))?' % (f, _re_subj_grade)) for f in grade_fields ) + (
                r'(?:%s)?' % _rg_tr_remarks,
        )
        return tuple(map(re.compile, patterns))

    def parse(self, iterator, **kw):
        colspan_finder = self.mk_colspan_finder(len(self.parent.grade_fields))
        self._colspans = self.find_colspans(iterator, colspan_finder)
        self._td_patterns = self.mk_td_patterns(self.parent.grade_fields)
        return super().parse(iterator, **kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
