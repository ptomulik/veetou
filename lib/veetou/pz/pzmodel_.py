# -*- coding: utf8 -*-
"""`veetou.pz.pzmodel_`

Defines data model for pz (Protokół Zaliczeń)
"""

from veetou.model import *

__all__ = ( 'PzReport',
            'PzSheet',
            'PzPage',
            'PzPreamble',
            'PzHeader',
            'PzFooter',
            'PzAddress',
            'PzContact',
            'PzTr',
            'PzSummary',
            'PzDataModel' )

##def strn(s=None):
##    if s is None:
##        return None
##    else:
##        return str(s)

PzReport = declare( DataType, 'PzReport',

        ('source', 'datetime', 'first_page', 'sheets_parsed', 'pages_parsed'),
#        5 * (strn,),
        plural = 'PzReports'

)

PzSheet = declare( DataType, 'PzSheet',

        ('pages_parsed', 'first_page'),
##        2 * (strn,),
        plural = 'PzSheets'

)

PzPage = declare( DataType, 'PzPage',

        ( 'page_number', 'parser_page_number', ),
##        2 * (strn,),
        plural = 'PzPages'

)

PzPreamble = declare( DataType, 'PzPreamble',

        ( 'town', 'date', 'time', 'title', 'exam', 'sheet_id', 'semester_code',
          'sheet_serie', 'sheet_number', 'return_desc', 'return_date',
          'subj_name','subj_code', 'subj_department', 'subj_tutor',
          'subj_grades', 'subj_cond'  ),
##        17 * (strn,),
        plural = 'PzPreambles'

)

PzHeader = declare( DataType, 'PzHeader',

        ( 'university', 'faculty', 'entity' ),
##        3 * (strn,),
        plural = 'PzHeaders'

)

PzFooter = declare( DataType, 'PzFooter',

        ( 'pagination', 'sheet_page_number', 'sheet_pages_total',  'title',
          'subj_name', 'subj_code', 'sheet_id', 'semester_code', 'sheet_serie',
          'sheet_number', 'generator_name', 'generator_home', 'sig_prompt'),
##        13 * (strn,),
        plural = 'PzFooters'

)

PzAddress = declare( DataType, 'PzAddress',

        ( 'street_prefix',   'street_name', 'street_number', 'postoffice_zip',
          'postoffice_town', 'edifice',     'room',          'website' ),
##        8 * (strn,),
        plural = 'PzAddresses'

)

PzContact = declare( DataType, 'PzContact',

        ( 'phone_prefix', 'phone_numbers', 'faxtel_prefix', 'faxtel_numbers',
          'email_prefix', 'email_address' ),
##        6 * (strn,),
        plural = 'PzContacts'

)

PzTr = declare( DataType, 'PzTr',

        (  'tr_ord_no', 'student_name', 'student_index', 'subj_grade',
           'subj_grade_final', 'subj_grade_project', 'subj_grade_lecture',
           'subj_grade_class', 'subj_grade_p', 'subj_grade_n',
           'tr_remarks' ),
##        11 * (strn,),
        plural = 'PzTrs'

)

PzSummary = declare( DataType, 'PzSummary',

        ( 'caption', 'th', 'content' ),
##        3 * (strn,),
        plural = 'PzSummaries'

)


class PzDataModel(DataModel):

    _datatypes =  ( PzReport,
                    PzSheet,
                    PzPage,
                    PzPreamble,
                    PzHeader,
                    PzFooter,
                    PzAddress,
                    PzContact,
                    PzTr,
                    PzSummary )

    def _mk_initial_tables(self):
        tables = map( lambda t: (tablename(t), t), map(lambda dt : tableclass(dt)(), self._datatypes))
        self.tables.update(tables)

    def _mk_initial_relations(self):
        strings =   ( ( 'pz_report_sheets',     ('pz_reports', 'pz_sheets'),      ('pz_sheets', 'pz_report') ),
                      ( 'pz_sheet_pages',       ('pz_sheets', 'pz_pages'),        ('pz_pages', 'pz_sheet') ),
                      ( 'pz_sheet_preamble',    ('pz_sheets', 'pz_preambles'),    ('pz_preamble', 'pz_sheet') ),
                      ( 'pz_page_header',       ('pz_pages', 'pz_headers'),       ('pz_header', 'pz_page') ),
                      ( 'pz_page_footer',       ('pz_pages', 'pz_footers'),       ('pz_footer', 'pz_page') ),
                      ( 'pz_header_address',    ('pz_headers', 'pz_addresses'),   ('pz_address', 'pz_header') ),
                      ( 'pz_header_contact',    ('pz_headers', 'pz_contacts'),    ('pz_contact', 'pz_header') ),
                      ( 'pz_page_trs',          ('pz_pages', 'pz_trs'),           ('pz_trs', 'pz_page') ),
                      ( 'pz_sheet_summary',     ('pz_sheets', 'pz_summaries'),    ('pz_summary', 'pz_sheet') ) )
        relations = map( lambda x : (x[0],Junction(map(self.tables.__getitem__,x[1]),x[2])), strings )
        self.relations.update(relations)

    def __init__(self):
        super().__init__()
        self._mk_initial_tables()
        self._mk_initial_relations()

    @property
    def prefix(self):
        return 'pz_'


# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
