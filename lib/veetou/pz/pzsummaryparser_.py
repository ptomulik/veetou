# -*- coding: utf8 -*-
"""`veetou.pz.pzsummaryparser_`

Provides the PzSummaryParser class
"""


from ..parser import SummaryParser
from ..parser import ParserError
from ..parser import reentrant
from ..parser import ifullmatch
from ..parser import skipemptyiter
from ..parser import permutexpr

from ..parser.patterns_ import _re_subj_grade

import re
import json

__all__ = ( 'PzSummaryParser', )

_rl_caption_line_variants = [
    r'W celu weryfikacji wprowadzenia danych proszę podać liczbę poszczególnych ocen\.?',
    r'Podsumowanie ocen:?'
]
_rg_caption_line = re.compile(
        r'(?P<caption>%s)' % \
        r'|'.join(map(lambda s : r'(?:%s)' % s, _rl_caption_line_variants))
)
_rl_th_1_pieces = [
        r'[Pp]rojekt',
        r'[Ww]ykład',
        r'[Ćć]wiczenia',
        r'[Oo]cena {1,3}końcowa',
        r'[Oo]cena {1,3}z {1,3}przedmiotu'
]
_rg_th_1 = re.compile( r'(?P<th>%s)' % permutexpr(_rl_th_1_pieces, space = r' {3,}') )

_fieldmap = [
    (_rl_th_1_pieces[0], 'subj_grade_project'),
    (_rl_th_1_pieces[1], 'subj_grade_lecture'),
    (_rl_th_1_pieces[2], 'subj_grade_class'),
    (_rl_th_1_pieces[3], 'subj_grade_final'),
    (_rl_th_1_pieces[4], 'subj_grade')
]

_re_th_2 = r'[Oo]cena +[Ll]iczba'


class PzSummaryParser(SummaryParser):

    __slots__ = ()

    @property
    def table(self):
        return 'summaries'

    @property
    def endpoint(self):
        'summary'

    @property
    def junctions(self):
        return ('sheet',)

    def match_caption(self, iterator, **kw):
        return reentrant(ifullmatch, iterator, _rg_caption_line, strip=True, **kw)

    def match_th_1(self, iterator, **kw):
        if 'groupdict' not in kw:
            kw['groupdict'] = dict()
        groupdict = kw['groupdict']
        if not reentrant(ifullmatch, iterator, _rg_th_1, strip=True, **kw):
            return False
        if 'th_grade_fields' in kw:
            # try to elaborate what kind of partial grades are in the table
            hdr = groupdict['th']
            fields = {}
            for pattern, groupname in _fieldmap:
                m = re.search(r'\b' + pattern + r'\b', hdr)
                if m:
                    fields[m.start()] = groupname
            if fields:
                kw['th_grade_fields'][:] = [fields[k] for k in sorted(fields)]
        return True

    def match_th_2(self, iterator, **kw):
        n = len(kw['th_grade_fields'])
        pattern = r' {3,}'.join(map(lambda s : r'(?:%s)' % s, n * [_re_th_2]))
        return reentrant(ifullmatch, iterator, pattern, strip=True, **kw)

    def match_tbody(self, iterator, **kw):
        grade_fields = kw['th_grade_fields']
        formatter = lambda field : r'(?P<%s>%s) {3,}(?P<%s_count>(?:[0-9]{1,2})|(?:\.{4,10}))' % \
                (field, _re_subj_grade, field)
        rl_fields = map(formatter, grade_fields)
        pattern = re.compile(r' {3,}'.join(rl_fields))

        if not self.match_tr(iterator, pattern, grade_fields, **kw):
            return False

        while True:
            skipemptyiter(iterator, 1)
            if not self.match_tr(iterator, pattern, grade_fields, **kw):
                break

        return True

    def match_tr(self, iterator, pattern, grade_fields, **kw):
        if 'content' in kw:
            if 'groupdict' not in kw:
                kw['groupdict'] = dict()
            groupdict = kw['groupdict']

        if not reentrant(ifullmatch, iterator, pattern, strip=True, **kw):
            return False

        if 'content' in kw:
            for field in grade_fields:
                if not field in kw['content']:
                    kw['content'][field] = dict()
                grade = groupdict[field]
                count =  groupdict['%s_count' % field]
                kw['content'][field][grade] = count
        return True

    def match_before_children(self, iterator, **kw):
        if not self.match_caption(iterator, **kw):
            return False
        if 'th_grade_fields' not in kw:
            kw['th_grade_fields'] = []
        if not self.match_th_1(iterator, **kw):
            return False
        if not self.match_th_2(iterator, **kw):
            return False
        if not self.match_tbody(iterator, **kw):
            return False
        return True

    def parse_before_children(self, iterator, kw):
        content = dict()
        if not self.match_before_children(iterator, groupdict = kw, content = content):
            if kw:
                # if we had seen initial lines of the summary...
                dsc = 'syntax error in sheet summary'
                self.errors.append(ParserError(iterator, dsc))
            return False
        kw['content'] = json.dumps(content)
        return True

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
