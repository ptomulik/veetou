#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.parser.parsererror_ as parsererror_
import veetou.input.inputline_ as inputline_
import veetou.input.inputcontext_ as inputcontext_

class ParserErrorTestCase(object):

    def createTestObj(self, description = 'parsing error', string = "funky line",
                      source='input.txt', lineno=20):
        context = inputcontext_.InputContext(source, lineno)
        line = inputline_.InputLine(string, context)
        return (self.classTested())(line, description)

    def test__subclass__1(self):
        self.assertTrue(issubclass(self.classTested(), parsererror_.ParserError))

    def test__init__1(self):
        msg = r'%s is not an instance of %s' % (repr('foo'),repr(inputcontext_.InputContext))
        with self.assertRaisesRegex(TypeError, msg):
            (self.classTested())('foo', 'bar')

    def test__category__1(self):
        self.assertEqual(self.createTestObj().category(), self.errorCategory())

    def test__description__1(self):
        self.assertEqual(self.createTestObj().description, 'parsing error')

    def test__context__1(self):
        ctx = inputcontext_.InputContext('input.txt', 20)
        self.assertEqual(self.createTestObj().context(), ctx)

    def test__message__1(self):
        obj = self.createTestObj()
        ctx = obj.context()
        msg = '%s: %s: parsing error' % (ctx.__log__(), self.errorCategory())
        self.assertEqual(self.createTestObj().message(), msg)

class Test__ParserError(unittest.TestCase, ParserErrorTestCase):

    def classTested(self):
        return parsererror_.ParserError

    def errorCategory(self):
        return "error"


class Test__ParserWarning(unittest.TestCase, ParserErrorTestCase):

    def classTested(self):
        return parsererror_.ParserWarning

    def errorCategory(self):
        return "warning"

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
