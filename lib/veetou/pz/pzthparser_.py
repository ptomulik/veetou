# -*- coding: utf8 -*-
"""`veetou.pz.pzthparser_`

Provides the PzThParser class
"""

from ..parser import ThParser
from ..parser import reentrant
from ..parser import ifullmatch
from ..parser import permutexpr

import re

__all__ = ( 'PzThParser', )

class PzThParser(ThParser):

    __slots__ = ()

    _lre_th_3_pieces = [
        r'[Zz] [Pp]rojektu',
        r'[Zz] [Ww]ykładu',
        r'[Zz] [Ćć]wiczeń',
        r'[Kk]ońcowa',
        r'(?:[Zz] )?[Pp]rzedmiotu'
    ]

    _lre_th_4_pieces = [
        r'P',
        r'N'
    ]

    _re_th_3 = permutexpr(_lre_th_3_pieces)
    _re_th_4 = permutexpr(_lre_th_4_pieces, nmin = 2, space = r' {3,}')

    _lre_th = [
        r'(?P<th_0>Ocena)',
        r'(?P<th_1>z)',
        r'(?P<th_2>Lp. {3,}Student {3,}Nr {1,2}albumu(?: {3,}z)? {3,}Uwagi)',
        r'(?P<th_3>' + _re_th_3 + r')',
        r'(?P<th_4>' + _re_th_4 + r')'
    ]

    _fieldmap = [
        (_lre_th_3_pieces[0], 'subj_grade_project'),
        (_lre_th_3_pieces[1], 'subj_grade_lecture'),
        (_lre_th_3_pieces[2], 'subj_grade_class'),
        (_lre_th_3_pieces[3], 'subj_grade_final'),
        (_lre_th_3_pieces[4], 'subj_grade'),
        (_lre_th_4_pieces[0], 'subj_grade_p'),
        (_lre_th_4_pieces[1], 'subj_grade_n')
    ]


    def match(self, iterator, **kw):
        optional = (1,4)
        if 'groupdict' not in kw:
            kw['groupdict'] = dict()
        groupdict = kw['groupdict']
        for i in range(len(self._lre_th)):
            if not reentrant(ifullmatch, iterator, self._lre_th[i], strip=True, **kw) \
               and i not in optional:
                return False
        if 'th_grade_fields' in kw:
            # try to elaborate what kind of partial grades are in the table
            for i in (4,3):
                hdr = groupdict.get('th_%d' % i)
                if hdr:
                    fields = {}
                    for pattern, groupname in self._fieldmap:
                        m = re.search(r'\b' + pattern + r'\b', hdr)
                        if m:
                            fields[m.start()] = groupname
                    if fields:
                        kw['th_grade_fields'][:] = [fields[k] for k in sorted(fields)]
                        break
        return True

    def parse(self, iterator, **kw):
        if not self.match(iterator, th_grade_fields = self.parent.grade_fields):
            return False
        return True

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
