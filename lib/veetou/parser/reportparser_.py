# -*- coding: utf8 -*-
"""`veetou.parser.reportparser_`

Provides the ReportParser class
"""

from . import parser_
from . import functions_

from ..input import BufferedIterator
from ..common import checkinstance

import abc

__all__ = ('ReportParser', )

class ReportParser(parser_.RootParser):
    """An abstract base class for report parsers"""

    __slots__ = ('_sheet_parser', '_sheets_parsed', '_pages_parsed', '_first_page')

    def __init__(self, disable_datamodel = False, **kw):
        self.reset()
        sheet_parser = self.create_sheet_parser(parent = self)
        self._sheet_parser = sheet_parser
        super().__init__((sheet_parser,), self.create_datamodel(), disable_datamodel, **kw)

    @abc.abstractmethod
    def create_datamodel(self, **kw):
        pass

    @abc.abstractmethod
    def create_sheet_parser(self, **kw):
        pass

    @property
    def sheet_parser(self):
        return self._sheet_parser

    @property
    def sheets_parsed(self):
        """Return the number of sheets parsed so far"""
        return self._sheets_parsed

    @property
    def pages_parsed(self):
        """Return the number of report pages parsed so far"""
        return self._pages_parsed

    @property
    def first_page(self):
        return self._first_page

    @property
    def prefixed_table(self):
        return '%sreports' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%sreport' % self.prefix

    def next_sheet_parsed(self):
        """Use this method from a child parser to notify root that next report
        sheet was successfully parsed"""
        self._sheets_parsed += 1

    def next_page_parsed(self):
        """Use this method from a child parser to notify root that next report
        page was successfully parsed"""
        self._pages_parsed += 1

    def parse_before_children(self, iterator, kw):
        checkinstance(iterator, BufferedIterator)

        self.reset(iterator, kw)

        if functions_.skipemptylines(iterator):
            if not self.parse_before_sheets(iterator, kw):
                return False
        return True

    def parse_with_children(self, iterator, kw):
        if not self.parse_sheets(iterator, kw):
            return False
        kw['sheets_parsed'] = self.sheets_parsed
        kw['pages_parsed'] = self.pages_parsed
        return True

    def parse_after_children(self, iterator, kw):
        return self.parse_after_sheets(iterator, kw)

    def reset(self, iterator=None, kw=None):
        """Reset parser from __init__() or parse()"""
        self._sheets_parsed = 0
        self._pages_parsed = 0
        self._first_page = self._determine_first_page(iterator, kw)


    def parse_before_sheets(self, iterator, kw):
        """This method may be overriden in a subclass"""
        return True

    def parse_sheets(self, iterator, kw):
        while functions_.skipemptylines(iterator):
            if not self.sheet_parser.parse(iterator):
                return False
            self.next_sheet_parsed()
            iterator.drop()
        return True

    def parse_after_sheets(self, iterator, kw):
        """This method may be overriden in a subclass"""
        return True

    def _determine_first_page(self, iterator=None, kw=None):
        if kw is not None and 'first_page' in kw:
            first_page = kw['first_page']
        elif iterator is not None:
            ctx = iterator.loc()
            try:
                first_page = ctx.page
            except AttributeError:
                first_page = 1
        else:
            first_page = 1
        if kw is not None:
            kw['first_page'] = first_page
        return first_page


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
