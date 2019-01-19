CREATE OR REPLACE VIEW veetou_ko_unmapped_programs
AS SELECT
      v.job_uuid job_uuid
    , v.program_mapping_id program_mapping_id
    , v.matching_score matching_score
    -- instance
    , v.specialty_instance.university university
    , v.specialty_instance.faculty faculty
    , v.specialty_instance.studies_modetier studies_modetier
    , v.specialty_instance.studies_field studies_field
    , v.specialty_instance.studies_specialty studies_specialty
    , v.specialty_instance.semester_code semester_code
    -- mapping
    , v.program_mapping.mapped_program_code mapped_program_code
    , v.program_mapping.mapped_modetier_code mapped_modetier_code
    , v.program_mapping.mapped_field_code mapped_field_code
    , v.program_mapping.studies_specialty matched_studies_specialty
    , v.program_mapping.expr_semester_code expr_semester_code
    -- count
    , v.pages_count pages_count
FROM veetou_ko_unmapped_programs_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
