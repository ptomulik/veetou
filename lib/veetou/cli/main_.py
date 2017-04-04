# -*- coding: utf8 -*-
"""`veetou.cli.main_`

Provides the Main class
"""

from . import pzcmd_
from . import kocmd_

import argparse
import sys

__all__ = ('Main',)

class Main(object):

    __slots__ = ('_argparser', )

    def __init__(self):
        self._argparser = argparse.ArgumentParser(
                description = 'Data conversion utility',
                usage = '''veetou <command> [<args>]
Commands:
    ko          Convert 'Karta Osiągnięć' (PDF/TXT)
    pz          Convert 'Protokół Zaliczeń' (PDF/TXT)
    pzhtml      Convert 'Protokół Zaliczeń' (HTML)
''')

        self._argparser.add_argument('command', help='Subcommand to run')

    @property
    def argparser(self):
        return self._argparser

    def run(self):
        args = self.argparser.parse_args(sys.argv[1:2])
        if not hasattr(self, args.command) or args.command == 'run':
            sys.stderr.write('error: unrecognized command %r\n' % args.command)
            self.argparser.print_help()
            return 1
        return getattr(self, args.command)()

    def help(self):
        self.argparser.print_help()

    def ko(self):
        return kocmd_.KoCmd().run()

    def pz(self):
        return pzcmd_.PzCmd().run()

    def pzhtml(self):
        sys.stderr.write("error: command 'pzhtml' is not implemented yet\n")
        return 1

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
