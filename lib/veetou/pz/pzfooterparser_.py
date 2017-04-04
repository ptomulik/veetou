# -*- coding: utf8 -*-
"""`veetou.pz.pzfooterparser_`

Parser for parsing pz (Protokol Zaliczen) documents
"""

from ..parser import patterns_
from ..parser import FooterParser
from ..parser import ParserError
from ..parser import reentrant
from ..parser import ifullmatch

from ..parser.patterns_ import _rg_subj_name
from ..parser.patterns_ import _rg_subj_code
from ..parser.patterns_ import _rg_sheet_id

import re

__all__ = ( 'PzFooterParser', )

_rg_sig_dots = '(?P<sig_dots>\.{6,})'
_rg_sig_prompt = '(?P<sig_prompt>[pP]odpis(?: {1,2}\w+)*)'
_rg_pagination = r'(?P<pagination>Strona {1,2}(?P<sheet_page_number>\d+) {1,2}z {1,2}(?P<sheet_pages_total>\d+))'
_re_title = r'(?P<title>%s {1,2}\(%s\)\.? {1,2}Protokół: {,2}%s)' % (_rg_subj_name, _rg_subj_code, _rg_sheet_id)
_rg_pagination_and_title = r'(?P<pagination_and_title>%s {2,}%s)' % (_rg_pagination, _re_title)
_rg_generator_name = r"(?P<generator_name>[\w']+(?: {1,2}[\w']+)*)"
_rg_generator_home = r'(?P<generator_home>(?:https?://)?(?:\w+(?:\.\w+)*)\.(?:com|org|pl|eu))'
_rg_generator = r'(?P<generator>%s, {,2}%s)' % (_rg_generator_name, _rg_generator_home)
_rg_generator_line = r'(?P<generator_line>Wygenerowano z użyciem %s)' % _rg_generator

class PzFooterParser(FooterParser):

    __slots__ = ()

    _seq1 = ( (re.compile(_rg_sig_dots),),
              (re.compile(_rg_sig_prompt),),
              (re.compile(_re_title), re.compile(_rg_pagination_and_title)),
              (re.compile(_rg_generator_line),) )

    def match_before_children(self, iterator, **kw):
        for patterns in self._seq1:
            success = False
            for pattern in patterns:
                if reentrant(ifullmatch, iterator, pattern, strip=True, unwrap=1, **kw):
                    success = True
                    break
            if not success:
                return False
        return True

    def refine_footer(self, data):
        def refine(key, fcn):
            if isinstance(data.get(key), str):
                data[key] = fcn(data[key])
        refine('semester_code', lambda s : s.replace(' ', ''))

    def parse_before_children(self, iterator, kw):
        tmp = iterator.state()
        if not self.match_before_children(iterator, groupdict = kw):
            if iterator.state() != tmp:
                # if we've seen some initial lines of the footer
                dsc = 'syntax error in page footer'
                self.errors.append(ParserError(iterator, dsc))
            return False
        self.refine_footer(kw)
        return True


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
