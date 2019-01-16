CREATE OR REPLACE VIEW veetou_ko_full_ov
AS SELECT Veetou_Ko_Full_Typ
    ( job_uuid => v.job_uuid
    , tr_id => v.tr_id
    , tr_subj_code => v.tr_subj_code
    , tr_subj_name => v.tr_subj_name
    , tr_subj_hours_w => v.tr_subj_hours_w
    , tr_subj_hours_c => v.tr_subj_hours_c
    , tr_subj_hours_l => v.tr_subj_hours_l
    , tr_subj_hours_p => v.tr_subj_hours_p
    , tr_subj_hours_s => v.tr_subj_hours_s
    , tr_subj_credit_kind => v.tr_subj_credit_kind
    , tr_subj_ects => v.tr_subj_ects
    , tr_subj_tutor => v.tr_subj_tutor
    , tr_subj_grade => v.tr_subj_grade
    , tr_subj_grade_date => v.tr_subj_grade_date
    , tbody_id => v.tbody_id
    , tbody_remark => v.tbody_remark
    , page_id => v.page_id
    , page_page_number => v.page_page_number
    , page_parser_page_number => v.page_parser_page_number
    , sheet_id => v.sheet_id
    , sheet_pages_parsed => v.sheet_pages_parsed
    , sheet_first_page => v.sheet_first_page
    , sheet_ects_mandatory => v.sheet_ects_mandatory
    , sheet_ects_other => v.sheet_ects_other
    , sheet_ects_total => v.sheet_ects_total
    , sheet_ects_attained => v.sheet_ects_attained
    , report_id => v.report_id
    , report_source => v.report_source
    , report_datetime => v.report_datetime
    , report_first_page => v.report_first_page
    , report_sheets_parsed => v.report_sheets_parsed
    , report_pages_parsed => v.report_pages_parsed
    , preamble_id => v.preamble_id
    , preamble_studies_modetier => v.preamble_studies_modetier
    , preamble_title => v.preamble_title
    , preamble_student_index => v.preamble_student_index
    , preamble_first_name => v.preamble_first_name
    , preamble_last_name => v.preamble_last_name
    , preamble_student_name => v.preamble_student_name
    , preamble_semester_code => v.preamble_semester_code
    , preamble_studies_field => v.preamble_studies_field
    , preamble_semester_number => v.preamble_semester_number
    , preamble_studies_specialty => v.preamble_studies_specialty
    , header_id => v.header_id
    , header_university => v.header_university
    , header_faculty => v.header_faculty
    , footer_id => v.footer_id
    , footer_pagination => v.footer_pagination
    , footer_sheet_page_number => v.footer_sheet_page_number
    , footer_sheet_pages_total => v.footer_sheet_pages_total
    , footer_generator_name => v.footer_generator_name
    , footer_generator_home => v.footer_generator_home
    ) full
FROM veetou_ko_full v;

-- vim: set ft=sql ts=4 sw=4 et:
