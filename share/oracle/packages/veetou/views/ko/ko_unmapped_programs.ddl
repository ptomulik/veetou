CREATE OR REPLACE VIEW v2u_ko_unmapped_programs
AS SELECT
      v.job_uuid job_uuid
    , v.specialty_map_id specialty_map_id
    , v.matching_score matching_score
    , v.specialty.university university
    , v.specialty.faculty faculty
    , v.specialty.studies_modetier studies_modetier
    , v.specialty.studies_field studies_field
    , v.specialty.studies_specialty studies_specialty
    , v.semester_code semester_code
    , v.specialty_map.mapped_program_code mapped_program_code
    , v.specialty_map.mapped_modetier_code mapped_modetier_code
    , v.specialty_map.mapped_field_code mapped_field_code
    , v.specialty_map.studies_specialty matched_studies_specialty
    , v.specialty_map.expr_semester_code expr_semester_code
    , v.pages_count pages_count
FROM v2u_ko_unmapped_programs_dv v;

-- vim: set ft=sql ts=4 sw=4 et:
