#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.input.filetype_ as filetype_
import enum

class Test__FileType(unittest.TestCase):
    def test__subclass_1(self):
        self.assertTrue(issubclass(filetype_.FileType, enum.Enum))

    def test__constants(self):
        self.assertEqual(filetype_.FileType.UNKNOWN.value, -1)
        self.assertEqual(filetype_.FileType.PDF.value, 0)
        self.assertEqual(filetype_.FileType.TXT.value, 1)
        self.assertEqual(filetype_.FileType.CSV.value, 2)

    def test__from_filemime__pdf_1(self):
        self.assertIs(filetype_.FileType.from_filemime('application/pdf'), filetype_.FileType.PDF)
        self.assertIs(filetype_.FileType.from_filemime('application/pdf; charset=binary'), filetype_.FileType.PDF)

    def test__from_filemime__txt_1(self):
        self.assertIs(filetype_.FileType.from_filemime('text/plain'), filetype_.FileType.TXT)
        self.assertIs(filetype_.FileType.from_filemime('text/plain; charset=utf-8'), filetype_.FileType.TXT)

    def test__from_filemime__csv_1(self):
        self.assertIs(filetype_.FileType.from_filemime('text/csv'), filetype_.FileType.CSV)
        self.assertIs(filetype_.FileType.from_filemime('text/csv; charset=utf-8'), filetype_.FileType.CSV)

    def test__from_filemime__unknown_1(self):
        self.assertIs(filetype_.FileType.from_filemime('foo/bar'), filetype_.FileType.UNKNOWN)
        self.assertIs(filetype_.FileType.from_filemime('foo/bar; charset=utf-8'), filetype_.FileType.UNKNOWN)
        self.assertIs(filetype_.FileType.from_filemime('karramba'), filetype_.FileType.UNKNOWN)

    def test__from_filetype__pdf_1(self):
        self.assertIs(filetype_.FileType.from_filetype('PDF document'), filetype_.FileType.PDF)
        self.assertIs(filetype_.FileType.from_filetype('PDF document, version 1.4'), filetype_.FileType.PDF)

    def test__from_filetype__txt_1(self):
        self.assertIs(filetype_.FileType.from_filetype('ASCII text'), filetype_.FileType.TXT)
        self.assertIs(filetype_.FileType.from_filetype('UTF-8 text'), filetype_.FileType.TXT)
        self.assertIs(filetype_.FileType.from_filetype('UTF-8 Unicode text'), filetype_.FileType.TXT)


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
