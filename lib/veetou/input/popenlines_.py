# -*- coding: utf8 -*-
"""`veetou.input.popenlines_`

Provides the PopenLines class
"""

from . import inputlines_
from ..common import checkinstance

import subprocess
import shlex

__all__ = ('PopenLines', )

class PopenLines(inputlines_.InputLines):
    """Iterates over lines of a text stream yielding instances of InputLine"""

    __slots__ = ('_process', '_name', '_charset')

    def __init__(self, process, name=None, charset=None):
        self._process = checkinstance(process, subprocess.Popen)
        if name is None:
            name = ' '.join(map(shlex.quote, process.args))
        self._name = name
        self._charset = charset
        super().__init__(self.process.stdout)

    def __enter__(self):
        self.process.__enter__()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        return self.process.__exit__(exc_type, exc_val, exc_tb)

    def __wrap__(self, string):
        if not self.process.universal_newlines and self._charset:
            string = string.decode(self._charset)
        return super().__wrap__(string)

    @property
    def process(self):
        return self._process

    @property
    def name(self):
        return self._name

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
