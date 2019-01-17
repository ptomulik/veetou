CREATE OR REPLACE VIEW veetou_ko_mapped_subjects_ov
AS WITH joined AS (
    SELECT
          si.job_uuid job_uuid
        , sm.id subject_mapping_id
        , sm.subject_mapping.match_expr_fields(si.subject_instance) matching_score
        , si.subject_instance subject_instance
        , sm.subject_mapping subject_mapping
        , si.trs_count trs_count
    FROM veetou_ko_subject_instances_ov si
    LEFT JOIN veetou_subject_mappings_ov sm
    ON sm.subject_mapping.subj_code = si.subject_instance.subj_code
)
SELECT * FROM joined
WHERE matching_score > 0
ORDER BY subject_instance;

-- vim: set ft=sql ts=4 sw=4 et:
