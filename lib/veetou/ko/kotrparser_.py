# -*- coding: utf8 -*-
"""`veetou.ko.kothparser_`

Provides the KoTrParser class
"""

from ..parser import TrParser
from ..parser import fullmatch
from ..parser import skipemptylines

from .kopatterns_ import _rg_pagination

import re

__all__ = ( 'KoTrParser', )

class KoTrParser(TrParser):

    @property
    def colspans(self):
        return self.parent.colspans

    @property
    def td_patterns(self):
        return self.parent.td_patterns

    @property
    def table(self):
        return self.prefixed_table

    @property
    def endpoint(self):
        return self.prefixed_endpoint

    def lookahead_match(self, line):
        return line.strip() and not fullmatch(_rg_pagination, line, strip=True)

    def refine_tr(self, data):
        def refine(key, fcn):
            if isinstance(data.get(key), str):
                data[key] = fcn(data[key])
        commagrade = lambda s : re.sub(r'\b(\d)\.(\d)\b', r'\1,\2', s)
        isodate = lambda s : re.sub(r'\b(\d{2})\.(\d{2})\.(\d{4})\b', r'\3-\2-\1', s)
        refine('subj_grade', commagrade)
        refine('subj_grade_date', isodate)

    def parse_tr(self, iterator, kw):
        if not self.parse_tr_mid_aligned(iterator, kw):
            return False
        self.refine_tr(kw)
        return True


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
