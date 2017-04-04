#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.input.pdftextlines_ as pdftextlines_
import veetou.input.popenlines_ as popenlines_

class Test__PdfTextLines(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(pdftextlines_.PdfTextLines, popenlines_.PopenLines))

    # TODO: write tests

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
