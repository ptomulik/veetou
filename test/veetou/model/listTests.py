#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.list_ as list_
import collections.abc


class Wrapper(object):
    def __init__(self, obj):
        self._obj = obj
    @property
    def obj(self):
        return self._obj
    def __eq__(self, other):
        if isinstance(other, Wrapper):
            return self.obj == other.obj
        else:
            return NotImplemented

class Wrapper2(Wrapper):
    def __eq__(self, other):
        if isinstance(other, Wrapper):
            return self.obj == other.obj
        else:
            return self.obj == other

    def __ne__(self, other):
        if isinstance(other, Wrapper):
            return self.obj != other.obj
        else:
            return self.obj != other

    def __lt__(self, other):
        if isinstance(other, Wrapper2):
            return self.obj < other.obj
        else:
            return self.obj < other

    def __gt__(self, other):
        if isinstance(other, Wrapper2):
            return self.obj > other.obj
        else:
            return self.obj > other

    def __le__(self, other):
        if isinstance(other, Wrapper2):
            return self.obj <= other.obj
        else:
            return self.obj <= other

    def __ge__(self, other):
        if isinstance(other, Wrapper2):
            return self.obj >= other.obj
        else:
            return self.obj >= other

class WrapList(list_.List):
    def __wrap__(self, value):
        return Wrapper(value)
    def __unwrap__(self, value):
        return value.obj

class WrapList2(WrapList):
    def __wrap__(self, value):
        return Wrapper2(value)

class Test__List(unittest.TestCase):

    def test__subclass_1(self):
        self.assertTrue(issubclass(list_.List, collections.abc.MutableSequence))

    def test__listclass_1(self):
        self.assertIs(list_.List.__listclass__(), list)

    def test__init_1(self):
        lst = list_.List()
        self.assertEqual(lst._data, list())
        self.assertIsInstance(lst._data, list)

    def test__init_2(self):
        items = (('it1',), ('it2',))
        lst = list_.List(items)
        self.assertEqual(len(lst._data), 2)
        self.assertIs(lst._data[0], items[0])
        self.assertIs(lst._data[1], items[1])
        #
        self.assertEqual(len(lst), 2)
        self.assertIs(lst[0], items[0])
        self.assertIs(lst[1], items[1])

    def test__getitem__1(self):
        items = (('it1',), ('it2',))
        lst = list_.List(items)

        self.assertIs(lst[0], items[0])
        self.assertIs(lst[1], items[1])

    def test__getitem__2(self):
        lst = list_.List()
        with self.assertRaises(IndexError): lst[0]

        lst = list_.List((('it1',), ('it2',)))
        with self.assertRaises(IndexError): lst[ 2]
        with self.assertRaises(IndexError): lst[-3]

    def test__setitem__1(self):
        items = (('it1',), ('it2',), ('it3',))
        lst = list_.List(items[:2])
        lst[1] = items[2]

        self.assertEqual(len(lst._data), 2)
        self.assertIs(lst._data[0], items[0])
        self.assertIs(lst._data[1], items[2])

        self.assertEqual(len(lst), 2)
        self.assertIs(lst[0], items[0])
        self.assertIs(lst[1], items[2])

    def test__setitem_2(self):
        lst = list_.List()
        with self.assertRaises(IndexError): lst[0] = 'Bleah'

    def test__delitem_1(self):
        items = (('it1',), ('it2',), ('it3',))
        lst = list_.List(items)
        del lst[1]
        self.assertEqual(len(lst._data), 2)
        self.assertIs(lst._data[0], items[0])
        self.assertIs(lst._data[1], items[2])
        #
        self.assertEqual(len(lst), 2)
        self.assertIs(lst[0], items[0])
        self.assertIs(lst[1], items[2])

    def test__len_1(self):
        lst = list_.List()
        self.assertEqual(len(lst), 0)

        lst = list_.List((('it1',), ('it2',), ('it3',)))
        self.assertEqual(len(lst), 3)

    def test__clear_1(self):
        lst = list_.List((('it1',), ('it2',), ('it3',)))
        self.assertEqual(len(lst._data), 3)
        self.assertEqual(len(lst), 3)

        lst.clear()
        self.assertEqual(len(lst._data), 0)
        self.assertEqual(lst._data, [])
        self.assertEqual(len(lst), 0)

    def test__insert_1(self):
        items = (('it1',), ('it2',))
        lst = list_.List()
        lst.insert(12, items[0])
        self.assertEqual(len(lst._data), 1)
        self.assertIs(lst._data[0], items[0])
        self.assertEqual(len(lst), 1)
        self.assertIs(lst[0], items[0])
        lst.insert(0, items[1])
        self.assertEqual(len(lst._data), 2)
        self.assertIs(lst._data[0], items[1])
        self.assertIs(lst._data[1], items[0])
        self.assertEqual(len(lst), 2)
        self.assertIs(lst[0], items[1])
        self.assertIs(lst[1], items[0])

    def test__reverse_1(self):
        items = (('it1',), ('it2',), ('it3',))
        lst = list_.List(items)
        lst.reverse()
        self.assertEqual(len(lst._data), 3)
        self.assertIs(lst._data[0], items[2])
        self.assertIs(lst._data[1], items[1])
        self.assertIs(lst._data[2], items[0])
        #
        self.assertEqual(len(lst), 3)
        self.assertIs(lst[0], items[2])
        self.assertIs(lst[1], items[1])
        self.assertIs(lst[2], items[0])

    def test__extend_1(self):
        items = (('it1',), ('it2',), ('it3',), ('it4',))
        lst = list_.List(items[:2])
        lst.extend(items[2:])
        self.assertEqual(len(lst._data), 4)
        self.assertIs(lst._data[0], items[0])
        self.assertIs(lst._data[1], items[1])
        self.assertIs(lst._data[2], items[2])
        self.assertIs(lst._data[3], items[3])
        #
        self.assertIs(lst[0], items[0])
        self.assertIs(lst[1], items[1])
        self.assertIs(lst[2], items[2])
        self.assertIs(lst[3], items[3])

    def test__pop_1(self):
        items = (('it1',), ('it2',))
        lst = list_.List(items)
        self.assertIs(lst.pop(), items[1])
        self.assertIs(lst.pop(), items[0])
        with self.assertRaises(IndexError) : lst.pop()

    def test__remove_1(self):
        items = (('it1',), ('it2',))
        lst = list_.List(items)
        lst.remove(('it2',))
        self.assertEqual(len(lst._data), 1)
        self.assertEqual(len(lst), 1)
        self.assertIs(lst._data[0], items[0])
        self.assertIs(lst[0], items[0])
        lst.remove(('it1',))
        self.assertEqual(len(lst._data), 0)
        self.assertEqual(len(lst), 0)
        self.assertEqual(lst._data, [])

    def test__remove_2(self):
        items = (('it1',), ('it2',))
        lst = list_.List(items)
        with self.assertRaises(ValueError): lst.remove(('it3',))

    def test__contains_1(self):
        items = (('it1',), ('it2',))
        lst = list_.List(items)
        self.assertTrue(('it1',) in lst._data)
        self.assertTrue(('it2',) in lst._data)
        self.assertFalse(('it3',) in lst._data)
        #
        self.assertTrue(('it1',) in lst)
        self.assertTrue(('it2',) in lst)
        self.assertFalse(('it3',) in lst)

    def test__count_1(self):
        items = (('it1',), ('it2',), ('it3',), ('it1',), ('it2',), ('it1',))
        lst = list_.List(items)
        self.assertEqual(lst._data.count(('it1',)), 3)
        self.assertEqual(lst._data.count(('it2',)), 2)
        self.assertEqual(lst._data.count(('it3',)), 1)
        self.assertEqual(lst._data.count('foo'), 0)
        #
        self.assertEqual(lst.count(('it1',)), 3)
        self.assertEqual(lst.count(('it2',)), 2)
        self.assertEqual(lst.count(('it3',)), 1)
        self.assertEqual(lst.count('foo'), 0)

    def test__iter_1(self):
        items = (('it1',), ('it2',))
        lst = list_.List(items)
        itr = iter(lst)
        self.assertIs(next(itr), items[0])
        self.assertIs(next(itr), items[1])
        with self.assertRaises(StopIteration): next(itr)

    def test__eq_1(self):
        self.assertTrue( list_.List() == list_.List())
        self.assertTrue( list_.List() == list())
        self.assertTrue( list() == list_.List())
        #
        self.assertTrue( list_.List((('it1',), ('it2',))) == list_.List((('it1',), ('it2',))) )
        self.assertTrue( list_.List((('it1',), ('it2',))) == [('it1',), ('it2',)] )
        self.assertTrue( [('it1',), ('it2',)] == list_.List((('it1',), ('it2',))) )
        self.assertFalse( list_.List((('it1',), ('it2',))) == list_.List(('foo', ('it2',))) )
        self.assertFalse( list_.List((('it1',), ('it2',))) == ['foo', ('it2',)] )
        self.assertFalse( ['foo', ('it2',)] == list_.List((('it1',), ('it2',))) )
        #
        self.assertFalse(list_.List(['foo', 'bar']) == list_.List(['bar', 'foo']))
        self.assertFalse(list_.List(['foo']) == list_.List(['foo', 'bar']))
        self.assertFalse(list_.List(['foo', 'bar']) == list_.List(['foo']))

    def test__ne_1(self):
        self.assertFalse( list_.List() != list_.List())
        self.assertFalse( list_.List() != list())
        self.assertFalse( list() != list_.List())
        #
        self.assertFalse( list_.List((('it1',), ('it2',))) != list_.List((('it1',), ('it2',))) )
        self.assertFalse( list_.List((('it1',), ('it2',))) != [('it1',), ('it2',)] )
        self.assertFalse( [('it1',), ('it2',)] != list_.List((('it1',), ('it2',))) )
        self.assertTrue( list_.List((('it1',), ('it2',))) != list_.List(('foo', ('it2',))) )
        self.assertTrue( list_.List((('it1',), ('it2',))) != ['foo', ('it2',)] )
        self.assertTrue( ['foo', ('it2',)] != list_.List((('it1',), ('it2',))) )
        #
        self.assertTrue(list_.List(['foo', 'bar']) != list_.List(['bar', 'foo']))
        self.assertTrue(list_.List(['foo']) != list_.List(['foo', 'bar']))
        self.assertTrue(list_.List(['foo', 'bar']) != list_.List(['foo']))

    def test__lt_1(self):
        self.assertFalse(list_.List() < list_.List())
        self.assertFalse(list_.List(['foo', 'bar']) < list_.List(['foo', 'bar']))
        self.assertFalse(list_.List(['foo', 'bar']) < list_.List(['bar', 'foo']))
        self.assertTrue( list_.List(['foo']) < list_.List(['foo', 'bar']))
        self.assertFalse(list_.List(['foo', 'bar']) < list_.List(['foo']))
        self.assertTrue( list_.List(['a', 'b']) < list_.List(['c', 'b']))
        self.assertFalse(list_.List(['c', 'b']) < list_.List(['a', 'b']))

    def test__gt_1(self):
        self.assertFalse(list_.List() > list_.List())
        self.assertFalse(list_.List(['foo', 'bar']) > list_.List(['foo', 'bar']))
        self.assertTrue( list_.List(['foo', 'bar']) > list_.List(['bar', 'foo']))
        self.assertFalse(list_.List(['foo']) > list_.List(['foo', 'bar']))
        self.assertTrue( list_.List(['foo', 'bar']) > list_.List(['foo']))
        self.assertFalse(list_.List(['a', 'b']) > list_.List(['c', 'b']))
        self.assertTrue( list_.List(['c', 'b']) > list_.List(['a', 'b']))

    def test__le_1(self):
        self.assertTrue(list_.List() <= list_.List())
        self.assertTrue(list_.List(['foo', 'bar']) <= list_.List(['foo', 'bar']))
        self.assertFalse(list_.List(['foo', 'bar']) <= list_.List(['bar', 'foo']))
        self.assertTrue( list_.List(['foo']) <= list_.List(['foo', 'bar']))
        self.assertFalse(list_.List(['foo', 'bar']) <= list_.List(['foo']))
        self.assertTrue( list_.List(['a', 'b']) <= list_.List(['c', 'b']))
        self.assertFalse(list_.List(['c', 'b']) <= list_.List(['a', 'b']))

    def test__ge_1(self):
        self.assertTrue( list_.List() >= list_.List())
        self.assertTrue( list_.List(['foo', 'bar']) >= list_.List(['foo', 'bar']))
        self.assertTrue( list_.List(['foo', 'bar']) >= list_.List(['bar', 'foo']))
        self.assertFalse(list_.List(['foo']) >= list_.List(['foo', 'bar']))
        self.assertTrue( list_.List(['foo', 'bar']) >= list_.List(['foo']))
        self.assertFalse(list_.List(['a', 'b']) >= list_.List(['c', 'b']))
        self.assertTrue( list_.List(['c', 'b']) >= list_.List(['a', 'b']))

