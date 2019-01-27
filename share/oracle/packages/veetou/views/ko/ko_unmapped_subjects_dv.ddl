CREATE OR REPLACE VIEW v2u_ko_unmapped_subjects_dv
AS SELECT
      v.job_uuid job_uuid
    , v.subject_map_id subject_map_id
    , v.matching_score matching_score
    , v.subject_issue subject_issue
    , v.subject_map subject_map
    , v.trs_count trs_count
FROM v2u_ko_mapped_subjects_dv v
WHERE v.subject_map_id IS NULL OR
      v.subject_map.mapped_subj_code IS NULL OR
      v.matching_score < 1;

-- vim: set ft=sql ts=4 sw=4 et:
