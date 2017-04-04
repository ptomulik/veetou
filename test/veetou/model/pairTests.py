#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.pair_ as pair_
import veetou.model.list_ as list_

class Test__Pair(unittest.TestCase):
    def test__init_1(self):
        rel = pair_.Pair(21, 12)
        self.assertEqual(rel._data, (21,12))

    def test__getitem_1(self):
        rel = pair_.Pair(21, 12)
        self.assertEqual(rel[0], 21)
        self.assertEqual(rel[1], 12)

    def test__getitem_2(self):
        rel = pair_.Pair(21, 12)
        self.assertEqual(rel[-1], 12)
        self.assertEqual(rel[-2], 21)

    def test__getitem_3(self):
        rel = pair_.Pair(21, 12)
        with self.assertRaises(IndexError): rel[2]
        with self.assertRaises(IndexError): rel[-3]

    def test__left_right_1(self):
        rel = pair_.Pair(21, 12)
        self.assertEqual(rel.left, 21)
        self.assertEqual(rel.right, 12)

    def test__hash_1(self):
        rel = pair_.Pair(12,34)
        self.assertEqual(hash(rel), hash(rel))
        self.assertEqual(hash(rel), hash(pair_.Pair(12,34)))
        self.assertNotEqual(hash(rel), hash(pair_.Pair(56,78)))

    def test__contains_1(self):
        rel = pair_.Pair(12,34)
        self.assertTrue(12 in rel)
        self.assertTrue(34 in rel)
        self.assertFalse(78 in rel)

    def test__iter_1(self):
        it = iter(pair_.Pair(12,34))
        self.assertEqual(next(it),12)
        self.assertEqual(next(it),34)

    def test__reversed_1(self):
        rev = tuple(reversed(pair_.Pair(12,34)))
        self.assertEqual(rev[0],34)
        self.assertEqual(rev[1],12)

    def test__index_1(self):
        rel = pair_.Pair(12,34)
        self.assertEqual(rel.index(12), 0)
        self.assertEqual(rel.index(34), 1)
        with self.assertRaises(ValueError): rel.index(123)

    def test__count_1(self):
        self.assertEqual(pair_.Pair(12,34).count(12), 1)
        self.assertEqual(pair_.Pair(12,34).count(34), 1)
        self.assertEqual(pair_.Pair(12,12).count(12), 2)
        self.assertEqual(pair_.Pair(12,34).count(56), 0)

    def test__eq_1(self):
        self.assertTrue(pair_.Pair(12,34) == pair_.Pair(12,34))
        self.assertFalse(pair_.Pair(12,34) == pair_.Pair(32,12))

    def test__repr_1(self):
        self.assertEqual(repr(pair_.Pair(12,34)), 'Pair(%r,%r)' % (12, 34))

class Test__PairList(unittest.TestCase):
    def test__subclass_1(self):
        self.assertTrue(issubclass(pair_.PairList, list_.List))

    def test__wrap_2(self):
        p = pair_.Pair(0,1)
        self.assertIs(pair_.PairList().__wrap__(p),p)

    def test__wrap_1(self):
        with self.assertRaisesRegex(TypeError, r'%s is not an instance of %s' % (repr('foo'), repr(pair_.Pair))):
            pair_.PairList().__wrap__('foo')

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
