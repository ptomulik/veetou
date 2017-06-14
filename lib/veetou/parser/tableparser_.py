# -*- coding: utf8 -*-
"""`veetou.parser.tableparser_`

Provides the TableParser class
"""

from . import parser_
from . import parsererror_

import abc

__all__ = ('TableParser', )

class TableParser(parser_.Parser):

    __slots__ = (   '_th_parser',
                    '_tbody_parser'  )

    def __init__(self, **kw):
        th_parser = self.create_th_parser(parent = self)
        tbody_parser = self.create_tbody_parser(parent = self)
        super().__init__((th_parser, tbody_parser), **kw)
        self._th_parser = th_parser
        self._tbody_parser = tbody_parser

    @abc.abstractmethod
    def create_th_parser(self, **kw):
        pass

    @abc.abstractmethod
    def create_tbody_parser(self, **kw):
        pass

    @property
    def prefixed_table(self):
        return '%stables' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%stable' % self.prefix

    @property
    def th_parser(self):
        return self._th_parser

    @property
    def tbody_parser(self):
        return self._tbody_parser

    def parse_th(self, iterator, kw):
        return self.th_parser.parse(iterator)

    def parse_tbody(self, iterator, kw):
        return self.tbody_parser.parse(iterator)

    def parse_with_children(self, iterator, kw):
        tmp = iterator.state()
        if not self.parse_th(iterator, kw):
            if iterator.state() != tmp:
                dsc = 'syntax error in table header'
                self.errors.append(parsererror_.ParserError(iterator, dsc))
            return False
        return self.parse_tbody(iterator, kw)


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
