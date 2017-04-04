# -*- coding: utf8 -*-
"""`veetou.model.fieldmapper_`

Provides the FieldMapper class
"""

from . import table_
from . import record_
from . import functions_


__all__ = ('FieldMapper',)

class FieldMapper(object):

    __slots__ = ('_fieldaliases',)

    def __init__(self, fieldaliases = ()):
        self._fieldaliases = fieldaliases

    @property
    def fieldaliases(self):
        return self._fieldaliases

    def __call__(self, seq):
        if isinstance(seq, (table_.Table, table_.TableList)):
            iterator = functions_.columniter(seq)
        elif isinstance(seq, (record_.Record, record_.RecordSequence)):
            iterator = functions_.fielditer(seq)
        else:
            iterator = seq
        dct = { functions_.schemaname(x) : x for x in iterator }
        return tuple( (alias, dct[key]) for key, alias in self._fieldaliases )

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
