#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.keystuple_ as keystuple_
import veetou.model.tuple_ as tuple_

class Test__KeysTuple(unittest.TestCase):

    def test__base_class(self):
        self.assertTrue(issubclass(keystuple_.KeysTuple, tuple_.Tuple))

    def test__init_0(self):
        self.assertEqual(keystuple_.KeysTuple()._data, ())

    def test__init_1(self):
        self.assertEqual(keystuple_.KeysTuple(['foo','bar'])._data, ('foo', 'bar'))
        with self.assertRaisesRegex(ValueError, "key names must be unique"):
            self.assertEqual(keystuple_.KeysTuple(['foo', 'bar', 'geez', 'bar']))

    def test__repr_1(self):
        self.assertEqual(repr(keystuple_.KeysTuple(['foo', 'bar'])), "KeysTuple([%r,%r])" % ('foo', 'bar'))

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
