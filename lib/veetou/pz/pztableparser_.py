# -*- coding: utf8 -*-
"""`veetou.pz.pztableparser_`

Provides the PzTableParser class
"""

from . import pzthparser_
from . import pztbodyparser_

from ..parser import TableParser

__all__ = ( 'PzTableParser', )

class PzTableParser(TableParser):

    __slots__ = ('_grade_fields',)

    def __init__(self, **kw):
        super().__init__(**kw)
        self._grade_fields = []

    @property
    def grade_fields(self):
        return self._grade_fields

    def create_th_parser(self, **kw):
        return pzthparser_.PzThParser(**kw)

    def create_tbody_parser(self, **kw):
        return pztbodyparser_.PzTbodyParser(**kw)

    def parse(self, iterator, **kw):
        self.grade_fields.clear()
        return super().parse(iterator, **kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
