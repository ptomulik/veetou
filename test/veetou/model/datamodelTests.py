#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.datamodel_ as datamodel_
import veetou.model.table_ as table_
import veetou.model.relation_ as relation_
import veetou.model.entity_ as entity_
import veetou.model.record_ as record_
import veetou.model.keystuple_ as keystuple_
import re


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

class Test__DataModel(unittest.TestCase):
    def test__init__1(self):
        dm = datamodel_.DataModel()
        self.assertIsInstance(dm.tables, table_.TableDict)
        self.assertIsInstance(dm.relations, relation_.RelationDict)

    def test__init__2(self):
        dogs, persons = (Dogs(), Persons())
        relation = MyRelation((dogs,persons), ('owners','pets'))
        dm = datamodel_.DataModel((('dogs',dogs),('persons',persons)), (('dogs_owners', relation),))
        self.assertIs(dm.tables['dogs'], dogs)
        self.assertIs(dm.tables['persons'], persons)
        self.assertIs(dm.relations['dogs_owners'], relation)

    def test__getattr__1(self):
        dogs, persons = (Dogs(), Persons())
        relation = MyRelation((dogs,persons), ('owners','pets'))
        dm = datamodel_.DataModel((('dogs',dogs),('persons',persons)), (('dogs_owners', relation),))
        self.assertIs(dm.tab_dogs, dogs)
        self.assertIs(dm.tab_persons, persons)
        self.assertIs(dm.rel_dogs_owners, relation)
        msg = re.escape('%s object has no attribute %s' % (repr(datamodel_.DataModel.__name__), 'foo'))
        with self.assertRaisesRegex(AttributeError, msg):
            dm.foo

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
