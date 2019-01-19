CREATE OR REPLACE VIEW veetou_ko_ambiguous_programs
AS SELECT
      v.job_uuid job_uuid
    , v.program_mapping_ids program_mapping_ids
    , v.mapped_program_codes mapped_program_codes
    , v.matching_scores matching_scores
    , v.program_mappings_count program_mappings_count
    -- instance
    , v.specialty_instance.university university
    , v.specialty_instance.faculty faculty
    , v.specialty_instance.studies_modetier studies_modetier
    , v.specialty_instance.studies_field studies_field
    , v.specialty_instance.studies_specialty studies_specialty
    , v.specialty_instance.semester_code semester_code
    -- mapping
    , v.program_mappings program_mappings
    -- count
    , v.pages_counts pages_counts
FROM veetou_ko_ambiguous_programs_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
