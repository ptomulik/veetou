#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.input.paginatedloc_ as paginatedloc_
import veetou.input.inputloc_ as inputloc_

class Test__PaginatedLoc(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(paginatedloc_.PaginatedLoc, inputloc_.InputLoc))

    # TODO: write tests

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
