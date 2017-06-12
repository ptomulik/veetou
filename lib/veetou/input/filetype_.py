# -*- coding: utf8 -*-
"""`veetou.input.filetype_`

Provides the FileType class
"""

import enum
import re

__all__ = ('FileType', )

class FileType(enum.Enum):
    """Enumerates supported file types"""

    UNKNOWN = -1
    PDF = 0
    TXT = 1
    CSV = 2
    HTML = 3

    @classmethod
    def from_filemime(cls, string):
        """Returns FileType appropriate for given file mime type."""
        m = re.match(_re_mime, string)
        if m:
            return _mime_type_map.get(m.group('mime_type'), cls.UNKNOWN)
        else:
            return cls.UNKNOWN

    @classmethod
    def from_filetype(cls, string):
        """Returns FileType appropriate for given file."""
        if re.match(r'PDF document', string):
            return cls.PDF
        elif re.match(r'(ASCII|UTF-8(?: Unicode)?) text', string):
            return cls.TXT
        elif re.match(r'HTML document', string):
            return cls.HTML
        else:
            return cls.UNKNOWN

_re_mime = re.compile(
    r'^(?=[-a-z]{1,127}/[-\.a-z0-9]{1,127}(?:\s*;\s*.+)*$)' + \
    r'(?P<mime_type>[a-z]+(?:-[a-z]+)*/[a-z0-9]+(?:[-\.][a-z0-9]+)*)(?:\s*;\s*.+)*$'
)
_mime_type_map = {
    'application/pdf'   : FileType.PDF,
    'text/plain'        : FileType.TXT,
    'text/csv'          : FileType.CSV,
    'text/html'         : FileType.HTML
}


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
