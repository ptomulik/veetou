CREATE OR REPLACE VIEW v2u_ko_unmapped_programs_ov
AS SELECT
      v.job_uuid job_uuid
    , v.program_mapping_id program_mapping_id
    , v.matching_score matching_score
    , v.specialty specialty
    , v.semester_code semester_code
    , v.program_mapping program_mapping
    , v.pages_count pages_count
FROM v2u_ko_mapped_programs_ov v
WHERE v.program_mapping_id IS NULL OR
      v.program_mapping.mapped_program_code IS NULL OR
      v.matching_score < 1;

-- vim: set ft=sql ts=4 sw=4 et:
