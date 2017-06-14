"""`veetou.parser.tbodyparser_`

Provides the TbodyParser class
"""

from . import parser_
from ..input import InputLine

import abc
import sys
import re

__all__ = ('TbodyParser',)

class TbodyParser(parser_.Parser):

    __slots__ = ('_tr_parser', '_tbody_complete')

    def __init__(self, **kw):
        self._tr_parser = self.create_tr_parser(parent = self)
        self._tbody_complete = False
        super().__init__((self._tr_parser,), **kw)

    @property
    def tr_parser(self):
        return self._tr_parser

    @property
    def tbody_complete(self):
        return self._tbody_complete

    def next_tbody_parsed(self):
        self._tbody_complete = True

    @abc.abstractmethod
    def create_tr_parser(self, **kw):
        pass

    @property
    def prefixed_table(self):
        return '%stbodies' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%stbody' % self.prefix

    def match_tbody_line(self, string):
        return bool(string.strip())

    def lookahead(self, iterator):
        yield from self.tr_parser.lookahead(iterator)

    def find_colspans(self, iterator, colspan_finder):
        tmp = iterator.state()
        lines = list(self.lookahead(iterator))
        iterator.restore(tmp)
        return colspan_finder.find(lines)

    def parse_tr(self, iterator, kw):
        return self.tr_parser.parse(iterator)

    def parse_with_children(self, iterator, kw):
        while not self.tbody_complete:
            if not self.parse_tr(iterator, kw):
                return False
        return True

    def parse(self, iterator, **kw):
        self._tbody_complete = False
        return super().parse(iterator, **kw)


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
