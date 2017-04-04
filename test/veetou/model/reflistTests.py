#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.reflist_ as reflist_
import veetou.model.list_ as list_
import veetou.model.ref_ as ref_
import veetou.model.functions_ as functions_
import collections.abc

class X(object):
    def __init__(self, x = 0):
        self.x = x

    def __eq__(self, other):
        if isinstance(other, X):
            return self.x == other.x
        else:
            return self.x == x

    def __ne__(self, other):
        if isinstance(other, X):
            return self.x != other.x
        else:
            return self.x != x

    def __lt__(self, other):
        if isinstance(other, X):
            return self.x < other.x
        else:
            return self.x < x

    def __gt__(self, other):
        if isinstance(other, X):
            return self.x > other.x
        else:
            return self.x > x

    def __le__(self, other):
        if isinstance(other, X):
            return self.x <= other.x
        else:
            return self.x <= x

    def __ge__(self, other):
        if isinstance(other, X):
            return self.x >= other.x
        else:
            return self.x >= x

    def  __hash__(self):
        return hash(self.x)

class Test__RefList(unittest.TestCase):

    def test__subclass_1(self):
        self.assertTrue(issubclass(reflist_.RefList, list_.List))

    def test__init_1(self):
        seq = reflist_.RefList()
        self.assertEqual(seq._data, list())
        self.assertIsInstance(seq._data, list)

    def test__init_2(self):
        warsaw = 'warsaw'
        london = 'london'

        seq = reflist_.RefList((warsaw, london))
        self.assertEqual(len(seq._data), 2)
        self.assertIsInstance(seq._data[0], ref_.Ref)
        self.assertIsInstance(seq._data[1], ref_.Ref)
        self.assertIs(seq._data[0].obj, warsaw)
        self.assertIs(seq._data[1].obj, london)

    def test__getitem__1(self):
        warsaw = 'warsaw'
        london = 'london'
        seq = reflist_.RefList([warsaw, london])

        self.assertIs(seq[0], warsaw)
        self.assertIs(seq[1], london)

    def test__getitem__2(self):
        seq = reflist_.RefList()
        with self.assertRaises(IndexError): seq[0]

        seq = reflist_.RefList(('warsaw', 'london'))
        with self.assertRaises(IndexError): seq[ 2]
        with self.assertRaises(IndexError): seq[-3]

    def test__setitem__1(self):
        warsaw = 'warsaw'
        london = 'london'
        roma = 'roma'

        seq = reflist_.RefList((warsaw, london))
        seq[1] = roma

        self.assertIs(seq[0], warsaw)
        self.assertIs(seq[1], roma)

    def test__setitem_2(self):
        seq = reflist_.RefList()
        with self.assertRaises(IndexError): seq[0] = 'Bleah'

    def test__delitem_1(self):
        xes = [ X(1), X(2), X(3) ]
        seq = reflist_.RefList(xes)
        del seq[1]
        self.assertEqual(seq._data, [xes[0], xes[2]])

    def test__len_1(self):
        seq = reflist_.RefList()
        self.assertEqual(len(seq), 0)

        seq = reflist_.RefList(('warsaw', 'london', 'roma'))
        self.assertEqual(len(seq), 3)

    def test__clear_1(self):
        seq = reflist_.RefList(('warsaw', 'london', 'roma'))
        self.assertEqual(len(seq), 3)

        seq.clear()
        self.assertEqual(seq._data, [])

    def test__insert_1(self):
        xes = [ X(1), X(2), X(3) ]
        seq = reflist_.RefList()
        seq.insert(12, xes[0])
        self.assertEqual(seq._data, [xes[0]])
        seq.insert(0, xes[1])
        self.assertEqual(seq._data, [xes[1], xes[0]])

    def test__reverse_1(self):
        xes = [ X(1), X(2), X(3) ]
        seq = reflist_.RefList(xes)
        seq.reverse()
        self.assertEqual(seq._data, list(reversed(xes)))

    def test__extend_1(self):
        xes = [ X(1), X(2), X(3), X(4), X(5) ]
        seq = reflist_.RefList(xes[:3])
        seq.extend(xes[3:])
        self.assertEqual(seq._data, xes)

    def test__pop_1(self):
        xes = [ X(1), X(2) ]
        seq = reflist_.RefList(xes)
        self.assertEqual(seq.pop(), xes[1])
        self.assertEqual(seq.pop(), xes[0])
        with self.assertRaises(IndexError) : seq.pop()

    def test__remove_1(self):
        xes = [ X(1), X(2) ]
        seq = reflist_.RefList(xes)
        seq.remove(xes[1])
        self.assertEqual(seq._data, [xes[0]])
        seq.remove(xes[0])
        self.assertEqual(seq._data, [])

    def test__remove_2(self):
        xes = [ X(), X() ]
        seq = reflist_.RefList(xes)
        with self.assertRaises(ValueError): seq.remove(X())

    def test__eq_0(self):
        xl = [ X(1), X(2) ]
        xr = [ X(1), X(2) ]
        self.assertTrue( xl == xr )
        self.assertTrue( reflist_.RefList(xl) == reflist_.RefList(xl) )
        self.assertTrue( reflist_.RefList(xl) == xl )
        self.assertTrue( xl == reflist_.RefList(xl) )
        self.assertFalse( reflist_.RefList(xl) == reflist_.RefList(xr) )
        self.assertFalse( reflist_.RefList(xl) == xr )
        self.assertFalse( xr == reflist_.RefList(xl) )

    def test__ne_0(self):
        xl = [ X(1), X(2) ]
        xr = [ X(1), X(2) ]
        self.assertFalse( xl != xr )
        self.assertFalse( reflist_.RefList(xl) != reflist_.RefList(xl) )
        self.assertFalse( reflist_.RefList(xl) != xl )
        self.assertFalse( xl != reflist_.RefList(xl) )
        self.assertTrue( reflist_.RefList(xl) != reflist_.RefList(xr) )
        self.assertTrue( reflist_.RefList(xl) != xr )
        self.assertTrue( xr != reflist_.RefList(xl) )

    def test__lt_0(self):
        xl = [ X(1), X(2) ]
        xr = [ X(1), X(2) ]
        self.assertFalse( xl < xr )
        self.assertFalse( reflist_.RefList(xl) < reflist_.RefList(xl) )
        self.assertFalse( reflist_.RefList(xl) < xl )
        self.assertFalse( xl < reflist_.RefList(xl) )
        self.assertEqual( reflist_.RefList(xl) < reflist_.RefList(xr), [id(x) for x in xl] < [id(x) for x in xr])
        self.assertEqual( reflist_.RefList(xl) < xr, [id(x) for x in xl] < [id(x) for x in xr])
        self.assertEqual( xr < reflist_.RefList(xl), [id(x) for x in xr] < [id(x) for x in xl])

    def test__gt_0(self):
        xl = [ X(1), X(2) ]
        xr = [ X(1), X(2) ]
        self.assertFalse( xl > xr )
        self.assertFalse( reflist_.RefList(xl) > reflist_.RefList(xl) )
        self.assertFalse( reflist_.RefList(xl) > xl )
        self.assertFalse( xl > reflist_.RefList(xl) )
        self.assertEqual( reflist_.RefList(xl) > reflist_.RefList(xr), [id(x) for x in xl] > [id(x) for x in xr])
        self.assertEqual( reflist_.RefList(xl) > xr, [id(x) for x in xl] > [id(x) for x in xr])
        self.assertEqual( xr > reflist_.RefList(xl), [id(x) for x in xr] > [id(x) for x in xl])

    def test__le_0(self):
        xl = [ X(1), X(2) ]
        xr = [ X(1), X(2) ]
        self.assertTrue( xl <= xr )
        self.assertTrue( reflist_.RefList(xl) <= reflist_.RefList(xl) )
        self.assertTrue( reflist_.RefList(xl) <= xl )
        self.assertTrue( xl <= reflist_.RefList(xl) )
        self.assertEqual( reflist_.RefList(xl) <= reflist_.RefList(xr), [id(x) for x in xl] <= [id(x) for x in xr])
        self.assertEqual( reflist_.RefList(xl) <= xr, [id(x) for x in xl] <= [id(x) for x in xr])
        self.assertEqual( xr <= reflist_.RefList(xl), [id(x) for x in xr] <= [id(x) for x in xl])

    def test__ge_0(self):
        xl = [ X(1), X(2) ]
        xr = [ X(1), X(2) ]
        self.assertTrue( xl >= xr )
        self.assertTrue( reflist_.RefList(xl) >= reflist_.RefList(xl) )
        self.assertTrue( reflist_.RefList(xl) >= xl )
        self.assertTrue( xl >= reflist_.RefList(xl) )
        self.assertEqual( reflist_.RefList(xl) >= reflist_.RefList(xr), [id(x) for x in xl] >= [id(x) for x in xr])
        self.assertEqual( reflist_.RefList(xl) >= xr, [id(x) for x in xl] >= [id(x) for x in xr])
        self.assertEqual( xr >= reflist_.RefList(xl), [id(x) for x in xr] >= [id(x) for x in xl])

    def test__repr_1(self):
        xes = [ X(1), X(2) ]
        seq = reflist_.RefList(xes)
        self.assertEqual(repr(seq), "%s([%s])" % (functions_.modelname(seq), ','.join(repr(x) for x in seq)))

    def test__contains_1(self):
        xes = [ X(1), X(2), X(3) ]
        seq = reflist_.RefList(xes)
        self.assertTrue(xes[0] in seq)
        self.assertTrue(xes[1] in seq)
        self.assertTrue(xes[2] in seq)
        self.assertFalse(X(1) in seq)
        self.assertFalse(X(2) in seq)
        self.assertFalse(X(3) in seq)

    def test__count_1(self):
        xes = [ X(1), X(2), X(3), X(1), X(1), X(2) ]
        seq = reflist_.RefList(xes)
        self.assertEqual(seq.count(xes[0]), 1)
        self.assertEqual(seq.count(xes[1]), 1)
        self.assertEqual(seq.count(xes[2]), 1)
        self.assertEqual(seq.count(xes[3]), 1)
        self.assertEqual(seq.count(xes[4]), 1)
        self.assertEqual(seq.count(xes[5]), 1)

        self.assertEqual(seq.count(X(1)), 0)
        self.assertEqual(seq.count(X(2)), 0)
        self.assertEqual(seq.count(X(3)), 0)

    def test__count_2(self):
        xes = [ X(1), X(2), X(3) ]
        seq = reflist_.RefList([xes[0], xes[1], xes[2], xes[0], xes[0], xes[1]])
        self.assertEqual(seq.count(xes[0]), 3)
        self.assertEqual(seq.count(xes[1]), 2)
        self.assertEqual(seq.count(xes[2]), 1)

        self.assertEqual(seq.count(X(1)), 0)
        self.assertEqual(seq.count(X(2)), 0)
        self.assertEqual(seq.count(X(3)), 0)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-seq-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
