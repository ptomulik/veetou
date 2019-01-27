CREATE OR REPLACE VIEW v2u_ko_unmapped_programs_dv
AS SELECT
      v.job_uuid job_uuid
    , v.specialty_map_id specialty_map_id
    , v.matching_score matching_score
    , v.specialty specialty
    , v.semester_code semester_code
    , v.specialty_map specialty_map
    , v.pages_count pages_count
FROM v2u_ko_mapped_programs_dv v
WHERE v.specialty_map_id IS NULL OR
      v.specialty_map.mapped_program_code IS NULL OR
      v.matching_score < 1;

-- vim: set ft=sql ts=4 sw=4 et:
