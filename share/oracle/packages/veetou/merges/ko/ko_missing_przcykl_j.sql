MERGE INTO v2u_ko_missing_przcykl_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  j1.job_uuid job_uuid
                , j1.subject_id subject_id
                , j1.specialty_id specialty_id
                , j1.semester_id semester_id
                , CAST(
                    COLLECT(DISTINCT j4.map_id ORDER BY j4.map_id)
                    AS V2u_5Ids_t
                  ) subject_map_ids
                , CAST(
                    COLLECT(subject_map.map_subj_code ORDER BY subject_map.map_subj_code)
                    AS V2u_5Vchars1024_t
                  ) tried_map_subj_codes
                , CAST(
                    COLLECT(j3.prz_kod ORDER BY j3.prz_kod)
                    AS V2u_5Vchars1024_t
                  ) istniejace_prz_kody
            FROM v2u_ko_subject_semesters_j j1
            LEFT JOIN v2u_ko_matched_przcykl_j j2
                ON (j2.subject_id = j1.subject_id AND
                    j2.specialty_id = j1.specialty_id AND
                    j2.semester_id = j1.semester_id AND
                    j2.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_ko_matched_przedm_j j3
                ON (j3.subject_id = j1.subject_id AND
                    j3.specialty_id = j1.specialty_id AND
                    j3.semester_id = j1.semester_id AND
                    j3.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_ko_subject_map_j j4
                ON (j4.subject_id = j1.subject_id AND
                    j4.specialty_id = j1.specialty_id AND
                    j4.semester_id = j1.semester_id AND
                    j4.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_subject_map subject_map
                ON (subject_map.id = j4.map_id)
            WHERE j2.id IS NULL
            GROUP BY
                  j1.job_uuid
                , j1.subject_id
                , j1.specialty_id
                , j1.semester_id
        )
        SELECT
              u.job_uuid job_uuid
            , u.subject_id subject_id
            , u.specialty_id specialty_id
            , u.semester_id semester_id
            , u.subject_map_ids subject_map_ids
            , CAST(MULTISET(
                    SELECT DISTINCT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u.tried_map_subj_codes) t
              ) AS V2u_Subj_5Codes_t) tried_map_subj_codes
            , CAST(MULTISET(
                    SELECT DISTINCT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u.istniejace_prz_kody) t
              ) AS V2u_Subj_5Codes_t) istniejace_prz_kody
        FROM u u
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.subject_id = src.subject_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.semester_id = src.semester_id)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     subject_id,     specialty_id,     semester_id,     subject_map_ids,     tried_map_subj_codes,     istniejace_prz_kody)
    VALUES (src.job_uuid, src.subject_id, src.specialty_id, src.semester_id, src.subject_map_ids, src.tried_map_subj_codes, src.istniejace_prz_kody)
WHEN MATCHED THEN UPDATE SET
      tgt.subject_map_ids = src.subject_map_ids
    , tgt.tried_map_subj_codes = src.tried_map_subj_codes
    , tgt.istniejace_prz_kody = src.istniejace_prz_kody
;
-- vim: set ft=sql ts=4 sw=4 et:
