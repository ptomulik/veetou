#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.namedtuple_ as namedtuple_
import veetou.model.functions_ as functions_
import veetou.model.tuple_ as tuple_
import veetou.model.keystuple_ as keystuple_
import veetou.model.namedarray_ as namedarray_
import veetou.model.datatype_ as datatype_

class FooBar(namedtuple_.NamedTuple):
    _keys = keystuple_.KeysTuple(['foo', 'bar'])

class FooBarGeez(namedtuple_.NamedTuple):
    _keys = keystuple_.KeysTuple(['foo', 'bar', 'geez'])

class Test__NamedTuple(unittest.TestCase):

    def test__abstract_0(self):
        with self.assertRaisesRegex(AttributeError, "_keys"):
            namedtuple_.NamedTuple.keys()

        with self.assertRaisesRegex(AttributeError, "_keys"):
            namedtuple_.NamedTuple()

    def test__abstract_1(self):
        class X(namedtuple_.NamedTuple): pass
        with self.assertRaisesRegex(AttributeError, "_keys"):
            X.keys()

        with self.assertRaisesRegex(AttributeError, "_keys"):
            X()

    def test__keys_1(self):
        class X(namedtuple_.NamedTuple):
            _keys = keystuple_.KeysTuple(['x', 'X'])
        class Y(namedtuple_.NamedTuple):
            _keys = keystuple_.KeysTuple(['y', 'Y'])

        self.assertEqual(X.keys(), keystuple_.KeysTuple(['x', 'X']))
        self.assertEqual(Y.keys(), keystuple_.KeysTuple(['y', 'Y']))

        x = X()
        y = Y()
        self.assertEqual(x.keys(), keystuple_.KeysTuple(['x', 'X']))
        self.assertEqual(y.keys(), keystuple_.KeysTuple(['y', 'Y']))

    def test__keyindex_1(self):
        class X(namedtuple_.NamedTuple):
            _keys = keystuple_.KeysTuple(['x', 'X'])
        class Y(namedtuple_.NamedTuple):
            _keys = keystuple_.KeysTuple(['y', 'Y'])

        self.assertEqual(X.keyindex('x'), 0)
        self.assertEqual(X.keyindex('X'), 1)
        self.assertEqual(Y.keyindex('y'), 0)
        self.assertEqual(Y.keyindex('Y'), 1)

        with self.assertRaises(KeyError): X.keyindex('z')
        with self.assertRaises(KeyError): Y.keyindex('z')

        x = X()
        y = Y()

        self.assertEqual(x.keyindex('x'), 0)
        self.assertEqual(x.keyindex('X'), 1)
        self.assertEqual(y.keyindex('y'), 0)
        self.assertEqual(y.keyindex('Y'), 1)

        with self.assertRaises(KeyError): x.keyindex('z')
        with self.assertRaises(KeyError): y.keyindex('z')

    def test__arraygen_1(self):
        array = functions_.arraygen(FooBar)
        self.assertTrue(issubclass(array, namedarray_.NamedArray))
        self.assertEqual(array.keys(), FooBar.keys())
        self.assertEqual(array.__name__, '')

    def test__arrayclass_1(self):
        array = functions_.arrayclass(FooBar)
        self.assertTrue(issubclass(array, namedarray_.NamedArray))
        self.assertEqual(array.keys(), FooBar.keys())

    def test__arrayclass_2(self):
        class X(FooBar): pass
        X._arrayclass = functions_.arraygen(X)
        self.assertIs(functions_.arrayclass(X), X._arrayclass)

    def test__arrayclass_setter_1(self):
        class XT(namedtuple_.NamedTuple): pass
        class XA(namedarray_.NamedArray): pass
        XT.arrayclass = XA
        self.assertIs(XT.arrayclass, XA)
        XT.arrayclass = None
        with self.assertRaisesRegex(AttributeError, r'\b_arrayclass\b'):
            XT.arrayclass

    def test__arrayclass_setter_2(self):
        class XT(namedtuple_.NamedTuple): pass
        with self.assertRaisesRegex(TypeError, '%s is not a subclass of %s' % (repr('foo'),repr(namedarray_.NamedArray))):
            XT.arrayclass = 'foo'

    def test__datatype_setter_1(self):
        class XT(namedtuple_.NamedTuple): pass
        class XA(namedarray_.NamedArray): pass
        class XD(datatype_.DataType):
            def __init__(self):
                pass
            arrayclass = XA
        xd = XD()
        XT.datatype = xd
        self.assertIs(XT.datatype, xd)
        self.assertIs(XT.arrayclass, XA)
        XT.datatype = None
        with self.assertRaisesRegex(AttributeError, r'\b_datatype\b'):
            XT.datatype

    def test__datatype_setter_2(self):
        class XT(namedtuple_.NamedTuple): pass
        with self.assertRaisesRegex(TypeError, '%s is not an instance of %s' % (repr('foo'),repr(datatype_.DataType))):
            XT.datatype = 'foo'

    def test__init_1(self):
        self.assertEqual(FooBar(['FOO', 'BAR'])._data, ('FOO', 'BAR'))
        self.assertEqual(FooBar()._data, (None, None))
        self.assertEqual(FooBar(foo='FOO')._data, ('FOO', None))
        self.assertEqual(FooBar(bar='BAR')._data, (None, 'BAR'))
        self.assertEqual(FooBar(foo='FOO', bar='BAR')._data, ('FOO', 'BAR'))

    def test__values_1(self):
        e = FooBar(['FOO', 'BAR'])
        self.assertEqual(e.values(), ('FOO', 'BAR'))
        self.assertEqual(e.values(), e._data)
        self.assertIsInstance(e.values(), tuple_.Tuple)

    def test__getitem_1(self):
        e = FooBar(['FOO', 'BAR'])
        self.assertEqual(e['foo'], 'FOO')
        self.assertEqual(e['bar'], 'BAR')
        with self.assertRaises(KeyError): e['gez']

    def test__getitem_2(self):
        e = FooBar(['FOO', 'BAR'])
        self.assertEqual(e[0], 'FOO')
        self.assertEqual(e[1], 'BAR')
        self.assertEqual(e[-1], 'BAR')
        self.assertEqual(e[-2], 'FOO')
        with self.assertRaises(IndexError): e[2]
        with self.assertRaises(IndexError): e[-3]

    def test__getitem_3(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        self.assertEqual(e[0:2],   ('FOO', 'BAR'))
        self.assertEqual(e[1:3],   ('BAR', 'GEEZ'))
        self.assertEqual(e[:],     ('FOO', 'BAR', 'GEEZ'))
        self.assertEqual(e[0:3:2], ('FOO', 'GEEZ'))

    def test__iter_1(self):
        e = FooBar(['FOO', 'BAR'])
        self.assertEqual(list(iter(e)), ['FOO', 'BAR'])

    def test__len_1(self):
        e = FooBar()
        self.assertEqual(len(FooBar), 2)
        self.assertEqual(len(e), 2)

    def test__get_1(self):
        e = FooBar(['FOO', 'BAR'])
        self.assertEqual(e.get('foo'), 'FOO')
        self.assertEqual(e.get('bar'), 'BAR')
        self.assertIs(e.get('gez'), None)

    def test__items_1(self):
        e = FooBar(['FOO', 'BAR'])

        self.assertEqual(e.items(), tuple_.Tuple([('foo', 'FOO'), ('bar', 'BAR')]))

    def test__eq_1(self):
        e1 = FooBar(['FOO', 'BAR'])
        e2 = FooBar(['FOO', 'BAR'])
        e3 = FooBar(['FOO', 'GEEZ'])

        self.assertTrue(e1 == e2)
        self.assertFalse(e1 == e3)

    def test__ne_1(self):
        e1 = FooBar(['FOO', 'BAR'])
        e2 = FooBar(['FOO', 'BAR'])
        e3 = FooBar(['FOO', 'GEEZ'])

        self.assertFalse(e1 != e2)
        self.assertTrue(e1 != e3)

    def test__in_1(self):
        e = FooBarGeez(['FOO', 'BAR', None])

        # keys...
        self.assertTrue('foo'      in e)
        self.assertTrue('bar'      in e)
        self.assertTrue('geez' not in e)
        # indices...
        self.assertTrue(0     in e)
        self.assertTrue(1     in e)
        self.assertTrue(2 not in e)

        # ...but not values
        self.assertTrue('FOO' not in e)
        self.assertTrue('BAR' not in e)

        # .. some falses (out of range) - shold not raise
        self.assertTrue( 4 not in e)
        self.assertTrue(-4 not in e)

    def test__index_1(self):
        e = FooBar(['FOO', 'BAR'])

        self.assertEqual(e.index('FOO'), 0)
        self.assertEqual(e.index('BAR'), 1)

    def test__reversed_1(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        self.assertEqual(list(reversed(e)), ['GEEZ', 'BAR', 'FOO'])

    def test__count_1(self):
        self.assertEqual(FooBar([1,2]).count('a'), 0)
        self.assertEqual(FooBar([1,2]).count(1), 1)
        self.assertEqual(FooBar([1,2]).count(2), 1)
        self.assertEqual(FooBarGeez([1,2,1]).count(1), 2)
        self.assertEqual(FooBarGeez([1,2,1]).count(2), 1)

    def test__hash_1(self):
        self.assertEqual(hash(tuple_.Tuple(['FOO', 'BAR'])), hash(tuple(['FOO', 'BAR'])))
        self.assertEqual(hash(FooBar(['FOO', 'BAR'])), hash(tuple_.Tuple(['FOO', 'BAR'])))
        self.assertNotEqual(hash(FooBar(['FOO', 'BAR'])), hash(FooBar(['FOO', None])))

    def test__repr_1(self):
        self.assertEqual(repr(FooBar(['FOO', 'BAR'])), "FooBar([%r,%r])" % ('FOO', 'BAR'))

    def test__declare_1(self):
        class XA(namedarray_.NamedArray): pass
        Cat = namedtuple_.NamedTuple.__declare__('Cat', ('name', 'age'), arrayclass = XA)
        self.assertTrue(issubclass(Cat, namedtuple_.NamedTuple))
        self.assertEqual(Cat.__name__, 'Cat')
        self.assertEqual(Cat._keys, keystuple_.KeysTuple(('name','age')))
        self.assertIs(Cat.arrayclass, XA)

    def test__declare_2(self):
        class XA(namedarray_.NamedArray): pass
        class XD(datatype_.DataType):
            def __init__(self): pass
            arrayclass = XA
        xd = XD()
        Cat = namedtuple_.NamedTuple.__declare__('Cat', ('name', 'age'), datatype = xd)
        self.assertTrue(issubclass(Cat, namedtuple_.NamedTuple))
        self.assertEqual(Cat.__name__, 'Cat')
        self.assertEqual(Cat._keys, keystuple_.KeysTuple(('name','age')))
        self.assertIs(Cat.datatype, xd)
        self.assertIs(Cat.arrayclass, XA)

    def test__declare_3(self):
        class XA(namedarray_.NamedArray): pass
        foo = 'FOO'
        Cat = namedtuple_.NamedTuple.__declare__("Cat", ('name','age'), 
                { 'foo' : foo },
                arrayclass = XA,
                module = 'xm'
        )
        self.assertTrue(issubclass(Cat, namedtuple_.NamedTuple))
        self.assertEqual(Cat.__name__, 'Cat')
        self.assertEqual(Cat._keys, keystuple_.KeysTuple(('name','age')))
        self.assertIs(Cat.arrayclass, XA)
        self.assertEqual(Cat.__module__, 'xm')
        self.assertIs(Cat.foo, foo)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