class Test__ListSubclass(unittest.TestCase):
    def test__init_1(self):
        lst = WrapList()
        self.assertEqual(lst._data, list())
        self.assertIsInstance(lst._data, list)

    def test__init_2(self):
        items = (('it1',), ('it2',))
        lst = WrapList(items)
        self.assertEqual(len(lst._data), 2)
        self.assertIsInstance(lst._data[0], Wrapper)
        self.assertIsInstance(lst._data[1], Wrapper)
        self.assertIs(lst._data[0].obj, items[0])
        self.assertIs(lst._data[1].obj, items[1])
        #
        self.assertEqual(len(lst), 2)
        self.assertIs(lst[0], items[0])
        self.assertIs(lst[1], items[1])

    def test__getitem__1(self):
        items = (('it1',), ('it2',))
        lst = WrapList(items)

        self.assertIs(lst[0], items[0])
        self.assertIs(lst[1], items[1])

    def test__getitem__2(self):
        lst = WrapList()
        with self.assertRaises(IndexError): lst[0]

        lst = WrapList((('it1',), ('it2',)))
        with self.assertRaises(IndexError): lst[ 2]
        with self.assertRaises(IndexError): lst[-3]

    def test__setitem__1(self):
        items = (('it1',), ('it2',), ('it3',))
        lst = WrapList(items[:2])
        lst[1] = items[2]

        self.assertEqual(len(lst._data), 2)
        self.assertIsInstance(lst._data[0], Wrapper)
        self.assertIsInstance(lst._data[1], Wrapper)
        self.assertIs(lst._data[0].obj, items[0])
        self.assertIs(lst._data[1].obj, items[2])

        self.assertEqual(len(lst), 2)
        self.assertIs(lst[0], items[0])
        self.assertIs(lst[1], items[2])

    def test__setitem_2(self):
        lst = WrapList()
        with self.assertRaises(IndexError): lst[0] = 'Bleah'

    def test__delitem_1(self):
        items = (('it1',), ('it2',), ('it3',))
        lst = WrapList(items)
        del lst[1]
        self.assertEqual(len(lst._data), 2)
        self.assertIsInstance(lst._data[0], Wrapper)
        self.assertIsInstance(lst._data[1], Wrapper)
        self.assertIs(lst._data[0].obj, items[0])
        self.assertIs(lst._data[1].obj, items[2])
        #
        self.assertEqual(len(lst), 2)
        self.assertIs(lst[0], items[0])
        self.assertIs(lst[1], items[2])

    def test__len_1(self):
        lst = WrapList()
        self.assertEqual(len(lst), 0)

        lst = WrapList((('it1',), ('it2',), ('it3',)))
        self.assertEqual(len(lst), 3)

    def test__clear_1(self):
        lst = WrapList((('it1',), ('it2',), ('it3',)))
        self.assertEqual(len(lst._data), 3)
        self.assertEqual(len(lst), 3)

        lst.clear()
        self.assertEqual(len(lst._data), 0)
        self.assertEqual(lst._data, [])
        self.assertEqual(len(lst), 0)

    def test__insert_1(self):
        items = (('it1',), ('it2',))
        lst = WrapList()
        lst.insert(12, items[0])
        self.assertEqual(len(lst._data), 1)
        self.assertIsInstance(lst._data[0], Wrapper)
        self.assertIs(lst._data[0].obj, items[0])
        self.assertEqual(len(lst), 1)
        self.assertIs(lst[0], items[0])
        lst.insert(0, items[1])
        self.assertEqual(len(lst._data), 2)
        self.assertIsInstance(lst._data[0], Wrapper)
        self.assertIsInstance(lst._data[1], Wrapper)
        self.assertIs(lst._data[0].obj, items[1])
        self.assertIs(lst._data[1].obj, items[0])
        self.assertEqual(len(lst), 2)
        self.assertIs(lst[0], items[1])
        self.assertIs(lst[1], items[0])

    def test__reverse_1(self):
        items = (('it1',), ('it2',), ('it3',))
        lst = WrapList(items)
        lst.reverse()
        self.assertEqual(len(lst._data), 3)
        self.assertIsInstance(lst._data[0], Wrapper)
        self.assertIsInstance(lst._data[1], Wrapper)
        self.assertIsInstance(lst._data[2], Wrapper)
        self.assertIs(lst._data[0].obj, items[2])
        self.assertIs(lst._data[1].obj, items[1])
        self.assertIs(lst._data[2].obj, items[0])
        #
        self.assertEqual(len(lst), 3)
        self.assertIs(lst[0], items[2])
        self.assertIs(lst[1], items[1])
        self.assertIs(lst[2], items[0])

    def test__extend_1(self):
        items = (('it1',), ('it2',), ('it3',), ('it4',))
        lst = WrapList(items[:2])
        lst.extend(items[2:])
        self.assertEqual(len(lst._data), 4)
        self.assertIsInstance(lst._data[0], Wrapper)
        self.assertIsInstance(lst._data[1], Wrapper)
        self.assertIsInstance(lst._data[2], Wrapper)
        self.assertIsInstance(lst._data[3], Wrapper)
        self.assertIs(lst._data[0].obj, items[0])
        self.assertIs(lst._data[1].obj, items[1])
        self.assertIs(lst._data[2].obj, items[2])
        self.assertIs(lst._data[3].obj, items[3])
        #
        self.assertIs(lst[0], items[0])
        self.assertIs(lst[1], items[1])
        self.assertIs(lst[2], items[2])
        self.assertIs(lst[3], items[3])

    def test__pop_1(self):
        items = (('it1',), ('it2',))
        lst = WrapList(items)
        self.assertIs(lst.pop(), items[1])
        self.assertIs(lst.pop(), items[0])
        with self.assertRaises(IndexError) : lst.pop()

    def test__remove_1(self):
        items = (('it1',), ('it2',))
        lst = WrapList(items)
        lst.remove(('it2',))
        self.assertEqual(len(lst._data), 1)
        self.assertIsInstance(lst._data[0], Wrapper)
        self.assertIs(lst._data[0].obj, items[0])
        self.assertEqual(len(lst), 1)
        self.assertIs(lst[0], items[0])
        lst.remove(('it1',))
        self.assertEqual(len(lst._data), 0)
        self.assertEqual(len(lst), 0)
        self.assertEqual(lst._data, [])

    def test__remove_2(self):
        items = (('it1',), ('it2',))
        lst = WrapList(items)
        with self.assertRaises(ValueError): lst.remove(('it3',))

    def test__contains_1(self):
        items = (('it1',), ('it2',))
        lst = WrapList(items)
        self.assertTrue(Wrapper(('it1',)) in lst._data)
        self.assertTrue(Wrapper(('it2',)) in lst._data)
        self.assertFalse(Wrapper(('it3',)) in lst._data)
        #
        self.assertTrue(('it1',) in lst)
        self.assertTrue(('it2',) in lst)
        self.assertFalse(('it3',) in lst)

    def test__count_1(self):
        items = (('it1',), ('it2',), ('it3',), ('it1',), ('it2',), ('it1',))
        lst = WrapList(items)
        self.assertEqual(lst._data.count(Wrapper(('it1',))), 3)
        self.assertEqual(lst._data.count(Wrapper(('it2',))), 2)
        self.assertEqual(lst._data.count(Wrapper(('it3',))), 1)
        self.assertEqual(lst._data.count(Wrapper('foo')), 0)
        #
        self.assertEqual(lst.count(('it1',)), 3)
        self.assertEqual(lst.count(('it2',)), 2)
        self.assertEqual(lst.count(('it3',)), 1)
        self.assertEqual(lst.count('foo'), 0)

    def test__iter_1(self):
        items = (('it1',), ('it2',))
        lst = WrapList(items)
        itr = iter(lst)
        self.assertIs(next(itr), items[0])
        self.assertIs(next(itr), items[1])
        with self.assertRaises(StopIteration): next(itr)

    def test__eq_1(self):
        self.assertTrue( WrapList() == WrapList())
        self.assertTrue( WrapList() == list())
        self.assertTrue( list() == WrapList())
        #
        self.assertTrue( WrapList((('it1',), ('it2',))) == WrapList((('it1',), ('it2',))) )
        self.assertTrue( WrapList((('it1',), ('it2',))) == [Wrapper(('it1',)), Wrapper(('it2',))] )
        self.assertTrue( [Wrapper(('it1',)), Wrapper(('it2',))] == WrapList((('it1',), ('it2',))) )
        self.assertFalse( WrapList((('it1',), ('it2',))) == [('it1',), ('it2',)] )
        self.assertFalse( [('it1',), ('it2',)] == WrapList((('it1',), ('it2',))) )
        self.assertFalse( WrapList((('it1',), ('it2',))) == WrapList(('foo', ('it2',))) )
        self.assertFalse( WrapList((('it1',), ('it2',))) == ['foo', ('it2',)] )
        self.assertFalse( ['foo', ('it2',)] == WrapList((('it1',), ('it2',))) )
        #
        self.assertFalse(WrapList(['foo', 'bar']) == WrapList(['bar', 'foo']))
        self.assertFalse(WrapList(['foo']) == WrapList(['foo', 'bar']))
        self.assertFalse(WrapList(['foo', 'bar']) == WrapList(['foo']))

    def test__ne_1(self):
        self.assertFalse( WrapList() != WrapList())
        self.assertFalse( WrapList() != list())
        self.assertFalse( list() != WrapList())
        #
        self.assertFalse( WrapList((('it1',), ('it2',))) != WrapList((('it1',), ('it2',))) )
        self.assertFalse( WrapList((('it1',), ('it2',))) != [Wrapper(('it1',)), Wrapper(('it2',))] )
        self.assertFalse( [Wrapper(('it1',)), Wrapper(('it2',))] != WrapList((('it1',), ('it2',))) )
        self.assertTrue( WrapList((('it1',), ('it2',))) != [('it1',), ('it2',)] )
        self.assertTrue( [('it1',), ('it2',)] != WrapList((('it1',), ('it2',))) )
        self.assertTrue( WrapList((('it1',), ('it2',))) != WrapList(('foo', ('it2',))) )
        self.assertTrue( WrapList((('it1',), ('it2',))) != ['foo', ('it2',)] )
        self.assertTrue( ['foo', ('it2',)] != WrapList((('it1',), ('it2',))) )
        #
        self.assertTrue(WrapList(['foo', 'bar']) != WrapList(['bar', 'foo']))
        self.assertTrue(WrapList(['foo']) != WrapList(['foo', 'bar']))
        self.assertTrue(WrapList(['foo', 'bar']) != WrapList(['foo']))

    def test__lt_1(self):
        self.assertFalse(WrapList() < WrapList())
        self.assertFalse(WrapList(['foo', 'bar']) < WrapList(['foo', 'bar']))
        with self.assertRaises(TypeError): ( WrapList(['foo', 'bar']) < WrapList(['bar', 'foo']) )
        self.assertTrue( WrapList(['foo']) < WrapList(['foo', 'bar']))
        self.assertFalse(WrapList(['foo', 'bar']) < WrapList(['foo']))
        with self.assertRaises(TypeError): ( WrapList(['a', 'b']) < WrapList(['c', 'b']) )
        with self.assertRaises(TypeError): ( WrapList(['c', 'b']) < WrapList(['a', 'b']) )
        #
        self.assertFalse(WrapList2() < WrapList2())
        self.assertFalse(WrapList2(['foo', 'bar']) < WrapList2(['foo', 'bar']))
        self.assertFalse(WrapList2(['foo', 'bar']) < WrapList2(['bar', 'foo']))
        self.assertTrue( WrapList2(['foo']) < WrapList2(['foo', 'bar']))
        self.assertFalse(WrapList2(['foo', 'bar']) < WrapList2(['foo']))
        self.assertTrue( WrapList2(['a', 'b']) < WrapList2(['c', 'b']))
        self.assertFalse(WrapList2(['c', 'b']) < WrapList2(['a', 'b']))

    def test__gt_1(self):
        self.assertFalse(WrapList() > WrapList())
        self.assertFalse(WrapList(['foo', 'bar']) > WrapList(['foo', 'bar']))
        with self.assertRaises(TypeError): ( WrapList(['foo', 'bar']) > WrapList(['bar', 'foo']))
        self.assertFalse(WrapList(['foo']) > WrapList(['foo', 'bar']))
        self.assertTrue( WrapList(['foo', 'bar']) > WrapList(['foo']))
        with self.assertRaises(TypeError): ( WrapList(['a', 'b']) > WrapList(['c', 'b']) )
        with self.assertRaises(TypeError): ( WrapList(['c', 'b']) > WrapList(['a', 'b']) )
        #
        self.assertFalse(WrapList2() > WrapList2())
        self.assertFalse(WrapList2(['foo', 'bar']) > WrapList2(['foo', 'bar']))
        self.assertTrue( WrapList2(['foo', 'bar']) > WrapList2(['bar', 'foo']))
        self.assertFalse(WrapList2(['foo']) > WrapList2(['foo', 'bar']))
        self.assertTrue( WrapList2(['foo', 'bar']) > WrapList2(['foo']))
        self.assertFalse(WrapList2(['a', 'b']) > WrapList2(['c', 'b']))
        self.assertTrue( WrapList2(['c', 'b']) > WrapList2(['a', 'b']))

    def test__le_1(self):
        self.assertTrue(WrapList() <= WrapList())
        self.assertTrue(WrapList(['foo', 'bar']) <= WrapList(['foo', 'bar']))
        with self.assertRaises(TypeError): ( WrapList(['foo', 'bar']) <= WrapList(['bar', 'foo']) )
        self.assertTrue( WrapList(['foo']) <= WrapList(['foo', 'bar']))
        self.assertFalse(WrapList(['foo', 'bar']) <= WrapList(['foo']))
        with self.assertRaises(TypeError): ( WrapList(['a', 'b']) <= WrapList(['c', 'b']) )
        with self.assertRaises(TypeError): ( WrapList(['c', 'b']) <= WrapList(['a', 'b']) )
        #
        self.assertTrue(WrapList2() <= WrapList2())
        self.assertTrue(WrapList2(['foo', 'bar']) <= WrapList2(['foo', 'bar']))
        self.assertFalse(WrapList2(['foo', 'bar']) <= WrapList2(['bar', 'foo']))
        self.assertTrue( WrapList2(['foo']) <= WrapList2(['foo', 'bar']))
        self.assertFalse(WrapList2(['foo', 'bar']) <= WrapList2(['foo']))
        self.assertTrue( WrapList2(['a', 'b']) <= WrapList2(['c', 'b']))
        self.assertFalse(WrapList2(['c', 'b']) <= WrapList2(['a', 'b']))

    def test__ge_1(self):
        self.assertTrue( WrapList() >= WrapList())
        self.assertTrue( WrapList(['foo', 'bar']) >= WrapList(['foo', 'bar']))
        with self.assertRaises(TypeError): ( WrapList(['foo', 'bar']) >= WrapList(['bar', 'foo']) )
        self.assertFalse(WrapList(['foo']) >= WrapList(['foo', 'bar']))
        self.assertTrue( WrapList(['foo', 'bar']) >= WrapList(['foo']))
        with self.assertRaises(TypeError): ( WrapList(['a', 'b']) >= WrapList(['c', 'b']) )
        with self.assertRaises(TypeError): ( WrapList(['c', 'b']) >= WrapList(['a', 'b']) )
        #
        self.assertTrue( WrapList2() >= WrapList2())
        self.assertTrue( WrapList2(['foo', 'bar']) >= WrapList2(['foo', 'bar']))
        self.assertTrue( WrapList2(['foo', 'bar']) >= WrapList2(['bar', 'foo']))
        self.assertFalse(WrapList2(['foo']) >= WrapList2(['foo', 'bar']))
        self.assertTrue( WrapList2(['foo', 'bar']) >= WrapList2(['foo']))
        self.assertFalse(WrapList2(['a', 'b']) >= WrapList2(['c', 'b']))
        self.assertTrue( WrapList2(['c', 'b']) >= WrapList2(['a', 'b']))


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
