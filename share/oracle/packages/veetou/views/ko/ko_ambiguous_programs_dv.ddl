CREATE OR REPLACE VIEW v2u_ko_ambiguous_programs_dv
AS WITH grouped_mappings AS (
    SELECT
          v.job_uuid job_uuid
        , LISTAGG(v.specialty_map_id, ',')
            WITHIN GROUP (ORDER BY v.specialty_map_id) specialty_map_ids
        , LISTAGG(v.specialty_map.mapped_program_code, ',')
            WITHIN GROUP (ORDER BY v.specialty_map_id) mapped_program_codes
        , LISTAGG(v.matching_score, ',')
            WITHIN GROUP (ORDER BY v.specialty_map_id) matching_scores
        , COUNT(*) specialty_map_count
        , v.specialty specialty
        , v.semester_code semester_code
        , CAST(COLLECT(v.specialty_map) AS V2u_Specialty_Maps_t) specialty_map
        , LISTAGG(v.pages_count, ',') WITHIN GROUP (ORDER BY v.specialty_map_id) pages_counts
    FROM v2u_ko_mapped_programs_dv v
    GROUP BY v.job_uuid, v.specialty, v.semester_code
    ORDER BY v.job_uuid, v.specialty, v.semester_code
)
SELECT * FROM grouped_mappings
WHERE specialty_map_count > 1;

-- vim: set ft=sql ts=4 sw=4 et:
