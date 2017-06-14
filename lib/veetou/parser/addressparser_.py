# -*- coding: utf8 -*-
"""`veetou.parser.addressparser_`

Provides the AddressParser class
"""

from . import parser_

__all__ = ('AddressParser',)

class AddressParser(parser_.Parser):

    @property
    def prefixed_table(self):
        return '%saddresses' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%saddress' % self.prefix

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
