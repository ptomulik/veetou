#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.type_ as type_

class Test__Type(unittest.TestCase):

    def test__declare_1(self):
        with self.assertRaisesRegex(TypeError, r'__declare__\(\) takes exactly 3 positional arguments \(0 given\)'):
            type_.Type.__declare__()
        with self.assertRaisesRegex(TypeError, r'__declare__\(\) takes exactly 3 positional arguments \(1 given\)'):
            type_.Type.__declare__(0)
        with self.assertRaisesRegex(TypeError, r'__declare__\(\) takes exactly 3 positional arguments \(2 given\)'):
            type_.Type.__declare__(0,1)
        with self.assertRaisesRegex(TypeError, r'__declare__\(\) takes exactly 3 positional arguments \(4 given\)'):
            type_.Type.__declare__(0,1,2,3)

    def test__declare_2(self):
        class X(object): pass
        Y = type_.Type.__declare__('YY', (X,), {})
        self.assertTrue(issubclass(Y,X))
        self.assertEqual(Y.__name__, 'YY')
        self.assertEqual(Y.__module__, 'veetou.model.type_')

    def test__declare_3(self):
        class X(object): pass
        Y = type_.Type.__declare__('YY', (X,), { 'foo' : 'FOO' }, module='xm')
        self.assertTrue(issubclass(Y,X))
        self.assertEqual(Y.__name__, 'YY')
        self.assertEqual(Y.__module__, 'xm')


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
