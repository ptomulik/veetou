# -*- coding: utf8 -*-
"""`veetou.pzh.pzmodel_`

Defines data model for pzh (Protokół Zaliczeń - HTML)
"""

from veetou.model import *

__all__ = ( 'PzHReport',
            'PzHPreamble',
            'PzHTr',
            'PzHSummary',
            'PzHDataModel' )

##def strn(s=None):
##    if s is None:
##        return None
##    else:
##        return str(s)

PzHReport = declare( DataType, 'Report',

        ('source', 'datetime'),
#        5 * (strn,),
        plural = 'Reports'

)

PzHPreamble = declare( DataType, 'Preamble',

        (   'title', 'sheet_id', 'semester_code', 'sheet_serie',
            'sheet_number', 'sheet_type', 'sheet_state', 'subj_name',
            'subj_department', 'subj_code', 'subj_grade_type', 'subj_tutor',
            'return_date', 'approved_by', 'modified_datetime',
            'return_deadline'),
##        17 * (strn,),
        plural = 'Preambles'

)


PzHTr = declare( DataType, 'Tr',

        (  'tr_ord_no', 'student_name', 'student_index', 'subj_grade',
           'subj_grade_final', 'subj_grade_project', 'subj_grade_lecture',
           'subj_grade_class', 'subj_grade_p', 'subj_grade_n',
           'edited_by', 'edited_datetime' ),
##        11 * (strn,),
        plural = 'Trs'

)

PzHSummary = declare( DataType, 'Summary',

        ( 'caption', 'th', 'content' ),
##        3 * (strn,),
        plural = 'Summaries'

)


class PzHDataModel(DataModel):

    _datatypes =  ( PzHReport,
                    PzHPreamble,
                    PzHTr,
                    PzHSummary )

    def _mk_initial_tables(self):
        tables = map( lambda t: (tablename(t), t), map(lambda dt : tableclass(dt)(), self._datatypes))
        self.tables.update(tables)

    def _mk_initial_relations(self):
        strings =   ( ( 'report_preamble',  ('reports', 'preambles'),  ('preamble', 'report') ),
                      ( 'report_trs',       ('reports', 'trs'),        ('trs', 'report') ) )#,
                      #( 'report_summary',   ('reports', 'summaries'),  ('summary', 'report') ) )
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