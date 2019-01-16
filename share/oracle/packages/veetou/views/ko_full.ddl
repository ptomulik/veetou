CREATE OR REPLACE VIEW veetou_ko_full AS
SELECT
      veetou_ko_trs.job_uuid AS job_uuid
    , veetou_ko_trs.id AS tr_id
    , veetou_ko_trs.subj_code AS tr_subj_code
    , veetou_ko_trs.subj_name AS tr_subj_name
    , veetou_ko_trs.subj_hours_w AS tr_subj_hours_w
    , veetou_ko_trs.subj_hours_c AS tr_subj_hours_c
    , veetou_ko_trs.subj_hours_l AS tr_subj_hours_l
    , veetou_ko_trs.subj_hours_p AS tr_subj_hours_p
    , veetou_ko_trs.subj_hours_s AS tr_subj_hours_s
    , veetou_ko_trs.subj_credit_kind AS tr_subj_credit_kind
    , veetou_ko_trs.subj_ects AS tr_subj_ects
    , veetou_ko_trs.subj_tutor AS tr_subj_tutor
    , veetou_ko_trs.subj_grade AS tr_subj_grade
    , veetou_ko_trs.subj_grade_date AS tr_subj_grade_date
    , veetou_ko_tbodies.id AS tbody_id
    , veetou_ko_tbodies.remark AS tbody_remark
    , veetou_ko_pages.id AS page_id
    , veetou_ko_pages.page_number AS page_page_number
    , veetou_ko_pages.parser_page_number AS page_parser_page_number
    , veetou_ko_sheets.id AS sheet_id
    , veetou_ko_sheets.pages_parsed AS sheet_pages_parsed
    , veetou_ko_sheets.first_page AS sheet_first_page
    , veetou_ko_sheets.ects_mandatory AS sheet_ects_mandatory
    , veetou_ko_sheets.ects_other AS sheet_ects_other
    , veetou_ko_sheets.ects_total AS sheet_ects_total
    , veetou_ko_sheets.ects_attained AS sheet_ects_attained
    , veetou_ko_reports.id AS report_id
    , veetou_ko_reports.source AS report_source
    , veetou_ko_reports.datetime AS report_datetime
    , veetou_ko_reports.first_page AS report_first_page
    , veetou_ko_reports.sheets_parsed AS report_sheets_parsed
    , veetou_ko_reports.pages_parsed AS report_pages_parsed
    , veetou_ko_preambles.id AS preamble_id
    , veetou_ko_preambles.studies_modetier AS preamble_studies_modetier
    , veetou_ko_preambles.title AS preamble_title
    , veetou_ko_preambles.student_index AS preamble_student_index
    , veetou_ko_preambles.first_name AS preamble_first_name
    , veetou_ko_preambles.last_name AS preamble_last_name
    , veetou_ko_preambles.student_name AS preamble_student_name
    , veetou_ko_preambles.semester_code AS preamble_semester_code
    , veetou_ko_preambles.studies_field AS preamble_studies_field
    , veetou_ko_preambles.semester_number AS preamble_semester_number
    , veetou_ko_preambles.studies_specialty AS preamble_studies_specialty
    , veetou_ko_headers.id AS header_id
    , veetou_ko_headers.university AS header_university
    , veetou_ko_headers.faculty AS header_faculty
    , veetou_ko_footers.id AS footer_id
    , veetou_ko_footers.pagination AS footer_pagination
    , veetou_ko_footers.sheet_page_number AS footer_sheet_page_number
    , veetou_ko_footers.sheet_pages_total AS footer_sheet_pages_total
    , veetou_ko_footers.generator_name AS footer_generator_name
    , veetou_ko_footers.generator_home AS footer_generator_home
FROM veetou_ko_trs
INNER JOIN veetou_ko_tbody_trs
      ON (veetou_ko_tbody_trs.job_uuid = veetou_ko_trs.job_uuid AND
          veetou_ko_tbody_trs.ko_tr_id = veetou_ko_trs.id)
INNER JOIN veetou_ko_tbodies
      ON (veetou_ko_tbody_trs.job_uuid = veetou_ko_tbodies.job_uuid AND
          veetou_ko_tbody_trs.ko_tbody_id = veetou_ko_tbodies.id)
INNER JOIN veetou_ko_page_tbody
      ON (veetou_ko_page_tbody.job_uuid = veetou_ko_tbodies.job_uuid AND
          veetou_ko_page_tbody.ko_tbody_id = veetou_ko_tbodies.id)
INNER JOIN veetou_ko_pages
      ON (veetou_ko_page_tbody.job_uuid = veetou_ko_pages.job_uuid AND
          veetou_ko_page_tbody.ko_page_id = veetou_ko_pages.id)
INNER JOIN veetou_ko_sheet_pages
      ON (veetou_ko_sheet_pages.job_uuid = veetou_ko_pages.job_uuid AND
          veetou_ko_sheet_pages.ko_page_id = veetou_ko_pages.id)
INNER JOIN veetou_ko_sheets
      ON (veetou_ko_sheet_pages.job_uuid = veetou_ko_sheets.job_uuid AND
          veetou_ko_sheet_pages.ko_sheet_id = veetou_ko_sheets.id)
INNER JOIN veetou_ko_report_sheets
      ON (veetou_ko_report_sheets.job_uuid = veetou_ko_sheets.job_uuid AND
          veetou_ko_report_sheets.ko_sheet_id = veetou_ko_sheets.id)
INNER JOIN veetou_ko_reports
      ON (veetou_ko_report_sheets.job_uuid = veetou_ko_reports.job_uuid AND
          veetou_ko_report_sheets.ko_report_id = veetou_ko_reports.id)
INNER JOIN veetou_ko_page_preamble
      ON (veetou_ko_page_preamble.job_uuid = veetou_ko_pages.job_uuid AND
          veetou_ko_page_preamble.ko_page_id = veetou_ko_pages.id)
INNER JOIN veetou_ko_preambles
      ON (veetou_ko_page_preamble.job_uuid = veetou_ko_preambles.job_uuid AND
          veetou_ko_page_preamble.ko_preamble_id = veetou_ko_preambles.id)
INNER JOIN veetou_ko_page_header
      ON (veetou_ko_page_header.job_uuid = veetou_ko_pages.job_uuid AND
          veetou_ko_page_header.ko_page_id = veetou_ko_pages.id)
INNER JOIN veetou_ko_headers
      ON (veetou_ko_page_header.job_uuid = veetou_ko_headers.job_uuid AND
          veetou_ko_page_header.ko_header_id = veetou_ko_headers.id)
INNER JOIN veetou_ko_page_footer
      ON (veetou_ko_page_footer.job_uuid = veetou_ko_pages.job_uuid AND
          veetou_ko_page_footer.ko_page_id = veetou_ko_pages.id)
INNER JOIN veetou_ko_footers
      ON (veetou_ko_page_footer.job_uuid = veetou_ko_footers.job_uuid AND
          veetou_ko_page_footer.ko_footer_id = veetou_ko_footers.id);

-- vim: set ft=sql ts=4 sw=4 et:
