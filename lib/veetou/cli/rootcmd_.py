# -*- coding: utf8 -*-
"""`veetou.cli.rootcmd_`
"""
from . import cmd_

import abc
import sys
import argparse

__all__ = ('RootCmd',)

class RootCmd(cmd_.Cmd):

    __slots__ = ('_argparser', '_arguments')

    def __init__(self):
        self._argparser = argparse.ArgumentParser(description = self.description)
        super().__init__()

    def add_arguments(self):
        pass

    @property
    @abc.abstractmethod
    def description(self):
        pass

    @property
    def argparser(self):
        return self._argparser

    @property
    def arguments(self):
        return self._arguments

    @property
    def parent(self):
        raise AttributeError()

    def run(self):
        self._arguments = self._argparser.parse_args(sys.argv[2:])
        return 0


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
