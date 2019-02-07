MERGE INTO v2u_ko_missing_prgos_j tgt
USING
    (
        SELECT
              j.job_uuid job_uuid
            , j.student_id student_id
            , j.specialty_id specialty_id
            , j.semester_id semester_id
            , j.specialty_map_ids specialty_map_ids
        FROM v2u_ko_missing_etpos_j j
        WHERE (SELECT COUNT(*) FROM TABLE(j.prgos_ids)) = 0
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.student_id = src.student_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.semester_id = src.semester_id)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     student_id,     specialty_id,     semester_id,     specialty_map_ids)
    VALUES (src.job_uuid, src.student_id, src.specialty_id, src.semester_id, src.specialty_map_ids)
WHEN MATCHED THEN UPDATE SET
    tgt.specialty_map_ids = src.specialty_map_ids
;
-- vim: set ft=sql ts=4 sw=4 et: