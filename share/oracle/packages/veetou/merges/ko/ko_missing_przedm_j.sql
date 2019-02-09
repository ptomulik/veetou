MERGE INTO v2u_ko_missing_przedm_j tgt
USING
    (
        SELECT
              j.job_uuid job_uuid
            , j.subject_id subject_id
            , j.specialty_id specialty_id
            , j.semester_id semester_id
            , j.subject_map_ids subject_map_ids
            , j.tried_map_subj_codes tried_map_subj_codes
        FROM v2u_ko_missing_przcykl_j j
        WHERE (SELECT COUNT(*) FROM TABLE(j.istniejace_przedmioty_kod)) = 0
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.subject_id = src.subject_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.semester_id = src.semester_id)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     subject_id,     specialty_id,     semester_id,     subject_map_ids,     tried_map_subj_codes)
    VALUES (src.job_uuid, src.subject_id, src.specialty_id, src.semester_id, src.subject_map_ids, src.tried_map_subj_codes)
WHEN MATCHED THEN UPDATE SET
      tgt.subject_map_ids = src.subject_map_ids
    , tgt.tried_map_subj_codes = src.tried_map_subj_codes
;
-- vim: set ft=sql ts=4 sw=4 et:
