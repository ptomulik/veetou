# -*- coding: utf8 -*-
"""`veetou.ko.koaddressparser_`

Provides the KoAddressParser class
"""

from ..parser import AddressParser
from ..parser import ParserError
from ..parser import reentrant
from ..parser import ifullmatch

import re

__all__ = ( 'KoAddressParser', )

class KoAddressParser(AddressParser):

    __slots__ = ()

    _re_street = \
        r'(?:(?P<street_prefix>ul\.?|pl\.?) *)?' + \
        r'(?P<street_name>\w+(?: +\w+)*)' + \
        r' +(?P<street_number>\d+(?:(?: *[/-] *\d+)|(?:(?: */ *)?\w+))?)'
    _re_postoffice = \
        r'(?P<postoffice_zip>\d\d *- *\d\d\d)' + \
        r' +(?P<postoffice_town>\w+(?:(?: +| *- *)\w+){,2})'
    _re_edifice = \
        r'(?P<edifice>(?:[Gg]mach|[Bb]udynek)(?: +\w+)(?:(?:(?: +)|(?: ?- ?))\w+)*)'
    _re_room = \
        r'(?P<room>(?:p\.?|pok\.?)? *\d+)'
    _re_website = \
        r'(?P<website>(?:https?://)?(?:\w+(?:\.\w+)*)\.(?:com|org|pl|eu))'

    _re_0 = re.compile(r'(?P<address>' + r', *'.join((_re_street, _re_postoffice, _re_edifice, _re_room)) + r')')
    _re_1 = re.compile(r'(?P<address>' + r', *'.join((_re_street, _re_room, _re_postoffice, _re_website)) + r')')

    _alternatives = (_re_0, _re_1)

    @property
    def table(self):
        return self.prefixed_table

    @property
    def endpoint(self):
        return self.prefixed_address

    def match_before_children(self, iterator, **kw):
        for pattern in self._alternatives:
            if reentrant(ifullmatch, iterator, pattern, strip=True, **kw):
                return True
        return False

    def parse_before_children(self, iterator, kw):
        if not self.match_before_children(iterator, groupdict = kw):
            dsc = 'syntax error in address info'
            self.errors.append(ParserError(iterator, dsc))
            return False
        return True

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
