# -*- coding: utf8 -*-

import re
import sys
import collections

class Map(collections.MutableMapping):
    def __init__(self, keyname = None, valuenames = None):
        self.keyname = keyname
        self._values = dict()
        self.valuenames = []
        self.extend(valuenames or [])

    def extend(self, valuenames):
        self._leftmargin = len(self.valuenames)
        self.valuenames.extend(valuenames)

    def setrow(self, key, values):
        if not key in self._values:
            self._values[key] = dict()
        beg = self._leftmargin
        end = min(len(self.valuenames), beg+len(values))
        self._values[key].update({ self.valuenames[i]:values[i-beg] for i in range(beg,end) })

    def __getitem__(self, key):
        return self._values[self.__keywrap__(key)]

    def __setitem__(self, key, value):
        self._values[self.__keywrap__(key)] = value

    def __delitem__(self, key):
        del self._values[self.__keywrap__(key)]

    def __iter__(self):
        return iter(self._values)

    def __len__(self):
        return len(self._values)

    def __keywrap__(self, key):
        return key

    def __repr__(self):
        return "{keyname: %r, valuenames: %r, values: %r}" % (self.keyname, self.valuenames, self._values)

    def copy(self):
        m = Map(self.keyname, self.valuenames)
        m.update(self._values)
        return m


class Maps(collections.MutableMapping):

    # Contexts
    C_TOP = 0
    C_COLNAMES = 1

    _re_empty = re.compile(r'^[ \t]*$')
    _re_comment = re.compile(r'^[ \t]*#')
    _re_colnames = re.compile(r'^[ \t]*#+[ \t]*\\colnames[ \t]*$')
    _re_colname = re.compile(r'^[ \t]*#+[ \t]*(?P<field>\w+)[ \t]*:[ \t]*(?P<column>[^\s#]+(?:[ \t]+[^\s#]+)*)[ \t]*$')
    _re_endcolnames = re.compile(r'^[ \t]*#[ \t]*\\endcolnames[\t ]*$')
    _re_header = re.compile(r'^[ \t]*(?P<keyname>\w+)(?P<separator>\W)(?P<valuenames>(?:\w+(?:(?P=separator)\w+)*))[ \t]*$')

    def __init__(self, **kw):
        self.reset(**kw)

    def __getitem__(self, key):
        return self._maps[self.__keywrap__(key)]

    def __setitem__(self, key, value):
        self._maps[self.__keywrap__(key)] = value

    def __delitem__(self, key):
        del self._maps[self.__keywrap__(key)]

    def __iter__(self):
        return iter(self._maps)

    def __len__(self):
        return len(self._maps)

    def __keywrap__(self, key):
        return key

    def __repr__(self):
        return "{colnames: %r, maps: %r}" % (self.colnames, self._maps)

    def copy(self):
        m = Maps(colnames = self.colnames)
        m.update(self._maps)
        return m

    def reset(self, **kw):
        self.colnames = kw.get('colnames', dict())
        self._maps = dict()
        self.reset_parser()

    def reset_parser(self, **kw):
        self._stack = [ Maps.C_TOP ]
        self.keyname = None
        self.separator = None
        self._header_parsed = False
        self._re_row = None

    def _context(self):
        return self._stack[-1]

    def _push_context(self, state):
        return self._stack.append(state)

    def _pop_context(self):
        return self._stack.pop()

    def _try_empty(self, line):
        m = self._re_empty.match(line)
        return m

    def _try_comment(self, line):
        m = self._re_comment.match(line)
        return m

    def _try_colname(self, line):
        m = self._re_colname.match(line)
        if m:
            self.colnames[m.group('field')] =  m.group('column')
        return m

    def _try_colnames(self, line):
        m = self._re_colnames.match(line)
        if m:
            self._push_context(Maps.C_COLNAMES)
        return m

    def _try_endcolnames(self, line):
        m = self._re_endcolnames.match(line)
        if m:
            self._pop_context()
        return m

    def _try_header(self, line):
        m = self._re_header.match(line)
        if m:
            self._header_parsed = True
            s =  m.group('separator')
            self.separator = s
            self.keyname = m.group('keyname')
            valuenames = m.group('valuenames').split(s)
            self._re_row = re.compile(
                r'^(?P<key>[^' + s + r']*)' +
                r'(?P<values>(?:' + s + r'[^' + s + r']*){' + str(len(valuenames)) + r'})$'
            )
            if not self.keyname in self:
                self[self.keyname] = Map(self.keyname, valuenames)
            else:
                self[self.keyname].extend(valuenames)
        return m

    def _try_row(self, line):
        m = self._re_row.match(line)
        if m:
            values = line.split(self.separator)
            key = values.pop(0)
            self[self.keyname].setrow(key, values)
        return m

    def parse(self, lines, **kw):
        self.reset_parser(**kw)

        fname = kw.get('file', '-')

        i = 1
        for line in lines:
            context = self._context()
            m = None
            if context == Maps.C_COLNAMES:
                m = self._try_endcolnames(line)
                if not m:
                    m = self._try_colname(line)
                if not m:
                    sys.stderr.write("%s\n" % line)
                    sys.stderr.write("%s:%d:warning: expected field:column or \\endcolnames\n" % (fname,i))
            else:
                m = self._try_empty(line)
                if not m:
                    m = self._try_colnames(line)
                if not m:
                    m = self._try_comment(line)
                if not m:
                    if not self._header_parsed:
                        if not m:
                            m = self._try_header(line)
                        if not m:
                            sys.stderr.write("%s\n" % line)
                            sys.stderr.write("%s:%d:warning: expected header row with fields definition\n" % (fname,i))
                    else:
                        m = self._try_row(line)
                        if not m:
                            sys.stderr.write("%s\n" % line)
                            sys.stderr.write("%s:%d:warning: expected row of values separated with '%s'\n" % (fname,i,self.separator))
            i += 1



# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
