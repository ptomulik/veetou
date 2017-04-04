
# -*- coding: utf8 -*-
"""`veetou.parser.patterns_`

Common regular expressions used by KoXyzParser classes
"""

import re

__all__ = ()

_rl_ects = (
    r'(?:Punkty +ECTS +obowiązkowe: *(?P<ects_mandatory>\d+))',
    r'(?:Punkty +ECTS +pozostałe: *(?P<ects_other>\d+))',
    r'(?:Razem +punkty +ECTS: *(?P<ects_total>\d+))',
    r'(?:Uzyskane punkty ECTS: *(?P<ects_attained>\d+))'
)

_rg_ects_line = re.compile(r'(?:%s)' % '|'.join(_rl_ects))

_rg_pagination = r'(?P<pagination>(?P<sheet_page_number>\d+) {,1}/ {,1}(?P<sheet_pages_total>\d+))'
_rg_generator_name = r"(?P<generator_name>[\w']+(?: {1,2}[\w']+)*)"
_rg_generator_home = r'(?P<generator_home>(?:https?://)?(?:\w+(?:\.\w+)*)\.(?:com|org|pl|eu))'
_rg_generator = r'(?P<generator>%s, {,2}%s)' % (_rg_generator_name, _rg_generator_home)
_rg_generator_line = r'(?P<generator_line>Wygenerowano z użyciem %s)' % _rg_generator


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
