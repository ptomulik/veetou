MERGE INTO v2u_ko_matched_zajcykl_j tgt
USING
    (
        SELECT
              sm_j.job_uuid job_uuid
            , sm_j.subject_id subject_id
            , sm_j.specialty_id specialty_id
            , sm_j.semester_id semester_id
            , cm_j.classes_type classes_type
            , cm_j.classes_hours classes_hours
            , sm_j.map_id subject_map_id
            , cm_j.map_id classes_map_id
            , zajecia_cykli.prz_kod prz_kod
            , zajecia_cykli.cdyd_kod cdyd_kod
            , zajecia_cykli.tzaj_kod tzaj_kod
            , zajecia_cykli.id zaj_cyk_id
        FROM v2u_ko_subject_map_j sm_j
        INNER JOIN v2u_ko_classes_map_j cm_j
            ON  (
                        cm_j.subject_id = sm_j.subject_id
                    AND cm_j.specialty_id = sm_j.specialty_id
                    AND cm_j.semester_id = sm_j.semester_id
                    AND cm_j.job_uuid = sm_j.job_uuid
                    AND cm_j.selected = 1
                )
        INNER JOIN v2u_subject_map subject_map
            ON  (
                        subject_map.id = sm_j.map_id
                    AND subject_map.map_subj_code IS NOT NULL
                )
        INNER JOIN v2u_classes_map classes_map
            ON  (
                        classes_map.id = cm_j.map_id
                    AND classes_map.map_classes_type IS NOT NULL
                )
        INNER JOIN v2u_ko_semesters semesters
            ON  (
                        semesters.id = sm_j.semester_id
                    AND semesters.job_uuid = sm_j.job_uuid
                )
        INNER JOIN v2u_dz_zajecia_cykli zajecia_cykli
            ON  (
                        zajecia_cykli.prz_kod = subject_map.map_subj_code
                    AND zajecia_cykli.cdyd_kod = semesters.semester_code
                    AND zajecia_cykli.tzaj_kod = classes_map.map_classes_type
                )
        WHERE sm_j.selected = 1
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.classes_type = src.classes_type
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , subject_id
        , specialty_id
        , semester_id
        , classes_type
        , classes_hours
        , subject_map_id
        , classes_map_id
        , prz_kod
        , cdyd_kod
        , tzaj_kod
        , zaj_cyk_id
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.classes_type
        , src.classes_hours
        , src.subject_map_id
        , src.classes_map_id
        , src.prz_kod
        , src.cdyd_kod
        , src.tzaj_kod
        , src.zaj_cyk_id
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.classes_hours = src.classes_hours
        , tgt.subject_map_id = src.subject_map_id
        , tgt.classes_map_id = src.classes_map_id
        , tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.tzaj_kod = src.tzaj_kod
        , tgt.zaj_cyk_id = src.zaj_cyk_id
;

COMMIT;
-- vim: set ft=sql ts=4 sw=4 et:
