MERGE INTO v2u_ko_matched_przcykl_j tgt
USING
    (
        SELECT
              sm_j.job_uuid job_uuid
            , sm_j.subject_id subject_id
            , sm_j.specialty_id specialty_id
            , sm_j.semester_id semester_id
            , sm_j.map_id subject_map_id
            , sm_j.matching_score matching_score
            , przedmioty_cykli.prz_kod prz_kod
            , przedmioty_cykli.cdyd_kod cdyd_kod
        FROM v2u_ko_subject_map_j sm_j
        INNER JOIN v2u_subject_map subject_map
            ON  (
                        subject_map.id = sm_j.map_id
                    AND subject_map.map_subj_code IS NOT NULL
                )
        INNER JOIN v2u_ko_semesters semesters
            ON  (
                        semesters.id = sm_j.semester_id
                    AND semesters.job_uuid = sm_j.job_uuid
                )
        INNER JOIN v2u_dz_przedmioty_cykli przedmioty_cykli
            ON  (
                        przedmioty_cykli.prz_kod = subject_map.map_subj_code
                    AND przedmioty_cykli.cdyd_kod = semesters.semester_code
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
        , cdyd_kod
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.subject_map_id
        , src.matching_score
        , src.prz_kod
        , src.cdyd_kod
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.matching_score = src.matching_score
        , tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
