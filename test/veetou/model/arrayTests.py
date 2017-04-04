#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.array_ as array_

class Test__Array(unittest.TestCase):

    def test__len_1(self):
        self.assertEqual(len(array_.Array()), 0)
        self.assertEqual(len(array_.Array(['foo','bar','geez'])), 3)

    def test__getitem_1(self):
        array = array_.Array(['foo', 'bar'])
        self.assertEqual(array[0], 'foo')
        self.assertEqual(array[1], 'bar')

    def test__getitem_2(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        self.assertEqual(array[:2], array_.Array(['foo', 'bar']))
        self.assertEqual(array[1:], array_.Array(['bar', 'geez']))

    def test__getitem_3(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        with self.assertRaises(IndexError): array[-4]
        with self.assertRaises(IndexError): array[ 3]

    def test__setitem_by_index_1(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        array[0] = 'xxx'
        self.assertEqual(array[0], 'xxx')
        self.assertEqual(array[1], 'bar')
        self.assertEqual(array[2], 'geez')

    def test__setitem_by_index_2(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        array[-1] = 'xxx'
        self.assertEqual(array[0], 'foo')
        self.assertEqual(array[1], 'bar')
        self.assertEqual(array[2], 'xxx')

    def test__setitem_by_index_3(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        with self.assertRaises(IndexError): array[ 3] = 'xxx'
        with self.assertRaises(IndexError): array[-4] = 'xxx'
        self.assertEqual(array, ['foo', 'bar', 'geez'])

    def test__setitem_by_slice_1(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        array[:] = ['a', 'b', 'c']
        self.assertEqual(len(array), 3)
        self.assertEqual(array, ['a', 'b', 'c'])

    def test__setitem_by_slice_2(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        array[:2] = ['a', 'b']
        self.assertEqual(len(array), 3)
        self.assertEqual(array, ['a', 'b', 'geez'])

    def test__setitem_by_slice_3(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        array[1:] = ['a', 'b']
        self.assertEqual(len(array), 3)
        self.assertEqual(array, ['foo', 'a', 'b'])

    def test__setitem_by_slice_4(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        array[1:] = ['a', 'b', 'c']
        self.assertEqual(len(array), 3)
        self.assertEqual(array, ['foo', 'a', 'b'])

    def test__setitem_by_slice_5(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        array[3:] = ['a', 'b', 'c']
        self.assertEqual(len(array), 3)
        self.assertEqual(array, ['foo', 'bar', 'geez'])

    def test__setitem_by_slice_6(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        array[2:5] = ['a', 'b', 'c']
        self.assertEqual(len(array), 3)
        self.assertEqual(array, ['foo', 'bar', 'a'])

    def test__contains_1(self):
        array = array_.Array(['foo', 'bar'])
        self.assertTrue('foo'     in array)
        self.assertTrue('bar'     in array)
        self.assertTrue('gex' not in array)

    def test__iter_1(self):
        array = array_.Array(['foo', 'bar'])
        it   = iter(array)
        self.assertEqual(next(it), 'foo')
        self.assertEqual(next(it), 'bar')

    def test__reversed_1(self):
        array = array_.Array(['foo', 'bar', 'geez'])
        self.assertEqual(list(reversed(array)), ['geez', 'bar', 'foo'])

    def test__eq_1(self):
        self.assertTrue( array_.Array() == array_.Array())
        self.assertTrue( array_.Array(['foo', 'bar']) == array_.Array(['foo', 'bar']))
        self.assertFalse(array_.Array(['foo', 'bar']) == array_.Array(['bar', 'foo']))
        self.assertFalse(array_.Array(['foo']) == array_.Array(['foo', 'bar']))
        self.assertFalse(array_.Array(['foo', 'bar']) == array_.Array(['foo']))

    def test__eq_2(self):
        self.assertTrue( array_.Array() == list())
        self.assertTrue( list() == array_.Array())
        self.assertTrue( array_.Array(['a', 'b']) == list(['a', 'b']))
        self.assertTrue( list(['a', 'b']) == array_.Array(['a', 'b']))

    def test__ne_1(self):
        self.assertFalse(array_.Array() != array_.Array())
        self.assertFalse(array_.Array(['foo', 'bar']) != array_.Array(['foo', 'bar']))
        self.assertTrue( array_.Array(['foo', 'bar']) != array_.Array(['bar', 'foo']))
        self.assertTrue( array_.Array(['foo']) != array_.Array(['foo', 'bar']))
        self.assertTrue( array_.Array(['foo', 'bar']) != array_.Array(['foo']))

    def test__lt_1(self):
        self.assertFalse(array_.Array() < array_.Array())
        self.assertFalse(array_.Array(['foo', 'bar']) < array_.Array(['foo', 'bar']))
        self.assertFalse(array_.Array(['foo', 'bar']) < array_.Array(['bar', 'foo']))
        self.assertTrue( array_.Array(['foo']) < array_.Array(['foo', 'bar']))
        self.assertFalse(array_.Array(['foo', 'bar']) < array_.Array(['foo']))
        self.assertTrue( array_.Array(['a', 'b']) < array_.Array(['c', 'b']))
        self.assertFalse(array_.Array(['c', 'b']) < array_.Array(['a', 'b']))

    def test__gt_1(self):
        self.assertFalse(array_.Array() > array_.Array())
        self.assertFalse(array_.Array(['foo', 'bar']) > array_.Array(['foo', 'bar']))
        self.assertTrue( array_.Array(['foo', 'bar']) > array_.Array(['bar', 'foo']))
        self.assertFalse(array_.Array(['foo']) > array_.Array(['foo', 'bar']))
        self.assertTrue( array_.Array(['foo', 'bar']) > array_.Array(['foo']))
        self.assertFalse(array_.Array(['a', 'b']) > array_.Array(['c', 'b']))
        self.assertTrue( array_.Array(['c', 'b']) > array_.Array(['a', 'b']))

    def test__le_1(self):
        self.assertTrue(array_.Array() <= array_.Array())
        self.assertTrue(array_.Array(['foo', 'bar']) <= array_.Array(['foo', 'bar']))
        self.assertFalse(array_.Array(['foo', 'bar']) <= array_.Array(['bar', 'foo']))
        self.assertTrue( array_.Array(['foo']) <= array_.Array(['foo', 'bar']))
        self.assertFalse(array_.Array(['foo', 'bar']) <= array_.Array(['foo']))
        self.assertTrue( array_.Array(['a', 'b']) <= array_.Array(['c', 'b']))
        self.assertFalse(array_.Array(['c', 'b']) <= array_.Array(['a', 'b']))

    def test__ge_1(self):
        self.assertTrue( array_.Array() >= array_.Array())
        self.assertTrue( array_.Array(['foo', 'bar']) >= array_.Array(['foo', 'bar']))
        self.assertTrue( array_.Array(['foo', 'bar']) >= array_.Array(['bar', 'foo']))
        self.assertFalse(array_.Array(['foo']) >= array_.Array(['foo', 'bar']))
        self.assertTrue( array_.Array(['foo', 'bar']) >= array_.Array(['foo']))
        self.assertFalse(array_.Array(['a', 'b']) >= array_.Array(['c', 'b']))
        self.assertTrue( array_.Array(['c', 'b']) >= array_.Array(['a', 'b']))

    def test__repr_1(self):
        self.assertEqual(repr(array_.Array(['foo', 'bar'])), "Array([%r,%r])" % ('foo', 'bar'))

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
