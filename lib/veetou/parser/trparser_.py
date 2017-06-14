# -*- coding: utf8 -*-
"""`veetou.parser.thparser_`

Provides the TrParser class
"""

from . import parser_
from . import parsererror_
from ..input import InputLine

import re

__all__ = ('TrParser',)

class TrParser(parser_.Parser):

    __slots__ = ()

    @property
    def prefixed_table(self):
        return '%strs' % self.prefix

    @property
    def prefixed_endpoint(self):
        return '%str' % self.prefix

    @property
    def td_patterns(self):
        raise NotImplementedError('this property must be implemented in a subclass')

    @property
    def colspans(self):
        raise NotImplementedError('this property must be implemented in a subclass')

    def lookahead_match(self, string):
        return bool(string.strip())

    def lookahead(self, iterator):
        tmp = iterator.state()
        for line in iterator:
            if not self.lookahead_match(line):
                iterator.restore(tmp)
                return
            tmp = iterator.state()
            yield line

    def colsplit(self, line):
        return tuple( InputLine(line[beg:end].strip(), line.loc()) \
                      for beg, end in self.colspans )

    def parse_tr_tds(self, line, tr, kw, lines=None):
        data = dict()
        patterns = self.td_patterns
        for i in range(0, len(tr)):
            m = re.fullmatch(patterns[i], tr[i])
            if not m:
                dsc = 'syntax error in table column no. %d (tr[%d]=%s, tr=%s)' % \
                      (i+1, i+1, repr(tr[i]), repr(tr))
                self.errors.append(parsererror_.ParserError(line, dsc, lines))
                return False
            data.update(m.groupdict())
        kw.update(data)
        return True

    def append_tr_tds(self, tr, cs):
        if not tr:
            tr[:] = cs
        else:
            for i in range(0, len(cs)):
                if cs[i]:
                    if tr[i]:
                        tr[i] = r'%s %s' % (tr[i], cs[i])
                    else:
                        tr[i] = cs[i]

    def top_aligned_tr_is_top(self, cs):
        return bool(cs[0])

    def mid_aligned_tr_is_mid(self, cs):
        return bool(cs[0])

    def parse_tr_top_aligned(self, iterator, kw):
        """Parses table row (tr) where the contents is "verticaly top-aligned".
        The row always starts at a line having non-empty first column, and the
        following lines with empty first columns are taken as a continuation of
        the tr (this undoes line wrapping within columns)"""
        tr = []
        beg = iterator.state()
        tmp = beg
        lines = []
        for line in self.lookahead(iterator):
            cs = self.colsplit(line)
            if self.top_aligned_tr_is_top(cs): # subsequent virtual row started
                if tr: # but we have previous one "cached"
                    if not self.parse_tr_tds(lines[-1], tr, kw, lines):
                        iterator.restore(beg)
                        return False
                    iterator.restore(tmp)
                    return True
                else:
                    tr = list(cs)
            else: # current virtual row is being continued
                if not tr:
                    dsc = 'first cell in first row is empty (row=%s)' % repr(cs)
                    self.errors.append(parsererror_.ParserError(line, dsc, lines))
                    iterator.restore(tmp)
                    return False
                self.append_tr_tds(tr, cs)
            lines.append(line)
            tmp = iterator.state()

        if tr:
            if not self.parse_tr_tds(lines[-1], tr, kw, lines):
                iterator.restore(beg)
                return False
            else:
                self.parent.next_tbody_parsed()
                return True
        # empty input or so...
        return False

    def parse_tr_mid_aligned(self, iterator, kw):
        """Parses table row (tr) which is "verticaly middle-aligned". The row
        always consists of odd number of lines (1, 3, 5, ..). The middle line
        is recognized as the line having non-empty first column."""
        tr = []
        beg = iterator.state()
        lines = []
        before, mid, after = (0,0,0)
        lookahead = self.lookahead(iterator)
        for line in lookahead:
            lines.append(line)
            cs = self.colsplit(line)
            self.append_tr_tds(tr, cs)
            if self.mid_aligned_tr_is_mid(cs): # this should be middle line
                if mid:
                    dsc = "error parsing table row - %d lines after row's 'middle'" \
                          " line found another 'middle' line" % after
                    self.errors.append(parsererror_.ParserError(line, dsc, lines))
                    iterator.restore(beg)
                    return False
                elif before == 0:
                    # check if it's end of tbody...
                    tmp = iterator.state()
                    try:
                        next(lookahead)
                    except StopIteration:
                        self.parent.next_tbody_parsed()
                    finally:
                        iterator.restore(tmp)
                    return self.parse_tr_tds(line, tr, kw, lines)
                else:
                    mid += 1
            else: # this is a line above or below the mid line
                if mid:
                    after += 1
                else:
                    before += 1
                if before > 3:
                    dsc = "error parsing table row - %d row lines scanned and" \
                          " middle line still not found" % before
                    self.errors.append(parsererror_.ParserError(line, dsc, lines))
                    iterator.restore(beg)
                    return False
                if before == after:
                    # check if it's end of tbody...
                    tmp = iterator.state()
                    try:
                        next(lookahead)
                    except StopIteration:
                        self.parent.next_tbody_parsed()
                    finally:
                        iterator.restore(tmp)
                    return self.parse_tr_tds(line, tr, kw, lines)

        # empty input or so...
        return False

    def parse_tr(self, iterator, kw):
        raise NotImplementedError('this method should be implemented in a subclass')


    def parse_before_children(self, iterator, kw):
        return self.parse_tr(iterator, kw)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
