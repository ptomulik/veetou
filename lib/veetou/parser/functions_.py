# -*- coding: utf8 -*-
"""`veetou.parser.functions_`

Useful functions for parser
"""

import re
import sys
import itertools

__all__ = (
    'dictmatcher',
    'fullmatch',
    'fullmatchdict',
    'ifullmatch',
    'ilookahead',
    'imatch',
    'imatcher',
    'match',
    'matchdict',
    'matcher',
    'permutexpr',
    'reentrant',
    'scatter',
    'search',
    'searchpd',
    'skipemptyiter'
)

_re_empty = re.compile(r'\s*')

class _PDMatch(object):
    def __init__(self, key, match):
        self.key = key
        self.match = match

# Adds some convenient arguments to fullmatch(), match(), search(), etc.
def matcher(func):
    def wrapper(pattern, string, flags = 0, **kw):
        if kw.get('strip', False):
            string = string.strip()
        m = func(pattern, string, flags)
        if m and 'groupdict' in kw:
            f = lambda x : x[1] is not None
            kw['groupdict'].update(filter(f,  m.groupdict().items()))
        return m
    return wrapper

def imatcher(func):
    def wrapper(iterator, pattern, *args, **kw):
        unwrap = int(kw.get('unwrap', 0))
        try:
            string = next(iterator)
        except StopIteration:
            return False
        m = func(pattern, string, *args, **kw)
        if not m:
            unwrap_sep = kw.get('unwrap_sep', '')
            unwrap_lstrip = kw.get('unwrap_lstrip', True)
            unwrap_rstrip = kw.get('unwrap_rstrip', False)
            for i in range(0,unwrap):
                try:
                    tail = next(iterator)
                except StopIteration:
                    return False
                left = string if not unwrap_rstrip else string.rstrip()
                right = tail if not unwrap_lstrip else tail.lstrip()
                string = unwrap_sep.join((left, right))
                m = func(pattern, string, *args, **kw)
                if m: break
        return m
    return wrapper

# Matches string against a dict of patterns
def dictmatcher(func):
    def wrapper(patterns, string, flags = 0, **kw):
        for key, pattern in patterns.items():
            m = func(pattern, string, flags, **kw)
            if m:
                return _PDMatch(key, m)
        return None
    return wrapper

@matcher
def fullmatch(pattern, string, flags = 0, **kw):
    return re.fullmatch(pattern, string, flags)

@matcher
def search(pattern, string, flags = 0, **kw):
    return re.search(pattern, string, flags)

@matcher
def match(pattern, string, flags = 0, **kw):
    return re.match(pattern, string, flags)


@dictmatcher
def fullmatchdict(pattern, string, flags = 0, **kw):
    return fullmatch(pattern, string, flags, **kw)

@dictmatcher
def matchdict(pattern, string, flags = 0, **kw):
    return match(pattern, string, flags, **kw)

@dictmatcher
def searchpd(pattern, string, flags = 0, **kw):
    return search(pattern, string, flags, **kw)

def reentrant(parser, iterator, *args, **kw):
    tmp = iterator.state()
    result = parser(iterator, *args, **kw)
    if not result: iterator.restore(tmp)
    return result

@imatcher
def imatch(pattern, string, *args, **kw):
    return match(pattern, string, *args, **kw)

@imatcher
def ifullmatch(pattern, string, *args, **kw):
    return fullmatch(pattern, string, *args, **kw)

def ilookahead(iterator, criterion, maxcount=sys.maxsize):
    if maxcount <= 0:
        return
    count = 0
    tmp = iterator.state()
    for line in iterator:
        if count >= maxcount or not criterion(line):
            iterator.restore(tmp)
            return
        tmp = iterator.state()
        yield line
        count += 1

def skipemptyiter(iterator, maxcount=sys.maxsize):
    if maxcount <= 0:
        return None
    tmp = iterator.state()
    count = 0
    for string in iterator:
        if count >= maxcount or not re.fullmatch(_re_empty, string):
            iterator.restore(tmp)
            return string
        count += 1
        tmp = iterator.state()
    return None

def permutexpr(pieces, nmin=1, nmax=None, space=r' +', op=r'|'):
    if nmax is None: nmax = len(pieces)
    alternatives = []
    for n in range(nmin,nmax+1):
        for perm in itertools.permutations(pieces, n):
            alternatives.append(r'(?:' + space.join(perm) + ')')
    return op.join(alternatives)

def scatter(string, charspaces = 1):
    charsep = r' {,%d}' % charspaces
    wordsep = r' +'
    return wordsep.join([ charsep.join(x) for x in string.split() ])

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
