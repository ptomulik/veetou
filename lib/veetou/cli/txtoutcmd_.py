# -*- coding: utf8 -*-
"""`veetou.cli.txtoutcmd_`
"""

from . import cmd_
import sys

class TxtOutCmd(cmd_.Cmd):

    __slots__ = ('_input',)

    def __init__(self, parent, input):
        super().__init__(parent)
        self._input = input

    @property
    def input(self):
        return self._input

    @property
    def outfile(self):
        if not self.arguments.output or self.arguments.output == '-':
            return sys.stdout
        else:
            return open(self._arguments.output, 'w')

    def run(self):
        # FIXME: arguments.inpus, arguments.pdftotext - where are they defined?
        with self.outfile as outfile:
            if not self.arguments.inputs:
                # Hard-coded: input is taken as a text
                outfile.write(sys.stdin.read())
            else:
                try:
                    for filename in self.arguments.inputs:
                        with self.input.open(filename) as infile:
                            for line in infile:
                                outfile.write("%s\n" % line)
                except NotImplementedError as err:
                    sys.stderr.write("error: %s\n" % err)
                    return 1
        return 0


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
