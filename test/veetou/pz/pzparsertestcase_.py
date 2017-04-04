#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest

class PzParserTestCase(unittest.TestCase):
    def assertRegexFullMatch(self, s, r, msg=None):
        try: p = r.pattern
        except AttributeError: p = r
        try: f = r.flags
        except AttributeError: f = 0
        if not p.startswith('^') and not p.startswith(r'\A'):
            p = r'\A' + p
        if not p.endswith('$') and not p.endswith(r'\Z'):
            p = p + r'\Z'
        r = re.compile(p, f)
        self.assertRegex(s, r, msg)

    def mkInputLines(self, strings):
        return inputlines_.InputLines(io.StringIO('\n'.join(strings)))

    def mkBufferedIterator(self, strings):
        return pzreportparser_.BufferedIterator(self.mkInputLines(strings))

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
