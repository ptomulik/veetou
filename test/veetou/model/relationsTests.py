#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
##import veetou.model.relations_ as relations_
##import veetou.model.relation_ as relation_
##import veetou.model.entity_ as entity_
##import veetou.model.keystuple_ as keystuple_
##import veetou.model.table_ as table_
##import collections.abc
##
##
##class Dog(entity_.Entity):
##    _keys = keystuple_.KeysTuple(('name', 'age'))
##
##class Person(entity_.Entity):
##    _keys = keystuple_.KeysTuple(('name', 'surname'))
##
##class Dogs(table_.Table):
##    _entityclass = Dog
##
##class Persons(table_.Table):
##    _entityclass = Person
##
##class Test__Table(unittest.TestCase):
##
##    def test__subclass_1(self):
##        self.assertTrue(issubclass(relations_.Relations, collections.abc.MutableMapping))
##
##    def test__init_1(self):
##        rels = relations_.Relations()
##        self.assertEqual(rels._data, dict())
##        self.assertIs(rels.register, False)
##
##    def test__init_2(self):
##        dogs = Dogs()
##        persons = Persons()
##        pets_owners = relation_.Relation(tables = (dogs,persons), endnames = ('owner','pets'))
##        rels = relations_.Relations({ 'pets_owners' : pets_owners })
##
##        self.assertIs(rels._data['pets_owners'], pets_owners)
##        self.assertIs(rels.register, False)
##        self.assertEqual(len(dogs.relations), 0)
##        self.assertEqual(len(persons.relations), 0)
##
##    def test__init_3(self):
##        dogs = Dogs()
##        persons = Persons()
##        pets_owners = relation_.Relation(tables = (dogs,persons), endnames = ('owner','pets'))
##        rels = relations_.Relations({ 'pets_owners' : pets_owners }, register = True)
##
##        self.assertIs(rels._data['pets_owners'], pets_owners)
##        self.assertIs(rels.register, True)
##
##        self.assertEqual(len(dogs.relations), 1)
##        self.assertEqual(len(persons.relations), 1)
##
##        self.assertIs(dogs.relations['owner'].relation, pets_owners)
##        self.assertEqual(dogs.relations['owner'].side, relation_.LEFT)
##        self.assertIs(persons.relations['pets'].relation, pets_owners)
##        self.assertEqual(persons.relations['pets'].side, relation_.RIGHT)
##
##
##    def test__getitem__1(self):
##        dogs = Dogs()
##        persons = Persons()
##        pets_owners = relation_.Relation(tables = (dogs,persons), endnames = ('owner','pets'))
##        rels = relations_.Relations({ 'pets_owners' : pets_owners }, register = True)
##
##        self.assertIs(rels['pets_owners'], pets_owners)
##
##    def test__setitem__1(self):
##        dogs = Dogs()
##        persons = Persons()
##        pets_owners = relation_.Relation(tables = (dogs,persons), endnames = ('owner','pets'))
##        rels = relations_.Relations()
##
##        rels['pets_owners'] = pets_owners
##
##        self.assertIs(rels['pets_owners'], pets_owners)
##        self.assertEqual(len(dogs.relations), 0)
##        self.assertEqual(len(persons.relations), 0)
##
##    def test__setitem__2(self):
##        dogs = Dogs()
##        persons = Persons()
##        pets_owners = relation_.Relation(tables = (dogs,persons), endnames = ('owner','pets'))
##        rels = relations_.Relations(register = True)
##
##        self.assertEqual(len(dogs.relations), 0)
##        self.assertEqual(len(persons.relations), 0)
##
##        rels['pets_owners'] = pets_owners
##
##        self.assertIs(rels['pets_owners'], pets_owners)
##        self.assertEqual(len(dogs.relations), 1)
##        self.assertEqual(len(persons.relations), 1)
##
##        self.assertIs(dogs.relations['owner'].relation, pets_owners)
##        self.assertEqual(dogs.relations['owner'].side, relation_.LEFT)
##        self.assertIs(persons.relations['pets'].relation, pets_owners)
##        self.assertEqual(persons.relations['pets'].side, relation_.RIGHT)
##
##    def test__setitem__3(self):
##        dogs = Dogs()
##        owners = Persons()
##        sellers = Persons()
##        dogs_owners = relation_.Relation(tables = (dogs,owners), endnames = ('owner','dogs'))
##        dogs_owners2 = relation_.Relation(tables = (dogs,owners), endnames = ('owner','dogs'))
##        dogs_sellers = relation_.Relation(tables = (dogs,sellers), endnames = ('seller','dogs'))
##        rels = relations_.Relations(register = True)
##
##        rels['dogs_owners'] = dogs_owners
##
##        self.assertIs(rels['dogs_owners'], dogs_owners)
##        self.assertEqual(len(dogs.relations), 1)
##        self.assertEqual(len(owners.relations), 1)
##        self.assertEqual(len(sellers.relations), 0)
##
##        self.assertIs(dogs.relations['owner'].relation, dogs_owners)
##        self.assertEqual(dogs.relations['owner'].side, relation_.LEFT)
##        self.assertIs(owners.relations['dogs'].relation, dogs_owners)
##        self.assertEqual(owners.relations['dogs'].side, relation_.RIGHT)
##
##        rels['dogs_sellers'] = dogs_sellers
##
##        self.assertIs(rels['dogs_owners'], dogs_owners)
##        self.assertEqual(len(dogs.relations), 2)
##        self.assertEqual(len(owners.relations), 1)
##        self.assertEqual(len(sellers.relations), 1)
##
##        self.assertIs(dogs.relations['owner'].relation, dogs_owners)
##        self.assertEqual(dogs.relations['owner'].side, relation_.LEFT)
##        self.assertIs(dogs.relations['seller'].relation, dogs_sellers)
##        self.assertEqual(dogs.relations['seller'].side, relation_.LEFT)
##        self.assertIs(owners.relations['dogs'].relation, dogs_owners)
##        self.assertEqual(owners.relations['dogs'].side, relation_.RIGHT)
##        self.assertIs(sellers.relations['dogs'].relation, dogs_sellers)
##        self.assertEqual(sellers.relations['dogs'].side, relation_.RIGHT)
##
##        rels['dogs_owners'] = dogs_owners2
##
##        self.assertIs(rels['dogs_owners'], dogs_owners2)
##        self.assertEqual(len(dogs.relations), 2)
##        self.assertEqual(len(owners.relations), 1)
##        self.assertEqual(len(sellers.relations), 1)
##
##        self.assertIs(dogs.relations['owner'].relation, dogs_owners2)
##        self.assertEqual(dogs.relations['owner'].side, relation_.LEFT)
##        self.assertIs(dogs.relations['seller'].relation, dogs_sellers)
##        self.assertEqual(dogs.relations['seller'].side, relation_.LEFT)
##        self.assertIs(owners.relations['dogs'].relation, dogs_owners2)
##        self.assertEqual(owners.relations['dogs'].side, relation_.RIGHT)
##        self.assertIs(sellers.relations['dogs'].relation, dogs_sellers)
##        self.assertEqual(sellers.relations['dogs'].side, relation_.RIGHT)
##
##    def test__setitem_4(self):
##        rels = relations_.Relations()
##        with self.assertRaisesRegex(TypeError, "%s is not an instance of %s" % (repr('Bleah'),repr(relation_.Relation))):
##            rels['foo'] = 'Bleah'
##
##    def test__setitem_5(self):
##        rels = relations_.Relations()
##        with self.assertRaisesRegex(TypeError, "%s is not a string" % repr(7)):
##            rels[7] = Dogs()

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
