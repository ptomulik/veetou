#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.table_ as table_
import veetou.model.mapset_ as mapset_
import veetou.model.entity_ as entity_
import veetou.model.record_ as record_
import veetou.model.datatype_ as datatype_
import veetou.model.keystuple_ as keystuple_
import veetou.model.functions_ as functions_
import veetou.model.list_ as list_
import veetou.model.dict_ as dict_
import veetou.model.reflist_ as reflist_
import veetou.model.ref_ as ref_
import veetou.model.namedtuple_ as namedtuple_
import veetou.model.endpoint_ as endpoint_
import veetou.model.link_ as link_
import collections.abc


class Dog(entity_.Entity):
    _keys = keystuple_.KeysTuple(('name', 'age'))

class Person(entity_.Entity):
    _keys = keystuple_.KeysTuple(('name', 'surname', 'address'))

class Car(entity_.Entity):
    _keys = keystuple_.KeysTuple(('model', 'brand'))

class DogRecord(record_.Record):
    _entityclass = Dog

class PersonRecord(record_.Record):
    _entityclass = Person

class CarRecord(record_.Record):
    _entityclass = Car

class Dogs(table_.Table):
    _entityclass = Dog
    _recordclass = DogRecord

class Persons(table_.Table):
    _entityclass = Person
    _recordclass = PersonRecord

class Cars(table_.Table):
    _entityclass = Car
    _recordclass = CarRecord


DogRecord._tableclass = Dogs
PersonRecord._tableclass = Persons
CarRecord._tableclass = Cars

class Test__Table(unittest.TestCase):
    def test__is_dict__1(self):
        self.assertTrue(issubclass(table_.Table, mapset_.Mapset))

    def test__abstract__0(self):
        with self.assertRaisesRegex(AttributeError, r'\b_entityclass\b'): table_.Table.__entityclass__()
        with self.assertRaisesRegex(AttributeError, r'\b_entityclass\b'): table_.Table()

    def test__abstract__1(self):
        class Abstract(table_.Table): pass
        with self.assertRaisesRegex(AttributeError, r'\b_entityclass\b'): Abstract.__entityclass__()
        with self.assertRaisesRegex(AttributeError, r'\b_entityclass\b'): Abstract()

    def test__entityclass__1(self):
        self.assertIs(Dogs.entityclass, Dog)
        self.assertIs(Dogs.__entityclass__(), Dog)
        self.assertIs(Dogs().__entityclass__(), Dog)
        self.assertIs(functions_.entityclass(Dogs), Dog)
        self.assertIs(functions_.entityclass(Dogs()), Dog)

    def test__entityclass_setter__1(self):
        class MyTable(table_.Table): pass
        with self.assertRaisesRegex(TypeError, r'%s is not a subclass of %s' % (repr('foo'),repr(entity_.Entity))):
            MyTable.entityclass = 'foo'

    def test__entityclass_setter__2(self):
        class MyTable(table_.Table): pass
        class MyEntity(entity_.Entity): pass
        MyTable.entityclass = MyEntity
        self.assertIs(MyTable.entityclass, MyEntity)

    def test__recordclass__1(self):
        self.assertIs(Dogs.recordclass, DogRecord)
        self.assertIs(Dogs.__recordclass__(), DogRecord)
        self.assertIs(Dogs().__recordclass__(), DogRecord)
        self.assertIs(functions_.recordclass(Dogs), DogRecord)
        self.assertIs(functions_.recordclass(Dogs()), DogRecord)

    def test__recordclass_setter__1(self):
        class MyTable(table_.Table): pass
        with self.assertRaisesRegex(TypeError, r'%s is not a subclass of %s' % (repr('foo'),repr(record_.Record))):
            MyTable.recordclass = 'foo'

    def test__recordclass_setter__2(self):
        class MyTable(table_.Table): pass
        class MyRecord(record_.Record): pass
        MyTable.recordclass = MyRecord
        self.assertIs(MyTable.recordclass, MyRecord)

    def test__datatype__1(self):
        class MyEntity(entity_.Entity):
            _keys = keystuple_.KeysTuple(('xxx',))
        class MyTable(table_.Table):
            _datatype = 'foo'
            _entityclass = MyEntity
        self.assertIs(MyTable.datatype, MyTable._datatype)
        self.assertIs(MyTable.__datatype__(), MyTable._datatype)
        self.assertIs(MyTable().__datatype__(), MyTable._datatype)
        self.assertIs(functions_.datatype(MyTable), MyTable._datatype)
        self.assertIs(functions_.datatype(MyTable()), MyTable._datatype)

    def test__datatype_setter__1(self):
        class MyTable(table_.Table): pass
        with self.assertRaisesRegex(TypeError, r'%s is not an instance of %s' % (repr('foo'),repr(datatype_.DataType))):
            MyTable.datatype = 'foo'

    def test__datatype_setter__2(self):
        class MyTable(table_.Table): pass
        dt =  datatype_.DataType()
        MyTable.datatype = dt
        self.assertIs(MyTable.datatype, dt)

    def test__init__1(self):
        table = Dogs()
        self.assertEqual(len(table), 0)

    def test__init__2(self):
        dogs = { 'cody' : Dog(('Cody', 3)), 'snoopy' : Dog(('Snoopy', 5)) }
        table = Dogs(dogs)
        self.assertEqual(len(table), 2)
        self.assertIs(table['cody'], dogs['cody'])
        self.assertIs(table['snoopy'], dogs['snoopy'])

    def test__init__3(self):
        dogs = ( ('key', 'Bleah'),  )
        with self.assertRaisesRegex(TypeError, r"%s is not an instance of %s" % (repr('Bleah'),Dog)):
            Dogs(dogs)

    def test__relations__1(self):
        table = Dogs()
        self.assertIsInstance(table.relations, endpoint_.EndpointDict)
        self.assertEqual(len(table.relations), 0)

    def test__relations_setter__1(self):
        table = Dogs()
        with self.assertRaisesRegex(AttributeError, r"can't set attribute"): table.relations = 'foo'

    def test__setitem__1(self):
        table = Dogs()
        with self.assertRaisesRegex(TypeError, "%s is not an instance of %s" % (repr('Bleah'),Dog)):
            table['key'] = 'Bleah'

    def test__declare__1(self):
        MyTable = table_.Table.__declare__('MyTable', entityclass = Dog, recordclass = DogRecord)
        self.assertTrue(issubclass(MyTable, table_.Table))
        self.assertIs(MyTable.entityclass, Dog)
        self.assertIs(MyTable.recordclass, DogRecord)

    def test__declare__3(self):
        foo = 'FOO'
        MyTable = table_.Table.__declare__("MyTable",
                { 'foo' : foo },
                entityclass = Dog,
                module = 'xm'
        )
        self.assertTrue(issubclass(MyTable, table_.Table))
        self.assertEqual(MyTable.__name__, 'MyTable')
        self.assertIs(MyTable.entityclass, Dog)
        self.assertEqual(MyTable.__module__, 'xm')
        self.assertIs(MyTable.foo, foo)

    def test__start_append_id__1(self):
        table = Dogs()
        self.assertEqual(table.start_append_id, 0)
        table.start_append_id = 2
        self.assertEqual(table.start_append_id, 2)

    def test__start_append_id__2(self):
        table = Dogs(start_append_id = 10)
        self.assertEqual(table.start_append_id, 10)

    def test__last_append_id__1(self):
        table = Dogs()
        self.assertFalse(hasattr(table, 'last_append_id'))
        with self.assertRaisesRegex(AttributeError, r"can't set attribute"):
            table.last_append_id = 20
        self.assertEqual(table.append(Dog(('Snoopy', 10))), 0)
        self.assertEqual(table.last_append_id, 0)
        self.assertEqual(table.append(Dog(('Cody', 12))), 1)
        self.assertEqual(table.last_append_id, 1)
        self.assertEqual(table.find_or_append(Dog(('Snoopy', 10))), 0)
        self.assertEqual(table.last_append_id, 0)

    def test__last_append_id__2(self):
        table = Dogs(start_append_id = 10)
        self.assertFalse(hasattr(table, 'last_append_id'))
        self.assertEqual(table.append(Dog(('Snoopy', 10))), 10)
        self.assertEqual(table.last_append_id, 10)

    def test__high_append_id__1(self):
        table = Dogs()
        self.assertFalse(hasattr(table, 'high_append_id'))
        with self.assertRaisesRegex(AttributeError, r"can't set attribute"):
            table.high_append_id = 20
        self.assertEqual(table.append(Dog(('Snoopy', 10))), 0)
        self.assertEqual(table.high_append_id, 0)
        self.assertEqual(table.append(Dog(('Cody', 12))), 1)
        self.assertEqual(table.high_append_id, 1)
        self.assertEqual(table.find_or_append(Dog(('Snoopy', 10))), 0)
        self.assertEqual(table.high_append_id, 1)

    def test__high_append_id__2(self):
        table = Dogs(start_append_id = 10)
        self.assertFalse(hasattr(table, 'high_append_id'))
        self.assertEqual(table.append(Dog(('Snoopy', 10))), 10)
        self.assertEqual(table.high_append_id, 10)

    def test__append__1(self):
        table = Dogs(start_append_id = 10)
        table[11] = Dog(('Lessie', 2))
        table[12] = Dog(('Snoopy', 8))
        self.assertEqual(table.append(Dog(('Cody',12))), 10)
        self.assertEqual(table.last_append_id, 10)
        self.assertEqual(table.append(Dog(('Lilly',6))), 13)
        self.assertEqual(table.last_append_id, 13)

    def test__find_or_append__1(self):
        table = Dogs(start_append_id = 10)
        table[11] = Dog(('Lessie', 2))
        table[12] = Dog(('Snoopy', 8))
        self.assertEqual(table.find_or_append(Dog(('Cody',12))), 10)
        self.assertEqual(table.last_append_id, 10)
        self.assertEqual(table.find_or_append(Dog(('Lilly',6))), 13)
        self.assertEqual(table.last_append_id, 13)
        self.assertEqual(table.find_or_append(Dog(('Snoopy',8))), 12)
        self.assertEqual(table.last_append_id, 12)
        self.assertEqual(table.high_append_id, 13)

    def test__getrecord__1(self):
        dogs = { 'cody' : Dog(('Cody', 3)), 'snoopy' : Dog(('Snoopy', 5)) }
        table = Dogs(dogs)

        cody = table.getrecord('cody')
        self.assertIsInstance(cody, DogRecord)
        self.assertEqual(cody['name'], 'Cody')
        self.assertEqual(cody['age'], 3)
        self.assertIs(cody.table, table)
        self.assertIs(cody.id, 'cody')

        snoopy = table.getrecord('snoopy')
        self.assertIsInstance(snoopy, DogRecord)
        self.assertEqual(snoopy['name'], 'Snoopy')
        self.assertEqual(snoopy['age'], 5)
        self.assertIs(snoopy.table, table)
        self.assertIs(snoopy.id, 'snoopy')


    def test__columniter__1(self):
        tab = Dogs()
        it = functions_.columniter(tab)

        self.assertIsInstance(it, table_.TableColumnIterator)

        col = next(it)
        self.assertIs(col.table, tab)
        self.assertEqual(col.index, 0)

        col = next(it)
        self.assertIs(col.table, tab)
        self.assertEqual(col.index, 1)

        with self.assertRaises(StopIteration):
            next(it)

    def test__columniter__2(self):
        columniter = functions_.columniter
        schemaname = functions_.schemaname
        self.assertEqual([schemaname(col) for col in columniter(Dogs())], ['dogs.name', 'dogs.age'])

class Test_TableColumnDescriptor(unittest.TestCase):
    def test__init__1(self):
        tab = Dogs()
        col = table_.TableColumnDescriptor(tab, 0)
        self.assertIs(col._table, tab)
        self.assertEqual(col._index, 0)

        col = table_.TableColumnDescriptor(tab, 1)
        self.assertIs(col._table, tab)
        self.assertEqual(col._index, 1)

        col = table_.TableColumnDescriptor(tab, -2)
        self.assertIs(col._table, tab)
        self.assertEqual(col._index, -2)

    def test__init__2(self):
        with self.assertRaisesRegex(TypeError, "%s is not an instance of %s" % (repr('foo'), repr(table_.Table))):
            table_.TableColumnDescriptor('foo', 1)

    def test__init__3(self):
        with self.assertRaisesRegex(IndexError, "table column index out of range"):
            table_.TableColumnDescriptor(Dogs(), -3)
        with self.assertRaisesRegex(IndexError, "table column index out of range"):
            table_.TableColumnDescriptor(Dogs(), 2)

    def test__table__1(self):
        tab = Dogs()
        col = table_.TableColumnDescriptor(tab, 0)
        self.assertIs(col.table, tab)

    def test__table_setter__1(self):
        class MyTable(table_.Table): pass
        col = table_.TableColumnDescriptor(Dogs(), 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            col.table = MyTable

    def test__tableclass__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        self.assertIs(functions_.tableclass(col), Dogs)

    def test__tableclass_setter__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            col.table = Persons()

    def test__index__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        self.assertEqual(col.index, 0)

        col = table_.TableColumnDescriptor(Dogs(), -1)
        self.assertEqual(col.index, -1)

    def test__index_setter__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            col.index = 1

    def test__entityclass__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 1)
        self.assertIs(col.entityclass, Dog)
        self.assertIs(functions_.entityclass(col), Dog)

    def test__entityclass_setter__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            col.entityclass = Dog

    def test__key__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        self.assertEqual(col.key, Dog.keys()[0])

        col = table_.TableColumnDescriptor(Dogs(), 1)
        self.assertEqual(col.key, Dog.keys()[1])

        col = table_.TableColumnDescriptor(Dogs(), -1)
        self.assertEqual(col.key, Dog.keys()[-1])

        col = table_.TableColumnDescriptor(Dogs(), -2)
        self.assertEqual(col.key, Dog.keys()[-2])

    def test__key_setter__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            col.key = 'foo'

    def test__type__1(self):
        class MyEnt(entity_.Entity):
            _keys = keystuple_.KeysTuple(('foo', 'bar'))
            _types = (str,int)
        class MyTab(table_.Table):
            _entityclass = MyEnt

        col = table_.TableColumnDescriptor(MyTab(), 0)
        self.assertIs(col.type, MyEnt.types()[0])

        col = table_.TableColumnDescriptor(MyTab(), 1)
        self.assertIs(col.type, MyEnt.types()[1])

        col = table_.TableColumnDescriptor(MyTab(), -1)
        self.assertIs(col.type, MyEnt.types()[-1])

        col = table_.TableColumnDescriptor(MyTab(), -2)
        self.assertIs(col.type, MyEnt.types()[-2])

    def test__type_setter__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            col.type = Dog

    def test__schemaname__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        self.assertEqual(col.schemaname, 'dogs.name')
        self.assertEqual(functions_.schemaname(col), 'dogs.name')

        col = table_.TableColumnDescriptor(Dogs(), 1)
        self.assertEqual(col.schemaname, 'dogs.age')
        self.assertEqual(functions_.schemaname(col), 'dogs.age')

    def test__schemaname_setter__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            col.schemaname = 'foo'

    def test__modelname__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        self.assertEqual(col.modelname, "Dog['name']")
        self.assertEqual(functions_.modelname(col), "Dog['name']")

        col = table_.TableColumnDescriptor(Dogs(), 1)
        self.assertEqual(col.modelname, "Dog['age']")
        self.assertEqual(functions_.modelname(col), "Dog['age']")

    def test__modelname_setter__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            col.modelname = 'foo'

    def test__repr__1(self):
        col = table_.TableColumnDescriptor(Dogs(), 1)
        self.assertEqual(repr(col), "%s(%s,%d)" % (functions_.modelname(col), functions_.modelname(Dogs), 1))

