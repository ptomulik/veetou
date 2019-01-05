MERGE INTO v2u_ko_subject_trs_j tgt
USING
    (
        WITH u AS
        (
            SELECT job_uuid, id, tr_ids
            FROM v2u_ko_subjects
        )
        SELECT
              u.job_uuid job_uuid
            , u.id subject_id
            , VALUE(t) tr_id
        FROM u u
        CROSS JOIN TABLE(u.tr_ids) t
    ) src
ON  (
            tgt.tr_id = src.tr_id
        AND tgt.subject_id = src.subject_id
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     subject_id,     tr_id)
    VALUES (src.job_uuid, src.subject_id, src.tr_id)
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
