#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.common.functions_ as functions_

class Test__Functions(unittest.TestCase):
    def test__checkinstance__1(self):
        class A(object): pass
        class B(A): pass

        b = B()
        self.assertIs(functions_.checkinstance(b,A), b)

        a = A()
        with self.assertRaisesRegex(TypeError, '%s is not an instance of %s' % (a,repr(B))):
            functions_.checkinstance(a,B)

        with self.assertRaisesRegex(TypeError, '%s is not an instance of %s' % (repr('hello'),repr(B))):
            functions_.checkinstance('hello',B)

    def test__checksubclass__1(self):
        class A(object): pass
        class B(A): pass

        self.assertIs(functions_.checksubclass(B,A), B)

        with self.assertRaisesRegex(TypeError, '%s is not a subclass of %s' % (repr(A),repr(B))):
            functions_.checksubclass(A,B)

        with self.assertRaisesRegex(TypeError, '%s is not a subclass of %s' % (repr('hello'),repr(B))):
            functions_.checksubclass('hello',B)

    def test__logstr__1(self):
        msg = '%s object has no attribute %s' % (repr(str.__name__), repr('__logstr__'))
        with self.assertRaisesRegex(AttributeError, msg):
            functions_.logstr('asdf')

    def test__logstr__2(self):
        class X(object):
            def __logstr__(self):
                return 'jinga lala'
        self.assertEqual(functions_.logstr(X()), 'jinga lala')

    def test__safedelattr__1(self):
        class A(object): foo = 10
        self.assertTrue(hasattr(A,'foo'))
        functions_.safedelattr(A, 'foo')
        self.assertFalse(hasattr(A,'foo'))
        functions_.safedelattr(A, 'foo') # does not raise
        self.assertFalse(hasattr(A,'foo'))

    def test__setdelattr__1(self):
        class A(object): pass
        self.assertFalse(hasattr(A,'foo'))
        functions_.setdelattr(A, 'foo') # does not raise
        self.assertFalse(hasattr(A,'foo'))
        functions_.setdelattr(A, 'foo', 10)
        self.assertEqual(A.foo, 10)
        functions_.setdelattr(A, 'bar', 'value', lambda x : x.capitalize())
        self.assertEqual(A.bar, 'Value')
        functions_.setdelattr(A, 'foo')
        self.assertFalse(hasattr(A,'foo'))
        functions_.setdelattr(A, 'bar')
        self.assertFalse(hasattr(A,'bar'))

    def test__snakecase__1(self):
        self.assertEqual(functions_.snakecase('a'), 'a')
        self.assertEqual(functions_.snakecase('Abra'), 'abra')
        self.assertEqual(functions_.snakecase('AbraCadabra'), 'abra_cadabra')

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
