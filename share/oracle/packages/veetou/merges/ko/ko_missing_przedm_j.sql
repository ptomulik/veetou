MERGE INTO v2u_ko_missing_przedm_j tgt
USING
    (
        SELECT
              j.job_uuid job_uuid
            , j.subject_id subject_id
            , j.specialty_id specialty_id
            , j.semester_id semester_id
            , j.subject_map_ids subject_map_ids
        FROM v2u_ko_missing_przcykl_j j
        WHERE (SELECT COUNT(*) FROM TABLE(j.prz_kody)) = 0
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.subject_id = src.subject_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.semester_id = src.semester_id)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     subject_id,     specialty_id,     semester_id,     subject_map_ids)
    VALUES (src.job_uuid, src.subject_id, src.specialty_id, src.semester_id, src.subject_map_ids)
WHEN MATCHED THEN UPDATE SET
    tgt.subject_map_ids = src.subject_map_ids
;
-- vim: set ft=sql ts=4 sw=4 et:
