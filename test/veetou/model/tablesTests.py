#!/usr/bin/env python3
# -*- coding: utf8 -*-


##import unittest
##import veetou.model.tables_ as tables_
##import veetou.model.entity_ as entity_
##import veetou.model.keystuple_ as keystuple_
##import veetou.model.table_ as table_
##import collections.abc
##import collections
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
##class Test__Tables(unittest.TestCase):
##
##    def test__subclass_1(self):
##        self.assertTrue(issubclass(tables_.Tables, collections.abc.MutableMapping))
##
##    def test__init_1(self):
##        tabs = tables_.Tables()
##        self.assertEqual(tabs._data, dict())
##        self.assertIsInstance(tabs._data, collections.OrderedDict)
##
##    def test__init_2(self):
##        dogs = Dogs()
##        persons = Persons()
##        tabs = tables_.Tables({ 'persons' : persons, 'dogs' : dogs })
##
##        self.assertIs(tabs._data['persons'], persons)
##        self.assertIs(tabs._data['dogs'], dogs)
##
##    def test__getitem__1(self):
##        dogs = Dogs()
##        persons = Persons()
##        tabs = tables_.Tables({ 'persons' : persons, 'dogs' : dogs})
##
##        self.assertIs(tabs['persons'], persons)
##        self.assertIs(tabs['dogs'], dogs)
##
##    def test__setitem__1(self):
##        persons = Persons()
##        tabs = tables_.Tables()
##
##        tabs['persons'] = persons
##
##        self.assertEqual(len(tabs), 1)
##        self.assertIs(tabs['persons'], persons)
##
##    def test__setitem_2(self):
##        tabs = tables_.Tables()
##        with self.assertRaisesRegex(TypeError, "%s is not an instance of %s" % (repr('Bleah'),repr(table_.Table))):
##            tabs['dogs'] = 'Bleah'
##
##    def test__setitem_3(self):
##        tabs = tables_.Tables()
##        with self.assertRaisesRegex(TypeError, "%s is not a string" % repr(7)):
##            tabs[7] = Dogs()

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
