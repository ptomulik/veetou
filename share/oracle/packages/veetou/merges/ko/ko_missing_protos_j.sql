MERGE INTO v2u_ko_missing_protos_j tgt
USING
    (
        WITH u AS
        ( -- all grades except those falling into v2u_ko_matched_protos_j
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
                      pm.map_subj_code
                    , sm.map_subj_code
                  ) map_subj_code
                , COALESCE(
                      pm.map_classes_type
                    , cm.map_classes_type
                  ) map_classes_type
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

                -- for "reason"
                , subjects.subj_code
                , semesters.semester_code
                , COALESCE(pm.map_semester_code, semesters.semester_code) map_semester_code
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
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = g_j.subject_id
                        AND sm_j.specialty_id = g_j.specialty_id
                        AND sm_j.semester_id = g_j.semester_id
                        AND sm_j.job_uuid = g_j.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map sm
                ON  (
                            sm.id = sm_j.map_id
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
                        AND pm_j.specialty_id = g_j.specialty_id
                        AND pm_j.semester_id = g_j.semester_id
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
            LEFT JOIN v2u_dz_protokoly protokoly
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
            LEFT JOIN v2u_ko_matched_protos_j ma_protos_j
                ON  (
                            ma_protos_j.student_id = g_j.student_id
                        AND ma_protos_j.subject_id = g_j.subject_id
                        AND ma_protos_j.specialty_id = g_j.specialty_id
                        AND ma_protos_j.semester_id = g_j.semester_id
                        AND ma_protos_j.classes_type = g_j.classes_type
                        AND ma_protos_j.job_uuid = g_j.job_uuid
                    )
            WHERE
                  ma_protos_j.job_uuid IS NULL
        )
        SELECT
              u.*
            , CASE
                WHEN u.classes_type = '-' AND u.subject_map_id IS NULL
                THEN 'no subject map for {subject: "'
                     ||
                     u.subj_code
                     || '", semester: "' ||
                     u.semester_code
                     || '"}'
                WHEN u.map_subj_code IS NULL
                THEN 'map_subj_code IS NULL for {subject: "'
                     ||
                     u.subj_code
                     || '", semester: ' ||
                     u.semester_code
                     || '"}'
                WHEN u.classes_type <> '-' AND u.classes_map_id IS NULL
                THEN 'no classes map for {subject: "'
                     ||
                     u.subj_code
                     || '", semester: "' ||
                     u.semester_code
                     || '", classes: "' ||
                     u.classes_type
                     || '"}'
                WHEN u.classes_type <> '-' AND u.map_classes_type IS NULL
                THEN 'map_classes_type IS NULL for {subject: "'
                     ||
                     u.subj_code
                     || '", semester: "' ||
                     u.semester_code
                     || '", classes: "' ||
                     u.classes_type
                     || '"}'
                WHEN u.classes_type <> '-' AND u.zaj_cyk_id IS NULL
                THEN '{subject: "'
                     ||
                     u.map_subj_code
                     || '", semester: "' ||
                     u.semester_code
                     || '", tzaj: "' ||
                     u.map_classes_type
                     || '"} not in v2u_ko_matched_zajcykl_j'
                WHEN u.prot_id IS NULL
                THEN '{subject: "'
                     ||
                     u.map_subj_code
                     || '", semester: "' ||
                     u.map_semester_code
                     || '", tzaj: "' ||
                     u.map_classes_type
                     || '", protocol: "' ||
                     u.proto_type
                     || '"} not in v2u_dz_protokoly'
                ELSE 'error (v2u_ko_matched_protos_j out of sync?)'
              END reason
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
        , subject_id
        , specialty_id
        , semester_id
        , classes_type
        , student_id
        , subject_map_id
        , classes_map_id
        , protocol_map_id
        , map_subj_code
        , map_classes_type
        , proto_type
        , zaj_cyk_id
        , prot_id
        , reason
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.classes_type
        , src.student_id
        , src.subject_map_id
        , src.classes_map_id
        , src.protocol_map_id
        , src.map_subj_code
        , src.map_classes_type
        , src.proto_type
        , src.zaj_cyk_id
        , src.prot_id
        , src.reason
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.classes_map_id = src.classes_map_id
        , tgt.protocol_map_id = src.protocol_map_id
        , tgt.map_subj_code = src.map_subj_code
        , tgt.map_classes_type = src.map_classes_type
        , tgt.proto_type = src.proto_type
        , tgt.zaj_cyk_id = src.zaj_cyk_id
        , tgt.prot_id = src.prot_id
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
