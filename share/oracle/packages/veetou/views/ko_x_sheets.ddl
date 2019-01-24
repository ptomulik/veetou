CREATE OR REPLACE VIEW v2u_ko_x_sheets
AS SELECT
      x.job_uuid job_uuid
    , x.id id
    , x.sheet.job_uuid sheet_job_uuid
    , x.sheet.id sheet_id
    , x.sheet.pages_parsed sheet_pages_parsed
    , x.sheet.first_page sheet_first_page
    , x.sheet.ects_mandatory sheet_ects_mandatory
    , x.sheet.ects_other sheet_ects_other
    , x.sheet.ects_total sheet_ects_total
    , x.sheet.ects_attained sheet_ects_attained
    , x.page_ids page_ids
    , x.header.job_uuid header_job_uuid
    , x.header.id header_id
    , x.header.university header_university
    , x.header.faculty header_faculty
    , x.preamble.job_uuid preamble_job_uuid
    , x.preamble.id preamble_id
    , x.preamble.studies_modetier preamble_studies_modetier
    , x.preamble.title preamble_title
    , x.preamble.student_index preamble_student_index
    , x.preamble.first_name preamble_first_name
    , x.preamble.last_name preamble_last_name
    , x.preamble.student_name preamble_student_name
    , x.preamble.semester_code preamble_semester_code
    , x.preamble.studies_field preamble_studies_field
    , x.preamble.semester_number preamble_semester_number
    , x.preamble.studies_specialty preamble_studies_specialty
    , x.footer_ids footer_ids
    , x.report.job_uuid report_job_uuid
    , x.report.id report_id
    , x.report.source report_source
    , x.report.datetime report_datetime
    , x.report.first_page report_first_page
    , x.report.sheets_parsed report_sheets_parsed
    , x.report.pages_parsed report_pages_parsed
FROM v2u_ko_x_sheets_mv x
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
