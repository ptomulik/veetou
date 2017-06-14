# -*- coding: utf8 -*-
"""`veetou.parser.contactparser_`

Provides the ContactParser class
"""

from . import parser_

__all__ = ('ContactParser',)

class ContactParser(parser_.Parser):

    @property
    def prefixed_table(self):
        return '%scontacts' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%scontact' % self.prefix

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
