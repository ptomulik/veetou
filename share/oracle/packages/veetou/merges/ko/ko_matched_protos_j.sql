MERGE INTO v2u_ko_matched_protos_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  g_j.job_uuid
                , g_j.semester_id
                , g_j.specialty_id
                , g_j.subject_id
                , g_j.classes_type
                , g_j.student_id
                , sm_j.map_id subject_map_id
                , cm_j.map_id classes_map_id
                , pm_j.map_id protocol_map_id
                , COALESCE(
                      pm.map_proto_type
                    , sm.map_proto_type
                    , V2U_Get.Tpro_Kod(
                          subj_credit_kind => subjects.subj_credit_kind
                        , subj_grades => DECODE(
                                  g_j.subj_grade
                                , NULL
                                , V2u_Subj_Grades_t()
                                , V2u_Subj_Grades_t(g_j.subj_grade)
                                )
                      )
                  ) proto_type
                , protokoly.id prot_id
                , protokoly.zaj_cyk_id
                , protokoly.prz_kod
                , protokoly.cdyd_kod
                , protokoly.tpro_kod

            FROM v2u_ko_grades_j g_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = g_j.subject_id
                        AND subjects.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = g_j.semester_id
                        AND semesters.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = g_j.subject_id
                        AND sm_j.specialty_id = g_j.specialty_id
                        AND sm_j.semester_id = g_j.semester_id
                        AND sm_j.job_uuid = g_j.job_uuid
                        AND sm_j.selected = 1
                    )
            INNER JOIN v2u_subject_map sm
                ON  (
                            sm.id = sm_j.map_id
                        AND sm.map_subj_code IS NOT NULL
                    )
            LEFT JOIN v2u_ko_classes_map_j cm_j
                ON  (
                            cm_j.subject_id = g_j.subject_id
                        AND cm_j.specialty_id = g_j.specialty_id
                        AND cm_j.semester_id = g_j.semester_id
                        AND cm_j.classes_type = g_j.classes_type
                        AND cm_j.job_uuid = g_j.job_uuid
                        AND cm_j.selected = 1
                    )
            LEFT JOIN v2u_classes_map cm
                ON  (
                            cm.id = cm_j.map_id
                    )
            LEFT JOIN v2u_ko_protocol_map_j pm_j
                ON  (
                            pm_j.student_id = g_j.student_id
                        AND pm_j.subject_id = g_j.subject_id
                        AND pm_j.semester_id = g_j.semester_id
                        AND pm_j.specialty_id = g_j.specialty_id
                        AND pm_j.classes_type = g_j.classes_type
                        AND pm_j.job_uuid = g_j.job_uuid
                        AND pm_j.selected = 1
                    )
            LEFT JOIN v2u_protocol_map pm
                ON  (
                        pm.id = pm_j.map_id
                    )
            LEFT JOIN v2u_dz_zajecia_cykli zajecia_cykli
                ON  (
                            zajecia_cykli.prz_kod = COALESCE(pm.map_subj_code, sm.map_subj_code)
                        AND zajecia_cykli.cdyd_kod = COALESCE(pm.map_semester_code, semesters.semester_code)
                        AND zajecia_cykli.tzaj_kod = COALESCE(pm.map_classes_type, cm.map_classes_type)
                    )
            INNER JOIN v2u_dz_protokoly protokoly
                ON  (
                            protokoly.prz_kod = COALESCE(pm.map_subj_code, sm.map_subj_code)
                        AND protokoly.cdyd_kod = COALESCE(pm.map_semester_code, semesters.semester_code)
                        AND (
                                        COALESCE(pm.map_classes_type, g_j.classes_type) = '-'
                                    AND protokoly.zaj_cyk_id IS NULL
                                OR
                                        COALESCE(pm.map_classes_type, g_j.classes_type) <> '-'
                                    AND protokoly.zaj_cyk_id = zajecia_cykli.id
                            )
                    )
            WHERE
                        (
                                COALESCE(pm.map_classes_type, '-') = '-'
                            AND g_j.classes_type = '-'
                            AND cm_j.map_id IS NULL
                        )
                    OR
                        (
                                COALESCE(pm.map_classes_type, '-') <> '-'
                            OR
                                    g_j.classes_type <> '-'
                                AND cm_j.map_id IS NOT NULL
                        )
        )
        SELECT
              u.*
            , CASE
                WHEN u.proto_type <> u.tpro_kod
                THEN '"' || u.tpro_kod || '" <> "' || u.proto_type || '"'
                ELSE NULL
              END tpro_kod_missmatch
        FROM u u
    ) src
ON  (
            tgt.student_id = src.student_id
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.classes_type = src.classes_type
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , subject_id
        , classes_type
        , student_id
        , subject_map_id
        , classes_map_id
        , protocol_map_id
        , proto_type
        , prot_id
        , zaj_cyk_id
        , prz_kod
        , cdyd_kod
        , tpro_kod
        , tpro_kod_missmatch
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.classes_type
        , src.student_id
        , src.subject_map_id
        , src.classes_map_id
        , src.protocol_map_id
        , src.proto_type
        , src.prot_id
        , src.zaj_cyk_id
        , src.prz_kod
        , src.cdyd_kod
        , src.tpro_kod
        , src.tpro_kod_missmatch
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.classes_map_id = src.classes_map_id
        , tgt.protocol_map_id = src.protocol_map_id
        , tgt.proto_type = src.proto_type
        , tgt.prot_id = src.prot_id
        , tgt.zaj_cyk_id = src.zaj_cyk_id
        , tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.tpro_kod = src.tpro_kod
        , tgt.tpro_kod_missmatch = src.tpro_kod_missmatch
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
