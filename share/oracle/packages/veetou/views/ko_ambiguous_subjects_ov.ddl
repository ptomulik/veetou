CREATE OR REPLACE VIEW veetou_ko_ambiguous_subjects_ov
AS WITH grouped_mappings AS (
    SELECT
          v.job_uuid job_uuid
        , LISTAGG(v.subject_mapping_id, ',')
            WITHIN GROUP (ORDER BY v.subject_mapping_id) subject_mapping_ids
        , LISTAGG(v.subject_mapping.mapped_subj_code, ',')
            WITHIN GROUP (ORDER BY v.subject_mapping_id) mapped_subj_codes
        , LISTAGG(v.matching_score, ',')
            WITHIN GROUP (ORDER BY v.subject_mapping_id) matching_scores
        , COUNT(*) subject_mappings_count
        , v.subject_instance subject_instance
        , CAST(COLLECT(v.subject_mapping) AS Veetou_Subject_Mappings_Typ) subject_mappings
        , LISTAGG(v.trs_count, ',') WITHIN GROUP (ORDER BY v.subject_mapping_id) trs_counts
    FROM veetou_ko_mapped_subjects_ov v
    GROUP BY v.job_uuid, v.subject_instance
    ORDER BY v.job_uuid, v.subject_instance
)
SELECT * FROM grouped_mappings
WHERE subject_mappings_count > 1;

-- vim: set ft=sql ts=4 sw=4 et:
