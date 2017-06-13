#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.input.inputloc_ as inputloc_

class Test__InputLoc(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(inputloc_.InputLoc, object))

    def test__init__1(self):
        ctx = inputloc_.InputLoc('foo.pdf', 20)
        self.assertEqual(ctx.name, 'foo.pdf')
        self.assertEqual(ctx.line, 20)

    def test__logstr__1(self):
        ctx = inputloc_.InputLoc('foo.pdf', 20)
        self.assertEqual(ctx.__logstr__(), 'foo.pdf:20')

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
