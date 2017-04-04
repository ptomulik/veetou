# -*- coding: utf8 -*-
"""`veetou.pz.pzheaderparser_`

Provides PzHeaderParser class
"""

from . import pzaddressparser_
from . import pzcontactparser_

from ..parser import HeaderParser
from ..parser import skipemptyiter
from ..parser import fullmatchdict
from ..parser import scatter
from ..parser.patterns_ import _rd_university
from ..parser.patterns_ import _rd_faculty
from ..parser.patterns_ import _rd_contact_name

import re

__all__ = ( 'PzHeaderParser', )

class PzHeaderParser(HeaderParser):

    __slots__ = ('_address_parser', '_contact_parser')

    def __init__(self, **kw):
        address_parser = pzaddressparser_.PzAddressParser(parent = self)
        contact_parser = pzcontactparser_.PzContactParser(parent = self)
        super().__init__((address_parser, contact_parser), **kw)
        self._address_parser = address_parser
        self._contact_parser = contact_parser

    @property
    def address_parser(self):
        return self._address_parser

    @property
    def contact_parser(self):
        return self._contact_parser

    _seq1 = (('university', _rd_university), ('faculty', _rd_faculty))

    def match_before_children(self, iterator, **kw):
        for key, rd in self._seq1:
            tmp = iterator.state()
            m = fullmatchdict(rd, next(iterator), strip=True, **kw)
            if not m:
                iterator.restore(tmp)
                return False
            if 'groupdict' in kw:
                kw['groupdict'][key] = m.key
        tmp = iterator.state()
        m = fullmatchdict(_rd_contact_name, next(iterator), strip=True, **kw)
        if not m: # contact name is optional...
            iterator.restore(tmp)
        elif 'groupdict' in kw:
            kw['groupdict']['contact_name'] = m.key
        return True

    def parse_before_children(self, iterator, kw):
        return self.match_before_children(iterator, groupdict = kw)

    def parse_address(self, iterator, kw):
        return self.address_parser.parse(iterator)

    def parse_contact(self, iterator, kw):
        return self.contact_parser.parse(iterator)

    def parse_with_children(self, iterator, kw):
        skipemptyiter(iterator)
        if not self.parse_address(iterator, kw):
            return False
        if not self.parse_contact(iterator, kw):
            return False
        return True

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