class Test_TableColumnIterator(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(table_.TableColumnIterator, collections.abc.Iterator))
    def test__init__1(self):
        tab = Dogs()
        it = table_.TableColumnIterator(tab)
        self.assertIs(it._table, tab)
        self.assertEqual(it._index, 0)

    def test__next__1(self):
        tab = Dogs()
        it = table_.TableColumnIterator(tab)

        self.assertEqual(it._index, 0)
        col = next(it)
        self.assertIsInstance(col, table_.TableColumnDescriptor)
        self.assertIs(col.table, tab)
        self.assertEqual(col.index, 0)

        self.assertEqual(it._index, 1)
        col = next(it)
        self.assertIsInstance(col, table_.TableColumnDescriptor)
        self.assertIs(col.table, tab)
        self.assertEqual(col.index, 1)

        self.assertEqual(it._index, 2)
        with self.assertRaises(StopIteration):
            next(it)

    def test__repr__1(self):
        it = table_.TableColumnIterator(Dogs())
        self.assertEqual(repr(it), "%s(%s,%d)" % (functions_.modelname(it), functions_.modelname(Dogs), 0))
        next(it)
        self.assertEqual(repr(it), "%s(%s,%d)" % (functions_.modelname(it), functions_.modelname(Dogs), 1))

class Test_TableList(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(table_.TableList, list_.List))

    def test__listclass__1(self):
        self.assertIs(table_.TableList.__listclass__(), list)

    def test__init__1(self):
        ts = table_.TableList()
        self.assertEqual(len(ts), 0)

    def test__init__2(self):
        dogs = Dogs()
        persons = Persons()
        ts = table_.TableList((dogs, persons))
        self.assertEqual(len(ts._data), 2)
        self.assertIsInstance(ts._data[0], ref_.Ref)
        self.assertIsInstance(ts._data[1], ref_.Ref)
        self.assertIs(ts._data[0].obj, dogs)
        self.assertIs(ts._data[1].obj, persons)

    def test__getitem__1(self):
        dogs = Dogs()
        persons = Persons()
        ts = table_.TableList((dogs, persons))
        self.assertIs(ts[0], dogs)
        self.assertIs(ts[1], persons)
        with self.assertRaises(IndexError): ts[ 2]
        with self.assertRaises(IndexError): ts[-3]

    def test__setitem__1(self):
        dogs = Dogs()
        persons = Persons()
        ts = table_.TableList((dogs, persons))
        ts[0] = persons
        ts[1] = dogs

        self.assertIs(ts[0], persons)
        self.assertIs(ts[1], dogs)

        with self.assertRaises(IndexError): ts[ 2] = persons
        with self.assertRaises(IndexError): ts[-3] = persons

        self.assertEqual(len(ts), 2)
        self.assertIs(ts[0], persons)
        self.assertIs(ts[1], dogs)

    def test__setitem__2(self):
        dogs = Dogs()
        persons = Persons()
        tables = [dogs, persons]

        ts = table_.TableList()
        ts[:] = tables

        self.assertEqual(len(ts), 2)
        self.assertIs(ts[0], dogs)
        self.assertIs(ts[1], persons)

    def test__setitem__3(self):
        dogs = Dogs()
        persons = Persons()
        ts = table_.TableList((dogs, persons))

        with self.assertRaisesRegex(TypeError, "%s is not an instance of %s" % (repr('foo'), repr(table_.Table))):
            ts[0] = 'foo'

    def test__delitem__1(self):
        dogs = Dogs()
        persons = Persons()
        ts = table_.TableList((dogs, persons))

        self.assertEqual(len(ts), 2)
        del ts[0]
        self.assertEqual(len(ts), 1)
        self.assertIs(ts[0], persons)

        del ts[0]
        self.assertEqual(len(ts), 0)

        with self.assertRaises(IndexError): del ts[0]

    def test__delitem__2(self):
        dogs = Dogs()
        persons = Persons()
        ts = table_.TableList((dogs, persons))
        del ts[:]
        self.assertEqual(len(ts), 0)

    def test__insert__1(self):
        dogs = Dogs()
        persons = Persons()
        cars = Cars()
        ts = table_.TableList((dogs, persons))

        ts.insert(1, cars)
        self.assertEqual(len(ts), 3)
        self.assertIs(ts[0], dogs)
        self.assertIs(ts[1], cars)
        self.assertIs(ts[2], persons)

    def test__columniter__1(self):
        dogs = Dogs()
        persons = Persons()
        ts = table_.TableList((dogs, persons))
        it = functions_.columniter(ts)

        col = next(it)
        self.assertIs(col.table, dogs)
        self.assertIs(col.index, 0)

        col = next(it)
        self.assertIs(col.table, dogs)
        self.assertIs(col.index, 1)

        col = next(it)
        self.assertIs(col.table, persons)
        self.assertIs(col.index, 0)

        col = next(it)
        self.assertIs(col.table, persons)
        self.assertIs(col.index, 1)

        col = next(it)
        self.assertIs(col.table, persons)
        self.assertIs(col.index, 2)

        with self.assertRaises(StopIteration): next(it)

    def test__columndict__1(self):
        dogs = Dogs()
        persons = Persons()

        ts = table_.TableList((dogs, persons))

        cd = ts.columndict

        self.assertEqual(len(cd), len(Dog) + len(Person))
        self.assertIsInstance(cd['dogs.name'], table_.TableColumnDescriptor)
        self.assertIs(cd['dogs.name'].table, dogs)
        self.assertEqual(cd['dogs.name'].index, 0)
        self.assertEqual(cd['dogs.name'].key, 'name')

        self.assertIsInstance(cd['dogs.age'], table_.TableColumnDescriptor)
        self.assertIs(cd['dogs.age'].table, dogs)
        self.assertEqual(cd['dogs.age'].index, 1)
        self.assertEqual(cd['dogs.age'].key, 'age')

        self.assertIsInstance(cd['persons.name'], table_.TableColumnDescriptor)
        self.assertIs(cd['persons.name'].table, persons)
        self.assertEqual(cd['persons.name'].index, 0)
        self.assertEqual(cd['persons.name'].key, 'name')

        self.assertIsInstance(cd['persons.surname'], table_.TableColumnDescriptor)
        self.assertEqual(cd['persons.surname'].table, persons)
        self.assertEqual(cd['persons.surname'].index, 1)
        self.assertEqual(cd['persons.surname'].key, 'surname')

        self.assertIsInstance(cd['persons.address'], table_.TableColumnDescriptor)
        self.assertEqual(cd['persons.address'].table, persons)
        self.assertEqual(cd['persons.address'].index, 2)
        self.assertEqual(cd['persons.address'].key, 'address')

    def test__columndict_setter__1(self):
        dogs = Dogs()
        persons = Persons()

        ts = table_.TableList((dogs, persons))

        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            ts.columndict = 'foo'

class Test_TableDict(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(table_.TableDict, dict_.Dict))

    def test__wrap___1(self):
        tab = Dogs()
        self.assertIs(table_.TableDict().__wrap__(tab), tab)

    def test__wrap___2(self):
        msg = '%s is not an instance of %s' % (repr('foo'), repr(table_.Table))
        with self.assertRaisesRegex(TypeError, msg):
            table_.TableDict().__wrap__('foo')


class Test_TableSequenceColumnIterator(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(table_.TableSequenceColumnIterator, collections.abc.Iterator))

    def test__init__1(self):
        seq = []
        it = table_.TableSequenceColumnIterator(seq)
        self.assertIs(it._coliter, None)
        self.assertTrue(hasattr(it, '_tabiter'))

    def test__next__1(self):
        class Empty(entity_.Entity): _keys = keystuple_.KeysTuple()
        class Empties(table_.Table): _entityclass = Empty

        seq = [ Dogs(), Empties(), Persons(), Cars()]

        it = table_.TableSequenceColumnIterator(seq)

        # Dogs.name
        col = next(it)
        self.assertIsInstance(col, table_.TableColumnDescriptor)
        self.assertIs(col.table, seq[0])
        self.assertEqual(col.index, 0)

        # Dogs.age
        col = next(it)
        self.assertIsInstance(col, table_.TableColumnDescriptor)
        self.assertIs(col.table, seq[0])
        self.assertEqual(col.index, 1)

        # Empties are skipped

        # Persons.name
        col = next(it)
        self.assertIsInstance(col, table_.TableColumnDescriptor)
        self.assertIs(col.table, seq[2])
        self.assertEqual(col.index, 0)

        # Persons.surname
        col = next(it)
        self.assertIsInstance(col, table_.TableColumnDescriptor)
        self.assertIs(col.table, seq[2])
        self.assertEqual(col.index, 1)

        # Persons.address
        col = next(it)
        self.assertIsInstance(col, table_.TableColumnDescriptor)
        self.assertIs(col.table, seq[2])
        self.assertEqual(col.index, 2)

        # Cars.model
        col = next(it)
        self.assertIsInstance(col, table_.TableColumnDescriptor)
        self.assertIs(col.table, seq[3])
        self.assertEqual(col.index, 0)

        # Cars.brand
        col = next(it)
        self.assertIsInstance(col, table_.TableColumnDescriptor)
        self.assertIs(col.table, seq[3])
        self.assertEqual(col.index, 1)

        with self.assertRaises(StopIteration):
            next(it)

    def test__repr__1(self):
        it = table_.TableSequenceColumnIterator([])
        self.assertEqual(repr(it), "%s(%s)" % (functions_.modelname(it), functions_.modelname(it._tabiter)))


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
