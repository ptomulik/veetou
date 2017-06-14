# -*- coding: utf8 -*-
"""`veetou.ko.kofooterparser_`

Parser for parsing ko (Protokol Zaliczen) documents
"""

from ..parser import patterns_
from ..parser import FooterParser
from ..parser import ParserError
from ..parser import reentrant
from ..parser import ifullmatch

from ..parser.patterns_ import _rg_subj_name
from ..parser.patterns_ import _rg_subj_code
from ..parser.patterns_ import _rg_sheet_id

from .kopatterns_ import _rg_pagination
from .kopatterns_ import _rg_generator_line

import re

__all__ = ( 'KoFooterParser', )

class KoFooterParser(FooterParser):

    __slots__ = ('_data')

    _seq1 = ( re.compile(_rg_pagination), re.compile(_rg_generator_line) )

    @property
    def data(self):
        return self._data

    @property
    def table(self):
        return self.prefixed_table

    @property
    def endpoint(self):
        return self.prefixed_endpoint

    def match_before_children(self, iterator, **kw):
        for pattern in self._seq1:
            if not reentrant(ifullmatch, iterator, pattern, strip=True, **kw):
                return False
        return True

    def parse_before_children(self, iterator, kw):
        tmp = iterator.state()
        self._data = dict()
        if not self.match_before_children(iterator, groupdict = kw):
            if iterator.state() != tmp:
                # if we've seen some initial lines of the footer
                dsc = 'syntax error in page footer'
                self.errors.append(ParserError(iterator, dsc))
            return False
        self._data.update(kw)
        return True


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
