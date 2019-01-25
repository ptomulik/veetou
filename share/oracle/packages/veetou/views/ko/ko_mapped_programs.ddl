CREATE OR REPLACE VIEW v2u_ko_mapped_programs
AS SELECT
      v.job_uuid job_uuid
    , v.program_mapping_id program_mapping_id
    , v.matching_score matching_score
    -- instance
    , v.specialty.university university
    , v.specialty.faculty faculty
    , v.specialty.studies_modetier studies_modetier
    , v.specialty.studies_field studies_field
    , v.specialty.studies_specialty studies_specialty
    , v.semester_code semester_code
    -- mapping
    , v.program_mapping.mapped_program_code mapped_program_code
    , v.program_mapping.mapped_modetier_code mapped_modetier_code
    , v.program_mapping.mapped_field_code mapped_field_code
    , v.program_mapping.studies_specialty matched_studies_specialty
    , v.program_mapping.expr_semester_code expr_semester_code
    -- count
    , v.pages_count pages_count
FROM v2u_ko_mapped_programs_dv v;

-- vim: set ft=sql ts=4 sw=4 et:
