# -*- coding: utf8 -*-
"""`veetou.ko.kotableparser_`

Provides the KoTableParser class
"""

from . import kothparser_
from . import kotbodyparser_

from ..parser import TableParser
from ..parser import skipemptylines

__all__ = ( 'KoTableParser', )

class KoTableParser(TableParser):

    __slots__ = ()

    def __init__(self, **kw):
        super().__init__(**kw)

    def create_th_parser(self, **kw):
        return kothparser_.KoThParser(**kw)

    def create_tbody_parser(self, **kw):
        return kotbodyparser_.KoTbodyParser(**kw)

    def parse_tbody(self, iterator, kw):
        skipemptylines(iterator, 1)
        return super().parse_tbody(iterator, kw)

    def parse(self, iterator, **kw):
        return super().parse(iterator, **kw)


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
