# -*- coding: utf8 -*-
"""`veetou.ko.kothparser_`

Provides the KoThParser class
"""

from ..parser import ThParser
from ..parser import reentrant
from ..parser import ifullmatch
#from ..parser import permutexpr

import re

__all__ = ( 'KoThParser', )

_rl_th = [
    r'(?P<th_0>Wymiar {1,4}godzin {6,}Forma)',
    r'(?P<th_1>Nr {1,4}katalogowy {6,}Nazwa przedmiotu {40,}ECTS {6,}Prowadzący {4,}Ocena {4,}Data)',
    r'(?P<th_2>W {3,}C {3,}L {3,}P {3,}S {3,}zalicz:)'
]

class KoThParser(ThParser):

    __slots__ = ()


    def match(self, iterator, **kw):
        optional = ()
        if 'groupdict' not in kw:
            kw['groupdict'] = dict()
        for i in range(len(_rl_th)):
            if not reentrant(ifullmatch, iterator, _rl_th[i], strip=True, **kw) \
               and i not in optional:
                return False
        return True

    def parse(self, iterator, **kw):
        return self.match(iterator)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
