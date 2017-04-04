#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.mapset_ as mapset_
import veetou.model.dict_ as dict_
import veetou.model.tuple_ as tuple_
import collections
import collections.abc

Tuple = tuple_.Tuple

class Test__Mapset(unittest.TestCase):
    def test__subclass_1(self):
        self.assertTrue(issubclass(mapset_.Mapset, collections.abc.MutableMapping))

    def test__init_1(self):
        dogs = ((0, Tuple(('Cody', 5))), (1, Tuple(('Snoopy', 2))))
        mset = mapset_.Mapset(dogs)
        self.assertEqual(len(mset._data), len(dogs))
        self.assertIs(mset._data[0], dogs[0][1])
        self.assertIs(mset._data[1], dogs[1][1])
        self.assertEqual(mset._set.count(dogs[0][1]), 1)
        self.assertEqual(mset._set.count(dogs[1][1]), 1)

    def test__init_2(self):
        dogs = {'cody1' : Tuple(('Cody', 5)), 'snoopy' : Tuple(('Snoopy', 2)), 'cody2' : Tuple(('Cody', 5)) }
        mset = mapset_.Mapset(dogs)
        self.assertEqual(len(mset._data), len(dogs))
        self.assertTrue(mset._data['cody1'] is dogs['cody1'] or mset._data['cody1'] is dogs['cody2'])
        self.assertTrue(mset._data['snoopy'] is dogs['snoopy'])
        self.assertTrue(mset._data['cody2'] is dogs['cody1'] or mset._data['cody2'] is dogs['cody2'])
        self.assertEqual(mset._set.count(Tuple(('Cody', 5))), 2)
        self.assertEqual(mset._set.count(Tuple(('Snoopy', 2))), 1)

    def test__getitem_1(self):
        dogs = {'cody1' : Tuple(('Cody', 5)), 'snoopy' : Tuple(('Snoopy', 2)), 'cody2' : Tuple(('Cody', 5)) }
        mset = mapset_.Mapset(dogs)
        self.assertTrue(mset['cody1'] is dogs['cody1'] or mset['cody1'] is dogs['cody2'])
        self.assertTrue(mset['snoopy'] is dogs['snoopy'])
        self.assertTrue(mset['cody2'] is dogs['cody1'] or mset['cody2'] is dogs['cody2'])

    def test__setitem_1(self):
        dogs = {'cody1' : Tuple(('Cody', 5)), 'snoopy' : Tuple(('Snoopy', 2)), 'cody2' : Tuple(('Cody', 5)) }
        mset = mapset_.Mapset()

        mset['cody1'] = dogs['cody1']
        self.assertEqual(len(mset), 1)
        self.assertIs(mset['cody1'], dogs['cody1'])
        self.assertEqual(mset.count(Tuple(('Cody', 5))), 1)

        mset['snoopy'] = dogs['snoopy']
        self.assertEqual(len(mset), 2)
        self.assertIs(mset['snoopy'], dogs['snoopy'])
        self.assertEqual(mset.count(Tuple(('Snoopy', 2))), 1)

        mset['cody2'] = dogs['cody2']
        self.assertEqual(len(mset), 3)
        self.assertIs(mset['cody2'], dogs['cody1'])
        self.assertEqual(mset.count(Tuple(('Cody', 5))), 2)

        newsnoopy = Tuple(('Snoopy', 3))
        mset['snoopy'] = newsnoopy
        self.assertEqual(len(mset), 3)
        self.assertIs(mset['snoopy'], newsnoopy)
        self.assertEqual(mset.count(Tuple(('Snoopy', 2))), 0)
        self.assertEqual(mset.count(Tuple(('Snoopy', 3))), 1)

        newcody = Tuple(('Cody', 6))
        mset['cody2'] = newcody
        self.assertEqual(len(mset), 3)
        self.assertIs(mset['cody2'], newcody)
        self.assertEqual(mset.count(Tuple(('Cody', 5))), 1)
        self.assertEqual(mset.count(Tuple(('Cody', 6))), 1)

    def test__delitem_1(self):
        dogs = {'cody1' : Tuple(('Cody', 5)), 'snoopy' : Tuple(('Snoopy', 2)), 'cody2' : Tuple(('Cody', 5)) }
        mset = mapset_.Mapset(dogs)

        self.assertEqual(len(mset), 3)
        del mset['cody1']
        self.assertEqual(len(mset), 2)
        self.assertEqual(mset.count(Tuple(('Cody', 5))), 1)

        del mset['snoopy']
        self.assertEqual(len(mset), 1)
        self.assertEqual(mset.count(Tuple(('Snoopy', 2))), 0)

        with self.assertRaises(KeyError): del mset['cody1']
        with self.assertRaises(KeyError): del mset['snoopy']
        with self.assertRaises(KeyError): del mset['foo']

    def test__iter_1(self):
        dogs = ( ('cody1', Tuple(('Cody', 5))), ('snoopy', Tuple(('Snoopy', 2))), ('cody2', Tuple(('Cody', 5))) )
        mset = mapset_.Mapset(dogs)

        keys = [ d[0] for d in dogs]

        it = iter(mset)
        for i in range(3):
            x = next(it)
            self.assertTrue(x in keys)
            keys.remove(x)

        with self.assertRaises(StopIteration): next(it)

    def test__pop_1(self):
        dogs = ( ('cody1', Tuple(('Cody', 5))), ('snoopy', Tuple(('Snoopy', 2))), ('cody2', Tuple(('Cody', 5))) )
        mset = mapset_.Mapset(dogs)

        self.assertEqual(len(mset), 3)

        self.assertIs(mset.pop('cody1'), dogs[0][1])
        self.assertEqual(len(mset), 2)
        self.assertTrue('cody1' not in mset)

        with self.assertRaises(KeyError): mset.pop('foo')

        self.assertIs(mset.pop('snoopy'), dogs[1][1])
        self.assertEqual(len(mset), 1)
        self.assertTrue('snoopy' not in mset)

        self.assertIs(mset.pop('cody2'), dogs[0][1])
        self.assertEqual(len(mset), 0)
        self.assertTrue('cody2' not in mset)

        with self.assertRaises(KeyError): mset.pop('cody2')

    def test__popitem_1(self):
        dogs = [ ('cody1', Tuple(('Cody', 5))), ('snoopy', Tuple(('Snoopy', 2))), ('cody2', Tuple(('Cody', 5))) ]
        mset = mapset_.Mapset(dogs)

        self.assertEqual(len(mset), 3)

        for i in range(len(dogs),0,-1):
            item = mset.popitem()
            index = dogs.index(item)
            self.assertEqual(len(mset), i-1)
            self.assertTrue(item[0] not in mset)
            del dogs[index]

        with self.assertRaises(KeyError): mset.popitem()


    def test__clear_1(self):
        dogs = ( ('cody1', Tuple(('Cody', 5))), ('snoopy', Tuple(('Snoopy', 2))), ('cody2', Tuple(('Cody', 5))) )
        mset = mapset_.Mapset(dogs)

        mset.clear()

        self.assertEqual(len(mset), 0)
        self.assertEqual(len(mset._data), 0)
        self.assertEqual(len(mset._set), 0)

    def test__update_1(self):
        dogs = ( ('cody1', Tuple(('Cody', 5))), ('snoopy', Tuple(('Snoopy', 2))), ('cody2', Tuple(('Cody', 5))) )
        mset = mapset_.Mapset()

        mset.update(dogs)

        self.assertEqual(len(mset), 3)
        self.assertIs(mset['cody1'], dogs[0][1])
        self.assertIs(mset['snoopy'],dogs[1][1])
        self.assertIs(mset['cody2'], dogs[0][1])
        self.assertEqual(mset.count(Tuple(('Cody', 5))), 2)
        self.assertEqual(mset.count(Tuple(('Snoopy', 2))), 1)

        newsnoopy = Tuple(('Snoopy', 3))
        lessie = Tuple(('Lessie', 4))
        mset.update({ 'snoopy' : newsnoopy , 'lessie' : lessie })

        self.assertEqual(len(mset), 4)
        self.assertIs(mset['snoopy'], newsnoopy)
        self.assertIs(mset['lessie'], lessie)

    def test__setdefault_1(self):
        dogs = ( ('cody', Tuple(('Cody', 5))), ('snoopy', Tuple(('Snoopy', 2))) )
        mset = mapset_.Mapset(dogs)

        lessie = Tuple(('Lessie', 4))
        self.assertIs(mset.setdefault('lessie', lessie), lessie)
        self.assertIs(mset['lessie'], lessie)
        newsnoopy = Tuple(('Snoopy', 3))
        self.assertIs(mset.setdefault('snoopy', newsnoopy), dogs[1][1])
        self.assertIs(mset['snoopy'], dogs[1][1])

        self.assertEqual(len(mset), 3)
        self.assertEqual(mset.count(Tuple(('Snoopy', 2))), 1)

    def test__keywrap_1(self):
        class Key(object):
            def __init__(self, obj):
                self._obj = obj

            @property
            def obj(self):
                return self._obj

            def __eq__(self, other):
                if isinstance(other, Key):
                    return self.obj == other.obj
                else:
                    return False

            def __hash__(self):
                return hash(self.obj)

        class MyDict(mapset_.Mapset):
            def __keywrap__(self, key):
                return Key(key)
            def __keyunwrap__(self, key):
                return key.obj

        itms = ((('k1',),('v1',)), (('k2',),('v2',)),(('k3',),('v1',)))
        dct = MyDict(itms)

        self.assertTrue(('k1',) in dct)
        self.assertTrue(('k2',) in dct)
        self.assertTrue(('k3',) in dct)

        k1 = dct[('k1',)]
        k2 = dct[('k2',)]
        k3 = dct[('k3',)]

        self.assertTrue(dct[('k1',)] is itms[0][1] or dct[('k1',)] is itms[2][1])
        self.assertIs(dct[('k1',)], dct[('k3',)])
        self.assertIs(dct[('k2',)], itms[1][1])

        keys = [ t[0] for t in itms ]
        for k in dct._data.keys():
            self.assertIsInstance(k, Key)
            self.assertTrue(k.obj in keys)
            j = keys.index(k.obj)
            self.assertIs(k.obj, keys[j])
            keys.remove(k.obj)

        keys = [ t[0] for t in itms ]
        for k in dct.keys():
            self.assertTrue(k in keys)
            j = keys.index(k)
            self.assertIs(k, keys[j])
            keys.remove(k)


    def test__wrap_1(self):
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
                    return False

            def __hash__(self):
                return hash(self.obj)

        class MyDict(mapset_.Mapset):
            def __wrap__(self, key):
                return Val(key)
            def __unwrap__(self, key):
                return key.obj

        itms = ((('k1',),('v1',)), (('k2',),('v2',)),(('k3',),('v1',)))
        dct = MyDict(itms)

        self.assertTrue(('k1',) in dct)
        self.assertTrue(('k2',) in dct)
        self.assertTrue(('k3',) in dct)

        k1 = dct[('k1',)]
        k2 = dct[('k2',)]
        k3 = dct[('k3',)]

        self.assertTrue(dct[('k1',)] is itms[0][1] or dct[('k1',)] is itms[2][1])
        self.assertIs(dct[('k1',)], dct[('k3',)])
        self.assertIs(dct[('k2',)], itms[1][1])

        values = [ t[1] for t in itms ]
        for x in dct._data.values():
            self.assertIsInstance(x, Val)
            self.assertTrue(x.obj in values)
            j = [ i for i in range(len(values)) if x.obj is values[i] ]
            k = [ i for i in range(len(values)) if x.obj == values[i] and x.obj is not values[i] ]
            self.assertEqual(len(j), 1)
            for kk in k: del values[kk]

        values = [ t[1] for t in itms ]
        for x in dct.values():
            self.assertTrue(x in values)
            j = [ i for i in range(len(values)) if x is values[i] ]
            k = [ i for i in range(len(values)) if x == values[i] and x is not values[i] ]
            self.assertEqual(len(j), 1)
            for kk in k: del values[kk]


    def test__dictclass_1(self):
        class OrdDict(mapset_.Mapset):
            @classmethod
            def __dictclass__(cls):
                return collections.OrderedDict

        dogs = ( ('cody1', ('Cody', 5)), ('snoopy', ('Snoopy', 2)), ('cody2', ('Cody', 5)) )

        dct = OrdDict(dogs)
        self.assertIsInstance(dct._data, collections.OrderedDict)

        i = 0
        for item in dct.items():
            self.assertEqual(item[0], dogs[i][0])
            self.assertEqual(item[1], dogs[i][1])
            i += 1

    def test__repr_1(self):
        dogs = ( ('cody', Tuple(('Cody', 5))), ('snoopy', Tuple(('Snoopy', 2))) )
        mset = mapset_.Mapset(dogs)

        self.assertEqual(repr(mset), "Mapset(%s)" % repr(dict(mset.items())))

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
