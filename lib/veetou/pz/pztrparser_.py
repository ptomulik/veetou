# -*- coding: utf8 -*-
"""`veetou.pz.pzthparser_`

Provides the PzTrParser class
"""

from ..parser import TrParser

import re

__all__ = ( 'PzTrParser', )

class PzTrParser(TrParser):

    @property
    def colspans(self):
        return self.parent.colspans

    @property
    def td_patterns(self):
        return self.parent.td_patterns

    def refine_tr(self, data):
        def refine(key, fcn):
            if isinstance(data.get(key), str):
                data[key] = fcn(data[key])
        dot2comma = lambda s : re.sub(r'\b(\d)\.(\d)\b', r'\1,\2', s)
        refine('subj_grade_project', dot2comma)
        refine('subj_grade_lecture', dot2comma)
        refine('subj_grade_class', dot2comma)
        refine('subj_grade_final', dot2comma)
        refine('subj_grade', dot2comma)
        refine('subj_grade_p', dot2comma)
        refine('subj_grade_n', dot2comma)

    def parse_tr(self, iterator, kw):
        if not self.parse_tr_top_aligned(iterator, kw):
            return False
        self.refine_tr(kw)
        return True


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
