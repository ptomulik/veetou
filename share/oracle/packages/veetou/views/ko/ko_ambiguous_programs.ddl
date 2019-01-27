CREATE OR REPLACE VIEW v2u_ko_ambiguous_programs
AS SELECT
      v.job_uuid job_uuid
    , v.specialty_map_ids specialty_map_ids
    , v.mapped_program_codes mapped_program_codes
    , v.matching_scores matching_scores
    , v.specialty_map_count specialty_map_count
    -- instance
    , v.specialty.university university
    , v.specialty.faculty faculty
    , v.specialty.studies_modetier studies_modetier
    , v.specialty.studies_field studies_field
    , v.specialty.studies_specialty studies_specialty
    , v.semester_code semester_code
    -- mapping
    , v.specialty_map specialty_map
    -- count
    , v.pages_counts pages_counts
FROM v2u_ko_ambiguous_programs_dv v;

-- vim: set ft=sql ts=4 sw=4 et:
