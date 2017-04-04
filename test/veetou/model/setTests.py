#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.set_ as set_

class Test__Set(unittest.TestCase):

    def test__init_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        _set = set_.Set(dogs)
        self.assertEqual(len(_set._data), len(set(dogs)))
        self.assertEqual(len(_set._counts), len(set(dogs)))
        for i in range(len(dogs)):
            self.assertIs(_set._data[dogs[i]], dogs[i])
            self.assertEqual(_set._counts[dogs[i]], dogs.count(dogs[i]))

    def test__init_2(self):
        dogs = (('Snoopy', 3), ('Cody', 5), ('Cody', 5), ('Lilly', 2), ('Snoopy', 3))
        _set = set_.Set(dogs)
        self.assertEqual(len(_set._data), len(set(dogs)))
        self.assertEqual(len(_set._counts), len(set(dogs)))
        for i in range(len(dogs)):
            self.assertIs(_set._data[dogs[i]], dogs[dogs.index(dogs[i])])
            self.assertEqual(_set._counts[dogs[i]], dogs.count(dogs[i]))

    def test__contains_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        lessie = ('Lessie', 10)
        _set = set_.Set(dogs)
        self.assertTrue(dogs[0] in _set)
        self.assertTrue(dogs[1] in _set)
        self.assertTrue(('Snoopy', 3) in _set)
        self.assertTrue(('Cody', 5) in _set)
        self.assertFalse(lessie in _set)

    def test__iter_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        dogs = tuple(dict(zip(dogs,dogs)))
        _set = set_.Set(dogs)
        it = iter(dogs)
        self.assertIs(next(it), dogs[0])
        self.assertIs(next(it), dogs[1])

    def test__len_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        self.assertEqual(len(set_.Set()), 0)
        self.assertEqual(len(set_.Set(dogs)), 2)

    def test__add_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        lessie = ('Lessie', 10)
        _set = set_.Set(dogs)
        self.assertEqual(len(_set), 2)
        self.assertIs(_set.add(lessie), lessie)
        self.assertEqual(len(_set), 3)
        self.assertTrue(lessie in _set)
        self.assertEqual(_set.count(('Lessie', 10)), 1)

        self.assertIs(_set.add(('Lessie', 10)), lessie)
        self.assertEqual(len(_set), 3)
        self.assertTrue(lessie in _set)
        self.assertEqual(_set.count(('Lessie', 10)), 2)

    def test__inc_dec_count_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        lessie = ('Lessie', 10)
        _set = set_.Set(dogs)
        self.assertEqual(len(_set), 2)
        self.assertEqual(_set.inc(lessie), 1)
        self.assertEqual(len(_set), 3)
        self.assertTrue(lessie in _set)
        self.assertEqual(_set.count(('Lessie', 10)), 1)

        self.assertEqual(_set.inc(('Lessie', 10)), 2)
        self.assertEqual(len(_set), 3)
        self.assertTrue(lessie in _set)
        self.assertEqual(_set.count(('Lessie', 10)), 2)

        self.assertEqual(_set.dec(('Lessie', 10)), 1)
        self.assertEqual(len(_set), 3)
        self.assertTrue(lessie in _set)
        self.assertEqual(_set.count(('Lessie', 10)), 1)

        self.assertEqual(_set.dec(('Lessie', 10)), 0)
        self.assertEqual(len(_set), 2)
        self.assertTrue(lessie not in _set)
        self.assertEqual(_set.count(('Lessie', 10)), 0)

        with self.assertRaises(KeyError): _set.dec(('Lessie', 10))

    def test__discard_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        lessie = ('Lessie', 10)
        _set = set_.Set(dogs)
        self.assertEqual(len(_set), 2)
        _set.discard(dogs[1])
        _set.discard(lessie)
        self.assertEqual(len(_set), 1)
        self.assertTrue(dogs[0]     in _set)
        self.assertTrue(dogs[1] not in _set)

    def test__clear_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        _set = set_.Set(dogs)
        _set.clear()
        self.assertEqual(len(_set), 0)
        self.assertEqual(len(_set._data), 0)

    def test__pop_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        dogs = tuple(dict(zip(dogs,dogs)))
        _set = set_.Set(dogs)
        self.assertEqual(len(_set), 2)
        dog = _set.pop()
        self.assertTrue(dog is dogs[0] or dog is dogs[1])
        self.assertEqual(len(_set), 1)
        dog = _set.pop()
        self.assertTrue(dog is dogs[0] or dog is dogs[1])
        self.assertEqual(len(_set), 0)
        with self.assertRaises(KeyError): _set.pop()

    def test__remove_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        _set = set_.Set(dogs)
        self.assertEqual(len(_set), 2)
        _set.remove(('Snoopy', 3))
        self.assertEqual(len(_set), 1)
        _set.remove(('Cody', 5))
        self.assertEqual(len(_set), 0)
        with self.assertRaises(KeyError): _set.remove(('Snoopy', 3))

    def test__getitem_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        _set = set_.Set(dogs)
        self.assertIs(_set[('Snoopy', 3)], dogs[0])
        self.assertIs(_set[('Cody', 5)], dogs[1])
        _set.add(('Snoopy', 3))
        self.assertIs(_set[('Snoopy', 3)], dogs[0])

    def test__getitem_2(self):
        _set = set_.Set()
        with self.assertRaises(KeyError): _set[('Snoopy', 3)]

    def test__get_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        garfield = ('Garfield', 3)
        _set = set_.Set(dogs)
        self.assertIs(_set.get(('Snoopy', 3)), dogs[0])
        self.assertIsNone(_set.get(('Lessie', 10)))
        self.assertIs(_set.get(('Cody', 5), garfield), dogs[1])
        self.assertIs(_set.get(('Lessie', 10), garfield), garfield)

    def test__repr_1(self):
        dogs = (('Snoopy', 3), ('Cody', 5))
        self.assertEqual(repr(set_.Set(dogs)), 'Set([%r,%r])' % tuple(dict(zip(dogs,dogs))))


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
