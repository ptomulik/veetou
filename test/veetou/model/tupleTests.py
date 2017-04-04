#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.tuple_ as tuple_

class Test__Tuple(unittest.TestCase):

    def test__len_1(self):
        self.assertEqual(len(tuple_.Tuple()), 0)
        self.assertEqual(len(tuple_.Tuple(['foo','bar','geez'])), 3)

    def test__getitem_1(self):
        _tuple = tuple_.Tuple(['foo', 'bar'])
        self.assertEqual(_tuple[0], 'foo')
        self.assertEqual(_tuple[1], 'bar')

    def test__getitem_2(self):
        _tuple = tuple_.Tuple(['foo', 'bar', 'geez'])
        self.assertEqual(_tuple[:2], tuple_.Tuple(['foo', 'bar']))
        self.assertEqual(_tuple[1:], tuple_.Tuple(['bar', 'geez']))

    def test__getitem_3(self):
        _tuple = tuple_.Tuple(['foo', 'bar', 'geez'])
        with self.assertRaises(IndexError): _tuple[-4]
        with self.assertRaises(IndexError): _tuple[ 3]

    def test__contains_1(self):
        _tuple = tuple_.Tuple(['foo', 'bar'])
        self.assertTrue('foo'     in _tuple)
        self.assertTrue('bar'     in _tuple)
        self.assertTrue('gex' not in _tuple)

    def test__iter_1(self):
        _tuple = tuple_.Tuple(['foo', 'bar'])
        it   = iter(_tuple)
        self.assertEqual(next(it), 'foo')
        self.assertEqual(next(it), 'bar')

    def test__reversed_1(self):
        _tuple = tuple_.Tuple(['foo', 'bar', 'geez'])
        self.assertEqual(list(reversed(_tuple)), ['geez', 'bar', 'foo'])

    def test__eq_1(self):
        self.assertTrue( tuple_.Tuple() == tuple_.Tuple())
        self.assertTrue( tuple_.Tuple(['foo', 'bar']) == tuple_.Tuple(['foo', 'bar']))
        self.assertFalse(tuple_.Tuple(['foo', 'bar']) == tuple_.Tuple(['bar', 'foo']))
        self.assertFalse(tuple_.Tuple(['foo']) == tuple_.Tuple(['foo', 'bar']))
        self.assertFalse(tuple_.Tuple(['foo', 'bar']) == tuple_.Tuple(['foo']))

    def test__eq_2(self):
        self.assertTrue( tuple_.Tuple() == tuple())
        self.assertTrue( tuple() == tuple_.Tuple())
        self.assertTrue( tuple_.Tuple(['a', 'b']) == tuple(['a', 'b']))
        self.assertTrue( tuple(['a', 'b']) == tuple_.Tuple(['a', 'b']))

    def test__ne_1(self):
        self.assertFalse(tuple_.Tuple() != tuple_.Tuple())
        self.assertFalse(tuple_.Tuple(['foo', 'bar']) != tuple_.Tuple(['foo', 'bar']))
        self.assertTrue( tuple_.Tuple(['foo', 'bar']) != tuple_.Tuple(['bar', 'foo']))
        self.assertTrue( tuple_.Tuple(['foo']) != tuple_.Tuple(['foo', 'bar']))
        self.assertTrue( tuple_.Tuple(['foo', 'bar']) != tuple_.Tuple(['foo']))

    def test__lt_1(self):
        self.assertFalse(tuple_.Tuple() < tuple_.Tuple())
        self.assertFalse(tuple_.Tuple(['foo', 'bar']) < tuple_.Tuple(['foo', 'bar']))
        self.assertFalse(tuple_.Tuple(['foo', 'bar']) < tuple_.Tuple(['bar', 'foo']))
        self.assertTrue( tuple_.Tuple(['foo']) < tuple_.Tuple(['foo', 'bar']))
        self.assertFalse(tuple_.Tuple(['foo', 'bar']) < tuple_.Tuple(['foo']))
        self.assertTrue( tuple_.Tuple(['a', 'b']) < tuple_.Tuple(['c', 'b']))
        self.assertFalse(tuple_.Tuple(['c', 'b']) < tuple_.Tuple(['a', 'b']))

    def test__gt_1(self):
        self.assertFalse(tuple_.Tuple() > tuple_.Tuple())
        self.assertFalse(tuple_.Tuple(['foo', 'bar']) > tuple_.Tuple(['foo', 'bar']))
        self.assertTrue( tuple_.Tuple(['foo', 'bar']) > tuple_.Tuple(['bar', 'foo']))
        self.assertFalse(tuple_.Tuple(['foo']) > tuple_.Tuple(['foo', 'bar']))
        self.assertTrue( tuple_.Tuple(['foo', 'bar']) > tuple_.Tuple(['foo']))
        self.assertFalse(tuple_.Tuple(['a', 'b']) > tuple_.Tuple(['c', 'b']))
        self.assertTrue( tuple_.Tuple(['c', 'b']) > tuple_.Tuple(['a', 'b']))

    def test__le_1(self):
        self.assertTrue(tuple_.Tuple() <= tuple_.Tuple())
        self.assertTrue(tuple_.Tuple(['foo', 'bar']) <= tuple_.Tuple(['foo', 'bar']))
        self.assertFalse(tuple_.Tuple(['foo', 'bar']) <= tuple_.Tuple(['bar', 'foo']))
        self.assertTrue( tuple_.Tuple(['foo']) <= tuple_.Tuple(['foo', 'bar']))
        self.assertFalse(tuple_.Tuple(['foo', 'bar']) <= tuple_.Tuple(['foo']))
        self.assertTrue( tuple_.Tuple(['a', 'b']) <= tuple_.Tuple(['c', 'b']))
        self.assertFalse(tuple_.Tuple(['c', 'b']) <= tuple_.Tuple(['a', 'b']))

    def test__ge_1(self):
        self.assertTrue( tuple_.Tuple() >= tuple_.Tuple())
        self.assertTrue( tuple_.Tuple(['foo', 'bar']) >= tuple_.Tuple(['foo', 'bar']))
        self.assertTrue( tuple_.Tuple(['foo', 'bar']) >= tuple_.Tuple(['bar', 'foo']))
        self.assertFalse(tuple_.Tuple(['foo']) >= tuple_.Tuple(['foo', 'bar']))
        self.assertTrue( tuple_.Tuple(['foo', 'bar']) >= tuple_.Tuple(['foo']))
        self.assertFalse(tuple_.Tuple(['a', 'b']) >= tuple_.Tuple(['c', 'b']))
        self.assertTrue( tuple_.Tuple(['c', 'b']) >= tuple_.Tuple(['a', 'b']))

    def test__hash_1(self):
        self.assertEqual(hash(tuple_.Tuple(('foo','bar'))), hash(tuple_.Tuple(['foo', 'bar'])))
        self.assertNotEqual(hash(tuple_.Tuple(('foo','bar'))), hash(tuple_.Tuple(('foo',))))

    def test__repr_1(self):
        self.assertEqual(repr(tuple_.Tuple(['foo', 'bar'])), "Tuple([%r,%r])" % ('foo', 'bar'))

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
