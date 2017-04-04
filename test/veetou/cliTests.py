#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.cli as cli

class Test__Cli(unittest.TestCase):

    def test__main__symbols__1(self):
        self.assertIs(cli.main_.Main, cli.Main)

    def test__pzcmd__symbols__1(self):
        self.assertIs(cli.pzcmd_.PzCmd, cli.PzCmd)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
