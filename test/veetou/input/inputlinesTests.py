#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.input.inputlines_ as inputlines_
import veetou.input.inputline_ as inputline_
import veetou.input.inputloc_ as inputloc_
import veetou.input.inputiterator_ as inputiterator_

import collections.abc
import io

class NamedStringIO(io.StringIO):

    @property
    def name(self):
        return 'namedstring'

class Test__InputLines(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(inputlines_.InputLines, inputiterator_.InputIterator))

    def test__init__1(self):
        input = io.StringIO('first line\nsecond line\nthird line')
        lines = inputlines_.InputLines(input)
        self.assertEqual(lines._counter, 0)
        self.assertIs(lines._input, input)

    def test__init__2(self):
        msg = '%s is not an instance of %s' % (repr('foo'), repr(io.IOBase))
        with self.assertRaisesRegex(TypeError, msg):
            inputlines_.InputLines('foo')

    def test__next__1(self):
        input = io.StringIO('first line\nsecond line\nthird line')
        lines = inputlines_.InputLines(input)

        line = next(lines)
        self.assertEqual(line, 'first line')
        self.assertEqual(line.loc(), inputloc_.InputLoc(repr(input), 1))

        line = next(lines)
        self.assertEqual(line, 'second line')
        self.assertEqual(line.loc(), inputloc_.InputLoc(repr(input), 2))

        line = next(lines)
        self.assertEqual(line, 'third line')
        self.assertEqual(line.loc(), inputloc_.InputLoc(repr(input), 3))

        with self.assertRaises(StopIteration):
            next(lines)

    def test__name__1(self):
        input = io.StringIO('first line\nsecond line\nthird line')
        lines = inputlines_.InputLines(input)
        self.assertEqual(lines.name, repr(input))

    def test__name__2(self):
        input = NamedStringIO('first line\nsecond line\nthird line')
        lines = inputlines_.InputLines(input)
        self.assertEqual(lines.name, input.name)

    def test__line__1(self):
        input = io.StringIO('first line\nsecond line\nthird line')
        lines = inputlines_.InputLines(input)
        self.assertEqual(lines.line, 1)

    def test__loc__1(self):
        input = io.StringIO('first line\nsecond line\nthird line')
        lines = inputlines_.InputLines(input)
        self.assertEqual(lines.loc(), inputloc_.InputLoc(repr(input), 1))

    def test__with__1(self):
        strings = ['first line', 'second line', 'third line']
        with inputlines_.InputLines(io.StringIO('\n'.join(strings))) as lines:
            i = 0
            for line in lines:
                self.assertEqual(line, strings[i])
                self.assertEqual(line.loc().line, i+1)
                i += 1


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
