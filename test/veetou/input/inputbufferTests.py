#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.input.inputbuffer_ as inputbuffer_
import veetou.input.inputline_ as inputline_
import veetou.model.list_ as list_

class Test__InputBuffer(unittest.TestCase):
    def test__subclass_1(self):
        self.assertTrue(issubclass(inputbuffer_.InputBuffer, list_.List))

    def test__wrap_1(self):
        line = inputline_.InputLine('line of text')
        self.assertIs(inputbuffer_.InputBuffer().__wrap__(line), line)

    def test__wrap_2(self):
        msg = r"%s is not an instance of %s" % (repr('foo'),repr(inputline_.InputLine))
        with self.assertRaisesRegex(TypeError, msg):
            self.assertIs(inputbuffer_.InputBuffer().__wrap__('foo'), line)


if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
