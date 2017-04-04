#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.datatype_ as datatype_
import veetou.model.entity_ as entity_
import veetou.model.table_ as table_
import veetou.model.record_ as record_
import veetou.model.namedarray_ as namedarray_
import veetou.model.namedtuple_ as namedtuple_
import veetou.model.keystuple_ as keystuple_
import veetou.model.functions_ as functions_

class DogEntity(entity_.Entity):
    _keys = keystuple_.KeysTuple(('name', 'age'))

class DogTable(table_.Table):
    _entityclass = DogEntity

class DogRecord(record_.Record):
    _entityclass = DogEntity

class DogTuple(namedtuple_.NamedTuple):
    _keys = DogEntity._keys

class DogArray(namedarray_.NamedArray):
    _keys = DogEntity._keys

class Test__DataType(unittest.TestCase):
    def test__init_0(self):
        dt = datatype_.DataType()
        self.assertFalse(hasattr(dt, 'entityclass'))
        self.assertFalse(hasattr(dt, 'tableclass'))
        self.assertFalse(hasattr(dt, 'recordclass'))
        self.assertFalse(hasattr(dt, 'tupleclass'))
        self.assertFalse(hasattr(dt, 'arrayclass'))

    def test__init_1(self):
        dt = datatype_.DataType(DogEntity, DogTable, DogRecord, DogTuple, DogArray)
        self.assertIs(dt.entityclass, DogEntity)
        self.assertIs(dt.tableclass,  DogTable)
        self.assertIs(dt.recordclass, DogRecord)
        self.assertIs(dt.tupleclass, DogTuple)
        self.assertIs(dt.arrayclass, DogArray)

    def test__functions_1(self):
        dt = datatype_.DataType(DogEntity, DogTable, DogRecord, DogTuple, DogArray)
        self.assertIs(functions_.entityclass(dt), DogEntity)
        self.assertIs(functions_.tableclass(dt), DogTable)
        self.assertIs(functions_.recordclass(dt), DogRecord)
        self.assertIs(functions_.tupleclass(dt), DogTuple)
        self.assertIs(functions_.arrayclass(dt), DogArray)

    def test__declare_1(self):

        capitalize = lambda cls, d : (d[0].capitalize(), d[1])
        dt = datatype_.DataType.__declare__('Dog', ('name', 'age'), (str,int), capitalize)

        self.assertTrue(issubclass(dt.entityclass, entity_.Entity))
        self.assertTrue(issubclass(dt.recordclass, record_.Record))
        self.assertTrue(issubclass(dt.tableclass, table_.Table))
        self.assertTrue(issubclass(dt.tupleclass, namedtuple_.NamedTuple))
        self.assertTrue(issubclass(dt.arrayclass, namedarray_.NamedArray))

        self.assertEqual(dt.entityclass.__name__, 'Dog')
        self.assertEqual(dt.recordclass.__name__, 'DogRecord')
        self.assertEqual(dt.tableclass.__name__,  'DogTable')
        self.assertEqual(dt.tupleclass.__name__,  'DogTuple')
        self.assertEqual(dt.arrayclass.__name__,  'DogArray')

        self.assertIs(dt.entityclass.datatype, dt)
        self.assertIs(dt.recordclass.datatype, dt)
        self.assertIs(dt.tableclass.datatype, dt)
        self.assertIs(dt.tupleclass.datatype, dt)
        self.assertIs(dt.arrayclass.datatype, dt)

        ent = dt.entityclass(('snoopy', '20'))
        self.assertEqual(ent['name'], 'Snoopy')
        self.assertEqual(ent['age'], 20)

    def test__declare_2(self):

        capitalize = lambda cls, d : (d[0],d[1].capitalize())
        dt = datatype_.DataType.__declare__('Dog', ('name', 'age'), plural = 'Dogs')

        self.assertTrue(issubclass(dt.entityclass, entity_.Entity))
        self.assertTrue(issubclass(dt.recordclass, record_.Record))
        self.assertTrue(issubclass(dt.tableclass, table_.Table))
        self.assertTrue(issubclass(dt.tupleclass, namedtuple_.NamedTuple))
        self.assertTrue(issubclass(dt.arrayclass, namedarray_.NamedArray))

        self.assertEqual(dt.entityclass.__name__, 'Dog')
        self.assertEqual(dt.recordclass.__name__, 'DogRecord')
        self.assertEqual(dt.tableclass.__name__,  'Dogs')
        self.assertEqual(dt.tupleclass.__name__,  'DogTuple')
        self.assertEqual(dt.arrayclass.__name__,  'DogArray')

    def test__declare_3(self):
        foo = 'FOO'
        dt = datatype_.DataType.__declare__(
                'Dog', ('name', 'age'),
                entityname = 'DogEnt',
                recordname = 'DogRec',
                tablename  = 'DogTab',
                tuplename  = 'DogTup',
                arrayname  = 'DogArr',
                entityargs = { 'attributes' : {'foo' : foo, '__module__' : 'em' } },
                module = 'xm'
        )

        self.assertTrue(issubclass(dt.entityclass, entity_.Entity))
        self.assertTrue(issubclass(dt.recordclass, record_.Record))
        self.assertTrue(issubclass(dt.tableclass, table_.Table))
        self.assertTrue(issubclass(dt.tupleclass, namedtuple_.NamedTuple))
        self.assertTrue(issubclass(dt.arrayclass, namedarray_.NamedArray))

        self.assertIs(dt.entityclass.foo, foo)

        self.assertEqual(dt.entityclass.__name__, 'DogEnt')
        self.assertEqual(dt.recordclass.__name__, 'DogRec')
        self.assertEqual(dt.tableclass.__name__,  'DogTab')
        self.assertEqual(dt.tupleclass.__name__,  'DogTup')
        self.assertEqual(dt.arrayclass.__name__,  'DogArr')

        self.assertEqual(dt.entityclass.__module__, 'em')
        self.assertEqual(dt.recordclass.__module__, 'xm')
        self.assertEqual(dt.tableclass.__module__, 'xm')
        self.assertEqual(dt.tupleclass.__module__, 'xm')
        self.assertEqual(dt.arrayclass.__module__, 'xm')

    def test__declare_4(self):

        dt = datatype_.DataType.__declare__(
                'Dog', ('name', 'age'),
                entityclass = None,
                recordclass = None,
                tableclass  = None,
                tupleclass  = None,
                arrayclass  = None
        )

        self.assertFalse(hasattr(dt, 'entityclass'))
        self.assertFalse(hasattr(dt, 'recordclass'))
        self.assertFalse(hasattr(dt, 'tableclass'))
        self.assertFalse(hasattr(dt, 'tupleclass'))
        self.assertFalse(hasattr(dt, 'arrayclass'))

    def test__declare_4(self):

        dt = datatype_.DataType.__declare__(
                'Dog', ('name', 'age'),
                entityargs = { 'attributes' : {'kind' : 'entity' } },
                recordargs = { 'attributes' : {'kind' : 'record' } },
                tableargs =  { 'attributes' : {'kind' : 'table' } },
                tupleargs =  { 'attributes' : {'kind' : 'tuple' } },
                arrayargs =  { 'attributes' : {'kind' : 'array' } } 
        )

        self.assertEqual(dt.entityclass.kind, 'entity')
        self.assertEqual(dt.recordclass.kind, 'record')
        self.assertEqual(dt.tableclass.kind, 'table')
        self.assertEqual(dt.tupleclass.kind, 'tuple')
        self.assertEqual(dt.arrayclass.kind, 'array')

    def test__newentity_1(self):
        dt = datatype_.DataType.__declare__( 'Dog', ('name', 'age') )
        dog = dt.newentity(('Snoopy', 10))
        self.assertIsInstance(dog, dt.entityclass)
        self.assertIsInstance(dog, entity_.Entity)

    def test__newtable_1(self):
        dt = datatype_.DataType.__declare__( 'Dog', ('name', 'age') )
        dog = dt.newtable()
        self.assertIsInstance(dog, dt.tableclass)
        self.assertIsInstance(dog, table_.Table)

    def test__newrecord_1(self):
        dt = datatype_.DataType.__declare__( 'Dog', ('name', 'age') )
        tab = dt.newtable()
        dog = dt.newrecord(('Snoopy', 10), tab)
        self.assertIsInstance(dog, dt.recordclass)
        self.assertIsInstance(dog, record_.Record)

    def test__newtuple_1(self):
        dt = datatype_.DataType.__declare__( 'Dog', ('name', 'age') )
        dog = dt.newtuple(('Snoopy', 10))
        self.assertIsInstance(dog, dt.tupleclass)
        self.assertIsInstance(dog, namedtuple_.NamedTuple)

    def test__newarray_1(self):
        dt = datatype_.DataType.__declare__( 'Dog', ('name', 'age') )
        dog = dt.newarray(('Snoopy', 10))
        self.assertIsInstance(dog, dt.arrayclass)
        self.assertIsInstance(dog, namedarray_.NamedArray)

    def test__keys_1(self):
        dt = datatype_.DataType.__declare__( 'Dog', ('name', 'age') )
        self.assertEqual(dt.keys(), keystuple_.KeysTuple(('name', 'age')))

    def test__types_1(self):
        dt = datatype_.DataType.__declare__( 'Dog', ('name', 'age'), (str, int) )
        self.assertEqual(dt.types(), (str, int))

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
