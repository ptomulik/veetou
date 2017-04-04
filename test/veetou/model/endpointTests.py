#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.endpoint_ as endpoint_
import veetou.model.relation_ as relation_
import veetou.model.junction_ as junction_
import veetou.model.entity_ as entity_
import veetou.model.record_ as record_
import veetou.model.table_ as table_
import veetou.model.keystuple_ as keystuple_
import veetou.model.pair_ as pair_
import veetou.model.dict_ as dict_
import veetou.model.functions_ as functions_
import collections

class Dog(entity_.Entity):
    _keys = keystuple_.KeysTuple(('name', 'age'))

class Person(entity_.Entity):
    _keys = keystuple_.KeysTuple(('name', 'surname', 'address'))

class Str(entity_.Entity):
    _keys = keystuple_.KeysTuple(('val',))

class DogRec(record_.Record):
    _entityclass = Dog

class PersonRec(record_.Record):
    _entityclass = Person

class StrRec(record_.Record):
    _entityclass = Str

class Dogs(table_.Table):
    _entityclass = Dog
    _recordclass = DogRec

class Persons(table_.Table):
    _entityclass = Person
    _recordclass = PersonRec

class Strs(table_.Table):
    _entityclass = Str
    _recordclass = StrRec

DogRec._tableclass = Dogs
PersonRec._tableclass = Persons
StrRec._tableclass = Strs

class Test__Endpoint(unittest.TestCase):

    def test__init_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons), ('owners', 'pets'))
        l_pin = endpoint_.Endpoint(rel, relation_.LEFT)
        r_pin = endpoint_.Endpoint(rel, relation_.RIGHT)

        self.assertIs(l_pin.relation, rel)
        self.assertIs(r_pin.relation, rel)
        self.assertIs(l_pin.side, relation_.LEFT)
        self.assertIs(r_pin.side, relation_.RIGHT)

    def test__init_2(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons), ('owners', 'pets'))
        with self.assertRaisesRegex(TypeError, '%s is not an instance of %s' % (repr('foo'),repr(relation_.Relation))):
            endpoint_.Endpoint('foo', relation_.LEFT)

        with self.assertRaisesRegex(ValueError, '%s is neither LEFT nor RIGHT' % repr('foo')):
            endpoint_.Endpoint(rel, 'foo')

    def test__relation_1(self):
        dogs = Dogs()
        persons = Persons()
        rel1 = junction_.Junction((dogs,persons),('owners','pets'))
        rel2 = junction_.Junction((dogs,persons),('sellers','sold'))
        pin = endpoint_.Endpoint(rel1, relation_.LEFT)
        self.assertIs(pin.relation, rel1)
        pin.relation = rel2
        self.assertIs(pin.relation, rel2)

        with self.assertRaisesRegex(TypeError, '%s is not an instance of %s' % (repr('foo'),repr(relation_.Relation))):
            pin.relation = 'foo'

    def test__side_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons), ('owners', 'pets'))
        pin = endpoint_.Endpoint(rel, relation_.LEFT)
        self.assertIs(pin.side, relation_.LEFT)
        pin.side = relation_.RIGHT
        self.assertIs(pin.side, relation_.RIGHT)

        with self.assertRaisesRegex(ValueError, '%s is neither LEFT nor RIGHT' % repr('foo')):
            pin.side = 'foo'

    def test__opposite_side_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons), ('owners', 'pets'))
        pin = endpoint_.Endpoint(rel, relation_.LEFT)
        self.assertIs(pin.opposite_side, relation_.RIGHT)
        pin.side = relation_.RIGHT
        self.assertIs(pin.opposite_side, relation_.LEFT)

        with self.assertRaisesRegex(AttributeError, r"can't set attribute"):
            pin.opposite_side = relation_.LEFT

    def test__opposite_table_1(self):
        left = Dogs()
        right = Dogs()
        rel = junction_.Junction((left,right),('parents','children'))
        self.assertIs(endpoint_.Endpoint(rel, relation_.LEFT).opposite_table, right)
        self.assertIs(endpoint_.Endpoint(rel, relation_.RIGHT).opposite_table, left)

    def test__opposite_keys_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = (pair_.Pair('0',1), pair_.Pair('0',2), pair_.Pair('1',0))
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)
        left = endpoint_.Endpoint(rel, relation_.LEFT)
        right = endpoint_.Endpoint(rel, relation_.RIGHT)

        self.assertEqual(tuple(left.opposite_keys('0')), (1,2))
        self.assertEqual(tuple(left.opposite_keys('1')), (0,))

        self.assertEqual(tuple(right.opposite_keys(0)), ('1',))
        self.assertEqual(tuple(right.opposite_keys(1)), ('0',))
        self.assertEqual(tuple(right.opposite_keys(2)), ('0',))

        self.assertEqual(tuple(left.opposite_keys('2')), ())

    def test__opposite_entities_1(self):
        (nil, one) = (Str(('nil',)), Str(('one',)))
        (zero, jeden, dwa) = (Str(('zero',)), Str(('jeden',)), Str(('dwa',)))

        l_tab = Strs({ '0' : nil, '1' : one })
        r_tab = Strs({  0  : zero, 1  : jeden, 2 : dwa })

        pairs = (pair_.Pair('0',1), pair_.Pair('0',2), pair_.Pair('1',0))

        rel = junction_.Junction((l_tab, r_tab), ('opposite','opposite'), pairs)

        left = endpoint_.Endpoint(rel, relation_.LEFT)
        right = endpoint_.Endpoint(rel, relation_.RIGHT)

        self.assertEqual(len(tuple(left.opposite_entities('0'))), 2)
        self.assertEqual(len(tuple(left.opposite_entities('1'))), 1)
        self.assertIs(tuple(left.opposite_entities('0'))[0], jeden)
        self.assertIs(tuple(left.opposite_entities('0'))[1], dwa)
        self.assertIs(tuple(left.opposite_entities('1'))[0], zero)

        self.assertEqual(len(tuple(right.opposite_entities(0))), 1)
        self.assertEqual(len(tuple(right.opposite_entities(1))), 1)
        self.assertEqual(len(tuple(right.opposite_entities(2))), 1)
        self.assertIs(tuple(right.opposite_entities(0))[0], one)
        self.assertIs(tuple(right.opposite_entities(1))[0], nil)
        self.assertIs(tuple(right.opposite_entities(2))[0], nil)

    def test__opposite_records_1(self):
        (nil, one) = (Str(('nil',)), Str(('one',)))
        (zero, jeden, dwa) = (Str(('zero',)), Str(('jeden',)), Str(('dwa',)))

        l_tab = Strs({ '0' : nil, '1' : one })
        r_tab = Strs({  0  : zero, 1  : jeden, 2 : dwa })

        pairs = (pair_.Pair('0',1), pair_.Pair('0',2), pair_.Pair('1',0))

        rel = junction_.Junction((l_tab, r_tab), ('opposite','opposite'), pairs)

        left = endpoint_.Endpoint(rel, relation_.LEFT)
        right = endpoint_.Endpoint(rel, relation_.RIGHT)

        lo = {  '0' : tuple(left.opposite_records('0')),
                '1' : tuple(left.opposite_records('1')) }

        ro = {   0  : tuple(right.opposite_records(0)),
                 1  : tuple(right.opposite_records(1)),
                 2  : tuple(right.opposite_records(2)) }

        self.assertEqual(len(lo['0']), 2)
        self.assertEqual(len(lo['1']), 1)
        self.assertIsInstance(lo['0'][0], StrRec)
        self.assertIsInstance(lo['0'][1], StrRec)
        self.assertIsInstance(lo['1'][0], StrRec)
        self.assertEqual(lo['0'][0], StrRec(jeden, r_tab, 1))
        self.assertEqual(lo['0'][1], StrRec(dwa, r_tab, 2))
        self.assertEqual(lo['1'][0], StrRec(zero, r_tab, 0))
        self.assertIs(lo['0'][0].table, r_tab)
        self.assertIs(lo['0'][1].table, r_tab)
        self.assertIs(lo['1'][0].table, r_tab)
        self.assertEqual(lo['0'][0].id, 1)
        self.assertEqual(lo['0'][1].id, 2)
        self.assertEqual(lo['1'][0].id, 0)

        self.assertEqual(len(ro[0]), 1)
        self.assertEqual(len(ro[1]), 1)
        self.assertEqual(len(ro[2]), 1)
        self.assertIsInstance(ro[0][0], StrRec)
        self.assertIsInstance(ro[1][0], StrRec)
        self.assertIsInstance(ro[2][0], StrRec)
        self.assertEqual(ro[0][0], StrRec(one, l_tab, 1))
        self.assertEqual(ro[1][0], StrRec(nil, l_tab, 0))
        self.assertEqual(ro[2][0], StrRec(nil, l_tab, 0))
        self.assertIs(ro[0][0].table, l_tab)
        self.assertIs(ro[1][0].table, l_tab)
        self.assertIs(ro[2][0].table, l_tab)
        self.assertIs(ro[0][0].id, '1')
        self.assertIs(ro[1][0].id, '0')
        self.assertIs(ro[2][0].id, '0')

    def test__pair_1(self):
        dogs, persons = (Dogs(), Persons())
        rel = junction_.Junction((dogs,persons), ('owners', 'pets'))
        l_pin = endpoint_.Endpoint(rel, relation_.LEFT)
        r_pin = endpoint_.Endpoint(rel, relation_.RIGHT)
        self.assertEqual(l_pin.pair(1,2), pair_.Pair(1,2))
        self.assertEqual(r_pin.pair(2,1), pair_.Pair(1,2))


    def test__repr_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons), ('owners','pets'))
        s = functions_.modelrefstr(rel)
        self.assertEqual(repr(endpoint_.Endpoint(rel, relation_.LEFT)), 'Endpoint(relation=%s,side=LEFT)' % s)
        self.assertEqual(repr(endpoint_.Endpoint(rel, relation_.RIGHT)), 'Endpoint(relation=%s,side=RIGHT)' % s)

class Test__EndpointDict(unittest.TestCase):
    def test__subclass_1(self):
        self.assertTrue(issubclass(endpoint_.EndpointDict, dict_.Dict))

    def test__dictclass_1(self):
        self.assertIs(endpoint_.EndpointDict.__dictclass__(), collections.OrderedDict)

    def test__wrap_1(self):
        with self.assertRaisesRegex(TypeError, r'%s is not an instance of %s' % (repr('foo'), repr(endpoint_.Endpoint))):
            endpoint_.EndpointDict().__wrap__('foo')

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
