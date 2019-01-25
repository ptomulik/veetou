CREATE MATERIALIZED VIEW v2u_ko_subj_instance_trs_mv
    (
        job_uuid
      , subj_instance_id
      , tr_id
    )
BUILD DEFERRED
REFRESH COMPLETE
AS WITH u AS
    (
        SELECT job_uuid, id, tr_ids
        FROM v2u_ko_subject_instances_mv
    )
SELECT
      u.job_uuid
    , u.id
    , VALUE(t)
FROM u u
CROSS JOIN TABLE(u.tr_ids) t;

-- vim: set ft=sql ts=4 sw=4 et:
