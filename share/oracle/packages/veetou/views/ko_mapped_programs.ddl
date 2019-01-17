CREATE OR REPLACE VIEW veetou_ko_mapped_programs
AS SELECT
      v.job_uuid job_uuid
    , v.program_mapping_id program_mapping_id
    , v.matching_score matching_score
    -- instance
    , v.program_instance.university university
    , v.program_instance.faculty faculty
    , v.program_instance.studies_modetier studies_modetier
    , v.program_instance.studies_field studies_field
    , v.program_instance.studies_specialty studies_specialty
    , v.program_instance.semester_code semester_code
    -- mapping
    , v.program_mapping.mapped_program_code mapped_program_code
    , v.program_mapping.mapped_modetier_code mapped_modetier_code
    , v.program_mapping.mapped_field_code mapped_field_code
    , v.program_mapping.studies_specialty matched_studies_specialty
    , v.program_mapping.expr_semester_code expr_semester_code
    -- count
    , v.trs_count trs_count
FROM veetou_ko_mapped_programs_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
