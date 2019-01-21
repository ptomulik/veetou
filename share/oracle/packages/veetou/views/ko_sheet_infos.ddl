CREATE OR REPLACE VIEW v2u_ko_sheet_infos
AS SELECT
      v.job_uuid job_uuid
    , v.header_id header_id
    , v.preamble_id preamble_id
    , v.sheet_id sheet_id
    , v.sheet_info.university university
    , v.sheet_info.faculty faculty
    , v.sheet_info.studies_modetier studies_modetier
    , v.sheet_info.student_index student_index
    , v.sheet_info.first_name first_name
    , v.sheet_info.last_name last_name
    , v.sheet_info.student_name student_name
    , v.sheet_info.semester_code semester_code
    , v.sheet_info.studies_field studies_field
    , v.sheet_info.semester_number semester_number
    , v.sheet_info.studies_specialty studies_specialty
    , v.sheet_info.ects_mandatory ects_mandatory
    , v.sheet_info.ects_other ects_other
    , v.sheet_info.ects_total ects_total
    , v.sheet_info.ects_attained ects_attained
FROM v2u_ko_sheet_infos_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
