#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.dict_ as dict_
import collections
import collections.abc

class Key(object):
    def __init__(self, obj):
        self._obj = obj

    @property
    def obj(self):
        return self._obj

    def __hash__(self):
        return hash(self.obj)

    def __eq__(self, other):
        if isinstance(other, Key):
            return self.obj == other.obj
        else:
            return self.obj == other

    def __ne__(self, other):
        if isinstance(other, Key):
            return self.obj != other.obj
        else:
            return self.obj != other

    def __lt__(self, other):
        if isinstance(other, Key):
            return self.obj < other.obj
        else:
            return self.obj < other

    def __gt__(self, other):
        if isinstance(other, Key):
            return self.obj > other.obj
        else:
            return self.obj > other

    def __le__(self, other):
        if isinstance(other, Key):
            return self.obj <= other.obj
        else:
            return self.obj <= other

    def __ge__(self, other):
        if isinstance(other, Key):
            return self.obj >= other.obj
        else:
            return self.obj >= other

class Val(object):
    def __init__(self, obj):
        self._obj = obj

    @property
    def obj(self):
        return self._obj

    def __eq__(self, other):
        if isinstance(other, Val):
            return self.obj == other.obj
        else:
            return self.obj == other

##    def __ne__(self, other):
##        if isinstance(other, Wrapper):
##            return self.obj != other.obj
##        else:
##            return self.obj != other
##
##    def __lt__(self, other):
##        if isinstance(other, Wrapper2):
##            return self.obj < other.obj
##        else:
##            return self.obj < other
##
##    def __gt__(self, other):
##        if isinstance(other, Wrapper2):
##            return self.obj > other.obj
##        else:
##            return self.obj > other
##
##    def __le__(self, other):
##        if isinstance(other, Wrapper2):
##            return self.obj <= other.obj
##        else:
##            return self.obj <= other
##
##    def __ge__(self, other):
##        if isinstance(other, Wrapper2):
##            return self.obj >= other.obj
##        else:
##            return self.obj >= other

class WrapDict(dict_.Dict):
    def __keywrap__(self, key):
        return Key(key)
    def __keyunwrap__(self, key):
        return key.obj
    def __wrap__(self, val):
        return Val(val)
    def __unwrap__(self, val):
        return val.obj

class Test__Dict(unittest.TestCase):
    def test__subclass_1(self):
        self.assertTrue(issubclass(dict_.Dict, collections.abc.MutableMapping))

    def test__dictclass_1(self):
        self.assertIs(dict_.Dict.__dictclass__(), dict)

    def test__init_1(self):
        itms = (('k1', ('v1',)), ('k2', ('v2',)))
        dct = dict_.Dict(itms)
        self.assertEqual(len(dct._data), len(itms))
        self.assertIs(dct._data['k1'], itms[0][1])
        self.assertIs(dct._data['k2'], itms[1][1])

        self.assertEqual(len(dct), len(itms))

    def test__init_2(self):
        itms = {'k1' : ('v1',), 'k2' : ('v2',), 'k3' : ('v3',) }
        dct = dict_.Dict(itms)
        self.assertEqual(len(dct._data), len(itms))
        self.assertIs(dct._data['k1'], itms['k1'])
        self.assertIs(dct._data['k2'], itms['k2'])
        self.assertIs(dct._data['k3'], itms['k3'])
        #
        self.assertEqual(len(dct), len(itms))
        self.assertIs(dct['k1'], itms['k1'])
        self.assertIs(dct['k2'], itms['k2'])
        self.assertIs(dct['k3'], itms['k3'])

    def test__getitem_1(self):
        itms = {'k1' : ('v1',), 'k2' : ('v2',), 'k3' : ('v3',) }
        dct = dict_.Dict(itms)
        self.assertIs(dct['k1'], itms['k1'])
        self.assertIs(dct['k2'], itms['k2'])
        self.assertIs(dct['k3'], itms['k3'])

    def test__setitem_1(self):
        itms = {'k1' : ('v1',), 'k2' : ('v2',), 'k3' : ('v3',) }
        dct = dict_.Dict()

        dct['k1'] = itms['k1']
        self.assertEqual(len(dct._data), 1)
        self.assertIs(dct._data['k1'], itms['k1'])
        self.assertEqual(len(dct), 1)
        self.assertIs(dct['k1'], itms['k1'])

        dct['k2'] = itms['k2']
        self.assertEqual(len(dct._data), 2)
        self.assertIs(dct._data['k2'], itms['k2'])
        self.assertEqual(len(dct), 2)
        self.assertIs(dct['k2'], itms['k2'])

        dct['k3'] = itms['k3']
        self.assertEqual(len(dct._data), 3)
        self.assertIs(dct._data['k3'], itms['k3'])
        self.assertEqual(len(dct), 3)
        self.assertIs(dct['k3'], itms['k3'])

        newk2 = ('x2',)
        dct['k2'] = newk2
        self.assertEqual(len(dct._data), 3)
        self.assertIs(dct._data['k2'], newk2)
        self.assertEqual(len(dct), 3)
        self.assertIs(dct['k2'], newk2)

        newk3 = ('x3',)
        dct['k3'] = newk3
        self.assertEqual(len(dct._data), 3)
        self.assertIs(dct._data['k3'], newk3)
        self.assertEqual(len(dct), 3)
        self.assertIs(dct['k3'], newk3)

    def test__delitem_1(self):
        itms = {'k1' : ('v1',), 'k2' : ('v2',), 'k3' : ('v3',) }
        dct = dict_.Dict(itms)

        self.assertEqual(len(dct._data), 3)
        self.assertIs(dct._data['k1'],itms['k1'])
        self.assertIs(dct._data['k2'],itms['k2'])
        self.assertIs(dct._data['k3'],itms['k3'])
        self.assertEqual(len(dct), 3)
        self.assertIs(dct['k1'],itms['k1'])
        self.assertIs(dct['k2'],itms['k2'])
        self.assertIs(dct['k3'],itms['k3'])
        del dct['k1']
        self.assertEqual(len(dct._data), 2)
        self.assertIs(dct._data['k2'],itms['k2'])
        self.assertIs(dct._data['k3'],itms['k3'])
        self.assertEqual(len(dct), 2)
        self.assertIs(dct['k2'],itms['k2'])
        self.assertIs(dct['k3'],itms['k3'])

        del dct['k2']
        self.assertEqual(len(dct._data), 1)
        self.assertIs(dct._data['k3'],itms['k3'])
        self.assertEqual(len(dct), 1)
        self.assertIs(dct['k3'],itms['k3'])

        with self.assertRaises(KeyError): del dct['k1']
        with self.assertRaises(KeyError): del dct['k2']
        with self.assertRaises(KeyError): del dct['foo']

    def test__iter_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = dict_.Dict(itms)

        keys = [ t[0] for t in itms ]

        it = iter(dct)
        for i in range(len(itms)):
            x = next(it)
            self.assertTrue(x in keys)
            j = keys.index(x)
            self.assertIs(x, keys[j])
            keys.remove(x)

        with self.assertRaises(StopIteration): next(it)

    def test__keys_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = dict_.Dict(itms)

        keys = [ t[0] for t in itms ]

        for x in dct.keys():
            self.assertTrue(x in keys)
            j = keys.index(x)
            self.assertIs(x, keys[j])
            keys.remove(x)

    def test__items_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = dict_.Dict(itms)

        items = list(itms)

        for x in dct._data.items():
            self.assertTrue((x[0],x[1]) in items)
            j = items.index((x[0],x[1]))
            self.assertIs(x[0], items[j][0])
            self.assertIs(x[1], items[j][1])
            items.remove((x[0], x[1]))

        items = list(itms)

        for x in dct.items():
            self.assertTrue(x in items)
            j = items.index(x)
            self.assertIs(x[0], items[j][0])
            self.assertIs(x[1], items[j][1])
            items.remove(x)

    def test__values_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = dict_.Dict(itms)

        values = [ t[1] for t in itms ]

        for x in dct._data.values():
            self.assertTrue(x in values)
            j = values.index(x)
            self.assertIs(x, values[j])
            values.remove(x)

        values = [ t[1] for t in itms ]

        for x in dct.values():
            self.assertTrue(x in values)
            j = values.index(x)
            self.assertIs(x, values[j])
            values.remove(x)

    def test__get_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = dict_.Dict(itms)

        self.assertEqual(len(dct._data), 3)
        self.assertEqual(len(dct), 3)

        self.assertIs(dct.get('k1'), itms[0][1])
        self.assertEqual(len(dct._data), 3)
        self.assertTrue('k1' in dct._data)
        self.assertEqual(len(dct), 3)
        self.assertTrue('k1' in dct)

        self.assertIs(dct.get('k2'), itms[1][1])
        self.assertEqual(len(dct._data), 3)
        self.assertTrue('k2' in dct._data)
        self.assertEqual(len(dct), 3)
        self.assertTrue('k2' in dct)

        self.assertIs(dct.get('k3'), itms[2][1])
        self.assertEqual(len(dct._data), 3)
        self.assertTrue('k3' in dct._data)
        self.assertEqual(len(dct), 3)
        self.assertTrue('k3' in dct)

        default = 'bar'
        self.assertIs(dct.get('foo'), None)
        self.assertIs(dct.get('foo', default), default)

    def test__pop_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = dict_.Dict(itms)

        self.assertEqual(len(dct._data), 3)
        self.assertEqual(len(dct), 3)

        self.assertIs(dct.pop('k1'), itms[0][1])
        self.assertEqual(len(dct._data), 2)
        self.assertTrue('k1' not in dct._data)
        self.assertEqual(len(dct), 2)
        self.assertTrue('k1' not in dct)

        with self.assertRaises(KeyError): dct.pop('foo')

        self.assertIs(dct.pop('k2'), itms[1][1])
        self.assertEqual(len(dct._data), 1)
        self.assertTrue('k2' not in dct._data)
        self.assertEqual(len(dct), 1)
        self.assertTrue('k2' not in dct)

        self.assertIs(dct.pop('k3'), itms[2][1])
        self.assertEqual(len(dct._data), 0)
        self.assertTrue('k3' not in dct._data)
        self.assertEqual(len(dct), 0)
        self.assertTrue('k3' not in dct)

        with self.assertRaises(KeyError): dct.pop('k3')

    def test__popitem_1(self):
        itms = [ ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) ]
        dct = dict_.Dict(itms)

        self.assertEqual(len(dct._data), 3)
        self.assertEqual(len(dct), 3)

        for i in range(3,0,-1):
            item = dct.popitem()
            j = itms.index(item)
            self.assertIs(item[1], itms[j][1])
            self.assertEqual(len(dct), i-1)
            self.assertTrue(item[0] not in dct)
            del itms[j]

        with self.assertRaises(KeyError): dct.popitem()


    def test__clear_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = dict_.Dict(itms)

        dct.clear()

        self.assertEqual(len(dct._data), 0)
        self.assertEqual(len(dct), 0)

    def test__update_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = dict_.Dict()

        dct.update(itms)

        self.assertEqual(len(dct._data), 3)
        self.assertIs(dct._data['k1'], itms[0][1])
        self.assertIs(dct._data['k2'], itms[1][1])
        self.assertIs(dct._data['k3'], itms[2][1])

        self.assertEqual(len(dct), 3)
        self.assertIs(dct['k1'], itms[0][1])
        self.assertIs(dct['k2'], itms[1][1])
        self.assertIs(dct['k3'], itms[2][1])

        newk2 = ('v2',)
        newk4 = ('v4',)
        dct.update({ 'k2' : newk2 , 'k4' : newk4 })

        self.assertEqual(len(dct._data), 4)
        self.assertIs(dct._data['k2'], newk2)
        self.assertIs(dct._data['k4'], newk4)

        self.assertEqual(len(dct), 4)
        self.assertIs(dct['k2'], newk2)
        self.assertIs(dct['k4'], newk4)

    def test__setdefault_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)) )
        dct = dict_.Dict(itms)

        k3 = ('v3',)
        self.assertIs(dct.setdefault('k3', k3), k3)
        self.assertIs(dct._data['k3'], k3)
        self.assertIs(dct['k3'], k3)
        newk2 = ('v2',)
        self.assertIs(dct.setdefault('k2', newk2), itms[1][1])
        self.assertIs(dct._data['k2'], itms[1][1])
        self.assertIs(dct['k2'], itms[1][1])

        self.assertEqual(len(dct), 3)

    def test__repr_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)) )
        dct = dict_.Dict(itms)

        self.assertEqual(repr(dct), "Dict(%s)" % repr(dict(dct.items())))

class Test__DictSubclass(unittest.TestCase):
    def test__init_1(self):
        itms = (('k1', ('v1',)), ('k2', ('v2',)))
        dct = WrapDict(itms)
        self.assertEqual(len(dct._data), len(itms))
        self.assertIsInstance(dct._data['k1'], Val)
        self.assertIsInstance(dct._data['k2'], Val)
        self.assertIs(dct._data['k1'].obj, itms[0][1])
        self.assertIs(dct._data['k2'].obj, itms[1][1])

        self.assertIs(dct['k1'], itms[0][1])
        self.assertIs(dct['k2'], itms[1][1])

        self.assertEqual(len(dct), len(itms))

    def test__init_2(self):
        itms = {'k1' : ('v1',), 'k2' : ('v2',), 'k3' : ('v3',) }
        dct = WrapDict(itms)
        self.assertEqual(len(dct._data), len(itms))
        self.assertIsInstance(dct._data['k1'], Val)
        self.assertIsInstance(dct._data['k2'], Val)
        self.assertIsInstance(dct._data['k3'], Val)
        self.assertIs(dct._data['k1'].obj, itms['k1'])
        self.assertIs(dct._data['k2'].obj, itms['k2'])
        self.assertIs(dct._data['k3'].obj, itms['k3'])
        #
        self.assertEqual(len(dct), len(itms))
        self.assertIs(dct['k1'], itms['k1'])
        self.assertIs(dct['k2'], itms['k2'])
        self.assertIs(dct['k3'], itms['k3'])

    def test__getitem_1(self):
        itms = {'k1' : ('v1',), 'k2' : ('v2',), 'k3' : ('v3',) }
        dct = WrapDict(itms)
        self.assertIs(dct['k1'], itms['k1'])
        self.assertIs(dct['k2'], itms['k2'])
        self.assertIs(dct['k3'], itms['k3'])

    def test__setitem_1(self):
        itms = {'k1' : ('v1',), 'k2' : ('v2',), 'k3' : ('v3',) }
        dct = WrapDict()

        dct['k1'] = itms['k1']
        self.assertEqual(len(dct._data), 1)
        self.assertIsInstance(dct._data['k1'], Val)
        self.assertIs(dct._data['k1'].obj, itms['k1'])
        self.assertEqual(len(dct), 1)
        self.assertIs(dct['k1'], itms['k1'])

        dct['k2'] = itms['k2']
        self.assertEqual(len(dct._data), 2)
        self.assertIsInstance(dct._data['k2'], Val)
        self.assertIs(dct._data['k2'].obj, itms['k2'])
        self.assertEqual(len(dct), 2)
        self.assertIs(dct['k2'], itms['k2'])

        dct['k3'] = itms['k3']
        self.assertEqual(len(dct._data), 3)
        self.assertIsInstance(dct._data['k3'], Val)
        self.assertIs(dct._data['k3'].obj, itms['k3'])
        self.assertEqual(len(dct), 3)
        self.assertIs(dct['k3'], itms['k3'])

        newk2 = ('x2',)
        dct['k2'] = newk2
        self.assertEqual(len(dct._data), 3)
        self.assertIsInstance(dct._data['k2'], Val)
        self.assertIs(dct._data['k2'].obj, newk2)
        self.assertEqual(len(dct), 3)
        self.assertIs(dct['k2'], newk2)

        newk3 = ('x3',)
        dct['k3'] = newk3
        self.assertEqual(len(dct._data), 3)
        self.assertIsInstance(dct._data['k3'], Val)
        self.assertIs(dct._data['k3'].obj, newk3)
        self.assertEqual(len(dct), 3)
        self.assertIs(dct['k3'], newk3)

    def test__delitem_1(self):
        itms = {'k1' : ('v1',), 'k2' : ('v2',), 'k3' : ('v3',) }
        dct = WrapDict(itms)

        self.assertEqual(len(dct._data), 3)
        self.assertIsInstance(dct._data['k1'],Val)
        self.assertIsInstance(dct._data['k2'],Val)
        self.assertIsInstance(dct._data['k3'],Val)
        self.assertIs(dct._data['k1'].obj,itms['k1'])
        self.assertIs(dct._data['k2'].obj,itms['k2'])
        self.assertIs(dct._data['k3'].obj,itms['k3'])
        self.assertEqual(len(dct), 3)
        self.assertIs(dct['k1'],itms['k1'])
        self.assertIs(dct['k2'],itms['k2'])
        self.assertIs(dct['k3'],itms['k3'])
        del dct['k1']
        self.assertEqual(len(dct._data), 2)
        self.assertIsInstance(dct._data['k2'],Val)
        self.assertIsInstance(dct._data['k3'],Val)
        self.assertIs(dct._data['k2'].obj,itms['k2'])
        self.assertIs(dct._data['k3'].obj,itms['k3'])
        self.assertEqual(len(dct), 2)
        self.assertIs(dct['k2'],itms['k2'])
        self.assertIs(dct['k3'],itms['k3'])

        del dct['k2']
        self.assertEqual(len(dct._data), 1)
        self.assertIsInstance(dct._data['k3'],Val)
        self.assertIs(dct._data['k3'].obj,itms['k3'])
        self.assertEqual(len(dct), 1)
        self.assertIs(dct['k3'],itms['k3'])

        with self.assertRaises(KeyError): del dct['k1']
        with self.assertRaises(KeyError): del dct['k2']
        with self.assertRaises(KeyError): del dct['foo']

    def test__iter_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = WrapDict(itms)

        keys = [ t[0] for t in itms ]

        it = iter(dct._data)
        for i in range(len(itms)):
            x = next(it)
            self.assertIsInstance(x, Key)
            self.assertTrue(x.obj in keys)
            j = keys.index(x.obj)
            self.assertIs(x.obj, keys[j])
            keys.remove(x.obj)

        keys = [ t[0] for t in itms ]

        it = iter(dct)
        for i in range(len(itms)):
            x = next(it)
            self.assertTrue(x in keys)
            j = keys.index(x)
            self.assertIs(x, keys[j])
            keys.remove(x)

        with self.assertRaises(StopIteration): next(it)

    def test__keys_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = WrapDict(itms)

        keys = [ t[0] for t in itms ]

        for x in dct._data.keys():
            self.assertIsInstance(x, Key)
            self.assertTrue(x.obj in keys)
            j = keys.index(x.obj)
            self.assertIs(x.obj, keys[j])
            keys.remove(x.obj)

        keys = [ t[0] for t in itms ]

        for x in dct.keys():
            self.assertTrue(x in keys)
            j = keys.index(x)
            self.assertIs(x, keys[j])
            keys.remove(x)

    def test__items_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = WrapDict(itms)

        items = list(itms)

        for x in dct._data.items():
            self.assertIsInstance(x[0], Key)
            self.assertIsInstance(x[1], Val)
            self.assertTrue((x[0].obj,x[1].obj) in items)
            j = items.index((x[0].obj,x[1].obj))
            self.assertIs(x[0].obj, items[j][0])
            self.assertIs(x[1].obj, items[j][1])
            items.remove((x[0].obj, x[1].obj))

        items = list(itms)

        for x in dct.items():
            self.assertTrue(x in items)
            j = items.index(x)
            self.assertIs(x[0], items[j][0])
            self.assertIs(x[1], items[j][1])
            items.remove(x)

    def test__values_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = WrapDict(itms)

        values = [ t[1] for t in itms ]

        for x in dct._data.values():
            self.assertIsInstance(x, Val)
            self.assertTrue(x.obj in values)
            j = values.index(x.obj)
            self.assertIs(x.obj, values[j])
            values.remove(x.obj)

        values = [ t[1] for t in itms ]

        for x in dct.values():
            self.assertTrue(x in values)
            j = values.index(x)
            self.assertIs(x, values[j])
            values.remove(x)

    def test__get_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = WrapDict(itms)

        self.assertEqual(len(dct._data), 3)
        self.assertEqual(len(dct), 3)

        self.assertIs(dct.get('k1'), itms[0][1])
        self.assertEqual(len(dct._data), 3)
        self.assertTrue('k1' in dct._data)
        self.assertEqual(len(dct), 3)
        self.assertTrue('k1' in dct)

        self.assertIs(dct.get('k2'), itms[1][1])
        self.assertEqual(len(dct._data), 3)
        self.assertTrue('k2' in dct._data)
        self.assertEqual(len(dct), 3)
        self.assertTrue('k2' in dct)

        self.assertIs(dct.get('k3'), itms[2][1])
        self.assertEqual(len(dct._data), 3)
        self.assertTrue('k3' in dct._data)
        self.assertEqual(len(dct), 3)
        self.assertTrue('k3' in dct)

        default = 'bar'
        self.assertIs(dct.get('foo'), None)
        self.assertIs(dct.get('foo', default), default)

    def test__pop_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = WrapDict(itms)

        self.assertEqual(len(dct._data), 3)
        self.assertEqual(len(dct), 3)

        self.assertIs(dct.pop('k1'), itms[0][1])
        self.assertEqual(len(dct._data), 2)
        self.assertTrue('k1' not in dct._data)
        self.assertEqual(len(dct), 2)
        self.assertTrue('k1' not in dct)

        with self.assertRaises(KeyError): dct.pop('foo')

        self.assertIs(dct.pop('k2'), itms[1][1])
        self.assertEqual(len(dct._data), 1)
        self.assertTrue('k2' not in dct._data)
        self.assertEqual(len(dct), 1)
        self.assertTrue('k2' not in dct)

        self.assertIs(dct.pop('k3'), itms[2][1])
        self.assertEqual(len(dct._data), 0)
        self.assertTrue('k3' not in dct._data)
        self.assertEqual(len(dct), 0)
        self.assertTrue('k3' not in dct)

        with self.assertRaises(KeyError): dct.pop('k3')

    def test__popitem_1(self):
        itms = [ ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) ]
        dct = WrapDict(itms)

        self.assertEqual(len(dct._data), 3)
        self.assertEqual(len(dct), 3)

        for i in range(3,0,-1):
            item = dct.popitem()
            j = itms.index(item)
            self.assertIs(item[1], itms[j][1])
            self.assertEqual(len(dct), i-1)
            self.assertTrue(item[0] not in dct)
            del itms[j]

        with self.assertRaises(KeyError): dct.popitem()


    def test__clear_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = WrapDict(itms)

        dct.clear()

        self.assertEqual(len(dct._data), 0)
        self.assertEqual(len(dct), 0)

    def test__update_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)), ('k3', ('v3',)) )
        dct = WrapDict()

        dct.update(itms)

        self.assertEqual(len(dct._data), 3)
        self.assertIsInstance(dct._data['k1'], Val)
        self.assertIsInstance(dct._data['k2'], Val)
        self.assertIsInstance(dct._data['k3'], Val)
        self.assertIs(dct._data['k1'].obj, itms[0][1])
        self.assertIs(dct._data['k2'].obj, itms[1][1])
        self.assertIs(dct._data['k3'].obj, itms[2][1])

        self.assertEqual(len(dct), 3)
        self.assertIs(dct['k1'], itms[0][1])
        self.assertIs(dct['k2'], itms[1][1])
        self.assertIs(dct['k3'], itms[2][1])

        newk2 = ('v2',)
        newk4 = ('v4',)
        dct.update({ 'k2' : newk2 , 'k4' : newk4 })

        self.assertEqual(len(dct._data), 4)
        self.assertIsInstance(dct._data['k2'], Val)
        self.assertIsInstance(dct._data['k4'], Val)
        self.assertIs(dct._data['k2'].obj, newk2)
        self.assertIs(dct._data['k4'].obj, newk4)

        self.assertEqual(len(dct), 4)
        self.assertIs(dct['k2'], newk2)
        self.assertIs(dct['k4'], newk4)

    def test__setdefault_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)) )
        dct = WrapDict(itms)

        k3 = ('v3',)
        self.assertIs(dct.setdefault('k3', k3), k3)
        self.assertIsInstance(dct._data['k3'], Val)
        self.assertIs(dct._data['k3'].obj, k3)
        self.assertIs(dct['k3'], k3)
        newk2 = ('v2',)
        self.assertIs(dct.setdefault('k2', newk2), itms[1][1])
        self.assertIsInstance(dct._data['k2'], Val)
        self.assertIs(dct._data['k2'].obj, itms[1][1])
        self.assertIs(dct['k2'], itms[1][1])

        self.assertEqual(len(dct), 3)

    def test__repr_1(self):
        itms = ( ('k1', ('v1',)), ('k2', ('v2',)) )
        dct = WrapDict(itms)

        self.assertEqual(repr(dct), "WrapDict(%s)" % repr(dict(dct.items())))

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
