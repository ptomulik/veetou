#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.entity_ as entity_
import veetou.model.tuple_ as tuple_
import veetou.model.keystuple_ as keystuple_
import veetou.model.functions_ as functions_
import veetou.model.namedarray_ as namedarray_

class FooBar(entity_.Entity):
    _keys = keystuple_.KeysTuple(['foo', 'bar'])

class FooBarGeez(entity_.Entity):
    _keys = keystuple_.KeysTuple(['foo', 'bar', 'geez'])

class Test__Entity(unittest.TestCase):

    def test__abstract_0(self):
        with self.assertRaisesRegex(AttributeError, r'\b_keys\b'):
            entity_.Entity.keys()

        with self.assertRaisesRegex(AttributeError, r'\b_keys\b'):
            entity_.Entity()

    def test__abstract_1(self):
        class X(entity_.Entity): pass
        with self.assertRaisesRegex(AttributeError, r'\b_keys\b'):
            X.keys()

        with self.assertRaisesRegex(AttributeError, r'\b_keys\b'):
            X()


    def test__modelname(self):
        self.assertEqual(functions_.modelname(FooBar), 'FooBar')
        self.assertEqual(functions_.modelname(FooBarGeez), 'FooBarGeez')

    def test__schemaname(self):
        self.assertEqual(functions_.schemaname(FooBar), 'foo_bar')
        self.assertEqual(functions_.schemaname(FooBarGeez), 'foo_bar_geez')

    def test__keys_1(self):
        class X(entity_.Entity):
            _keys = keystuple_.KeysTuple(['x', 'X'])
        class Y(entity_.Entity):
            _keys = keystuple_.KeysTuple(['y', 'Y'])

        self.assertEqual(X.keys(), keystuple_.KeysTuple(['x', 'X']))
        self.assertEqual(Y.keys(), keystuple_.KeysTuple(['y', 'Y']))

        x = X()
        y = Y()
        self.assertEqual(x.keys(), keystuple_.KeysTuple(['x', 'X']))
        self.assertEqual(y.keys(), keystuple_.KeysTuple(['y', 'Y']))

    def test__types_1(self):
        class Product(entity_.Entity):
            _keys = keystuple_.KeysTuple(('name', 'price'))
            _types = (str,int)
        class S(object):
            def __init__(self, s):
                self._s = s
            def __str__(self):
                return str(self._s)

        prod = Product((S('car'),'12345'))
        self.assertIsInstance(prod[0], str)
        self.assertIsInstance(prod[1], int)

    def test__types_2(self):
        class Product(entity_.Entity):
            _keys = keystuple_.KeysTuple(('name', 'price'))
            _types = (None,int)
        class S(object):
            def __init__(self, s):
                self._s = s
            def __str__(self):
                return str(self._s)

        prod = Product((S('car'),'12345'))
        self.assertIsInstance(prod[0], S)
        self.assertIsInstance(prod[1], int)

    def test__validate_1(self):
        self.assertEqual(FooBar.validate(('FOO', 'BAR')), ('FOO', 'BAR'))
        self.assertEqual(FooBar.validate(['FOO', 'BAR']), ['FOO', 'BAR'])

    def test__validate_2(self):
        class Dog(entity_.Entity):
            _keys = keystuple_.KeysTuple(['name', 'age'])
            @classmethod
            def validate(cls,data):
                return (str(data[0]), int(data[1]))
        class S(object):
            def __init__(self, s):
                self._s = s
            def __str__(self):
                return self._s

    def test__validate_3(self):
        class Dog(entity_.Entity):
            _keys = keystuple_.KeysTuple(['name', 'age'])
            @classmethod
            def validate(cls,data):
                data['name'] = str(data['name'])
                data['age'] = int(data['age'])
                return data
        class S(object):
            def __init__(self, s):
                self._s = s
            def __str__(self):
                return self._s

        self.assertEqual(Dog(['Snoopy', '12']).values(), tuple_.Tuple(['Snoopy', 12]))
        self.assertEqual(Dog([S('Snoopy'), 12.2]).values(), tuple_.Tuple(['Snoopy', 12]))

    def test__keyindex_1(self):
        class X(entity_.Entity):
            _keys = keystuple_.KeysTuple(['x', 'X'])
        class Y(entity_.Entity):
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
        self.assertEqual(hash(FooBar(['FOO', 'BAR'])), hash(FooBar(['FOO', 'BAR'])))
        self.assertNotEqual(hash(FooBar(['FOO', 'BAR'])), hash(FooBar(['FOO', None])))
        self.assertNotEqual(hash(FooBar(['FOO', 'BAR'])), hash(tuple_.Tuple(['FOO', 'BAR'])))
        self.assertEqual(hash(FooBar(['FOO', 'BAR'])), hash((FooBar, ('FOO', 'BAR'))))

    def test__repr_1(self):
        self.assertEqual(repr(FooBar(['FOO', 'BAR'])), "FooBar([%r,%r])" % ('FOO', 'BAR'))

    def test__declare_1(self):
        capitalize = lambda cls, data : data.__class__((data[0].capitalize(),data[1]))
        Cat = entity_.Entity.__declare__('Cat', ('name', 'age'), (str,int), capitalize)
        self.assertTrue(issubclass(Cat, entity_.Entity))
        self.assertEqual(Cat._keys, keystuple_.KeysTuple(('name','age')))
        self.assertEqual(Cat._types, (str,int))

        cat = Cat(('garfield', 12))
        self.assertEqual(cat['name'], 'Garfield') # capitalize works

    def test__declare_3(self):
        class XA(namedarray_.NamedArray): pass
        foo = 'FOO'
        Cat = entity_.Entity.__declare__("Cat", ('name','age'), None, None,
                { 'foo' : foo },
                arrayclass = XA,
                module = 'xm'
        )
        self.assertTrue(issubclass(Cat, entity_.Entity))
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
