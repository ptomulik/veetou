#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.input as input

class Test__Input(unittest.TestCase):
    def test__bufferediterator__symbols__1(self):
        self.assertIs(input.bufferediterator_.BufferedIterator, input.BufferedIterator)
        self.assertIs(input.bufferediterator_.BufferedIteratorState, input.BufferedIteratorState)
    def test__filetype__symbols__1(self):
        self.assertIs(input.filetype_.FileType, input.FileType)
    def test__inputbuffer__symbols__1(self):
        self.assertIs(input.inputbuffer_.InputBuffer, input.InputBuffer)
    def test__inputloc__symbols__1(self):
        self.assertIs(input.inputloc_.InputLoc, input.InputLoc)
    def test__inputiterator__symbols__1(self):
        self.assertIs(input.inputiterator_.InputIterator, input.InputIterator)
    def test__inputline__symbols__1(self):
        self.assertIs(input.inputline_.InputLine, input.InputLine)
    def test__inputlines__symbols__1(self):
        self.assertIs(input.inputlines_.InputLines, input.InputLines)
    def test__paginatedloc__symbols__1(self):
        self.assertIs(input.paginatedloc_.PaginatedLoc, input.PaginatedLoc)
    def test__pdftextlines__symbols__1(self):
        self.assertIs(input.pdftextlines_.PdfTextLines, input.PdfTextLines)
    def test__popenlines__symbols__1(self):
        self.assertIs(input.popenlines_.PopenLines, input.PopenLines)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
