#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
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

class Test__BasicLinkResolver(unittest.TestCase):
    def test__init__1(self):
        source = Messages(messages)
        r = linkresolver_.SourceColumnBasedLinkResolver(source, 'msgid')
        self.assertIs(r._source_table, source)
        self.assertEqual(r._index, 0)

    def test__init__2(self):
        source = Messages(messages)
        r = linkresolver_.SourceColumnBasedLinkResolver(source, 'default_text')
        self.assertIs(r._source_table, source)
        self.assertEqual(r._index, 1)

    def test__init__3(self):
        source = Messages(messages)
        with self.assertRaisesRegex(KeyError, 'foo'):
            linkresolver_.SourceColumnBasedLinkResolver(source, 'foo')

    def test__call__1(self):
        source = Messages(messages)
        r = linkresolver_.SourceColumnBasedLinkResolver(source, 'msgid')
        self.assertEqual(list(r(0)), ['hello.world'])
        self.assertEqual(list(r(1)), ['vibek.is.hungry'])
        self.assertEqual(list(r(2)), ['weather.is.awful'])
        self.assertEqual(list(r(3)), ['untranslated'])
        with self.assertRaisesRegex(KeyError, r'4'): r(4)

    def test__eq__1(self):
        source = Messages(messages)
        r1 = linkresolver_.SourceColumnBasedLinkResolver(source, 'msgid')
        r2 = linkresolver_.SourceColumnBasedLinkResolver(source, 'msgid')
        self.assertTrue(r1 == r2)

    def test__eq__2(self):
        source = Messages(messages)
        r1 = linkresolver_.SourceColumnBasedLinkResolver(source, 'msgid')
        r2 = linkresolver_.SourceColumnBasedLinkResolver(source, 0)
        self.assertTrue(r1 == r2)

    def test__eq__3(self):
        source1 = Messages(messages)
        source2 = Translations(polish)
        r1 = linkresolver_.SourceColumnBasedLinkResolver(source1, 0)
        r2 = linkresolver_.SourceColumnBasedLinkResolver(source2, 0)
        self.assertFalse(r1 == r2)

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
