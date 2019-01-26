CREATE OR REPLACE VIEW v2u_ko_unmapped_subjects_dv
AS SELECT
      v.job_uuid job_uuid
    , v.subject_mapping_id subject_mapping_id
    , v.matching_score matching_score
    , v.subject_instance subject_instance
    , v.subject_mapping subject_mapping
    , v.trs_count trs_count
FROM v2u_ko_mapped_subjects_dv v
WHERE v.subject_mapping_id IS NULL OR
      v.subject_mapping.mapped_subj_code IS NULL OR
      v.matching_score < 1;

-- vim: set ft=sql ts=4 sw=4 et: