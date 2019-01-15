CREATE VIEW veetou_ko_mapped_subjects_ov AS
    SELECT
          si.job_uuid job_uuid
        , sm.id subject_mapping_id
        , sm.subject_mapping.match_expr_fields(si.subject_instance) matching_score
        , si.subject_instance subject_instance
        , sm.subject_mapping subject_mapping
FROM veetou_ko_subject_instances_ov si
LEFT JOIN veetou_subject_mappings_ov sm
ON (sm.subject_mapping.subj_code = si.subject_instance.subj_code AND
    (sm.subject_mapping.match_expr_fields(si.subject_instance) > 0));

-- vim: set ft=sql ts=4 sw=4 et:
