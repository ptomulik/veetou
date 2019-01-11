#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
from unittest.mock import patch
from unittest.mock import MagicMock

import veetou.parser.parser_ as parser_
import veetou.model.datamodel_ as datamodel_
import veetou.model.table_ as table_
import veetou.model as model

Dog = model.declare(model.DataType, 'Dog',
        ('name', 'age'),
        plural = 'Dogs'
)

Person = model.declare(model.DataType, 'Person',

        ('name', 'surname'),
        plural = 'Persons'
)

Dogs = model.tableclass(Dog)
Persons = model.tableclass(Person)

class DataModel(model.DataModel):
    def __init__(self):
        super().__init__()
        self.tables['dogs'] = Dogs()
        self.tables['persons'] = Persons()
        self.relations['dog_owners'] = model.Junction(
                (self.tables['dogs'], self.tables['persons']),
                ('owners', 'pets')
        )

class Test__Parser(unittest.TestCase):
    def test__init__1(self):
        parser = parser_.Parser()
        with self.assertRaises(AttributeError):
            parser._parent
        self.assertEqual(parser._children, ())

    def test__init__2(self):
        chp1 = parser_.Parser()
        chp2 = parser_.Parser()
        parser = parser_.Parser((chp1, chp2))
        root = parser_.RootParser((parser,))
        self.assertIs(parser._children[0], chp1)
        self.assertIs(parser._children[1], chp2)
        self.assertIs(parser._parent, root)
        self.assertIs(chp1.parent, parser)
        self.assertIs(chp2.parent, parser)
        self.assertFalse(root._datamodel_disabled)

    def test__parent__1(self):
        chp1 = parser_.Parser()
        chp2 = parser_.Parser()
        parser = parser_.Parser((chp1, chp2))
        root = parser_.RootParser((parser,))
        self.assertIs(parser.parent, root)
        self.assertIs(chp1.parent, parser)
        self.assertIs(chp2.parent, parser)

    def test__parent_setter__1(self):
        chp = parser_.Parser()
        parser = parser_.Parser()
        chp.parent = parser
        self.assertIs(chp.parent, parser)

    def test__root__1(self):
        chp1 = parser_.Parser()
        chp2 = parser_.Parser()
        parser = parser_.Parser((chp1, chp2))
        root = parser_.RootParser((parser,))
        self.assertIs(parser.root, root)
        self.assertIs(chp1.root, root)
        self.assertIs(chp2.root, root)
        self.assertIs(root.root, root)

    def test__root__setter__1(self):
        parser = parser_.Parser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            parser.root = (parser_.Parser(),)

    def test__children__1(self):
        chp1 = parser_.Parser()
        chp2 = parser_.Parser()
        parser = parser_.Parser((chp1, chp2))
        self.assertIs(parser.children[0], chp1)
        self.assertIs(parser.children[1], chp2)

    def test__children__setter__1(self):
        parser = parser_.Parser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            parser.children = (parser_.Parser(),)

    def test__datamodel__1(self):
        chp1 = parser_.Parser()
        chp2 = parser_.Parser()
        parser = parser_.Parser((chp1, chp2))
        root = parser_.RootParser((parser,))
        self.assertIs(parser.datamodel, root.datamodel)
        self.assertIs(chp1.datamodel, root.datamodel)
        self.assertIs(chp2.datamodel, root.datamodel)

    def test__datamodel__setter__1(self):
        parser = parser_.Parser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            parser.datamodel = datamodel_.DataModel()

    def test__datamodel_disabled__1(self):
        chp1 = parser_.Parser()
        chp2 = parser_.Parser()
        parser = parser_.Parser((chp1, chp2))
        root = parser_.RootParser((parser,))
        self.assertIs(parser.datamodel_disabled, root.datamodel_disabled)
        self.assertIs(chp1.datamodel_disabled, root.datamodel_disabled)
        self.assertIs(chp2.datamodel_disabled, root.datamodel_disabled)

    def test__datamodel_disabled__setter__1(self):
        parser = parser_.Parser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            parser.datamodel_disabled = True

    def test__errors__1(self):
        chp1 = parser_.Parser()
        chp2 = parser_.Parser()
        parser = parser_.Parser((chp1, chp2))
        root = parser_.RootParser((parser,))
        self.assertIs(parser.errors, root.errors)
        self.assertIs(chp1.errors, root.errors)
        self.assertIs(chp2.errors, root.errors)
        self.assertIs(root.errors, root.errors)

    def test__errors__setter__1(self):
        parser = parser_.Parser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            parser.errors = True

    def test__table__1(self):
        parser = parser_.Parser()
        self.assertIsNone(parser.table)

    def test__table__setter__1(self):
        parser = parser_.Parser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            parser.table = 'foo'

    def test__endpoint__1(self):
        class MyParser(parser_.Parser):
            @property
            def endpoint(self):
                return 'xyz'
        parser = parser_.Parser()
        parent = MyParser((parser,))
        self.assertIs(parser.endpoint, parent.endpoint)

    def test__endpoint__setter__1(self):
        parser = parser_.Parser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            parser.endpoint = 'foo'

    def test__junctions__1(self):
        class MyParser(parser_.Parser):
            @property
            def endpoint(self):
                return 'xyz'
        parser = parser_.Parser()
        parent = MyParser((parser,))
        self.assertEqual(parser.junctions, ('xyz',))

    def test__junctions__setter__1(self):
        parser = parser_.Parser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            parser.junctions = 'foo'

    def test__append_record__1(self):
        parser = parser_.Parser()
        root = parser_.RootParser((parser,), disable_data=True)
        with patch.object(Dogs, 'append') as tab_append:
            parser.append_record({'name' : 'Name', 'age' : 'Age'}, 'dogs', ('owners',))
        tab_append.assert_not_called()

    def test__append_record__2(self):
        dm = DataModel()
        parser = parser_.Parser()
        root = parser_.RootParser((parser,), dm)
        with patch.object(Dogs, 'append') as tab_append, \
             patch.object(model.Junction, 'append') as rel_append:
            parser.append_record({'name' : 'Name', 'age' : 'Age', 'foo' : 'Foo'}, 'dogs', ())
        dog = model.entityclass(Dog)
        tab_append.assert_called_once_with(dog(**{'name': 'Name', 'age' : 'Age'}))
        rel_append.assert_not_called()

    def test__append_record__3(self):
        dm = DataModel()
        dog = model.entityclass(Dog)
        person = model.entityclass(Person)
        dm.tables['persons'].append(person(**{'name':'John', 'surname':'Smith'}))
        parser = parser_.Parser()
        root = parser_.RootParser((parser,), dm)
        with patch.object(Dogs, 'append', return_value=1) as tab_append, \
             patch.object(model.Junction, 'append') as rel_append:
            parser.append_record({'name' : 'Name', 'age' : 'Age', 'foo' : 'Foo'}, 'dogs', ('owners',))
        tab_append.assert_called_once_with(dog(**{'name': 'Name', 'age' : 'Age'}))
        rel_append.assert_called_once_with(model.Pair(1,0))

    def test__append_record__4(self):
        dm = DataModel()
        dog = model.entityclass(Dog)
        person = model.entityclass(Person)
        dm.tables['persons'].append(person(**{'name':'John', 'surname':'Smith'}))
        parser = parser_.Parser()
        root = parser_.RootParser((parser,), dm)
        with patch.object(Dogs, 'append', return_value=1) as tab_append, \
             patch.object(model.Junction, 'append') as rel_append:
            parser.append_record({'name' : 'Name', 'age' : 'Age', 'foo' : 'Foo'}, 'dogs', (dm.tables['dogs'].relations['owners'],))
        tab_append.assert_called_once_with(dog(**{'name': 'Name', 'age' : 'Age'}))
        rel_append.assert_called_once_with(model.Pair(1,0))

    def test__update_record__1(self):
        parser = parser_.Parser()
        root = parser_.RootParser((parser,), disable_data=True)
        with patch.object(Dogs, 'getrecord') as tab_getrecord, \
             patch.object(model.Record, 'update') as rec_update, \
             patch.object(model.Record, 'save') as rec_save:
            parser.update_record({'name' : 'Name', 'age' : 'Age'}, 'dogs', 'unimportant1', 'unimportant2')
        tab_getrecord.assert_not_called()
        rec_update.assert_not_called()
        rec_save.assert_not_called()

    def test__update_record__2(self):
        dm = DataModel()
        parser = parser_.Parser()
        root = parser_.RootParser((parser,), dm)
        record = model.recordclass(Dog)(('Goofy', '14'), dm.tables['dogs'])
        with patch.object(Dogs, 'getrecord', return_value=record) as tab_getrecord, \
             patch.object(model.Record, 'update', side_effect=record.update) as rec_update, \
             patch.object(model.Record, 'save') as rec_save:
            parser.update_record({'name' : 'Name', 'age' : 'Age', 'foo' : 'Foo'}, 'dogs', 12, True)
        tab_getrecord.assert_called_once_with(12)
        rec_update.assert_called_once_with({'name':'Name', 'age':'Age'})
        rec_save.assert_called_once_with()

    def test__parse_before_children__1(self):
        self.assertTrue(parser_.Parser().parse_before_children('iter', 'kw'))

    def test__parse_with_children__1(self):
        self.assertTrue(parser_.Parser().parse_with_children('iter', 'kw'))

    def test__parse_after_children__1(self):
        self.assertTrue(parser_.Parser().parse_after_children('iter', 'kw'))

    def test__parse__1(self):
        parser = parser_.Parser()
        with patch.object(parser_.Parser, 'parse_before_children', return_value = False) as before, \
             patch.object(parser_.Parser, 'parse_with_children', return_value = True) as middle, \
             patch.object(parser_.Parser, 'parse_after_children', return_value = True) as after, \
             patch.object(parser_.Parser, 'table', 'mytable'), \
             patch.object(parser_.Parser, 'junctions', 'myjunctions'), \
             patch.object(parser_.Parser, 'append_record') as append, \
             patch.object(parser_.Parser, 'update_record') as update:
            parser_.Parser().parse('iter', a = 'A', b = 'B')

        before.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        middle.assert_not_called()
        after.assert_not_called()
        append.assert_not_called()
        update.assert_not_called()

    def test__parse__2(self):
        with patch.object(parser_.Parser, 'parse_before_children', return_value = True) as before, \
             patch.object(parser_.Parser, 'parse_with_children', return_value = False) as middle, \
             patch.object(parser_.Parser, 'parse_after_children', return_value = True) as after, \
             patch.object(parser_.Parser, 'table', 'mytable'), \
             patch.object(parser_.Parser, 'junctions', 'myjunctions'), \
             patch.object(parser_.Parser, 'append_record', return_value = ('key', 'appended')) as append, \
             patch.object(parser_.Parser, 'update_record') as update:
            parser_.Parser().parse('iter', a = 'A', b = 'B')

        before.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        middle.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        after.assert_not_called()
        append.called_once_with({'a' : 'A', 'b' : 'B'}, 'mytable', 'myjunctions')
        update.assert_not_called()

    def test__parse__3(self):
        with patch.object(parser_.Parser, 'parse_before_children', return_value = True) as before, \
             patch.object(parser_.Parser, 'parse_with_children', return_value = True) as middle, \
             patch.object(parser_.Parser, 'parse_after_children', return_value = False) as after, \
             patch.object(parser_.Parser, 'table', 'mytable'), \
             patch.object(parser_.Parser, 'junctions', 'myjunctions'), \
             patch.object(parser_.Parser, 'append_record', return_value = ('key', 'appended')) as append, \
             patch.object(parser_.Parser, 'update_record') as update:
            parser_.Parser().parse('iter', a = 'A', b = 'B')

        before.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        middle.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        after.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        append.called_once_with({'a' : 'A', 'b' : 'B'}, 'mytable', 'myjunctions')
        update.assert_not_called()

    def test__parse__4(self):
        with patch.object(parser_.Parser, 'parse_before_children', return_value = True) as before, \
             patch.object(parser_.Parser, 'parse_with_children', return_value = True) as middle, \
             patch.object(parser_.Parser, 'parse_after_children', return_value = True) as after, \
             patch.object(parser_.Parser, 'table', 'mytable'), \
             patch.object(parser_.Parser, 'junctions', 'myjunctions'), \
             patch.object(parser_.Parser, 'append_record', return_value = ('key', 'appended')) as append, \
             patch.object(parser_.Parser, 'update_record') as update:
            parser_.Parser().parse('iter', a = 'A', b = 'B')

        before.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        middle.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        after.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        append.called_once_with({'a' : 'A', 'b' : 'B'}, 'mytable', 'myjunctions')
        update.called_once_with({'a' : 'A', 'b' : 'B'}, 'mytable', 'key', 'appended')

    def test__parse__5(self):
        with patch.object(parser_.Parser, 'parse_before_children', return_value = True) as before, \
             patch.object(parser_.Parser, 'parse_with_children', return_value = True) as middle, \
             patch.object(parser_.Parser, 'parse_after_children', return_value = True) as after, \
             patch.object(parser_.Parser, 'append_record') as append, \
             patch.object(parser_.Parser, 'update_record') as update:
            parser_.Parser().parse('iter', a = 'A', b = 'B')

        before.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        middle.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        after.assert_called_once_with('iter', {'a' : 'A', 'b' : 'B'})
        append.assert_not_called()
        update.assert_not_called()

    def test__getattr__1(self):
        class FooParser(parser_.Parser):
            def __init__(self):
                self._bar_parser = BarParser()
                super().__init__((self._bar_parser,))
            @property
            def bar_parser(self):
                return self._bar_parser
        class BarParser(parser_.Parser):
            pass
        foo = FooParser()
        bar = foo._bar_parser
        root = parser_.RootParser((foo,))
        self.assertIs(foo.bar_parser, bar)
        self.assertIs(root.bar_parser, bar)
        msg = '%s object has no attribute %s' % (repr(root.__class__.__name__), 'xyz')
        with self.assertRaisesRegex(AttributeError, msg):
            root.xyz
        msg = '%s object has no attribute %s' % (repr(root.__class__.__name__), 'xyz_parser')
        with self.assertRaisesRegex(AttributeError, msg):
            root.xyz_parser


class Test__RootParser(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(parser_.RootParser, parser_.Parser))

    def test__init__1(self):
        root = parser_.RootParser()
        self.assertEqual(root._children, ())
        self.assertEqual(root._errors, [])
        self.assertFalse(root._datamodel_disabled)
        self.assertIsInstance(root._datamodel, datamodel_.DataModel)

    def test__init__2(self):
        chp1 = parser_.Parser()
        chp2 = parser_.Parser()
        root = parser_.RootParser((chp1, chp2))
        self.assertIs(root._children[0], chp1)
        self.assertIs(root._children[1], chp2)
        self.assertEqual(root._errors, [])
        self.assertFalse(root._datamodel_disabled)
        self.assertIs(chp1.parent, root)
        self.assertIs(chp2.parent, root)

    def test__parent__1(self):
        root = parser_.RootParser()
        with self.assertRaises(AttributeError):
            root.parent

    def test__parent__setter__1(self):
        root1 = parser_.RootParser()
        root2 = parser_.RootParser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            root1.parent = root2

    def test__errors__1(self):
        root = parser_.RootParser()
        self.assertIs(root.errors, root._errors)

    def test__errors_setter__1(self):
        root = parser_.RootParser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            root.errors = []

    def test__root__1(self):
        root = parser_.RootParser()
        self.assertIs(root.root, root)

    def test__root__setter__1(self):
        root1 = parser_.RootParser()
        root2 = parser_.RootParser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            root1.root = root2

    def test__datamodel__1(self):
        root = parser_.RootParser()
        self.assertIs(root.datamodel, root._datamodel)

    def test__datamodel__setter__1(self):
        root = parser_.RootParser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            root.datamodel = datamodel_.DataModel()

    def test__datamodel_disabled__1(self):
        root = parser_.RootParser()
        self.assertIs(root.datamodel_disabled, root._datamodel_disabled)

    def test__datamodel_disabled__setter__1(self):
        root = parser_.RootParser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            root.datamodel_disabled = True

    def test__table__1(self):
        root = parser_.RootParser()
        with self.assertRaises(AttributeError):
            root.table

    def test__table__setter__1(self):
        root = parser_.RootParser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            root.table = 'foo'

    def test__endpoint__1(self):
        root = parser_.RootParser()
        with self.assertRaises(AttributeError):
            root.endpoint

    def test__endpoint__setter__1(self):
        root = parser_.RootParser()
        with self.assertRaisesRegex(AttributeError, "can't set attribute"):
            root.endpoint = 'foo'

    def test__junctions__1(self):
        root = parser_.RootParser()
        self.assertEqual(root.junctions, ())


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
