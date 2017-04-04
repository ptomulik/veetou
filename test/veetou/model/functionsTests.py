#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.functions_ as functions_
import veetou.model.object_ as object_

class Test__Object(unittest.TestCase):

    def test__checksubclass_1(self):
        class A(object): pass
        class B(A): pass

        self.assertIs(functions_.checksubclass(B,A), B)

        with self.assertRaisesRegex(TypeError, '%s is not a subclass of %s' % (repr(A),repr(B))):
            functions_.checksubclass(A,B)

        with self.assertRaisesRegex(TypeError, '%s is not a subclass of %s' % (repr('hello'),repr(B))):
            functions_.checksubclass('hello',B)

    def test__checkinstance_1(self):
        class A(object): pass
        class B(A): pass

        b = B()
        self.assertIs(functions_.checkinstance(b,A), b)

        a = A()
        with self.assertRaisesRegex(TypeError, '%s is not an instance of %s' % (a,repr(B))):
            functions_.checkinstance(a,B)

        with self.assertRaisesRegex(TypeError, '%s is not an instance of %s' % (repr('hello'),repr(B))):
            functions_.checkinstance('hello',B)

    def test__declare_1(self):
        class A(object):
            @classmethod
            def __declare__(cls,name,*args,**kw):
                cls._name = name
                cls._args = tuple(args)
                cls._kw = dict(kw)
                return 'result'

        self.assertEqual(functions_.declare(A, 'name', 'C', 'D', foo = 'FOO', bar = 'BAR'), 'result')
        self.assertEqual(A._name, 'name')
        self.assertEqual(A._args, ('C','D'))
        self.assertEqual(A._kw, {'foo' : 'FOO', 'bar' : 'BAR'})

    def test__safedelattr_1(self):
        class A(object): foo = 10
        self.assertTrue(hasattr(A,'foo'))
        functions_.safedelattr(A, 'foo')
        self.assertFalse(hasattr(A,'foo'))
        functions_.safedelattr(A, 'foo') # does not raise
        self.assertFalse(hasattr(A,'foo'))

    def test__setdelattr_1(self):
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

    def test__modelname_and_schemaname_2(self):
        self.assertEqual(functions_.modelname(object_.Object),    'Object')
        self.assertEqual(functions_.modelname(object_.Object()),  'Object')
        self.assertEqual(functions_.schemaname(object_.Object),   'object')
        self.assertEqual(functions_.schemaname(object_.Object()), 'object')

    def test__modelname_and_schemaname_4(self):
        class FooBarGeez(object_.Object): pass
        self.assertEqual(functions_.modelname(FooBarGeez),    'FooBarGeez')
        self.assertEqual(functions_.modelname(FooBarGeez()),  'FooBarGeez')
        self.assertEqual(functions_.schemaname(FooBarGeez),   'foo_bar_geez')
        self.assertEqual(functions_.schemaname(FooBarGeez()), 'foo_bar_geez')

    def test__modelname_and_schemaname_5(self):
        class FooBarGeez(object_.Object):
            @classmethod
            def __modelname__(cls):
                return 'JohnSmith'
        self.assertEqual(functions_.modelname(FooBarGeez),    'JohnSmith')
        self.assertEqual(functions_.modelname(FooBarGeez()),  'JohnSmith')
        self.assertEqual(functions_.schemaname(FooBarGeez),   'john_smith')
        self.assertEqual(functions_.schemaname(FooBarGeez()), 'john_smith')

    def test__modelname_and_schemaname_6(self):
        class FooBarGeez(object): pass
        self.assertEqual(functions_.modelname(FooBarGeez),   'FooBarGeez')
        self.assertEqual(functions_.modelname(FooBarGeez()), 'FooBarGeez')
        self.assertEqual(functions_.schemaname(FooBarGeez),   'FooBarGeez')
        self.assertEqual(functions_.schemaname(FooBarGeez()), 'FooBarGeez')

    def test__modelname_and_schemaname_7(self):
        self.assertEqual(functions_.modelname(str),      'str')
        self.assertEqual(functions_.modelname("hello"),  'str')
        self.assertEqual(functions_.schemaname(str),     'str')
        self.assertEqual(functions_.schemaname("hello"), 'str')

    def test__modelrefstr_1(self):
        class Foo(object): pass
        foo = Foo()
        self.assertEqual(functions_.modelrefstr(Foo), functions_.modelname(Foo))
        self.assertEqual(functions_.modelrefstr(foo), "<%s object at 0x%x>" % (functions_.modelname(foo), id(foo)))

    def test__arrayclass__1(self):
        with self.assertRaisesRegex(AttributeError, r'\b__arrayclass__\b'):
            functions_.arrayclass('foo')

    def test__arrayclass__2(self):
        class X(object):
            @classmethod
            def __arrayclass__(cls):
                return 'arrayclass'
        self.assertEqual(functions_.arrayclass(X), 'arrayclass')
        self.assertEqual(functions_.arrayclass(X()), 'arrayclass')

    def test__tupleclass__1(self):
        with self.assertRaisesRegex(AttributeError, r'\b__tupleclass__\b'):
            functions_.tupleclass('foo')

    def test__tupleclass__2(self):
        class X(object):
            @classmethod
            def __tupleclass__(cls):
                return 'tupleclass'
        self.assertEqual(functions_.tupleclass(X), 'tupleclass')
        self.assertEqual(functions_.tupleclass(X()), 'tupleclass')

    def test__entityclass__1(self):
        with self.assertRaisesRegex(AttributeError, r'\b__entityclass__\b'):
            functions_.entityclass('foo')

    def test__entityclass__2(self):
        class X(object):
            @classmethod
            def __entityclass__(cls):
                return 'entityclass'
        self.assertEqual(functions_.entityclass(X), 'entityclass')
        self.assertEqual(functions_.entityclass(X()), 'entityclass')

    def test__columniter__1(self):
        with self.assertRaisesRegex(AttributeError, r'\b__columniter__\b'):
            functions_.columniter('foo')

    def test__columniter__2(self):
        class X(object):
            @classmethod
            def __columniter__(cls):
                return 'columniter'
        self.assertEqual(functions_.columniter(X), 'columniter')
        self.assertEqual(functions_.columniter(X()), 'columniter')

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
