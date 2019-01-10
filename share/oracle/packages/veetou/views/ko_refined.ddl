CREATE VIEW veetou_ko_refined AS
SELECT
    veetou_ko_full.job_uuid AS job_uuid
  , veetou_ko_full.tr_id AS tr_id
  , veetou_ko_full.tr_subj_code AS subj_code
  , veetou_ko_full.tr_subj_name AS subj_name
  , veetou_ko_full.preamble_student_index AS student_index
  , veetou_ko_full.preamble_first_name AS first_name
  , veetou_ko_full.preamble_last_name AS last_name
  , veetou_ko_full.preamble_student_name AS student_name
  , veetou_ko_full.tr_subj_grade AS subj_grade
  , veetou_ko_full.tr_subj_grade_date AS subj_grade_date
  , veetou_ko_full.header_university AS university
  , veetou_ko_full.header_faculty AS faculty
  , veetou_ko_full.preamble_studies_modetier AS studies_modetier
  , veetou_ko_full.preamble_studies_field AS studies_field
  , veetou_ko_full.preamble_studies_specialty AS studies_specialty
  , veetou_ko_full.preamble_semester_code AS semester_code
  , veetou_ko_full.preamble_semester_number AS semester_number
  , veetou_ko_full.tr_subj_tutor AS subj_tutor
  , veetou_ko_full.tr_subj_hours_w AS subj_hours_w
  , veetou_ko_full.tr_subj_hours_c AS subj_hours_c
  , veetou_ko_full.tr_subj_hours_l AS subj_hours_l
  , veetou_ko_full.tr_subj_hours_p AS subj_hours_p
  , veetou_ko_full.tr_subj_hours_s AS subj_hours_s
  , veetou_ko_full.tr_subj_credit_kind AS subj_credit_kind
  , veetou_ko_full.tr_subj_ects AS subj_ects
  , veetou_ko_full.sheet_ects_mandatory AS ects_mandatory
  , veetou_ko_full.sheet_ects_other AS ects_other
  , veetou_ko_full.sheet_ects_total AS ects_total
  , veetou_ko_full.sheet_ects_attained AS ects_attained
  , veetou_ko_full.preamble_title AS preamble_title
  , veetou_ko_full.report_source AS report_source
  , veetou_ko_full.report_datetime AS report_open_datetime
  , veetou_ko_full.report_sheets_parsed AS report_sheets_parsed
  , veetou_ko_full.report_pages_parsed AS report_pages_parsed
  , veetou_ko_full.page_page_number AS page_number
  , veetou_ko_full.sheet_first_page AS sheet_first_page
  , veetou_ko_full.sheet_pages_parsed AS sheet_pages_parsed
FROM veetou_ko_full;

-- vim: set ft=sql ts=4 sw=4 et:
