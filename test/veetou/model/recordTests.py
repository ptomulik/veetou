#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.record_ as record_
import veetou.model.functions_ as functions_
import veetou.model.namedarray_ as namedarray_
import veetou.model.keystuple_ as keystuple_
import veetou.model.entity_ as entity_
import veetou.model.table_ as table_
import veetou.model.list_ as list_
import collections.abc


class Dog(entity_.Entity):
    _keys = keystuple_.KeysTuple(('name', 'age'))

class Dogs(table_.Table):
    _entityclass = Dog

class DogRec(record_.Record):
    _entityclass = Dog
    _tableclass = Dogs

class Person(entity_.Entity):
    _keys = keystuple_.KeysTuple(('name', 'surname', 'address'))

class Persons(table_.Table):
    _entityclass = Person

class PersonRec(record_.Record):
    _entityclass = Person
    _tableclass = Persons

class Car(entity_.Entity):
    _keys = keystuple_.KeysTuple(('model', 'price'))

class Cars(table_.Table):
    _entityclass = Car

class CarRec(record_.Record):
    _entityclass = Car
    _tableclass = Cars

Dogs._recordclass = DogRec
Persons._recordclass = PersonRec
Cars._recordclass = CarRec

class Test__Record(unittest.TestCase):

    def test__is_named_array(self):
        self.assertTrue(issubclass(record_.Record, namedarray_.NamedArray))

    def test__abstract__0(self):
        with self.assertRaisesRegex(AttributeError, r'\b_entityclass\b'):
            record_.Record.__entityclass__()
        with self.assertRaisesRegex(AttributeError, r'\b_entityclass\b'):
            record_.Record([],[],[])

    def test__abstract__1(self):
        class X(record_.Record): pass
        with self.assertRaisesRegex(AttributeError, r'\b_entityclass\b'):
            X.__entityclass__()
        with self.assertRaisesRegex(AttributeError, r'\b_entityclass\b'):
            X([],Dogs(),[])

    def test__attributes__1(self):
        mytable = Dogs()
        mykey = []
        rec = DogRec(('Snoopy', 10), mytable, mykey)
        self.assertIs(rec.table, mytable)
        self.assertIs(rec.id, mykey)

    def test__keys__1(self):
        self.assertEqual(DogRec.keys(), keystuple_.KeysTuple(('name', 'age')))
        self.assertEqual(DogRec(('Snoopy', 10), Dogs(), 0).keys(), keystuple_.KeysTuple(('name', 'age')))

    def test__entityclass__1(self):
        klass = functions_.entityclass(DogRec)
        self.assertIs(klass, DogRec._entityclass)

    def test__entityclass__2(self):
        class X(DogRec): pass
        X._entityclass = 'foo'
        self.assertIs(functions_.entityclass(X), X._entityclass)

    def test__entityclass_setter__1(self):
        class X(DogRec): pass
        with self.assertRaisesRegex(TypeError, r'%s is not a subclass of %s' % (repr('foo'), repr(entity_.Entity))):
            X.entityclass = 'foo'

    def test__tableclass__1(self):
        klass = functions_.tableclass(DogRec)
        self.assertIs(klass, DogRec._tableclass)

    def test__tableclass__2(self):
        class X(DogRec): pass
        X._tableclass = 'foo'
        self.assertIs(functions_.tableclass(X), X._tableclass)

    def test__tableclass_setter__1(self):
        class X(DogRec): pass
        with self.assertRaisesRegex(TypeError, r'%s is not a subclass of %s' % (repr('foo'), repr(table_.Table))):
            X.tableclass = 'foo'

    def test__declare__1(self):
        MyRecord = record_.Record.__declare__('MyRecord', entityclass = Dog, tableclass = Dogs)
        self.assertTrue(issubclass(MyRecord, record_.Record))
        self.assertIs(MyRecord.entityclass, Dog)
        self.assertIs(MyRecord.tableclass, Dogs)

    def test__declare__3(self):
        foo = 'FOO'
        MyRecord = record_.Record.__declare__("MyRecord",
                { 'foo' : foo },
                entityclass = Dog,
                tableclass = Dogs,
                module = 'xm'
        )
        self.assertTrue(issubclass(MyRecord, record_.Record))
        self.assertEqual(MyRecord.__name__, 'MyRecord')
        self.assertIs(MyRecord.entityclass, Dog)
        self.assertIs(MyRecord.tableclass, Dogs)
        self.assertEqual(MyRecord.__module__, 'xm')
        self.assertIs(MyRecord.foo, foo)

    def test__copy__1(self):
        tab = Dogs()
        rec = DogRec(('Snoopy', 10), tab, 'mykey')
        copy = rec.copy()
        self.assertIsNot(rec, copy)
        self.assertEqual(rec.table, copy.table)
        self.assertEqual(rec.id, copy.id)

    def test__save__1(self):
        tab = Dogs()
        rec = DogRec(('Snoopy', 10), tab, 'mykey')
        self.assertEqual(rec.save(), 'mykey')
        self.assertEqual(rec.id, 'mykey')
        self.assertEqual(tab.getrecord('mykey'), rec)

    def test__save__2(self):
        tab = Dogs()
        rec = DogRec(('Snoopy', 10), tab)
        key = rec.save()
        self.assertEqual(key, tab.last_append_id)
        self.assertEqual(rec.id, tab.last_append_id)
        self.assertEqual(tab.getrecord(tab.last_append_id), rec)

    def test__repr__1(self):
        dogs = Dogs()
        rec = DogRec(('Snoopy', 10), dogs, 123)
        self.assertEqual(repr(rec), "DogRec([%r,%r],table=%s,id=%r)" % ('Snoopy', 10, functions_.modelrefstr(dogs), 123))

class Test_RecordFieldProxy(unittest.TestCase):
    def test__init__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        self.assertIs(fld._record, dog)
        self.assertEqual(fld._index, 0)

        fld = record_.RecordFieldProxy(dog, 1)
        self.assertIs(fld._record, dog)
        self.assertEqual(fld._index, 1)

        fld = record_.RecordFieldProxy(dog, -2)
        self.assertIs(fld._record, dog)
        self.assertEqual(fld._index, -2)

    def test__init__2(self):
        with self.assertRaisesRegex(TypeError, "%s is not an instance of %s" % (repr('foo'), repr(record_.Record))):
            record_.RecordFieldProxy('foo', 1)

    def test__init__3(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)
        with self.assertRaisesRegex(IndexError, "record field index out of range"):
            record_.RecordFieldProxy(dog, -3)
        with self.assertRaisesRegex(IndexError, "record field index out of range"):
            record_.RecordFieldProxy(dog, 2)

    def test__recordclass__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)
        fld = record_.RecordFieldProxy(dog, 0)
        self.assertIs(fld.recordclass, DogRec)
        self.assertIs(functions_.recordclass(fld), DogRec)

    def test__recordclass_setter__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)
        persons = Persons()
        person = PersonRec(('John', 'Smith', 'New York'), persons)
        fld = record_.RecordFieldProxy(dog, 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            fld.record = person

    def test__index__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        self.assertEqual(fld.index, 0)

        fld = record_.RecordFieldProxy(dog, -1)
        self.assertEqual(fld.index, -1)

    def test__index_setter__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            fld.index = 1

    def test__entityclass__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 1)
        self.assertIs(fld.entityclass, Dog)
        self.assertIs(functions_.entityclass(fld), Dog)

    def test__entityclass_setter__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            fld.entityclass = Dog(('Snoopy',12))

    def test__key__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        self.assertEqual(fld.key, DogRec.keys()[0])

        fld = record_.RecordFieldProxy(dog, 1)
        self.assertEqual(fld.key, DogRec.keys()[1])

        fld = record_.RecordFieldProxy(dog, -1)
        self.assertEqual(fld.key, DogRec.keys()[-1])

        fld = record_.RecordFieldProxy(dog, -2)
        self.assertEqual(fld.key, DogRec.keys()[-2])

    def test__key_setter__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            fld.key = 'foo'

    def test__value__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        self.assertIs(fld.value, dog.values()[0])

        fld = record_.RecordFieldProxy(dog, 1)
        self.assertIs(fld.value, dog.values()[1])

        fld = record_.RecordFieldProxy(dog, -1)
        self.assertIs(fld.value, dog.values()[-1])

        fld = record_.RecordFieldProxy(dog, -2)
        self.assertIs(fld.value, dog.values()[-2])

    def test__value_setter__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        fld.value = 'Lessie'

        self.assertEqual(dog[0], 'Lessie')

    def test__type__1(self):
        class MyEnt(entity_.Entity):
            _keys = keystuple_.KeysTuple(('foo', 'bar'))
            _types = (str,int)
        class MyTab(table_.Table):
            _entityclass = MyEnt
        class MyRec(record_.Record):
            _entityclass = MyEnt
            _tableclass = MyTab

        tab = MyTab()
        rec = MyRec(('FOO','BAR'), tab)

        fld = record_.RecordFieldProxy(rec, 0)
        self.assertIs(fld.type, MyEnt.types()[0])

        fld = record_.RecordFieldProxy(rec, 1)
        self.assertIs(fld.type, MyEnt.types()[1])

        fld = record_.RecordFieldProxy(rec, -1)
        self.assertIs(fld.type, MyEnt.types()[-1])

        fld = record_.RecordFieldProxy(rec, -2)
        self.assertIs(fld.type, MyEnt.types()[-2])

    def test__type_setter__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            fld.type = DogRec

    def test__schemaname__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        self.assertEqual(fld.schemaname, 'dogs.name')
        self.assertEqual(functions_.schemaname(fld), 'dogs.name')

        fld = record_.RecordFieldProxy(dog, 1)
        self.assertEqual(fld.schemaname, 'dogs.age')
        self.assertEqual(functions_.schemaname(fld), 'dogs.age')

    def test__schemaname_setter__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            fld.schemaname = 'foo'

    def test__modelname__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        self.assertEqual(fld.modelname, "Dog['name']")
        self.assertEqual(functions_.modelname(fld), "Dog['name']")

        fld = record_.RecordFieldProxy(dog, 1)
        self.assertEqual(fld.modelname, "Dog['age']")
        self.assertEqual(functions_.modelname(fld), "Dog['age']")

    def test__modelname_setter__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 0)
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            fld.modelname = 'foo'

    def test__repr__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        fld = record_.RecordFieldProxy(dog, 1)
        self.assertEqual(repr(fld), "%s(%s,%d)" % (functions_.modelname(fld), functions_.modelname(DogRec), 1))

class Test_RecordFieldIterator(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(record_.RecordFieldIterator, collections.abc.Iterator))

    def test__init__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        it = record_.RecordFieldIterator(dog)
        self.assertIs(it._record, dog)
        self.assertEqual(it._index, 0)

    def test__next__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        it = record_.RecordFieldIterator(dog)

        self.assertEqual(it._index, 0)
        fld = next(it)
        self.assertIsInstance(fld, record_.RecordFieldProxy)
        self.assertIs(fld.record, dog)
        self.assertEqual(fld.index, 0)

        self.assertEqual(it._index, 1)
        fld = next(it)
        self.assertIsInstance(fld, record_.RecordFieldProxy)
        self.assertIs(fld.record, dog)
        self.assertEqual(fld.index, 1)

        self.assertEqual(it._index, 2)
        with self.assertRaises(StopIteration):
            next(it)

    def test__repr__1(self):
        dogs = Dogs()
        dog = DogRec(('Snoopy', 12), dogs)

        it = record_.RecordFieldIterator(dog)
        self.assertEqual(repr(it), "%s(%s,%d)" % (functions_.modelname(it), functions_.modelrefstr(dog), 0))
        next(it)
        self.assertEqual(repr(it), "%s(%s,%d)" % (functions_.modelname(it), functions_.modelrefstr(dog), 1))



class Test_RecordSequence(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(record_.RecordSequence, list_.List))

    def test__init__1(self):
        ts = record_.RecordSequence()
        self.assertEqual(len(ts), 0)

    def test__init__2(self):
        dogs = Dogs()
        persons = Persons()
        dog = DogRec(('Snoopy',12), dogs)
        person = PersonRec(('John', 'Smith', 'New York'), persons)
        ts = record_.RecordSequence((dog, person))
        self.assertEqual(len(ts._data), 2)
        self.assertIs(ts._data[0], dog)
        self.assertIs(ts._data[1], person)

    def test__getitem__1(self):
        dogs = Dogs()
        persons = Persons()
        dog = DogRec(('Snoopy',12), dogs)
        person = PersonRec(('John', 'Smith', 'New York'), persons)
        ts = record_.RecordSequence((dog, person))
        self.assertIs(ts[0], dog)
        self.assertIs(ts[1], person)
        with self.assertRaises(IndexError): ts[ 2]
        with self.assertRaises(IndexError): ts[-3]

    def test__setitem__1(self):
        dogs = Dogs()
        persons = Persons()
        dog = DogRec(('Snoopy',12), dogs)
        person = PersonRec(('John', 'Smith', 'New York'), persons)
        ts = record_.RecordSequence((dog, person))
        ts[0] = person
        ts[1] = dog

        self.assertIs(ts[0], person)
        self.assertIs(ts[1], dog)

        with self.assertRaises(IndexError): ts[ 2] = person
        with self.assertRaises(IndexError): ts[-3] = person

        self.assertEqual(len(ts), 2)
        self.assertIs(ts[0], person)
        self.assertIs(ts[1], dog)

    def test__setitem__2(self):
        dogs = Dogs()
        persons = Persons()
        dog = DogRec(('Snoopy',12), dogs)
        person = PersonRec(('John', 'Smith', 'New York'), persons)
        records = [dog, person]

        rs = record_.RecordSequence()
        rs[:] = records

        self.assertEqual(len(rs), 2)
        self.assertIs(rs[0], dog)
        self.assertIs(rs[1], person)

    def test__setitem__3(self):
        dogs = Dogs()
        persons = Persons()
        dog = DogRec(('Snoopy',12), dogs)
        person = PersonRec(('John', 'Smith', 'New York'), persons)
        ts = record_.RecordSequence((dog, person))

        with self.assertRaisesRegex(TypeError, "%s is not an instance of %s" % (repr('foo'), repr(record_.Record))):
            ts[0] = 'foo'

    def test__delitem__1(self):
        dogs = Dogs()
        persons = Persons()
        dog = DogRec(('Snoopy',12), dogs)
        person = PersonRec(('John', 'Smith', 'New York'), persons)
        rs = record_.RecordSequence((dog, person))

        self.assertEqual(len(rs), 2)
        del rs[0]
        self.assertEqual(len(rs), 1)
        self.assertIs(rs[0], person)

        del rs[0]
        self.assertEqual(len(rs), 0)

        with self.assertRaises(IndexError): del rs[0]

    def test__delitem__2(self):
        dogs = Dogs()
        persons = Persons()
        dog = DogRec(('Snoopy',12), dogs)
        person = PersonRec(('John', 'Smith', 'New York'), persons)
        rs = record_.RecordSequence((dog, person))
        del rs[:]
        self.assertEqual(len(rs), 0)

    def test__insert__1(self):
        dogs = Dogs()
        persons = Persons()
        cars = Cars()
        dog = DogRec(('Snoopy',12), dogs)
        person = PersonRec(('John', 'Smith', 'New York'), persons)
        car = CarRec(('Chevrolet', 12000), cars)

        rs = record_.RecordSequence((dog, person))

        rs.insert(1, car)
        self.assertEqual(len(rs), 3)
        self.assertIs(rs[0], dog)
        self.assertIs(rs[1], car)
        self.assertIs(rs[2], person)

    def test__fielditer__1(self):
        dogs = Dogs()
        persons = Persons()
        dog = DogRec(('Snoopy',12), dogs)
        person = PersonRec(('John', 'Smith', 'New York'), persons)

        rs = record_.RecordSequence((dog, person))
        it = functions_.fielditer(rs)

        fld = next(it)
        self.assertIs(fld.record, dog)
        self.assertIs(fld.index, 0)

        fld = next(it)
        self.assertIs(fld.record, dog)
        self.assertIs(fld.index, 1)

        fld = next(it)
        self.assertIs(fld.record, person)
        self.assertIs(fld.index, 0)

        fld = next(it)
        self.assertIs(fld.record, person)
        self.assertIs(fld.index, 1)

        fld = next(it)
        self.assertIs(fld.record, person)
        self.assertIs(fld.index, 2)

        with self.assertRaises(StopIteration): next(it)


class Test_RecordSequenceFieldIterator(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(record_.RecordSequenceFieldIterator, collections.abc.Iterator))

    def test__init__1(self):
        seq = []
        it = record_.RecordSequenceFieldIterator(seq)
        self.assertIs(it._coliter, None)
        self.assertTrue(hasattr(it, '_tabiter'))

    def test__next__1(self):
        class Empty(entity_.Entity): _keys = keystuple_.KeysTuple()
        class Empties(table_.Table): _entityclass = Empty
        class EmptyRec(record_.Record):
            _tableclass = Empties
            _entityclass = Empty

        dogs = Dogs()
        persons = Persons()
        cars = Cars()
        empties = Empties()

        dog = DogRec(('Snoopy', 12), dogs)
        person = PersonRec(('John', 'Smith', 'New York'), persons)
        car = CarRec(('Chevrolet', 12000), cars)
        empty = EmptyRec((),empties)

        seq = [ dog, empty, person, car]

        it = record_.RecordSequenceFieldIterator(seq)

        # Dogs.name
        fld = next(it)
        self.assertIsInstance(fld, record_.RecordFieldProxy)
        self.assertIs(fld.record, dog)
        self.assertEqual(fld.index, 0)

        # Dogs.age
        fld = next(it)
        self.assertIsInstance(fld, record_.RecordFieldProxy)
        self.assertIs(fld.record, dog)
        self.assertEqual(fld.index, 1)

        # Empties are skipped

        # Persons.name
        fld = next(it)
        self.assertIsInstance(fld, record_.RecordFieldProxy)
        self.assertIs(fld.record, person)
        self.assertEqual(fld.index, 0)

        # Persons.surname
        fld = next(it)
        self.assertIsInstance(fld, record_.RecordFieldProxy)
        self.assertIs(fld.record, person)
        self.assertEqual(fld.index, 1)

        # Persons.address
        fld = next(it)
        self.assertIsInstance(fld, record_.RecordFieldProxy)
        self.assertIs(fld.record, person)
        self.assertEqual(fld.index, 2)

        # Cars.model
        fld = next(it)
        self.assertIsInstance(fld, record_.RecordFieldProxy)
        self.assertIs(fld.record, car)
        self.assertEqual(fld.index, 0)

        # Cars.brand
        fld = next(it)
        self.assertIsInstance(fld, record_.RecordFieldProxy)
        self.assertIs(fld.record, car)
        self.assertEqual(fld.index, 1)

        with self.assertRaises(StopIteration):
            next(it)

    def test__repr__1(self):
        it = record_.RecordSequenceFieldIterator([])
        self.assertEqual(repr(it), "%s(%s)" % (functions_.modelname(it), functions_.modelname(it._tabiter)))


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
