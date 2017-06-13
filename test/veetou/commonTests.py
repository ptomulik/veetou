#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.common as common

class Test__Model(unittest.TestCase):

    def test__functions__symbols__1(self):
        self.assertIs(common.functions_.checkinstance, common.checkinstance)
        self.assertIs(common.functions_.checksubclass, common.checksubclass)
        self.assertIs(common.functions_.safedelattr, common.safedelattr)
        self.assertIs(common.functions_.setdelattr, common.setdelattr)
        self.assertIs(common.functions_.snakecase, common.snakecase)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
