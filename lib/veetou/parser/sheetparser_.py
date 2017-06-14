# -*- coding: utf8 -*-
"""`veetou.parser.sheetparser_`

Provides the SheetParser class
"""

from . import parser_
from . import parsererror_
from . import functions_

import abc

__all__ = ('SheetParser', )

class SheetParser(parser_.Parser):

    __slots__ = ('_page_parser', '_pages_parsed', '_first_page', '_sheet_complete')

    def __init__(self, **kw):
        page_parser = self.create_page_parser(parent=self)
        self._page_parser = page_parser
        super().__init__((page_parser,), **kw)
        self.reset()

    @abc.abstractmethod
    def create_page_parser(self):
        pass

    @property
    def page_parser(self):
        return self._page_parser

    @property
    def pages_parsed(self):
        return self._pages_parsed

    @property
    def first_page(self):
        return self._first_page

    @property
    def sheet_complete(self):
        return self._sheet_complete

    @property
    def prefixed_table(self):
        return '%ssheets' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%ssheet' % self.prefix

    def next_page_parsed(self):
        """This method is invoked by parse() everytime a new page is completed"""
        self._pages_parsed += 1
        self.parent.next_page_parsed()

    def next_sheet_parsed(self):
        """This method is invoked by page_parser everytime a sheet is complete"""
        self._sheet_complete = True

    def parse_before_children(self, iterator, kw):
        self.reset(iterator, kw)

        if not self.parse_before_pages(iterator, kw):
            return False
        return True

    def parse_with_children(self, iterator, kw):
        if not self.parse_pages(iterator, kw):
            return False
        kw['pages_parsed'] = self.pages_parsed
        kw['first_page'] = self.first_page
        return True

    def parse_after_children(self, iterator, kw):
        return self.parse_after_pages(iterator, kw)

    def parse_page(self, iterator, kw):
        return self.page_parser.parse(iterator)

    def parse_pages(self, iterator, kw):
        while not self.sheet_complete and functions_.skipemptylines(iterator):
            if not self.parse_page(iterator, kw):
                return False
            self.next_page_parsed()
        if not self.sheet_complete:
            dsc = 'incomplete sheet'
            self.errors.append(parsererror_.ParserError(iterator, dsc))
            return False
        return True

    def parse_before_pages(self, iterator, kw):
        """This method may be overriden in a subclass"""
        return True

    def parse_after_pages(self, iterator, kw):
        """This method may be overriden in a subclass"""
        return True

    def reset(self, iterator=None, kw=None):
        self._pages_parsed = 0
        self._sheet_complete = False
        self._first_page = self._determine_first_page(iterator, kw)

    def _determine_first_page(self, iterator=None, kw=None):
        if kw is not None and 'first_page' in kw:
            first_page = kw['first_page']
        else:
            first_page = self.parent.first_page + self.parent.pages_parsed
            if kw is not None:
                kw['first_page'] = first_page
        return first_page

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
