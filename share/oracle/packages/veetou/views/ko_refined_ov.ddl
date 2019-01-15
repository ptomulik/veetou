CREATE VIEW veetou_ko_refined_ov AS
    SELECT
      v.job_uuid job_uuid
    , v.tr_id tr_id
    , Veetou_Ko_Refined_Typ
        ( subj_code => v.subj_code
        , subj_name => v.subj_name
        , student_index => v.student_index
        , first_name => v.first_name
        , last_name => v.last_name
        , student_name => v.student_name
        , subj_grade => v.subj_grade
        , subj_grade_date => v.subj_grade_date
        , university => v.university
        , faculty => v.faculty
        , studies_modetier => v.studies_modetier
        , studies_field => v.studies_field
        , studies_specialty => v.studies_specialty
        , semester_code => v.semester_code
        , semester_number => v.semester_number
        , subj_tutor => v.subj_tutor
        , subj_hours_w => v.subj_hours_w
        , subj_hours_c => v.subj_hours_c
        , subj_hours_l => v.subj_hours_l
        , subj_hours_p => v.subj_hours_p
        , subj_hours_s => v.subj_hours_s
        , subj_credit_kind => v.subj_credit_kind
        , subj_ects => v.subj_ects
        , ects_mandatory => v.ects_mandatory
        , ects_other => v.ects_other
        , ects_total => v.ects_total
        , ects_attained => v.ects_attained
        , preamble_title => v.preamble_title
        , report_source => v.report_source
        , report_open_datetime => v.report_open_datetime
        , report_sheets_parsed => v.report_sheets_parsed
        , report_pages_parsed => v.report_pages_parsed
        , page_number => v.page_number
        , sheet_first_page => v.sheet_first_page
        , sheet_pages_parsed => v.sheet_pages_parsed
        ) refined
FROM veetou_ko_refined v;

-- vim: set ft=sql ts=4 sw=4 et:
