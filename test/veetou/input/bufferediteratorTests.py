#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.input.bufferediterator_ as bufferediterator_
import veetou.input.inputiterator_ as inputiterator_
import veetou.input.inputbuffer_ as inputbuffer_
import veetou.input.inputline_ as inputline_
import veetou.input.inputcontext_ as inputcontext_

class ThreeLines(inputiterator_.InputIterator):
    def __init__(self):
        self._lineno = 1
        self._iterator = iter(self.lines)

    @property
    def lines(self):
        return ['first line', 'second line', 'third line']

    def __enter__(self):
        return self

    def __exit__(self, *args):
        return False

    def __next__(self):
        line = inputline_.InputLine(next(self._iterator), self.context())
        self._lineno += 1
        return line

    def context(self):
        return inputcontext_.InputContext('three_lines', self._lineno)


class Test__BufferedIterator(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(bufferediterator_.BufferedIterator, inputiterator_.InputIterator))

    def test__init__1(self):
        bi = bufferediterator_.BufferedIterator(ThreeLines())
        self.assertIsInstance(bi._buffer, inputbuffer_.InputBuffer)
        self.assertEqual(bi._index, 0)

    def test__init__2(self):
        msg = '%s is not an instance of %s' % (repr('foo'), repr(inputiterator_.InputIterator))
        with self.assertRaisesRegex(TypeError, msg):
            bufferediterator_.BufferedIterator('foo')

    def test__next__1(self):
        bi = bufferediterator_.BufferedIterator(ThreeLines())
        self.assertEqual(bi._index, 0)
        self.assertEqual(len(bi._buffer), 0)

        ln = next(bi)
        self.assertIsInstance(ln, inputline_.InputLine)
        self.assertEqual(ln, 'first line')
        self.assertEqual(ln.context(), inputcontext_.InputContext('three_lines', 1))
        self.assertEqual(bi._index, 1)
        self.assertEqual(len(bi._buffer), 1)

        ln = next(bi)
        self.assertIsInstance(ln, inputline_.InputLine)
        self.assertEqual(ln, 'second line')
        self.assertEqual(ln.context(), inputcontext_.InputContext('three_lines', 2))
        self.assertEqual(bi._index, 2)
        self.assertEqual(len(bi._buffer), 2)

        ln = next(bi)
        self.assertIsInstance(ln, inputline_.InputLine)
        self.assertEqual(ln, 'third line')
        self.assertEqual(ln.context(), inputcontext_.InputContext('three_lines', 3))
        self.assertEqual(bi._index, 3)
        self.assertEqual(len(bi._buffer), 3)

        with self.assertRaises(StopIteration):
            next(bi)

        bi.rewind()
        self.assertEqual(bi._index, 0)
        self.assertEqual(len(bi._buffer), 3)

        ln = next(bi)
        self.assertIsInstance(ln, inputline_.InputLine)
        self.assertEqual(ln, 'first line')
        self.assertEqual(ln.context(), inputcontext_.InputContext('three_lines', 1))
        self.assertEqual(bi._index, 1)
        self.assertEqual(len(bi._buffer), 3)

        ln = next(bi)
        self.assertIsInstance(ln, inputline_.InputLine)
        self.assertEqual(ln, 'second line')
        self.assertEqual(ln.context(), inputcontext_.InputContext('three_lines', 2))
        self.assertEqual(bi._index, 2)
        self.assertEqual(len(bi._buffer), 3)

        ln = next(bi)
        self.assertIsInstance(ln, inputline_.InputLine)
        self.assertEqual(ln, 'third line')
        self.assertEqual(ln.context(), inputcontext_.InputContext('three_lines', 3))
        self.assertEqual(bi._index, 3)
        self.assertEqual(len(bi._buffer), 3)

        with self.assertRaises(StopIteration):
            next(bi)

        bi.rewind()
        self.assertEqual(bi._index, 0)
        self.assertEqual(len(bi._buffer), 3)

        ln = next(bi)
        self.assertIsInstance(ln, inputline_.InputLine)
        self.assertEqual(ln, 'first line')
        self.assertEqual(ln.context(), inputcontext_.InputContext('three_lines', 1))
        self.assertEqual(bi._index, 1)
        self.assertEqual(len(bi._buffer), 3)

        bi.drop()
        self.assertEqual(bi._index, 0)
        self.assertEqual(len(bi._buffer), 2)

        ln = next(bi)
        self.assertIsInstance(ln, inputline_.InputLine)
        self.assertEqual(ln, 'second line')
        self.assertEqual(ln.context(), inputcontext_.InputContext('three_lines', 2))
        self.assertEqual(bi._index, 1)
        self.assertEqual(len(bi._buffer), 2)

        ln = next(bi)
        self.assertIsInstance(ln, inputline_.InputLine)
        self.assertEqual(ln, 'third line')
        self.assertEqual(ln.context(), inputcontext_.InputContext('three_lines', 3))
        self.assertEqual(bi._index, 2)
        self.assertEqual(len(bi._buffer), 2)

        with self.assertRaises(StopIteration):
            next(bi)

    def test__with__1(self):
        input = ThreeLines()
        with bufferediterator_.BufferedIterator(input) as lines:
            i = 0
            for line in lines:
                self.assertEqual(line, input.lines[i])
                self.assertEqual(line.context().line, i+1)
                i += 1

    def test__context__1(self):
        it = ThreeLines()
        bi = bufferediterator_.BufferedIterator(it)
        self.assertEqual(it.context(), inputcontext_.InputContext('three_lines', 1))
        self.assertEqual(bi.context(), it.context())
        line = next(bi)
        self.assertEqual(line.context(), inputcontext_.InputContext('three_lines', 1))
        self.assertEqual(it.context(), inputcontext_.InputContext('three_lines', 2))
        self.assertEqual(bi.context(), it.context())
        line = next(bi)
        self.assertEqual(line.context(), inputcontext_.InputContext('three_lines', 2))
        self.assertEqual(it.context(), inputcontext_.InputContext('three_lines', 3))
        self.assertEqual(bi.context(), it.context())
        line = next(bi)
        self.assertEqual(line.context(), inputcontext_.InputContext('three_lines', 3))
        self.assertEqual(it.context(), inputcontext_.InputContext('three_lines', 4))
        self.assertEqual(bi.context(), it.context())
        # this is quite illegal...
        bi._index = 1
        self.assertEqual(bi.context(), inputcontext_.InputContext('three_lines', 2))
        self.assertEqual(it.context(), inputcontext_.InputContext('three_lines', 4))

    def test__rewind__1(self):
        bi = bufferediterator_.BufferedIterator(ThreeLines())
        next(bi)
        next(bi)
        next(bi)
        self.assertEqual(len(bi._buffer), 3)
        self.assertEqual(bi._index, 3)
        self.assertIs(bi.rewind(), bi)
        self.assertEqual(len(bi._buffer), 3)
        self.assertEqual(bi._index, 0)

    def test__clear__1(self):
        bi = bufferediterator_.BufferedIterator(ThreeLines())
        next(bi)
        next(bi)
        next(bi)
        self.assertEqual(len(bi._buffer), 3)
        self.assertEqual(bi._index, 3)
        bi.clear()
        self.assertEqual(len(bi._buffer), 0)
        self.assertEqual(bi._index, 0)

    def test__drop__1(self):
        bi = bufferediterator_.BufferedIterator(ThreeLines())
        next(bi)
        next(bi)
        next(bi)
        # this is quite illegal...
        bi._index = 1
        bi.drop()
        self.assertEqual(len(bi._buffer), 2)
        self.assertEqual(bi._index, 0)

    def test__state__1(self):
        bi = bufferediterator_.BufferedIterator(ThreeLines())

        state = bi.state()
        self.assertIsInstance(state, bufferediterator_.BufferedIteratorState)
        self.assertEqual(state._index, 0)

        next(bi)
        self.assertEqual(bi._index, 1)

        self.assertIs(bi.restore(state), bi)
        self.assertEqual(bi._index, 0)


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
