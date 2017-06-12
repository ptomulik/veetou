#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.input.inputline_ as inputline_
import veetou.input.inputloc_ as inputloc_

class Test__InputLine(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(inputline_.InputLine, str))

    def test__init__1(self):
        s = inputline_.InputLine()
        self.assertEqual(s, '')
        self.assertIsNone(s.loc())

    def test__init__2(self):
        s = inputline_.InputLine('lorem ipsum')
        self.assertEqual(s, 'lorem ipsum')
        self.assertIsNone(s.loc())

    def test__init__3(self):
        loc = inputloc_.InputLoc('foo.pdf', 12)
        line = inputline_.InputLine('lorem ipsum', loc)
        self.assertIs(line.loc(), loc)

    def test__init__4(self):
        msg = '%s is not an instance of %s' % (repr('foo'), repr(inputloc_.InputLoc))
        with self.assertRaisesRegex(TypeError, msg):
            inputline_.InputLine('lorem ipsum', 'foo')

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
