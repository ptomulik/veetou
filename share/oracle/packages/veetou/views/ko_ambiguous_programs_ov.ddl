CREATE OR REPLACE VIEW veetou_ko_ambiguous_programs_ov
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
        , v.program_instance program_instance
        , CAST(COLLECT(v.program_mapping) AS Veetou_Program_Mappings_Typ) program_mappings
        , LISTAGG(v.trs_count, ',') WITHIN GROUP (ORDER BY v.program_mapping_id) trs_counts
    FROM veetou_ko_mapped_programs_ov v
    GROUP BY v.job_uuid, v.program_instance
    ORDER BY v.job_uuid, v.program_instance
)
SELECT * FROM grouped_mappings
WHERE program_mappings_count > 1;

-- vim: set ft=sql ts=4 sw=4 et:
