CREATE OR REPLACE VIEW v2u_ko_ambiguous_programs_dv
AS WITH grouped_mappings AS (
    SELECT
          v.job_uuid job_uuid
        , LISTAGG(v.program_mapping_id, ',')
            WITHIN GROUP (ORDER BY v.program_mapping_id) program_mapping_ids
        , LISTAGG(v.program_mapping.mapped_program_code, ',')
            WITHIN GROUP (ORDER BY v.program_mapping_id) mapped_program_codes
        , LISTAGG(v.matching_score, ',')
            WITHIN GROUP (ORDER BY v.program_mapping_id) matching_scores
        , COUNT(*) program_mappings_count
        , v.specialty specialty
        , v.semester_code semester_code
        , CAST(COLLECT(v.program_mapping) AS V2u_Program_Mappings_t) program_mappings
        , LISTAGG(v.pages_count, ',') WITHIN GROUP (ORDER BY v.program_mapping_id) pages_counts
    FROM v2u_ko_mapped_programs_dv v
    GROUP BY v.job_uuid, v.specialty, v.semester_code
    ORDER BY v.job_uuid, v.specialty, v.semester_code
)
SELECT * FROM grouped_mappings
WHERE program_mappings_count > 1;

-- vim: set ft=sql ts=4 sw=4 et:
