#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.link_ as link_
import veetou.model.linkresolver_ as linkresolver_
import veetou.model.relation_ as relation_
import veetou.model.endpoint_ as endpoint_
import veetou.model.table_ as table_
import veetou.model.entity_ as entity_
import veetou.model.record_ as record_
import veetou.model.keystuple_ as keystuple_


class Message(entity_.Entity):
    _keys = keystuple_.KeysTuple(('msgid', 'default_text'))

class Translation(entity_.Entity):
    _keys = keystuple_.KeysTuple(('text',))

class MessageRec(record_.Record):
    _entityclass = Message

class TranslationRec(record_.Record):
    _entityclass = Translation

class Messages(table_.Table):
    _entityclass = Message
    _recordclass = MessageRec

class Translations(table_.Table):
    _entityclass = Translation
    _recordclass = TranslationRec

MessageRec._tableclass = Messages
TranslationRec._tableclass = Translations


messages = Messages({
    0 : Message(('hello.world', 'Hello World')),
    1 : Message(('vibek.is.hungry', 'Vibek is hungry')),
    2 : Message(('weather.is.awful', 'Weather is awful')),
    3 : Message(('untranslated', 'No translation available'))
})

polish = Translations({
    'hello.world' : Translation(('Witaj świecie',)),
    'vibek.is.hungry' : Translation(('Vibek jest głodny',)),
    'weather.is.awful' : Translation(('Pogoda jest paskudna',)),
})

class Test__Link(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(link_.Link, relation_.Relation))

    def test__init__1(self):
        m = Messages(messages)
        p = Translations(polish)
        msg = r"%s is not an instance of %s" % (repr('foo'), repr(table_.Table))
        with self.assertRaisesRegex(TypeError, msg): link_.Link(('foo', p), ('t','m'))
        with self.assertRaisesRegex(TypeError, msg): link_.Link((m, 'foo'), ('t', 'm'))
        msg = 'missing one of alternative arguments: column, resolver'
        with self.assertRaisesRegex(TypeError, msg): link_.Link((m, p), ('t', 'm'))

    def test__init__2(self):
        source = Messages()
        target = Translations()
        link = link_.Link((source, target), ('t', 's'), column = 0)
        self.assertIs(link.source_table, source)
        self.assertIs(link.target_table, target)
        self.assertIsInstance(link._resolver, linkresolver_.SourceColumnBasedLinkResolver)
        self.assertEqual(link._resolver, linkresolver_.SourceColumnBasedLinkResolver(source,0))
        self.assertIsInstance(source.relations['t'], endpoint_.Endpoint)
        self.assertIs(source.relations['t'].relation, link)
        self.assertIs(source.relations['t'].side, link_.SOURCE)
        self.assertIsInstance(target.relations['s'], endpoint_.Endpoint)
        self.assertIs(target.relations['s'].relation, link)
        self.assertIs(target.relations['s'].side, link_.TARGET)

    def test__init__3(self):
        source = Messages()
        target = Translations()
        link = link_.Link((source, target), ('t', 's'), column = 'msgid')
        self.assertIs(link.source_table, source)
        self.assertIs(link.target_table, target)
        self.assertIsInstance(link._resolver, linkresolver_.SourceColumnBasedLinkResolver)
        self.assertEqual(link._resolver, linkresolver_.SourceColumnBasedLinkResolver(source,0))
        self.assertIsInstance(source.relations['t'], endpoint_.Endpoint)
        self.assertIs(source.relations['t'].relation, link)
        self.assertIs(source.relations['t'].side, link_.SOURCE)
        self.assertIsInstance(target.relations['s'], endpoint_.Endpoint)
        self.assertIs(target.relations['s'].relation, link)
        self.assertIs(target.relations['s'].side, link_.TARGET)

    def test__init__4(self):
        source = Messages()
        target = Translations()
        link = link_.Link((source, target), ('t', 's'), False, column = 'msgid')
        self.assertIs(link.source_table, source)
        self.assertIs(link.target_table, target)
        self.assertIsInstance(link._resolver, linkresolver_.SourceColumnBasedLinkResolver)
        self.assertEqual(link._resolver, linkresolver_.SourceColumnBasedLinkResolver(source,0))
        self.assertFalse('t' in source.relations)
        self.assertFalse('s' in target.relations)

    def test__opposite_keys__1(self):
        m = Messages(messages)
        p = Translations(polish)
        link = link_.Link((m, p), ('t', 's'), column = 0)
        self.assertEqual(list(link.opposite_keys(link_.SOURCE, 0)), ['hello.world'])
        self.assertEqual(list(link.opposite_keys(link_.SOURCE, 1)), ['vibek.is.hungry'])
        self.assertEqual(list(link.opposite_keys(link_.SOURCE, 2)), ['weather.is.awful'])

    def test__opposite_keys__2(self):
        m = Messages(messages)
        p = Translations(polish)
        link = link_.Link((m, p), ('t', 's'), column = 'msgid')
        self.assertEqual(list(link.opposite_keys(link_.SOURCE, 0)), ['hello.world'])
        self.assertEqual(list(link.opposite_keys(link_.SOURCE, 1)), ['vibek.is.hungry'])
        self.assertEqual(list(link.opposite_keys(link_.SOURCE, 2)), ['weather.is.awful'])

    def test__opposite_keys__3(self):
        m = Messages(messages)
        p = Translations(polish)
        link = link_.Link((m, p), ('t', 's'), resolver = linkresolver_.SourceColumnBasedLinkResolver(m,'msgid'))
        self.assertEqual(list(link.opposite_keys(link_.SOURCE, 0)), ['hello.world'])
        self.assertEqual(list(link.opposite_keys(link_.SOURCE, 1)), ['vibek.is.hungry'])
        self.assertEqual(list(link.opposite_keys(link_.SOURCE, 2)), ['weather.is.awful'])
        self.assertEqual(list(link.opposite_keys(link_.SOURCE, 3)), [])

    def test__opposite_keys__4(self):
        m = Messages(messages)
        p = Translations(polish)
        link = link_.Link((m, p), ('t', 's'), resolver = linkresolver_.SourceColumnBasedLinkResolver(m,'msgid'))
        self.assertEqual(list(link.opposite_keys(link_.TARGET, 'hello.world')), [0])
        self.assertEqual(list(link.opposite_keys(link_.TARGET, 'vibek.is.hungry')), [1])
        self.assertEqual(list(link.opposite_keys(link_.TARGET, 'weather.is.awful')), [2])
        self.assertEqual(list(link.opposite_keys(link_.TARGET, 'untranslated')), []) # no real link
        self.assertEqual(list(link.opposite_keys(link_.TARGET, 'bleah')), [])

    def test__eq__1(self):
        m = Messages(messages)
        p = Translations(polish)
        self.assertTrue(link_.Link((m, p), ('t', 's'), column = 0) == link_.Link((m, p), ('t', 's'), column = 0))
        self.assertFalse(link_.Link((p, m), ('t', 's'), column = 0) == link_.Link((m, p), ('t', 's'), column = 0))
        self.assertFalse(link_.Link((m, p), ('t', 's'), column = 1) == link_.Link((m, p), ('t', 's'), column = 0))

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
