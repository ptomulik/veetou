MERGE INTO v2u_ko_matched_przedm_j tgt
USING
    (
        SELECT
              sm_j.job_uuid job_uuid
            , sm_j.subject_id subject_id
            , sm_j.specialty_id specialty_id
            , sm_j.semester_id semester_id
            , sm_j.map_id subject_map_id
            , sm_j.matching_score matching_score
            , subject_map.map_subj_code prz_kod
        FROM v2u_ko_subject_map_j sm_j
        INNER JOIN v2u_subject_map subject_map
            ON  (
                        subject_map.id = sm_j.map_id
                    AND subject_map.map_subj_code IS NOT NULL
                )
        INNER JOIN v2u_dz_przedmioty przedmioty
            ON  (
                        przedmioty.kod = subject_map.map_subj_code
                )
        WHERE sm_j.selected = 1
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , subject_id
        , specialty_id
        , semester_id
        , subject_map_id
        , matching_score
        , prz_kod
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.subject_map_id
        , src.matching_score
        , src.prz_kod
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.matching_score = src.matching_score
        , tgt.prz_kod = src.prz_kod
;

COMMIT;
-- vim: set ft=sql ts=4 sw=4 et:
