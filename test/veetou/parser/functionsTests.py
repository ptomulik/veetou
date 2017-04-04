#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.parser.functions_ as functions_
import veetou.input.bufferediterator_ as bufferediterator_
import veetou.input.inputline_ as inputline_
import veetou.input.inputiterator_ as inputiterator_
import veetou.input.inputcontext_ as inputcontext_
import re

class ThreeStrings(inputiterator_.InputIterator):
    def __init__(self):
        self._iterator = iter(['one', 'two', 'three'])
        self._lineno = 1
    def __next__(self):
       line = next(self._iterator)
       self._lineno += 1
       return inputline_.InputLine(line,self.context())
    def context(self):
       return inputcontext_.InputContext('three_strings', self._lineno)

class Test__fullmatch(unittest.TestCase):
    def test__fullmatch_01(self):
        m = functions_.fullmatch(r'this is text', 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,12))

    def test__fullmatch_02(self):
        m = functions_.fullmatch(re.compile(r'this is text'), 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,12))

    def test__fullmatch_03(self):
        m = functions_.fullmatch(r'this is', 'this is text')
        self.assertIsNone(m)

    def test__fullmatch_04(self):
        m = functions_.fullmatch(re.compile(r'this is'), 'this is text')
        self.assertIsNone(m)

    def test__fullmatch_05(self):
        m = functions_.fullmatch(r'is text', 'this is text')
        self.assertIsNone(m)

    def test__fullmatch_06(self):
        m = functions_.fullmatch(r'this is text', '  this is text  ')
        self.assertIsNone(m)

    def test__fullmatch_07(self):
        m = functions_.fullmatch(r'this is text', '  this is text  ', strip = True)
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,12))

    def test__fullmatch_08(self):
        gd = dict()
        m = functions_.fullmatch(r'(?P<w1>\w+) (?P<w2>\w+) (?P<w3>\w+)', 'this is text', groupdict = gd)
        self.assertTrue(m)
        self.assertEqual(gd, {'w1' : 'this', 'w2' : 'is', 'w3' : 'text'})

    def test__fullmatch_09(self):
        gd = dict()
        m = functions_.fullmatch(r'(?P<w1>\w+) (?P<w2>\w+) (?P<w3>\w+)', ' this is text ', groupdict = gd)
        self.assertFalse(m)
        self.assertEqual(gd, dict())

class Test__fullmatchdict(unittest.TestCase):
    def test__dictfullmatch_01(self):
        patterns = {
                r"Monday" : r"(?P<which>First) day of the week",
                r"Tuesday" : r"(?P<which>Second) day of the week",
                r"Wednesday" : r"(?P<which>Third) day of the week",
        }
        gd = dict()
        m = functions_.fullmatchdict(patterns, "Second day of the week", groupdict = gd)
        self.assertIsInstance(m, functions_._PDMatch)
        self.assertEqual(m.key, 'Tuesday')
        self.assertEqual(m.match.span(), (0,22))
        self.assertEqual(gd, { 'which' : 'Second' })
        #
        m = functions_.fullmatchdict(patterns, "Third day of the week", groupdict = gd)
        self.assertIsInstance(m, functions_._PDMatch)
        self.assertEqual(m.key, 'Wednesday')
        self.assertEqual(m.match.span(), (0,21))
        self.assertEqual(gd, { 'which' : 'Third' })

class Test__ifullmatch(unittest.TestCase):
    def test__ifullmatch_01(self):
        lines = iter(('first line', 'second line'))
        m = functions_.ifullmatch(lines, r'first line')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,10))
        self.assertEqual(next(lines), 'second line')

    def test__ifullmatch_02(self):
        lines = iter(('first line   ', '    second line'))
        m = functions_.ifullmatch(lines, r'first line;second line', unwrap=1, unwrap_sep=';', unwrap_rstrip=True)
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,22))
        with self.assertRaises(StopIteration):
            next(lines)

class Test__match(unittest.TestCase):
    def test__match_01(self):
        m = functions_.match(r'this is text', 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,12))

    def test__match_02(self):
        m = functions_.match(re.compile(r'this is text'), 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,12))

    def test__match_03(self):
        m = functions_.match(r'this is', 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,7))

    def test__match_04(self):
        m = functions_.match(re.compile(r'this is'), 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,7))

    def test__match_05(self):
        m = functions_.match(r'is text', 'this is text')
        self.assertIsNone(m)

    def test__match_06(self):
        m = functions_.match(r'this is text', '  this is text  ')
        self.assertIsNone(m)

    def test__match_07(self):
        m = functions_.match(r'this is text', '  this is text  ', strip = True)
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,12))

    def test__match_08(self):
        gd = dict()
        m = functions_.match(r'(?P<w1>\w+) (?P<w2>\w+) (?P<w3>\w+)', 'this is text', groupdict = gd)
        self.assertTrue(m)
        self.assertEqual(gd, {'w1' : 'this', 'w2' : 'is', 'w3' : 'text'})

    def test__match_09(self):
        gd = dict()
        m = functions_.match(r'(?P<w1>\w+) (?P<w2>\w+) (?P<w3>\w+)', ' this is text ', groupdict = gd)
        self.assertIsNone(m)
        self.assertEqual(gd, dict())

class Test__search(unittest.TestCase):
    def test__search_01(self):
        m = functions_.search(r'this is text', 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,12))

    def test__search_02(self):
        m = functions_.search(re.compile(r'this is text'), 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,12))

    def test__search_03(self):
        m = functions_.search(r'this is', 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,7))

    def test__search_04(self):
        m = functions_.search(re.compile(r'this is'), 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,7))

    def test__search_05(self):
        m = functions_.search(r'is text', 'this is text')
        self.assertTrue(m)
        self.assertEqual(m.span(), (5,12))

    def test__search_06(self):
        m = functions_.search(r'this is text', '  this is text  ')
        self.assertTrue(m)
        self.assertEqual(m.span(), (2,14))

    def test__search_07(self):
        m = functions_.search(r'this is text', '  this is text  ', strip = True)
        self.assertTrue(m)
        self.assertEqual(m.span(), (0,12))

    def test__search_08(self):
        gd = dict()
        m = functions_.search(r'(?P<w1>\w+) (?P<w2>\w+) (?P<w3>\w+)', 'this is text', groupdict = gd)
        self.assertTrue(m)
        self.assertEqual(gd, {'w1' : 'this', 'w2' : 'is', 'w3' : 'text'})

    def test__search_09(self):
        gd = dict()
        m = functions_.search(r'(?P<w1>\w+) (?P<w2>\w+) (?P<w3>\w+)', ' this is text ', groupdict = gd)
        self.assertTrue(m)
        self.assertEqual(gd, {'w1' : 'this', 'w2' : 'is', 'w3' : 'text'})

class Test__matchdict(unittest.TestCase):
    def test__dictmatch_01(self):
        patterns = {
                r"Monday" : r"(?P<which>First) day",
                r"Tuesday" : r"(?P<which>Second) day",
                r"Wednesday" : r"(?P<which>Third) day",
        }
        gd = dict()
        m = functions_.matchdict(patterns, "Second day of the week", groupdict = gd)
        self.assertIsInstance(m, functions_._PDMatch)
        self.assertEqual(m.key, 'Tuesday')
        self.assertEqual(m.match.span(), (0,10))
        self.assertEqual(gd, { 'which' : 'Second' })
        #
        m = functions_.matchdict(patterns, "Third day of the week", groupdict = gd)
        self.assertIsInstance(m, functions_._PDMatch)
        self.assertEqual(m.key, 'Wednesday')
        self.assertEqual(m.match.span(), (0,9))
        self.assertEqual(gd, { 'which' : 'Third' })

class Test__searchpd(unittest.TestCase):
    def test__dictsearch_01(self):
        patterns = {
                r"Monday" : r"(?P<which>First) day",
                r"Tuesday" : r"(?P<which>Second) day",
                r"Wednesday" : r"(?P<which>Third) day",
        }
        gd = dict()
        m = functions_.searchpd(patterns, "  Second day of the week", groupdict = gd)
        self.assertIsInstance(m, functions_._PDMatch)
        self.assertEqual(m.key, 'Tuesday')
        self.assertEqual(m.match.span(), (2,12))
        self.assertEqual(gd, { 'which' : 'Second' })
        #
        m = functions_.searchpd(patterns, "  Third day of the week", groupdict = gd)
        self.assertIsInstance(m, functions_._PDMatch)
        self.assertEqual(m.key, 'Wednesday')
        self.assertEqual(m.match.span(), (2,11))
        self.assertEqual(gd, { 'which' : 'Third' })

class Test__reentrant(unittest.TestCase):
    def test__reentrant_1(self):
        def parse_false(iterator):
            next(iterator)
            return False

        def parse_true(iterator):
            next(iterator)
            return True

        bi = bufferediterator_.BufferedIterator(ThreeStrings())
        next(bi)
        self.assertEqual(bi._index, 1)
        self.assertFalse(functions_.reentrant(parse_false, bi))
        self.assertEqual(bi._index, 1)

        self.assertTrue(functions_.reentrant(parse_true, bi))
        self.assertEqual(bi._index, 2)


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
