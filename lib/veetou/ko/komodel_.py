# -*- coding: utf8 -*-
"""`veetou.ko.komodel_`

Defines data model for ko (Karta Osiągnięć)
"""

from veetou.model import *

__all__ = ( 'KoReport',
            'KoSheet',
            'KoPage',
            'KoPreamble',
            'KoHeader',
            'KoFooter',
            'KoTbody',
            'KoTr',
            'KoDataModel' )

def strn(s=None):
    if s is None:
        return None
    else:
        return str(s)

# squash mutiple spaces into a single one
def sqws(s=None):
    if s is None:
        return None
    else:
        return ' '.join(s.split())

KoReport = declare( DataType, 'Report',

        ('source', 'datetime', 'first_page', 'sheets_parsed', 'pages_parsed'),
        5 * (strn,),
        plural = 'Reports'

)

KoSheet = declare( DataType, 'Sheet',

        ('pages_parsed', 'first_page', 'ects_mandatory', 'ects_other',
         'ects_total', 'ects_attained'),
        6 * (strn,),
        plural = 'Sheets'

)

KoPage = declare( DataType, 'Page',

        ( 'page_number', 'parser_page_number', ),
        2 * (strn,),
        plural = 'Pages'

)

KoPreamble = declare( DataType, 'Preamble',

        ( 'studies_modetier', 'title', 'student_index', 'first_name', 'last_name',
          'student_name', 'semester_code', 'studies_field', 'semester_number',
          'studies_specialty' ),
        10 * (sqws,),
        plural = 'Preambles'

)

KoHeader = declare( DataType, 'Header',

        ( 'university', 'faculty' ),
        2 * (strn,),
        plural = 'Headers'

)

KoFooter = declare( DataType, 'Footer',

        ( 'pagination', 'sheet_page_number', 'sheet_pages_total',
          'generator_name', 'generator_home'),
        5 * (strn,),
        plural = 'Footers'

)


KoTbody = declare( DataType, 'Tbody',

        ('remark', ),
        1 * (strn,),
        plural = 'Tbodies'
)

KoTr = declare( DataType, 'Tr',

        (   'subj_code', 'subj_name', 'subj_hours_w', 'subj_hours_c',
            'subj_hours_l', 'subj_hours_p', 'subj_hours_s', 'subj_credit_kind',
            'subj_ects', 'subj_tutor', 'subj_grade', 'subj_grade_date'  ),
        12 * (strn,),
        plural = 'Trs'

)

class KoDataModel(DataModel):

    _datatypes =  ( KoReport,
                    KoSheet,
                    KoPage,
                    KoPreamble,
                    KoHeader,
                    KoFooter,
                    KoTbody,
                    KoTr )

    def _mk_initial_tables(self):
        tables = map( lambda t: (tablename(t), t), map(lambda dt : tableclass(dt)(), self._datatypes))
        self.tables.update(tables)

    def _mk_initial_relations(self):
        strings =   ( ( 'report_sheets',     ('reports', 'sheets'),      ('sheets', 'report') ),
                      ( 'sheet_pages',       ('sheets', 'pages'),        ('pages', 'sheet') ),
                      ( 'page_preamble',     ('pages', 'preambles'),     ('preamble', 'page') ),
                      ( 'page_header',       ('pages', 'headers'),       ('header', 'page') ),
                      ( 'page_footer',       ('pages', 'footers'),       ('footer', 'page') ),
                      ( 'page_tbody',        ('pages', 'tbodies'),       ('tbody', 'page') ),
                      ( 'tbody_trs',         ('tbodies', 'trs'),         ('trs', 'tbody') )  )
        relations = map( lambda x : (x[0],Junction(map(self.tables.__getitem__,x[1]),x[2])), strings )
        self.relations.update(relations)

    def __init__(self):
        super().__init__()
        self._mk_initial_tables()
        self._mk_initial_relations()


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
