# -*- coding: utf8 -*-
"""`veetou.ko.koheaderparser_`

Provides KoHeaderParser class
"""

from . import koaddressparser_
from . import kocontactparser_

from ..parser import HeaderParser
from ..parser import skipemptylines
from ..parser import fullmatchdict
from ..parser import scatter
from ..parser import reentrant
from ..parser import ifullmatch
from ..parser.patterns_ import _rd_university
from ..parser.patterns_ import _rd_faculty
from ..parser.patterns_ import _rd_contact_name

import re

__all__ = ( 'KoHeaderParser', )

_rg_studies_modetier = r'(?P<studies_modetier>Studia(?: +\S+)+)'

class KoHeaderParser(HeaderParser):

    _seq1 = (('faculty', _rd_faculty), ('university', _rd_university))

    def match_before_children(self, iterator, **kw):
        for key, rd in self._seq1:
            tmp = iterator.state()
            m = fullmatchdict(rd, next(iterator), strip=True, **kw)
            if not m:
                iterator.restore(tmp)
                return False
            if 'groupdict' in kw:
                kw['groupdict'][key] = m.key
        return True

    def parse_before_children(self, iterator, kw):
        return self.match_before_children(iterator, groupdict = kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
