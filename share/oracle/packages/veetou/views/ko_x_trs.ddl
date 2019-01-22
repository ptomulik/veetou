CREATE OR REPLACE VIEW v2u_ko_x_trs
AS SELECT
      v.tr.job_uuid tr_job_uuid
    , v.tr.id tr_id
    , v.tr.subj_code tr_subj_code
    , v.tr.subj_name tr_subj_name
    , v.tr.subj_hours_w tr_subj_hours_w
    , v.tr.subj_hours_c tr_subj_hours_c
    , v.tr.subj_hours_l tr_subj_hours_l
    , v.tr.subj_hours_p tr_subj_hours_p
    , v.tr.subj_hours_s tr_subj_hours_s
    , v.tr.subj_credit_kind tr_subj_credit_kind
    , v.tr.subj_ects tr_subj_ects
    , v.tr.subj_tutor tr_subj_tutor
    , v.tr.subj_grade tr_subj_grade
    , v.tr.subj_grade_date tr_subj_grade_date
    , v.page.id page_id
    , v.page.page_number page_page_number
    , v.page.parser_page_number page_parser_page_number
    , v.header.id header_id
    , v.header.university header_university
    , v.header.faculty header_faculty
    , v.preamble.id preamble_id
    , v.preamble.studies_modetier preamble_studies_modetier
    , v.preamble.title preamble_title
    , v.preamble.student_index preamble_student_index
    , v.preamble.first_name preamble_first_name
    , v.preamble.last_name preamble_last_name
    , v.preamble.student_name preamble_student_name
    , v.preamble.semester_code preamble_semester_code
    , v.preamble.studies_field preamble_studies_field
    , v.preamble.semester_number preamble_semester_number
    , v.preamble.studies_specialty preamble_studies_specialty
    , v.tbody.id tbody_id
    , v.tbody.remark tbody_remark
    , v.footer.id footer_id
    , v.footer.pagination footer_pagination
    , v.footer.sheet_page_number footer_sheet_page_number
    , v.footer.sheet_pages_total footer_sheet_pages_total
    , v.footer.generator_name footer_generator_name
    , v.footer.generator_home footer_generator_home
    , v.sheet.id sheet_id
    , v.sheet.pages_parsed sheet_pages_parsed
    , v.sheet.first_page sheet_first_page
    , v.sheet.ects_mandatory sheet_ects_mandatory
    , v.sheet.ects_other sheet_ects_other
    , v.sheet.ects_total sheet_ects_total
    , v.sheet.ects_attained sheet_ects_attained
    , v.report.id report_id
    , v.report.source report_source
    , v.report.datetime report_datetime
    , v.report.first_page report_first_page
    , v.report.sheets_parsed report_sheets_parsed
    , v.report.pages_parsed report_pages_parsed
FROM v2u_ko_x_trs_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
