#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.ref_ as ref_

class MyObj(object): pass

class Test__Object(unittest.TestCase):

    def test__init_1(self):
        o = MyObj()
        r = ref_.Ref(o)
        self.assertIs(r._obj, o)

    def test__obj_1(self):
        o = MyObj()
        r = ref_.Ref(o)
        self.assertIs(r.obj, o)

    def test__obj_setter_1(self):
        r = ref_.Ref(MyObj())
        with self.assertRaisesRegex(AttributeError, r"can't set attribute"):
            r.obj = 'asdf'

    def test__hash_1(self):
        o = MyObj()
        r = ref_.Ref(o)
        self.assertEqual(hash(r), hash(id(o)))

    def test__eq_1(self):
        l = MyObj()
        r = MyObj()
        self.assertTrue(ref_.Ref(l) == ref_.Ref(l))
        self.assertTrue(ref_.Ref(r) == ref_.Ref(r))
        self.assertTrue(ref_.Ref(l) == l)
        self.assertTrue(ref_.Ref(r) == r)
        self.assertTrue(l == ref_.Ref(l))
        self.assertTrue(r == ref_.Ref(r))
        self.assertFalse(ref_.Ref(l) == ref_.Ref(r))
        self.assertFalse(ref_.Ref(r) == ref_.Ref(l))
        self.assertFalse(ref_.Ref(l) == r)
        self.assertFalse(ref_.Ref(r) == l)
        self.assertFalse(l == ref_.Ref(r))
        self.assertFalse(r == ref_.Ref(l))

    def test__ne_1(self):
        l = MyObj()
        r = MyObj()
        self.assertFalse(ref_.Ref(l) != ref_.Ref(l))
        self.assertFalse(ref_.Ref(r) != ref_.Ref(r))
        self.assertFalse(ref_.Ref(l) != l)
        self.assertFalse(ref_.Ref(r) != r)
        self.assertFalse(l != ref_.Ref(l))
        self.assertFalse(r != ref_.Ref(r))
        self.assertTrue(ref_.Ref(l) != ref_.Ref(r))
        self.assertTrue(ref_.Ref(r) != ref_.Ref(l))
        self.assertTrue(ref_.Ref(l) != r)
        self.assertTrue(ref_.Ref(r) != l)
        self.assertTrue(l != ref_.Ref(r))
        self.assertTrue(r != ref_.Ref(l))

    def test__lt_1(self):
        l = MyObj()
        r = MyObj()
        self.assertFalse(ref_.Ref(l) < ref_.Ref(l))
        self.assertFalse(ref_.Ref(r) < ref_.Ref(r))
        self.assertFalse(ref_.Ref(l) < l)
        self.assertFalse(ref_.Ref(r) < r)
        self.assertFalse(l < ref_.Ref(l))
        self.assertFalse(r < ref_.Ref(r))
        self.assertEqual(ref_.Ref(l) < ref_.Ref(r), id(l) < id(r))
        self.assertEqual(ref_.Ref(r) < ref_.Ref(l), id(r) < id(l))
        self.assertEqual(ref_.Ref(l) < r, id(l) < id(r))
        self.assertEqual(ref_.Ref(r) < l, id(r) < id(l))
        self.assertEqual(l < ref_.Ref(r), id(l) < id(r))
        self.assertEqual(r < ref_.Ref(l), id(r) < id(l))

    def test__gt_1(self):
        l = MyObj()
        r = MyObj()
        self.assertFalse(ref_.Ref(l) > ref_.Ref(l))
        self.assertFalse(ref_.Ref(r) > ref_.Ref(r))
        self.assertFalse(ref_.Ref(l) > l)
        self.assertFalse(ref_.Ref(r) > r)
        self.assertFalse(l > ref_.Ref(l))
        self.assertFalse(r > ref_.Ref(r))
        self.assertEqual(ref_.Ref(l) > ref_.Ref(r), id(l) > id(r))
        self.assertEqual(ref_.Ref(r) > ref_.Ref(l), id(r) > id(l))
        self.assertEqual(ref_.Ref(l) > r, id(l) > id(r))
        self.assertEqual(ref_.Ref(r) > l, id(r) > id(l))
        self.assertEqual(l > ref_.Ref(r), id(l) > id(r))
        self.assertEqual(r > ref_.Ref(l), id(r) > id(l))

    def test__le_1(self):
        l = MyObj()
        r = MyObj()
        self.assertTrue(ref_.Ref(l) <= ref_.Ref(l))
        self.assertTrue(ref_.Ref(r) <= ref_.Ref(r))
        self.assertTrue(ref_.Ref(l) <= l)
        self.assertTrue(ref_.Ref(r) <= r)
        self.assertTrue(l <= ref_.Ref(l))
        self.assertTrue(r <= ref_.Ref(r))
        self.assertEqual(ref_.Ref(l) <= ref_.Ref(r), id(l) <= id(r))
        self.assertEqual(ref_.Ref(r) <= ref_.Ref(l), id(r) <= id(l))
        self.assertEqual(ref_.Ref(l) <= r, id(l) <= id(r))
        self.assertEqual(ref_.Ref(r) <= l, id(r) <= id(l))
        self.assertEqual(l <= ref_.Ref(r), id(l) <= id(r))
        self.assertEqual(r <= ref_.Ref(l), id(r) <= id(l))

    def test__ge_1(self):
        l = MyObj()
        r = MyObj()
        self.assertTrue(ref_.Ref(l) >= ref_.Ref(l))
        self.assertTrue(ref_.Ref(r) >= ref_.Ref(r))
        self.assertTrue(ref_.Ref(l) >= l)
        self.assertTrue(ref_.Ref(r) >= r)
        self.assertTrue(l >= ref_.Ref(l))
        self.assertTrue(r >= ref_.Ref(r))
        self.assertEqual(ref_.Ref(l) >= ref_.Ref(r), id(l) >= id(r))
        self.assertEqual(ref_.Ref(r) >= ref_.Ref(l), id(r) >= id(l))
        self.assertEqual(ref_.Ref(l) >= r, id(l) >= id(r))
        self.assertEqual(ref_.Ref(r) >= l, id(r) >= id(l))
        self.assertEqual(l >= ref_.Ref(r), id(l) >= id(r))
        self.assertEqual(r >= ref_.Ref(l), id(r) >= id(l))


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
