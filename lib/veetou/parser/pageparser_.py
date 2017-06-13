# -*- coding: utf8 -*-
"""`veetou.parser.pageparser_`

Provides the PageParser class
"""

from . import parser_
from . import parsererror_
from . import functions_

import abc

__all__ = ('PageParser',)

class PageParser(parser_.Parser):

    __slots__ = (   '_header_parser',
                    '_footer_parser',
                    '_preamble_parser',
                    '_table_parser',
                    '_summary_parser'   )

    def __init__(self, **kw):
        header = self.create_header_parser(parent = self)
        footer = self.create_footer_parser(parent = self)
        preamble = self.create_preamble_parser(parent = self)
        table = self.create_table_parser(parent = self)
        summary = self.create_summary_parser(parent = self)

        super().__init__((header, footer, preamble, table, summary), **kw)

        self._header_parser = header
        self._footer_parser = footer
        self._preamble_parser = preamble
        self._table_parser = table
        self._summary_parser = summary

    @abc.abstractmethod
    def create_header_parser(self, **kw):
        pass

    @abc.abstractmethod
    def create_footer_parser(self, **kw):
        pass

    @abc.abstractmethod
    def create_preamble_parser(self, **kw):
        pass

    @abc.abstractmethod
    def create_table_parser(self, **kw):
        pass

    @abc.abstractmethod
    def create_summary_parser(self, **kw):
        pass

    @property
    def header_parser(self):
        return self._header_parser

    @property
    def footer_parser(self):
        return self._footer_parser

    @property
    def table_parser(self):
        return self._table_parser

    @property
    def preamble_parser(self):
        return self._preamble_parser

    @property
    def summary_parser(self):
        return self._summary_parser

    @property
    def table(self):
        return 'pages'

    @property
    def endpoint(self):
        return 'page'

    def parse_before_sections(self, iterator, kw):
        """This method may be overriden in a subclass"""
        return True

    def parse_after_sections(self, iterator, kw):
        """This method may be overriden in a subclass"""
        return True

    def parse_header(self, iterator, kw):
        return self.header_parser.parse(iterator)

    def parse_preamble(self, iterator, kw):
        return self.preamble_parser.parse(iterator)

    def parse_table(self, iterator, kw):
        return self.table_parser.parse(iterator)

    def parse_summary(self, iterator, kw):
        return self.summary_parser.parse(iterator)

    def parse_footer(self, iterator, kw):
        return self.footer_parser.parse(iterator)

    def expecting_header(self):
        return True

    def expecting_preamble(self):
        return True

    def expecting_table(self):
        return True

    def expecting_footer(self):
        return True

    def expecting_summary(self):
        return True

    def header_optional(self):
        return False

    def preamble_optional(self):
        return False

    def table_optional(self):
        return False

    def footer_optional(self):
        return False

    def summary_optional(self):
        return False

    def parse_before_children(self, iterator, kw):
        if self.parent.sheet_complete:
            raise RuntimeError("can't parse more pages, sheet parser need to be reset")

        ctx = iterator.loc()
        try:
            kw['page_number'] = ctx.page
        except AttributeError:
            pass
        kw['parser_page_number'] = self.root.first_page + self.root.pages_parsed

        if not self.parse_before_sections(iterator, kw):
            return False
        return True

    def parse_section(self, iterator, kw, parser, optional, what):
        tmp = iterator.state()
        if not parser(iterator, kw):
            if iterator.state() == tmp:
                if optional:
                    return True
                dsc = 'syntax error at the begining of (expected) %s' % what
            else:
                dsc = 'syntax error in %s' % what
            self.errors.append(parsererror_.ParserError(iterator, dsc))
            return False
        return True

    def parse_with_children(self, iterator, kw):
        if self.expecting_header():
            args = (self.parse_header, self.header_optional(), 'page header')
            if not self.parse_section(iterator, kw, *args):
                return False

        if self.expecting_preamble():
            functions_.skipemptylines(iterator)
            args = (self.parse_preamble, self.preamble_optional(), 'page preamble')
            if not self.parse_section(iterator, kw, *args):
                return False

        if self.expecting_table():
            functions_.skipemptylines(iterator)
            args = (self.parse_table, self.table_optional(), 'table')
            if not self.parse_section(iterator, kw, *args):
                return False

        if self.expecting_summary():
            functions_.skipemptylines(iterator)
            args = (self.parse_summary, self.summary_optional(), 'summary')
            if not self.parse_section(iterator, kw, *args):
                return False

        if self.expecting_footer():
            functions_.skipemptylines(iterator)
            args = (self.parse_footer, self.footer_optional(), 'page footer')
            if not self.parse_section(iterator, kw, *args):
                return False

        return True

    def parse_after_children(self, iterator, kw):
        return self.parse_after_sections(iterator, kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
