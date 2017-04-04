#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.junction_ as junction_
import veetou.model.relation_ as relation_
import veetou.model.pair_ as pair_
import veetou.model.table_ as table_
import veetou.model.entity_ as entity_
import veetou.model.record_ as record_
import veetou.model.keystuple_ as keystuple_
import veetou.model.endpoint_ as endpoint_
import veetou.model.functions_ as functions_

class Dog(entity_.Entity):
    _keys = keystuple_.KeysTuple(('name', 'age'))

class Person(entity_.Entity):
    _keys = keystuple_.KeysTuple(('name', 'surname'))

class Char(entity_.Entity):
    _keys = keystuple_.KeysTuple(('char',))

class DogRec(record_.Record):
    _entityclass = Dog

class PersonRec(record_.Record):
    _entityclass = Person

class CharRec(record_.Record):
    _entityclass = Char

class Dogs(table_.Table):
    _entityclass = Dog
    _recordclass = DogRec

class Persons(table_.Table):
    _entityclass = Person
    _recordclass = PersonRec

class Chars(table_.Table):
    _entityclass = Char
    _recordclass = CharRec

DogRec._tableclass = Dogs
PersonRec._tableclass = Persons
CharRec._tableclass = Chars

class Test__Junction(unittest.TestCase):
    def test__subclass_1(self):
        self.assertTrue(issubclass(junction_.Junction, relation_.Relation))

    def test__init_0(self):
        with self.assertRaises(TypeError): junction_.Junction()
        with self.assertRaises(TypeError): junction_.Junction((Dogs(),Persons()))
        with self.assertRaises(TypeError): junction_.Junction((Dogs(),Persons()), (None,None))
        with self.assertRaises(TypeError): junction_.Junction((None,None), ('foo','bar'))

    def test__init_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs, persons), ('owners', 'pets'))

        self.assertEqual(len(dogs.relations), 1)
        self.assertEqual(len(persons.relations), 1)
        self.assertIs(dogs.relations['owners'].relation, rel)
        self.assertIs(persons.relations['pets'].relation, rel)

        self.assertEqual(rel._list, list())
        self.assertEqual(rel._fkmaps, (dict(),dict()))
        self.assertIs(rel._tables[relation_.LEFT], dogs)
        self.assertIs(rel._tables[relation_.RIGHT], persons)
        self.assertEqual(rel._endnames[relation_.LEFT], 'owners')
        self.assertEqual(rel._endnames[relation_.RIGHT], 'pets')

    def test__init_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs, persons), ('owners', 'pets'), pairs)

        self.assertEqual(len(dogs.relations), 1)
        self.assertEqual(len(persons.relations), 1)
        self.assertIs(dogs.relations['owners'].relation, rel)
        self.assertIs(persons.relations['pets'].relation, rel)

        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[1]) # (1,1)
        self.assertIs(rel._list[2], pairs[2]) # (2,0)
        self.assertIs(rel._list[3], pairs[3]) # (0,1)

        self.assertEqual(rel._fkmaps[0], {0 : [0, 3], 1 : [1], 2 : [2]})
        self.assertEqual(rel._fkmaps[1], {0 : [0, 2], 1 : [1, 3]})

    def test__init_3(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair('a','a'), pair_.Pair('b','b'), pair_.Pair('c','a'), pair_.Pair('a','b')]
        rel = junction_.Junction((dogs, persons), ('owners', 'pets'), pairs, False)

        self.assertEqual(len(dogs.relations), 0)
        self.assertEqual(len(persons.relations), 0)

        self.assertIs(rel._list[0], pairs[0]) # ('a','a')
        self.assertIs(rel._list[1], pairs[1]) # ('b','b')
        self.assertIs(rel._list[2], pairs[2]) # ('c','a')
        self.assertIs(rel._list[3], pairs[3]) # ('a','b')

        self.assertEqual(rel._fkmaps[0], {'a' : [0, 3], 'b' : [1], 'c' : [2]})
        self.assertEqual(rel._fkmaps[1], {'a' : [0, 2], 'b' : [1, 3]})

    def test__init_4(self):
        dogs = Dogs()
        persons = Persons()
        with self.assertRaises(TypeError) : junction_.Junction((), ('owners','pets'))
        with self.assertRaises(TypeError) : junction_.Junction((dogs,), ('owners','pets'))
        with self.assertRaisesRegex(TypeError, '%s is not an instance of %s' % (repr('foo'), table_.Table)) :
            junction_.Junction(('foo',persons), ('owners','pets'))
        with self.assertRaisesRegex(TypeError, '%s is not an instance of %s' % (repr('foo'), table_.Table)) :
            junction_.Junction((dogs,'foo'), ('owners','pets'))
        with self.assertRaisesRegex(TypeError, r'%s is not an instance of %s' % (repr(None), table_.Table)):
            junction_.Junction((None,None), ('owners','pets'))

    def test__init_5(self):
        dogs = Dogs()
        persons = Persons()
        with self.assertRaises(TypeError) : junction_.Junction((dogs,persons),())
        with self.assertRaises(TypeError) : junction_.Junction((dogs,persons),('owners',))
        with self.assertRaisesRegex(TypeError, r'%s is not an instance of %s' % (repr(1), str)):
            junction_.Junction((dogs,persons), ('owner',1))
        with self.assertRaisesRegex(TypeError, r'%s is not an instance of %s' % (repr(None), str)):
            junction_.Junction((dogs,persons), (None,None))

    def test__tables_1(self):
        left = Dogs()
        right = Persons()
        rel = junction_.Junction((left, right), ('owners', 'pets'))
        self.assertIs(rel.tables[relation_.LEFT], left)
        self.assertIs(rel.tables[relation_.RIGHT], right)

    def test__tables_setter_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons), ('owners','pets'))
        with self.assertRaisesRegex(AttributeError, r"can't set attribute"):
            rel.tables = (persons,dogs)

    def test__endnames_1(self):
        dogs = Dogs()
        persons = Persons()
        owners = 'owners'
        pets = 'pets'
        rel = junction_.Junction((dogs,persons),(owners, pets))
        self.assertIs(rel.endnames[relation_.LEFT], owners)
        self.assertIs(rel.endnames[relation_.RIGHT], pets)

    def test__endnames_setter_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons),('owners','pets'))
        with self.assertRaisesRegex(AttributeError, r"can't set attribute"):
            rel.endnames = ('foo','bar')

    def test__register_in_tables_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons),('owners','pets'), register = False)
        self.assertEqual(len(dogs.relations), 0)
        self.assertEqual(len(persons.relations), 0)
        rel.register_in_tables()
        self.assertEqual(len(dogs.relations), 1)
        self.assertEqual(len(persons.relations), 1)
        self.assertIsInstance(dogs.relations['owners'], endpoint_.Endpoint)
        self.assertIsInstance(persons.relations['pets'], endpoint_.Endpoint)
        self.assertIs(dogs.relations['owners'].relation, rel)
        self.assertIs(persons.relations['pets'].relation, rel)
        self.assertIs(dogs.relations['owners'].side, relation_.LEFT)
        self.assertIs(persons.relations['pets'].side, relation_.RIGHT)

    def test__insert_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'))

        rel.insert(0,pairs[0])
        rel.insert(1,pairs[1])
        rel.insert(2,pairs[2])
        rel.insert(2,pairs[3])

        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[1]) # (1,1)
        self.assertIs(rel._list[2], pairs[3]) # (0,1)
        self.assertIs(rel._list[3], pairs[2]) # (2,0)

        self.assertEqual(rel._fkmaps[0], {0 : [0, 2], 1 : [1], 2 : [3]})
        self.assertEqual(rel._fkmaps[1], {0 : [0, 3], 1 : [1, 2]})

    def test__insert_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'),[pairs[1], pairs[0], pairs[3]])

        rel.insert(1,pairs[3])

        self.assertEqual(len(rel), 4)
        self.assertIs(rel[0], pairs[1]) # (1,1)
        self.assertIs(rel[1], pairs[3]) # (0,1)
        self.assertIs(rel[2], pairs[0]) # (0,0)
        self.assertIs(rel[3], pairs[3]) # (0,1)

        self.assertEqual(rel._fkmaps[0], {0 : [1,2,3], 1 : [0]})
        self.assertEqual(rel._fkmaps[1], {0 : [2], 1 : [0,1,3]})

    def test__insert_3(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'), pairs)

        with self.assertRaisesRegex(TypeError, r'%s is not an instance of %s' % (repr('foo'), repr(pair_.Pair))):
            rel.insert(0, 'foo')

    def test__setitem_by_index_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs[0:3])

        rel[1] = pairs[3]

        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[3]) # (0,1)
        self.assertIs(rel._list[2], pairs[2]) # (2,0)

        self.assertEqual(rel._fkmaps[0], {0 : [0, 1], 2 : [2]})
        self.assertEqual(rel._fkmaps[1], {0 : [0, 2], 1 : [1]})

    def test__setitem_by_index_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]

        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        with self.assertRaises(IndexError): rel[ 4] = pairs[2]
        with self.assertRaises(IndexError): rel[-5] = pairs[2]

    def test__setitem_by_index_3(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'), pairs)

        with self.assertRaisesRegex(TypeError, r'%s is not an instance of %s' % (repr('foo'), repr(pair_.Pair))):
            rel[0] = 'foo'

    def test__setitem_by_slice_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'))

        rel[:] = pairs

        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[1]) # (1,1)
        self.assertIs(rel._list[2], pairs[2]) # (2,0)
        self.assertIs(rel._list[3], pairs[3]) # (0,1)

        self.assertEqual(rel._fkmaps[0], {0 : [0, 3], 1 : [1], 2 : [2]})
        self.assertEqual(rel._fkmaps[1], {0 : [0, 2], 1 : [1, 3]})

        rel[1:3] = [ pairs[0], pairs[3] ]

        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[0]) # (0,0)
        self.assertIs(rel._list[2], pairs[3]) # (0,1)
        self.assertIs(rel._list[3], pairs[3]) # (0,1)

        self.assertEqual(rel._fkmaps[0], {0 : [0, 1, 2, 3]})
        self.assertEqual(rel._fkmaps[1], {0 : [0, 1], 1 : [2, 3]})

    def test__setitem_by_slice_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        rel[2:6] = [ pairs[0], pairs[1], pairs[3], pairs[2] ]

        self.assertEqual(len(rel), 6)
        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[1]) # (1,1)
        self.assertIs(rel._list[2], pairs[0]) # (0,0)
        self.assertIs(rel._list[3], pairs[1]) # (1,1)
        self.assertIs(rel._list[4], pairs[3]) # (0,1)
        self.assertIs(rel._list[5], pairs[2]) # (2,0)

        self.assertEqual(rel._fkmaps[0], {0 : [0, 2, 4], 1 : [1, 3], 2 : [5]})
        self.assertEqual(rel._fkmaps[1], {0 : [0, 2, 5], 1 : [1, 3, 4]})

    def test__setitem_by_slice_3(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'), pairs)

        with self.assertRaisesRegex(TypeError, r'%s is not an instance of %s' % (repr('foo'), repr(pair_.Pair))):
            rel[:] = ['foo', 'bar']

    def test__delitem_by_index_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        del rel[1]

        self.assertEqual(len(rel), 3)
        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[2]) # (2,0)
        self.assertIs(rel._list[2], pairs[3]) # (0,1)

        self.assertEqual(rel._fkmaps[0], {0 : [0, 2], 2 : [1]})
        self.assertEqual(rel._fkmaps[1], {0 : [0, 1], 1 : [2]})

    def test__delitem_by_index_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        del rel[-3]

        self.assertEqual(len(rel), 3)
        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[2]) # (2,0)
        self.assertIs(rel._list[2], pairs[3]) # (0,1)

        self.assertEqual(rel._fkmaps[0], {0 : [0, 2], 2 : [1]})
        self.assertEqual(rel._fkmaps[1], {0 : [0, 1], 1 : [2]})

    def test__delitem_by_index_3(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        del rel[3]

        self.assertEqual(len(rel), 3)
        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[1]) # (1,1)
        self.assertIs(rel._list[2], pairs[2]) # (2,0)

        self.assertEqual(rel._fkmaps[0], {0 : [0], 1 : [1], 2 : [2]})
        self.assertEqual(rel._fkmaps[1], {0 : [0, 2], 1 : [1]})

    def test__delitem_by_index_4(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        with self.assertRaises(IndexError): del rel[ 4]
        with self.assertRaises(IndexError): del rel[-5]

        self.assertEqual(len(rel), 4)
        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[1]) # (1,1)
        self.assertIs(rel._list[2], pairs[2]) # (2,0)
        self.assertIs(rel._list[3], pairs[3]) # (0,1)

    def test__delitem_by_slice_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        del rel[:2]

        self.assertEqual(len(rel), 2)
        self.assertIs(rel._list[0], pairs[2]) # (2,0)
        self.assertIs(rel._list[1], pairs[3]) # (0,1)

        self.assertEqual(rel._fkmaps[0], {0 : [1], 2 : [0]})
        self.assertEqual(rel._fkmaps[1], {0 : [0], 1 : [1]})

    def test__delitem_by_slice_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        del rel[2:8]

        self.assertEqual(len(rel), 2)
        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[1]) # (1,1)

        self.assertEqual(rel._fkmaps[0], {0 : [0], 1 : [1]})
        self.assertEqual(rel._fkmaps[1], {0 : [0], 1 : [1]})

    def test__delitem_by_slice_3(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1)]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        del rel[1:-1]

        self.assertEqual(len(rel), 2)
        self.assertIs(rel._list[0], pairs[0]) # (0,0)
        self.assertIs(rel._list[1], pairs[3]) # (0,1)

        self.assertEqual(rel._fkmaps[0], {0 : [0, 1]})
        self.assertEqual(rel._fkmaps[1], {0 : [0], 1 : [1]})

    def test__contains_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs[:3])

        self.assertTrue(pairs[0]     in rel)
        self.assertTrue(pairs[1]     in rel)
        self.assertTrue(pairs[2]     in rel)
        self.assertTrue(pairs[3] not in rel)

    def test__iter_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        it = iter(rel)

        self.assertIs(next(it), pairs[0])
        self.assertIs(next(it), pairs[1])
        self.assertIs(next(it), pairs[2])
        self.assertIs(next(it), pairs[3])

    def test__reversed_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        rev = list(reversed(rel))

        self.assertIs(rev[0], pairs[3])
        self.assertIs(rev[1], pairs[2])
        self.assertIs(rev[2], pairs[1])
        self.assertIs(rev[3], pairs[0])

    def test__index_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(rel.index(pairs[0]), 0)
        self.assertEqual(rel.index(pairs[1]), 1)
        self.assertEqual(rel.index(pairs[2]), 2)
        self.assertEqual(rel.index(pairs[3]), 3)

    def test__index_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(0,0) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(rel.index(pairs[0]), 0)
        self.assertEqual(rel.index(pairs[1]), 1)
        self.assertEqual(rel.index(pairs[2]), 0)

    def test__count_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(0,0) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(rel.count(pairs[0]), 2)
        self.assertEqual(rel.count(pairs[1]), 1)
        self.assertEqual(rel.count(pairs[2]), 2)
        self.assertEqual(rel.count(pair_.Pair(2,2)), 0)

    def test__indices_for_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(rel.indices_for(relation_.LEFT, 0), [0,3])
        self.assertEqual(rel.indices_for(relation_.LEFT, 1), [1])
        self.assertEqual(rel.indices_for(relation_.LEFT, 2), [2])
        self.assertEqual(rel.indices_for(relation_.RIGHT, 0), [0,2])
        self.assertEqual(rel.indices_for(relation_.RIGHT, 1), [1,3])

    def test__indices_for_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(rel.indices_for(relation_.LEFT, 4), [])
        self.assertEqual(rel.indices_for(relation_.RIGHT, 4), [])

    def test__indices_for_3(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons),('owners','pets'))

        with self.assertRaisesRegex(ValueError,  r'%s is neither LEFT nor RIGHT' % repr('foo')):
            rel.indices_for('foo', 2)

    def test__relations_for_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual([id(x) for x in rel.relations_for(relation_.LEFT, 0)],  [id(pairs[0]),id(pairs[3])])
        self.assertEqual([id(x) for x in rel.relations_for(relation_.LEFT, 1)],  [id(pairs[1])])
        self.assertEqual([id(x) for x in rel.relations_for(relation_.LEFT, 2)],  [id(pairs[2])])
        self.assertEqual([id(x) for x in rel.relations_for(relation_.RIGHT, 0)], [id(pairs[0]),id(pairs[2])])
        self.assertEqual([id(x) for x in rel.relations_for(relation_.RIGHT, 1)], [id(pairs[1]),id(pairs[3])])

    def test__relations_for_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(list(rel.relations_for(relation_.LEFT, 4)), [])
        self.assertEqual(list(rel.relations_for(relation_.RIGHT, 4)), [])

    def test__opposite_side_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons),('owners','pets'))

        self.assertIs(junction_.Junction.opposite_side(relation_.LEFT), relation_.RIGHT)
        self.assertIs(junction_.Junction.opposite_side(relation_.RIGHT), relation_.LEFT)

        with self.assertRaisesRegex(ValueError, r'%s is neither LEFT nor RIGHT' % repr('foo')):
            junction_.Junction.opposite_side('foo')

    def test__opposite_table_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons),('owners','pets'))

        self.assertIs(rel.opposite_table(relation_.LEFT), persons)
        self.assertIs(rel.opposite_table(relation_.RIGHT), dogs)

    def test__opposite_table_2(self):
        dogs = Dogs()
        persons = Persons()
        rel = junction_.Junction((dogs,persons),('owners','pets'),)

        with self.assertRaisesRegex(ValueError,  r'%s is neither LEFT nor RIGHT' % repr('foo')):
            rel.opposite_table('foo')

    def test__opposite_keys_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair('a','a'), pair_.Pair('b','b'), pair_.Pair('c','a'), pair_.Pair('a','b') ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(list(rel.opposite_keys(relation_.LEFT, 'a')),  ['a', 'b'])
        self.assertEqual(list(rel.opposite_keys(relation_.LEFT, 'b')),  ['b'])
        self.assertEqual(list(rel.opposite_keys(relation_.LEFT, 'c')),  ['a'])
        self.assertEqual(list(rel.opposite_keys(relation_.RIGHT, 'a')), ['a','c'])
        self.assertEqual(list(rel.opposite_keys(relation_.RIGHT, 'b')), ['b','a'])

    def test__opposite_keys_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(list(rel.opposite_keys(relation_.LEFT, 4)), [])
        self.assertEqual(list(rel.opposite_keys(relation_.RIGHT, 4)), [])

    def test__opposite_entities_1(self):
        left  = Chars({'a' : Char(('A',)), 'b' : Char(('B',)), 'c' : Char(('C',))})
        right = Chars({'a' : Char(('X',)), 'b' : Char(('Y',))})
        pairs = [ pair_.Pair('a','a'), pair_.Pair('b','b'), pair_.Pair('c','a'), pair_.Pair('a','b') ]
        rel = junction_.Junction((left,right),('r','l'),pairs)

        self.assertEqual(list(rel.opposite_entities(relation_.LEFT, 'a')),  [Char(('X',)), Char(('Y',))])
        self.assertEqual(list(rel.opposite_entities(relation_.LEFT, 'b')),  [Char(('Y',))])
        self.assertEqual(list(rel.opposite_entities(relation_.LEFT, 'c')),  [Char(('X',))])
        self.assertEqual(list(rel.opposite_entities(relation_.RIGHT, 'a')), [Char(('A',)),Char(('C',))])
        self.assertEqual(list(rel.opposite_entities(relation_.RIGHT, 'b')), [Char(('B',)),Char(('A',))])

    def test__opposite_entities_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(list(rel.opposite_entities(relation_.LEFT, 4)), [])
        self.assertEqual(list(rel.opposite_entities(relation_.RIGHT, 4)), [])

    def test__opposite_records_1(self):
        left  = Chars({'a' : Char(('A',)), 'b' : Char(('B',)), 'c' : Char(('C',))})
        right = Chars({'a' : Char(('X',)), 'b' : Char(('Y',))})
        pairs = [ pair_.Pair('a','a'), pair_.Pair('b','b'), pair_.Pair('c','a'), pair_.Pair('a','b') ]
        rel = junction_.Junction((left,right),('r','l'),pairs)

        lo = {  'a': list(rel.opposite_records(relation_.LEFT, 'a')),
                'b': list(rel.opposite_records(relation_.LEFT, 'b')),
                'c': list(rel.opposite_records(relation_.LEFT, 'c')) }
        ro = {  'a': list(rel.opposite_records(relation_.RIGHT, 'a')),
                'b': list(rel.opposite_records(relation_.RIGHT, 'b')) }

        self.assertEqual(lo['a'], [CharRec(('X',), right, 'a'), CharRec(('Y',), right, 'b')])
        self.assertEqual(lo['b'], [CharRec(('Y',), right, 'b')])
        self.assertEqual(lo['c'], [CharRec(('X',), right, 'a')])
        self.assertEqual(ro['a'], [CharRec(('A',), left, 'a'), CharRec(('C',), left, 'c')])
        self.assertEqual(ro['b'], [CharRec(('B',), left, 'b'), CharRec(('A',), left, 'a')])

        self.assertIsInstance(lo['a'][0], CharRec)
        self.assertIsInstance(lo['a'][1], CharRec)
        self.assertIsInstance(lo['b'][0], CharRec)
        self.assertIsInstance(lo['c'][0], CharRec)
        self.assertIsInstance(ro['a'][0], CharRec)
        self.assertIsInstance(ro['a'][1], CharRec)
        self.assertIsInstance(ro['b'][0], CharRec)
        self.assertIsInstance(ro['b'][1], CharRec)

        self.assertIs(lo['a'][0].table, right)
        self.assertIs(lo['a'][1].table, right)
        self.assertIs(lo['b'][0].table, right)
        self.assertIs(lo['c'][0].table, right)
        self.assertIs(ro['a'][0].table, left)
        self.assertIs(ro['a'][1].table, left)
        self.assertIs(ro['b'][0].table, left)
        self.assertIs(ro['b'][1].table, left)

        self.assertIs(lo['a'][0].id, 'a')
        self.assertIs(lo['a'][1].id, 'b')
        self.assertIs(lo['b'][0].id, 'b')
        self.assertIs(lo['c'][0].id, 'a')
        self.assertIs(ro['a'][0].id, 'a')
        self.assertIs(ro['a'][1].id, 'c')
        self.assertIs(ro['b'][0].id, 'b')
        self.assertIs(ro['b'][1].id, 'a')

    def test__opposite_records_2(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(2,0), pair_.Pair(0,1) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(list(rel.opposite_records(relation_.LEFT, 4)), [])
        self.assertEqual(list(rel.opposite_records(relation_.RIGHT, 4)), [])

    def test__repr_1(self):
        dogs = Dogs()
        persons = Persons()
        pairs = [ pair_.Pair(0,0), pair_.Pair(1,1), pair_.Pair(0,0) ]
        rel = junction_.Junction((dogs,persons),('owners','pets'),pairs)

        self.assertEqual(repr(rel), 'Junction((%s,%s),(%s,%s))' % (
            functions_.modelrefstr(dogs), functions_.modelrefstr(persons),
            repr('owners'), repr('pets')
        ))


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
