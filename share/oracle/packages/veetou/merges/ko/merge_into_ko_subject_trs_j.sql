MERGE INTO v2u_ko_subject_trs_j tgt
USING
    (
        WITH u AS
        (
            SELECT job_uuid, id, tr_ids
            FROM v2u_ko_subject_issues
        )
        SELECT
              u.job_uuid job_uuid
            , u.id subject_instance_id
            , VALUE(t) tr_id
        FROM u u
        CROSS JOIN TABLE(u.tr_ids) t
    ) src
ON (tgt.tr_id = src.tr_id AND
    tgt.subject_instance_id = src.subject_instance_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     subject_instance_id,     tr_id)
    VALUES (src.job_uuid, src.subject_instance_id, src.tr_id);

-- vim: set ft=sql ts=4 sw=4 et:
