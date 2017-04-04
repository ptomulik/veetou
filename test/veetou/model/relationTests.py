#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.relation_ as relation_
import veetou.model.object_ as object_
import veetou.model.table_ as table_
import veetou.model.endpoint_ as endpoint_
import veetou.model.entity_ as entity_
import veetou.model.record_ as record_
import veetou.model.keystuple_ as keystuple_
import veetou.model.functions_ as functions_
import veetou.model.dict_ as dict_

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

class MyRelation(relation_.Relation):

    _relations = (
            { 0: [0, 1], 1: [2] },
            { 0: [0],    1: [0], 2: [1] }
    )

    def opposite_keys(self, side, key):
        return self._relations[side][key]

class Test__Constants(unittest.TestCase):
    def test__LEFT_1(self):
        self.assertEqual(relation_.LEFT, 0)
    def test__RIGHT_1(self):
        self.assertEqual(relation_.RIGHT, 1)

class Test_Functions(unittest.TestCase):
    def test__checkside_LEFT_1(self):
        self.assertEqual(relation_.checkside(relation_.LEFT), relation_.LEFT)
    def test__checkside_RIGHT_1(self):
        self.assertEqual(relation_.checkside(relation_.RIGHT), relation_.RIGHT)
    def test__checkside_1(self):
        with self.assertRaisesRegex(ValueError, r'%s is neither LEFT nor RIGHT' % repr('foo')):
            relation_.checkside('foo')


class Test__Relation(unittest.TestCase):
    def test__subclass_1(self):
        self.assertTrue(issubclass(relation_.Relation, object_.Object))

    def test__abstract_1(self):
        msg = r"Can't instantiate abstract class Relation with abstract methods"
        with self.assertRaisesRegex(TypeError, msg):
            relation_.Relation()

    def test__init_1(self):
        left = Dogs()
        right = Persons()
        rel = MyRelation((left,right), ('owners', 'pets'))
        self.assertEqual(len(rel._tables), 2)
        self.assertIs(rel._tables[relation_.LEFT], left)
        self.assertIs(rel._tables[relation_.RIGHT], right)
        self.assertIsInstance(left.relations['owners'], endpoint_.Endpoint)
        self.assertIs(left.relations['owners'].relation, rel)
        self.assertEqual(left.relations['owners'].side, relation_.LEFT)
        self.assertIsInstance(right.relations['pets'], endpoint_.Endpoint)
        self.assertIs(right.relations['pets'].relation, rel)
        self.assertEqual(right.relations['pets'].side, relation_.RIGHT)

    def test__init_2(self):
        left = Dogs()
        right = Persons()
        rel = MyRelation((left,right), ('owners', 'pets'), False)
        self.assertEqual(len(rel._tables), 2)
        self.assertIs(rel._tables[relation_.LEFT], left)
        self.assertIs(rel._tables[relation_.RIGHT], right)
        self.assertFalse('owners' in left.relations)
        self.assertFalse('pets' in right.relations)

    def test__tables_1(self):
        left = Dogs()
        right = Persons()
        rel = MyRelation((left, right), ('owners', 'pets'))
        self.assertEqual(len(rel.tables), 2)
        self.assertIs(rel.tables[relation_.LEFT], left)
        self.assertIs(rel.tables[relation_.RIGHT], right)

    def test__tables_setter_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = MyRelation((dogs,persons), ('owners', 'pets'))
        with self.assertRaisesRegex(AttributeError, r"can't set attribute"):
            rel.tables = (persons,dogs)

    def test__endnames_1(self):
        tables = (Dogs(), Persons())
        endnames = ('owners', 'pets')
        rel = MyRelation(tables, endnames)
        self.assertEqual(len(rel.endnames), 2)
        self.assertIs(rel.endnames[relation_.LEFT], endnames[relation_.LEFT])
        self.assertIs(rel.endnames[relation_.RIGHT], endnames[relation_.RIGHT])

    def test__endnames_setter_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = MyRelation((dogs,persons), ('owners', 'pets'))
        with self.assertRaisesRegex(AttributeError, r"can't set attribute"):
            rel.endnames = (persons,dogs)

    def test__register_in_tables_1(self):
        left = Dogs()
        right = Persons()
        rel = MyRelation((left,right), ('owners', 'pets'), register = False)
        self.assertFalse('owners' in left.relations)
        self.assertFalse('pets' in right.relations)
        rel.register_in_tables()
        self.assertIsInstance(left.relations['owners'], endpoint_.Endpoint)
        self.assertIs(left.relations['owners'].relation, rel)
        self.assertEqual(left.relations['owners'].side, relation_.LEFT)
        self.assertIsInstance(right.relations['pets'], endpoint_.Endpoint)
        self.assertIs(right.relations['pets'].relation, rel)
        self.assertEqual(right.relations['pets'].side, relation_.RIGHT)

    def test__unregister_from_tables_1(self):
        left = Dogs()
        right = Persons()
        rel = MyRelation((left,right), ('owners', 'pets'))
        self.assertIsInstance(left.relations['owners'], endpoint_.Endpoint)
        self.assertIs(left.relations['owners'].relation, rel)
        self.assertEqual(left.relations['owners'].side, relation_.LEFT)
        self.assertIsInstance(right.relations['pets'], endpoint_.Endpoint)
        self.assertIs(right.relations['pets'].relation, rel)
        self.assertEqual(right.relations['pets'].side, relation_.RIGHT)
        rel.unregister_from_tables()
        self.assertFalse('owners' in left.relations)
        self.assertFalse('pets' in right.relations)

    def test__opposite_side_1(self):
        self.assertIs(relation_.Relation.opposite_side(relation_.LEFT), relation_.RIGHT)
        self.assertIs(relation_.Relation.opposite_side(relation_.RIGHT), relation_.LEFT)

        with self.assertRaisesRegex(ValueError, r'%s is neither LEFT nor RIGHT' % repr('foo')):
            relation_.Relation.opposite_side('foo')

    def test__opposite_table_1(self):
        left = Dogs()
        right = Persons()
        rel = MyRelation((left,right), ('owners', 'pets'))

        self.assertIs(rel.opposite_table(relation_.LEFT), right)
        self.assertIs(rel.opposite_table(relation_.RIGHT), left)

    def test__opposite_table_2(self):
        rel = MyRelation((Dogs(),Persons()), ('owners', 'pets'))

        with self.assertRaisesRegex(ValueError,  r'%s is neither LEFT nor RIGHT' % repr('foo')):
            rel.opposite_table('foo')

    def test__opposite_keys_1(self):
        rel = MyRelation((Dogs(), Persons()), ('owners', 'pets'))

        self.assertEqual(rel.opposite_keys(relation_.LEFT, 0), [0, 1])
        self.assertEqual(rel.opposite_keys(relation_.LEFT, 1), [2])
        self.assertEqual(rel.opposite_keys(relation_.RIGHT,0), [0])
        self.assertEqual(rel.opposite_keys(relation_.RIGHT,1), [0])
        self.assertEqual(rel.opposite_keys(relation_.RIGHT,2), [1])

    def test__opposite_entities_1(self):
        left  = Chars({0 : Char(('A',)), 1 : Char(('B',)), 2 : Char(('C',))})
        right = Chars({0 : Char(('X',)), 1 : Char(('Y',)), 2 : Char(('Z',))})
        rel = MyRelation((left,right), ('owners', 'pets'))

        self.assertEqual(list(rel.opposite_entities(relation_.LEFT, 0)),  [Char(('X',)), Char(('Y',))])
        self.assertEqual(list(rel.opposite_entities(relation_.LEFT, 1)),  [Char(('Z',))])
        self.assertEqual(list(rel.opposite_entities(relation_.RIGHT, 0)), [Char(('A',))])
        self.assertEqual(list(rel.opposite_entities(relation_.RIGHT, 1)), [Char(('A',))])
        self.assertEqual(list(rel.opposite_entities(relation_.RIGHT, 2)), [Char(('B',))])

    def test__opposite_records_1(self):
        left  = Chars({0 : Char(('A',)), 1 : Char(('B',)), 2 : Char(('C',))})
        right = Chars({0 : Char(('X',)), 1 : Char(('Y',)), 2 : Char(('Z',))})
        rel = MyRelation((left,right), ('owners', 'pets'))

        lo = {  0: list(rel.opposite_records(relation_.LEFT,  0)),
                1: list(rel.opposite_records(relation_.LEFT,  1))}
        ro = {  0: list(rel.opposite_records(relation_.RIGHT, 0)),
                1: list(rel.opposite_records(relation_.RIGHT, 1)),
                2: list(rel.opposite_records(relation_.RIGHT, 2)) }

        self.assertEqual(lo[0], [CharRec(('X',), right, 0), CharRec(('Y',), right, 1)])
        self.assertEqual(lo[1], [CharRec(('Z',), right, 2)])
        self.assertEqual(ro[0], [CharRec(('A',), left,  0)])
        self.assertEqual(ro[1], [CharRec(('A',), left,  0)])
        self.assertEqual(ro[2], [CharRec(('B',), left,  1)])

        self.assertIsInstance(lo[0][0], CharRec)
        self.assertIsInstance(lo[0][1], CharRec)
        self.assertIsInstance(lo[1][0], CharRec)
        self.assertIsInstance(ro[0][0], CharRec)
        self.assertIsInstance(ro[1][0], CharRec)
        self.assertIsInstance(ro[2][0], CharRec)

        self.assertIs(lo[0][0].table, right)
        self.assertIs(lo[0][1].table, right)
        self.assertIs(lo[1][0].table, right)
        self.assertIs(ro[0][0].table, left)
        self.assertIs(ro[1][0].table, left)
        self.assertIs(ro[2][0].table, left)

        self.assertIs(lo[0][0].id, 0)
        self.assertIs(lo[0][1].id, 1)
        self.assertIs(lo[1][0].id, 2)
        self.assertIs(ro[0][0].id, 0)
        self.assertIs(ro[1][0].id, 0)
        self.assertIs(ro[2][0].id, 1)

    def test__repr_1(self):
        dogs = Dogs()
        persons = Persons()
        rel = MyRelation((dogs,persons), ('owners', 'pets'))

        self.assertEqual(repr(rel), 'MyRelation((%s,%s),(%s,%s))' % (
            functions_.modelrefstr(dogs), functions_.modelrefstr(persons),
            repr('owners'), repr('pets')
        ))

class Test_RelationDict(unittest.TestCase):
    def test__subclass_1(self):
        self.assertTrue(issubclass(relation_.RelationDict, dict_.Dict))

    def test__wrap__1(self):
        dogs = Dogs()
        persons = Persons()
        rel = MyRelation((dogs,persons),('owners', 'pets'))
        self.assertIs(relation_.RelationDict().__wrap__(rel), rel)

    def test__wrap__2(self):
        msg = '%s is not an instance of %s' % (repr('foo'), repr(relation_.Relation))
        with self.assertRaisesRegex(TypeError, msg):
            relation_.RelationDict().__wrap__('foo')

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
