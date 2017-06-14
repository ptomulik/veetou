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

KoReport = declare( DataType, 'KoReport',

        ('source', 'datetime', 'first_page', 'sheets_parsed', 'pages_parsed'),
        5 * (strn,),
        plural = 'KoReports'

)

KoSheet = declare( DataType, 'KoSheet',

        ('pages_parsed', 'first_page', 'ects_mandatory', 'ects_other',
         'ects_total', 'ects_attained'),
        6 * (strn,),
        plural = 'KoSheets'

)

KoPage = declare( DataType, 'KoPage',

        ( 'page_number', 'parser_page_number', ),
        2 * (strn,),
        plural = 'KoPages'

)

KoPreamble = declare( DataType, 'KoPreamble',

        ( 'studies_modetier', 'title', 'student_index', 'first_name', 'last_name',
          'student_name', 'semester_code', 'studies_field', 'semester_number',
          'studies_specialty' ),
        10 * (sqws,),
        plural = 'KoPreambles'

)

KoHeader = declare( DataType, 'KoHeader',

        ( 'university', 'faculty' ),
        2 * (strn,),
        plural = 'KoHeaders'

)

KoFooter = declare( DataType, 'KoFooter',

        ( 'pagination', 'sheet_page_number', 'sheet_pages_total',
          'generator_name', 'generator_home'),
        5 * (strn,),
        plural = 'KoFooters'

)


KoTbody = declare( DataType, 'KoTbody',

        ('remark', ),
        1 * (strn,),
        plural = 'KoTbodies'
)

KoTr = declare( DataType, 'KoTr',

        (   'subj_code', 'subj_name', 'subj_hours_w', 'subj_hours_c',
            'subj_hours_l', 'subj_hours_p', 'subj_hours_s', 'subj_credit_kind',
            'subj_ects', 'subj_tutor', 'subj_grade', 'subj_grade_date'  ),
        12 * (strn,),
        plural = 'KoTrs'

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
        strings =   ( ( 'ko_report_sheets',     ('ko_reports', 'ko_sheets'),      ('ko_sheets', 'ko_report') ),
                      ( 'ko_sheet_pages',       ('ko_sheets', 'ko_pages'),        ('ko_pages', 'ko_sheet') ),
                      ( 'ko_page_preamble',     ('ko_pages', 'ko_preambles'),     ('ko_preamble', 'ko_page') ),
                      ( 'ko_page_header',       ('ko_pages', 'ko_headers'),       ('ko_header', 'ko_page') ),
                      ( 'ko_page_footer',       ('ko_pages', 'ko_footers'),       ('ko_footer', 'ko_page') ),
                      ( 'ko_page_tbody',        ('ko_pages', 'ko_tbodies'),       ('ko_tbody', 'ko_page') ),
                      ( 'ko_tbody_trs',         ('ko_tbodies', 'ko_trs'),         ('ko_trs', 'ko_tbody') )  )
        relations = map( lambda x : (x[0],Junction(map(self.tables.__getitem__,x[1]),x[2])), strings )
        self.relations.update(relations)

    def __init__(self):
        super().__init__()
        self._mk_initial_tables()
        self._mk_initial_relations()

    @property
    def prefix(self):
        return 'ko_'


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
