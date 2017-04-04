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

PzReport = declare( DataType, 'Report',

        ('source', 'datetime', 'first_page', 'sheets_parsed', 'pages_parsed'),
#        5 * (strn,),
        plural = 'Reports'

)

PzSheet = declare( DataType, 'Sheet',

        ('pages_parsed', 'first_page'),
##        2 * (strn,),
        plural = 'Sheets'

)

PzPage = declare( DataType, 'Page',

        ( 'page_number', 'parser_page_number', ),
##        2 * (strn,),
        plural = 'Pages'

)

PzPreamble = declare( DataType, 'Preamble',

        ( 'town', 'date', 'time', 'title', 'exam', 'sheet_id', 'semester_code',
          'sheet_serie', 'sheet_number', 'return_desc', 'return_date',
          'subj_name','subj_code', 'subj_department', 'subj_tutor',
          'subj_grades', 'subj_cond'  ),
##        17 * (strn,),
        plural = 'Preambles'

)

PzHeader = declare( DataType, 'Header',

        ( 'university', 'faculty', 'entity' ),
##        3 * (strn,),
        plural = 'Headers'

)

PzFooter = declare( DataType, 'Footer',

        ( 'pagination', 'sheet_page_number', 'sheet_pages_total',  'title',
          'subj_name', 'subj_code', 'sheet_id', 'semester_code', 'sheet_serie',
          'sheet_number', 'generator_name', 'generator_home', 'sig_prompt'),
##        13 * (strn,),
        plural = 'Footers'

)

PzAddress = declare( DataType, 'Address',

        ( 'street_prefix',   'street_name', 'street_number', 'postoffice_zip',
          'postoffice_town', 'edifice',     'room',          'website' ),
##        8 * (strn,),
        plural = 'Addresses'

)

PzContact = declare( DataType, 'Contact',

        ( 'phone_prefix', 'phone_numbers', 'faxtel_prefix', 'faxtel_numbers',
          'email_prefix', 'email_address' ),
##        6 * (strn,),
        plural = 'Contacts'

)

PzTr = declare( DataType, 'Tr',

        (  'tr_ord_no', 'student_name', 'student_index', 'subj_grade',
           'subj_grade_final', 'subj_grade_project', 'subj_grade_lecture',
           'subj_grade_class', 'subj_grade_p', 'subj_grade_n',
           'tr_remarks' ),
##        11 * (strn,),
        plural = 'Trs'

)

PzSummary = declare( DataType, 'Summary',

        ( 'caption', 'th', 'content' ),
##        3 * (strn,),
        plural = 'Summaries'

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
        strings =   ( ( 'report_sheets',     ('reports', 'sheets'),      ('sheets', 'report') ),
                      ( 'sheet_pages',       ('sheets', 'pages'),        ('pages', 'sheet') ),
                      ( 'sheet_preamble',    ('sheets', 'preambles'),    ('preamble', 'sheet') ),
                      ( 'page_header',       ('pages', 'headers'),       ('header', 'page') ),
                      ( 'page_footer',       ('pages', 'footers'),       ('footer', 'page') ),
                      ( 'header_address',    ('headers', 'addresses'),   ('address', 'header') ),
                      ( 'header_contact',    ('headers', 'contacts'),    ('contact', 'header') ),
                      ( 'page_trs',          ('pages', 'trs'),           ('trs', 'page') ),
                      ( 'sheet_summary',     ('sheets', 'summaries'),    ('summary', 'sheet') ) )
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
