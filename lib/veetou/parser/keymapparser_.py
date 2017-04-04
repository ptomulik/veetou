# -*- coding: utf8 -*-
"""`veetou.parser.keymapparser_`

Provides the KeyMapParser class
"""

from . import parsererror_
from . import functions_

import re

__all__ = ('KeyMapParser',)

_re_id = r'(?:[^\d\W]\w*)'
_re_key = '(?:%s(?:\.%s)?)' % (_re_id, _re_id)
_rg_item = re.compile(r'(?P<left>%s)\s*:\s*(?P<right>%s)' % (_re_key,_re_key))
_re_empty = re.compile(r'(?:#.*)?')

class KeyMapParser(object):

    __slots__ = ('_errors', '_result')

    def __init__(self):
        self._errors = []
        self._result = None

    @property
    def errors(self):
        return self._errors

    @property
    def result(self):
        return self._result

    def parse(self, iterator, **kw):
        self._result = []
        tmp = iterator.state()
        for line in iterator:
            groupdict = dict()
            if functions_.fullmatch(_re_empty, line, strip=True):
                pass
            else:
                if not functions_.fullmatch(_rg_item, line, strip=True, groupdict=groupdict):
                    dsc = 'syntax error'
                    self.errors.append(parsererror_.ParserError(line, dsc))
                    iterator.restore(tmp)
                    return False
                self._result.append( (groupdict['left'], groupdict['right']) )
            tmp = iterator.state()
        return True

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
