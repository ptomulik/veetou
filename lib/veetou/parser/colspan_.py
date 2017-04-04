# -*- coding: utf8 -*-
"""`veetou.parser.colspan_`

Provides the Colspan class
"""

__all__ = ('Colspan',)

from ..model import Tuple

import re
import sys

class _default(object): pass

class Colspan(object):
    """Implements our 'colspan' algorithm."""

    __slots__ = (   '_ncols', '_patterns', '_groups', '_spaces', '_initial',
                    '_xpatterns', '_xgroups', '_xspaces' )

    _default_pattern = r'(?P<content>\S+(?: \S+)*)'
    _default_space = r' +'
    _default_leadspace = r' *'
    _default_trailspace = r' *'

    def __init__(self, ncols, patterns=_default, groups=_default,
                 spaces=_default, initial=_default):
        self._init_vars()
        if ncols < 1:
            raise ValueError('ncols must be greater than one (%d<1)' % ncols)
        self._ncols = ncols
        self.spaces = spaces
        self.patterns = patterns
        self.groups = groups
        self.initial = initial

    def _init_vars(self):
        self._spaces = _default
        self._patterns = _default
        self._groups = _default

    @property
    def ncols(self):
        return self._ncols

    @property
    def nspaces(self):
        return 1 + self.ncols

    @property
    def patterns(self):
        """Returns patterns, as set by user (or default list if not set)"""
        if self._patterns is _default:
            return Tuple( self.ncols * (self._default_pattern,) )
        else:
            return self._patterns

    @patterns.setter
    def patterns(self, patterns):
        if patterns is _default:
            self._patterns = _default
        else:
            if len(patterns) != self.ncols:
                raise ValueError("len(patterns) must be %d, not %d" % (self.ncols, len(patterns)))
            self._patterns = Tuple( patterns )
        self.update_xpatterns()

    @property
    def spaces(self):
        if self._spaces is _default:
            return Tuple( (self._default_leadspace,) + \
                          (self.ncols-1) * (self._default_space,) + \
                          (self._default_trailspace,) )
        else:
            return self._spaces

    @spaces.setter
    def spaces(self, spaces):
        if spaces is _default:
            self._spaces = _default
        else:
            if len(spaces) != self.nspaces:
                raise ValueError("len(spaces) must be %d, not %d" % (self.nspaces, len(spaces)))
            self._spaces = Tuple( spaces )
        self.update_xspaces()

    @property
    def groups(self):
        if self._groups is _default:
            return self.extract_groups()
        else:
            return self._groups

    @groups.setter
    def groups(self, groups):
        if groups is _default:
            self._groups = _default
        else:
            if len(groups) != self.ncols:
                raise ValueError("len(groups) must be %d, not %d" % (self.ncols, len(groups)))
            self._groups = Tuple( groups )
        self.update_xgroups()

    @property
    def initial(self):
        if self._initial is _default:
            return self.ncols * ((sys.maxsize,-sys.maxsize),)
        else:
            return self._initial

    @initial.setter
    def initial(self, initial):
        if initial is _default:
            self._initial = _default
        else:
            if len(initial) != self.ncols:
                raise ValueError("len(initial) must be %d, not %d" % (self.ncols, len(initial)))
            self._initial = Tuple( (beg,end) for beg,end in initial )

    def extract_groups(self):
        return Tuple( self.extract_group(i) for i in range(0, self.ncols) )

    def extract_group(self, i):
        m = re.search(r'\(\?P<(?P<key>\w+)>', self.patterns[i])
        if not m:
            msg = ("couldn't determine group name from patterns[%d]" % i) + \
                  (" (the pattern was r%s)" % repr(self._patterns[i]))
            raise RuntimeError(msg)
        return m.group('key')

    @property
    def xspaces(self):
        return self._xspaces

    @property
    def xpatterns(self):
        return self._xpatterns

    @property
    def xgroups(self):
        return self._xgroups

    def update_xspaces(self):
        spaces = self.spaces

        strn = lambda s: '' if s is None else str(s)
        strn2 = lambda t: (strn(t[0]), strn(t[1]))
        prefix = lambda j: r'^' if j==0 else r''
        suffix = lambda j: r'$' if j==self.ncols else r''
        tup2str = lambda s: s if isinstance(s, str) else ' {%s,%s}' % tuple(strn2(s))
        ms = lambda j : r'%s%s%s' % (prefix(j), tup2str(spaces[j]), suffix(j))

        self._xspaces = Tuple( ms(j) for j in range(0, self.nspaces) )
        self.update_xpatterns()

    def update_xpatterns(self):
        mspaces, patterns = (self.xspaces, self.patterns)
        mp = lambda i : r'%s%s(?:(?:%s)|(?:$))' % (mspaces[i], patterns[i], mspaces[i+1])
        self._xpatterns = Tuple( re.compile(mp(i)) for i in range(0, self.ncols) )
        self.update_xgroups()

    def update_xgroups(self):
        self._xgroups = Tuple( self.groups )

    def find(self, lines):
        colspans = tuple(map(list, self.initial))
        for iteration in range(0,1):
            for line in lines:
                lm = 0
                for i in range(0,self.ncols):
                    group = self.xgroups[i]
                    pattern = self.xpatterns[i]
                    m = re.match(pattern, line[lm:])
                    if m:
                        s = lm + m.start(group)
                        e = lm + m.end(group)
                        if s < colspans[i][0]: colspans[i][0] = s
                        if e > colspans[i][1]: colspans[i][1] = e
                    #lm = max(colspans[i][1], lm)
                    lm = colspans[i][1]
        return colspans

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
