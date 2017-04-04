#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.object_ as object_

class Test__Object(unittest.TestCase):

    def test__modelname_and_schemaname_1(self):
        self.assertEqual(object_.Object.__modelname__(),    'Object')
        self.assertEqual(object_.Object().__modelname__(),  'Object')
        self.assertEqual(object_.Object.__schemaname__(),   'object')
        self.assertEqual(object_.Object().__schemaname__(), 'object')

    def test__modelname_and_schemaname_3(self):
        class FooBarGeez(object_.Object): pass
        self.assertEqual(FooBarGeez.__modelname__(),    'FooBarGeez')
        self.assertEqual(FooBarGeez().__modelname__(),  'FooBarGeez')
        self.assertEqual(FooBarGeez.__schemaname__(),   'foo_bar_geez')
        self.assertEqual(FooBarGeez().__schemaname__(), 'foo_bar_geez')

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
