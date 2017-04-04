# -*- coding: utf8 -*-
"""`veetou.pz.pzcontactparser_`

Provides the PzContactParser classs
"""

from ..parser import ContactParser
from ..parser import ParserError
from ..parser import reentrant
from ..parser import ifullmatch

import re

__all__ = ( 'PzContactParser', )

class PzContactParser(ContactParser):

    __slots__ = ()

    _re_phone_prefix = r'(?P<phone_prefix>tel\.:?)'
    _re_phone_number = r'(?:\(\+?\d{2,3}\))?(?: {,1}\d{1,3})+'
    _re_phone_numbers = r'(?P<phone_numbers>(?:' + \
                            _re_phone_number + \
                            r')(?:, *' + \
                            _re_phone_number + \
                        r')*)'
    _re_phone = r'(?P<phone>' + _re_phone_prefix + \
                r' *' + _re_phone_numbers + r')'
    _re_faxtel_prefix  = r'(?P<faxtel_prefix>fax(?: {0,1}/ {0,1}tel)?\.:?)'
    _re_faxtel_number  = r'(?:\(\+?\d{2,3}\))?(?: {,1}\d{1,3})+'
    _re_faxtel_numbers = r'(?P<faxtel_numbers>(?:' + \
                                    _re_faxtel_number + \
                                    r')(?:, *' + \
                                    _re_faxtel_number + \
                                     r')*)'

    _re_faxtel = \
        r'(?P<faxtel>' + _re_faxtel_prefix + \
        r' *' + _re_faxtel_numbers + r')'

    _re_email_prefix = r'(?P<email_prefix>(?:e-?mail:))'
    _re_email_address_localpart = r'(?P<email_address_localpart>[a-zA-Z0-9_.+-]+)'
    _re_email_address_domain = r'(?P<email_address_domain>[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)'
    _re_email_address = \
        r'(?P<email_address>' + \
        _re_email_address_localpart + r'@' + \
        _re_email_address_domain + r')'

    _re_email = \
        r'(?P<email>' + \
        _re_email_prefix + r' *' + \
        _re_email_address + \
        r')'

    _re_contact = re.compile(
        r'(?P<contact>' + \
            _re_phone + \
            r'(?:, *' + _re_faxtel + r')?' + \
            r', *' + _re_email + \
        r')')

    @property
    def table(self):
        return 'contacts'

    @property
    def endpoint(self):
        return 'contact'

    def match_before_children(self, iterator, **kw):
        if reentrant(ifullmatch, iterator, self._re_contact, strip=True, **kw):
            return True
        return False

    def parse_before_children(self, iterator, kw):
        if not self.match_before_children(iterator, groupdict = kw):
            dsc = 'syntax error in contact info'
            self.errors.append(ParserError(iterator, dsc))
            return False
        return True

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
