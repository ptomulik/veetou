CREATE OR REPLACE VIEW v2u_ko_mapped_subjects_dv
AS WITH joined AS (
    SELECT
          si.job_uuid job_uuid
        , sm.id subject_mapping_id
        , V2u_Match.Expr_Fields(sm.subject_mapping, si.subject_instance) matching_score
        , si.subject_instance subject_instance
        , sm.subject_mapping subject_mapping
        , si.trs_count trs_count
        , si.trs trs
    FROM v2u_ko_subject_instances_dv si
    LEFT JOIN v2u_subject_mappings_dv sm
    ON sm.subject_mapping.subj_code = si.subject_instance.subj_code
)
SELECT * FROM joined
WHERE matching_score > 0
ORDER BY subject_instance;

-- vim: set ft=sql ts=4 sw=4 et: