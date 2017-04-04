#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.input.paginatedcontext_ as paginatedcontext_
import veetou.input.inputcontext_ as inputcontext_

class Test__PaginatedContext(unittest.TestCase):
    def test__subclass__1(self):
        self.assertTrue(issubclass(paginatedcontext_.PaginatedContext, inputcontext_.InputContext))

    # TODO: write tests

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
