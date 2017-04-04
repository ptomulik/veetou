#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.namedarray_ as namedarray_
import veetou.model.namedtuple_ as namedtuple_
import veetou.model.functions_ as functions_
import veetou.model.keystuple_ as keystuple_
import veetou.model.array_ as array_
import veetou.model.datatype_ as datatype_

class FooBar(namedarray_.NamedArray):
    _keys = keystuple_.KeysTuple(['foo', 'bar'])

class FooBarGeez(namedarray_.NamedArray):
    _keys = keystuple_.KeysTuple(['foo', 'bar', 'geez'])

class Test__NamedArray(unittest.TestCase):

    def test__abstract__0(self):
        with self.assertRaisesRegex(AttributeError, "_keys"):
            namedarray_.NamedArray.keys()

        with self.assertRaisesRegex(AttributeError, "_keys"):
            namedarray_.NamedArray()

    def test__abstract__1(self):
        class X(namedarray_.NamedArray): pass
        with self.assertRaisesRegex(AttributeError, "_keys"):
            X.keys()

        with self.assertRaisesRegex(AttributeError, "_keys"):
            X()

    def test__keys__1(self):
        class X(namedarray_.NamedArray):
            _keys = keystuple_.KeysTuple(['x', 'X'])
        class Y(namedarray_.NamedArray):
            _keys = keystuple_.KeysTuple(['y', 'Y'])

        self.assertEqual(X.keys(), keystuple_.KeysTuple(['x', 'X']))
        self.assertEqual(Y.keys(), keystuple_.KeysTuple(['y', 'Y']))

        x = X()
        y = Y()
        self.assertEqual(x.keys(), keystuple_.KeysTuple(['x', 'X']))
        self.assertEqual(y.keys(), keystuple_.KeysTuple(['y', 'Y']))

    def test__keyindex__1(self):
        class X(namedarray_.NamedArray):
            _keys = keystuple_.KeysTuple(['x', 'X'])
        class Y(namedarray_.NamedArray):
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

    def test__tuplegen__1(self):
        klass = functions_.tuplegen(FooBar)
        self.assertTrue(issubclass(klass, namedtuple_.NamedTuple))
        self.assertEqual(klass.keys(), FooBar.keys())
        self.assertEqual(klass.__name__, '')

    def test__tupleclass__1(self):
        klass = functions_.tupleclass(FooBar)
        self.assertTrue(issubclass(klass, namedtuple_.NamedTuple))
        self.assertEqual(klass.keys(), FooBar.keys())

    def test__tupleclass__2(self):
        class X(FooBar): pass
        X._tupleclass = functions_.tuplegen(X)
        self.assertIs(functions_.tupleclass(X), X._tupleclass)

    def test__tupleclass_setter__1(self):
        class XA(namedarray_.NamedArray): pass
        class XT(namedtuple_.NamedTuple): pass
        XA.tupleclass = XT
        self.assertIs(XA.tupleclass, XT)

    def test__tupleclass_setter__2(self):
        class XA(namedarray_.NamedArray): pass
        with self.assertRaisesRegex(TypeError, '%s is not a subclass of %s' % (repr('foo'),repr(namedtuple_.NamedTuple))):
            XA.tupleclass = 'foo'

    def test__datatype_setter__1(self):
        class XA(namedarray_.NamedArray): pass
        class XT(namedtuple_.NamedTuple): pass
        class XD(datatype_.DataType):
            def __init__(self):
                pass
            tupleclass = XT
        xd = XD()
        XA.datatype = xd
        self.assertIs(XA.datatype, xd)
        self.assertIs(XA.tupleclass, XT)

    def test__datatype_setter__2(self):
        class XA(namedarray_.NamedArray): pass
        with self.assertRaisesRegex(TypeError, '%s is not an instance of %s' % (repr('foo'),repr(datatype_.DataType))):
            XA.datatype = 'foo'

    def test__init__1(self):
        self.assertEqual(FooBar(['FOO', 'BAR'])._data, ['FOO', 'BAR'])
        self.assertEqual(FooBar()._data, [None, None])
        self.assertEqual(FooBar(foo='FOO')._data, ['FOO', None])
        self.assertEqual(FooBar(bar='BAR')._data, [None, 'BAR'])
        self.assertEqual(FooBar(foo='FOO', bar='BAR')._data, ['FOO', 'BAR'])

    def test__values__1(self):
        e = FooBar(['FOO', 'BAR'])
        self.assertEqual(e.values(), ['FOO', 'BAR'])
        self.assertEqual(e.values(), e._data)
        self.assertIsInstance(e.values(), array_.Array)

    def test__getitem__1(self):
        e = FooBar(['FOO', 'BAR'])
        self.assertEqual(e['foo'], 'FOO')
        self.assertEqual(e['bar'], 'BAR')
        with self.assertRaises(KeyError): e['gez']

    def test__getitem__2(self):
        e = FooBar(['FOO', 'BAR'])
        self.assertEqual(e[0], 'FOO')
        self.assertEqual(e[1], 'BAR')
        self.assertEqual(e[-1], 'BAR')
        self.assertEqual(e[-2], 'FOO')
        with self.assertRaises(IndexError): e[2]
        with self.assertRaises(IndexError): e[-3]

    def test__getitem__3(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        self.assertEqual(e[0:2],   ['FOO', 'BAR'])
        self.assertEqual(e[1:3],   ['BAR', 'GEEZ'])
        self.assertEqual(e[:],     ['FOO', 'BAR', 'GEEZ'])
        self.assertEqual(e[0:3:2], ['FOO', 'GEEZ'])

    def test__setitem_by_index__1(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        e[0] = 'XXX'
        self.assertEqual(e[0], 'XXX')
        self.assertEqual(e[1], 'BAR')
        self.assertEqual(e[2], 'GEEZ')

    def test__setitem_by_index__2(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        e[-1] = 'XXX'
        self.assertEqual(e[0], 'FOO')
        self.assertEqual(e[1], 'BAR')
        self.assertEqual(e[2], 'XXX')

    def test__setitem_by_index__3(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        with self.assertRaises(IndexError): e[ 3] = 'XXX'
        with self.assertRaises(IndexError): e[-4] = 'XXX'
        self.assertEqual(e, ['FOO', 'BAR', 'GEEZ'])

    def test__setitem_by_slice__1(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        e[:] = ['A', 'B', 'C']
        self.assertEqual(len(e), 3)
        self.assertEqual(e, ['A', 'B', 'C'])

    def test__setitem_by_slice__2(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        e[:2] = ['A', 'B']
        self.assertEqual(len(e), 3)
        self.assertEqual(e, ['A', 'B', 'GEEZ'])

    def test__setitem_by_slice__3(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        e[1:] = ['A', 'B']
        self.assertEqual(len(e), 3)
        self.assertEqual(e, ['FOO', 'A', 'B'])

    def test__setitem_by_slice__4(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        e[1:] = ['A', 'B', 'C']
        self.assertEqual(len(e), 3)
        self.assertEqual(e, ['FOO', 'A', 'B'])

    def test__setitem_by_slice__5(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        e[3:] = ['A', 'B', 'C']
        self.assertEqual(len(e), 3)
        self.assertEqual(e, ['FOO', 'BAR', 'GEEZ'])

    def test__setitem_by_slice__6(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        e[2:5] = ['A', 'B', 'C']
        self.assertEqual(len(e), 3)
        self.assertEqual(e, ['FOO', 'BAR', 'A'])

    def test__setitem_by_key__1(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        e['foo'] = 'XXX'
        self.assertEqual(e, ['XXX', 'BAR', 'GEEZ'])
        e['bar'] = 'YYY'
        self.assertEqual(e, ['XXX', 'YYY', 'GEEZ'])


    def test__iter__1(self):
        e = FooBar(['FOO', 'BAR'])
        self.assertEqual(list(iter(e)), ['FOO', 'BAR'])

    def test__len__1(self):
        e = FooBar()
        self.assertEqual(len(FooBar), 2)
        self.assertEqual(len(e), 2)

    def test__get__1(self):
        e = FooBar(['FOO', 'BAR'])
        self.assertEqual(e.get('foo'), 'FOO')
        self.assertEqual(e.get('bar'), 'BAR')
        self.assertIs(e.get('gez'), None)

    def test__items__1(self):
        e = FooBar(['FOO', 'BAR'])

        self.assertEqual(e.items(), array_.Array([('foo', 'FOO'), ('bar', 'BAR')]))

    def test__eq__1(self):
        e1 = FooBar(['FOO', 'BAR'])
        e2 = FooBar(['FOO', 'BAR'])
        e3 = FooBar(['FOO', 'GEEZ'])

        self.assertTrue(e1 == e2)
        self.assertFalse(e1 == e3)

    def test__ne__1(self):
        e1 = FooBar(['FOO', 'BAR'])
        e2 = FooBar(['FOO', 'BAR'])
        e3 = FooBar(['FOO', 'GEEZ'])

        self.assertFalse(e1 != e2)
        self.assertTrue(e1 != e3)

    def test__in__1(self):
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

    def test__index__1(self):
        e = FooBar(['FOO', 'BAR'])

        self.assertEqual(e.index('FOO'), 0)
        self.assertEqual(e.index('BAR'), 1)

    def test__reversed__1(self):
        e = FooBarGeez(['FOO', 'BAR', 'GEEZ'])
        self.assertEqual(list(reversed(e)), ['GEEZ', 'BAR', 'FOO'])

    def test__count__1(self):
        self.assertEqual(FooBar([1,2]).count('a'), 0)
        self.assertEqual(FooBar([1,2]).count(1), 1)
        self.assertEqual(FooBar([1,2]).count(2), 1)
        self.assertEqual(FooBarGeez([1,2,1]).count(1), 2)
        self.assertEqual(FooBarGeez([1,2,1]).count(2), 1)

    def test__update__1(self):
        e = FooBar(['FOO', 'BAR'])
        e.update({'foo' : 'Foo', 'bar' : 'Bar'})
        self.assertEqual(e['foo'], 'Foo')
        self.assertEqual(e['bar'], 'Bar')

    def test__update__2(self):
        e = FooBar(['FOO', 'BAR'])
        e.update({0 : 'Foo', 1 : 'Bar'})
        self.assertEqual(e[0], 'Foo')
        self.assertEqual(e[1], 'Bar')

    def test__update__3(self):
        e = FooBar(['FOO', 'BAR'])
        with self.assertRaises(KeyError):
            e.update({'foo' : 'Foo', 'bar' : 'Bar', 'geez' : 'Geez'})

    def test__update__4(self):
        e = FooBar(['FOO', 'BAR'])
        with self.assertRaises(ValueError):
            e.update(('Foo', 'Bar'))

    def test__repr__1(self):
        self.assertEqual(repr(FooBar(['FOO', 'BAR'])), "FooBar([%r,%r])" % ('FOO', 'BAR'))

    def test__declare__1(self):
        class XT(namedtuple_.NamedTuple): pass
        Cat = namedarray_.NamedArray.__declare__('Cat', ('name', 'age'), tupleclass = XT)
        self.assertTrue(issubclass(Cat, namedarray_.NamedArray))
        self.assertEqual(Cat.__name__, 'Cat')
        self.assertEqual(Cat._keys, keystuple_.KeysTuple(('name','age')))
        self.assertIs(Cat.tupleclass, XT)

    def test__declare__2(self):
        class XT(namedtuple_.NamedTuple): pass
        class XD(datatype_.DataType):
            def __init__(self): pass
            tupleclass = XT
        xd = XD()
        Cat = namedarray_.NamedArray.__declare__('Cat', ('name', 'age'), datatype = xd)
        self.assertTrue(issubclass(Cat, namedarray_.NamedArray))
        self.assertEqual(Cat.__name__, 'Cat')
        self.assertEqual(Cat._keys, keystuple_.KeysTuple(('name','age')))
        self.assertIs(Cat.datatype, xd)
        self.assertIs(Cat.tupleclass, XT)

    def test__declare__3(self):
        class XT(namedtuple_.NamedTuple): pass
        foo = 'FOO'
        Cat = namedarray_.NamedArray.__declare__("Cat", ('name','age'), 
                { 'foo' : foo },
                tupleclass = XT,
                module = 'xm'
        )
        self.assertTrue(issubclass(Cat, namedarray_.NamedArray))
        self.assertEqual(Cat.__name__, 'Cat')
        self.assertEqual(Cat._keys, keystuple_.KeysTuple(('name','age')))
        self.assertIs(Cat.tupleclass, XT)
        self.assertEqual(Cat.__module__, 'xm')
        self.assertIs(Cat.foo, foo)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
