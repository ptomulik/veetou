MERGE INTO v2u_ko_missing_trmpro_j tgt
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
                , g_j.subj_grade_date
                , g_j.subj_grade
                , ma_protos_j.prot_id
                , ( SELECT MAX(tp.nr)
                    FROM v2u_dz_terminy_protokolow tp
                    WHERE tp.prot_id = ma_protos_j.prot_id
                  ) max_istniejacy_nr
                , CAST(CAST(MULTISET(
                        SELECT tp.data_zwrotu
                        FROM v2u_dz_terminy_protokolow tp
                        WHERE tp.prot_id = ma_protos_j.prot_id
                  ) AS V2u_Dates_t) AS V2u_20Dates_t) istniejace_daty_zwrotow
                , sm_j.map_id subject_map_id
                , subject_map.map_subj_code
                , cm_j.map_id classes_map_id
                , classes_map.map_classes_type
                , subjects.subj_code                -- for diagnostics
                , semesters.semester_code           -- for diagnostics
                , COALESCE(
                      subject_map.map_proto_type
                    , V2U_Get.Tpro_Kod(
                          subj_credit_kind => subjects.subj_credit_kind
                        , subj_grades => DECODE(  g_j.subj_grade,
                                                  NULL
                                                , V2u_Subj_Grades_t()
                                                , V2u_Subj_Grades_t(g_j.subj_grade)
                                                )
                      )
                  ) coalesced_proto_type
                , '{student: "' ||
                      students.student_index
                    || '", subject: "' ||
                      COALESCE(subject_map.map_subj_code, subjects.subj_code)
                    || '", semester: "' ||
                      semesters.semester_code
                    || '", classes: "' ||
                      COALESCE(classes_map.map_classes_type, g_j.classes_type)
                    || '"}'
                  grade_key

                , CAST(MULTISET(
                    SELECT
                        l$tp.nr
                    FROM v2u_ko_matched_oceny_j l$ma_oceny_j
                    INNER JOIN v2u_dz_terminy_protokolow l$tp
                        ON  (
                                    l$tp.prot_id = l$ma_oceny_j.prot_id
                                AND l$tp.nr = l$ma_oceny_j.term_prot_nr
                            )
                    WHERE   l$ma_oceny_j.student_id = g_j.student_id
                        AND l$ma_oceny_j.subject_id = g_j.subject_id
                        AND l$ma_oceny_j.semester_id = g_j.semester_id
                        AND l$ma_oceny_j.specialty_id = g_j.specialty_id
                        AND l$ma_oceny_j.classes_type = g_j.classes_type
                        AND l$ma_oceny_j.job_uuid = g_j.job_uuid

                    UNION ALL

                    --
                    -- Find l$tp that already have matched other grades_j
                    -- with same subj_grade_date as ours.
                    --
                    SELECT
                        l$tp.nr
                    FROM v2u_ko_matched_protos_j l$ma_protos_j
                    INNER JOIN v2u_dz_terminy_protokolow l$tp
                        ON  (
                                    l$tp.prot_id = l$ma_protos_j.prot_id
                            )
                    LEFT JOIN v2u_ko_matched_oceny_j l$ma_oceny_j
                        ON  (
                                    l$ma_oceny_j.student_id = l$ma_protos_j.student_id
                                AND l$ma_oceny_j.subject_id = l$ma_protos_j.subject_id
                                AND l$ma_oceny_j.semester_id = l$ma_protos_j.semester_id
                                AND l$ma_oceny_j.specialty_id = l$ma_protos_j.specialty_id
                                AND l$ma_oceny_j.classes_type = l$ma_protos_j.classes_type
                                AND l$ma_oceny_j.job_uuid = l$ma_protos_j.job_uuid
                            )
                    WHERE   l$ma_protos_j.student_id = g_j.student_id
                        AND l$ma_protos_j.subject_id = g_j.subject_id
                        AND l$ma_protos_j.semester_id = g_j.semester_id
                        AND l$ma_protos_j.specialty_id = g_j.specialty_id
                        AND l$ma_protos_j.classes_type = g_j.classes_type
                        AND l$ma_protos_j.job_uuid = g_j.job_uuid
                        --
                        AND l$ma_oceny_j.term_prot_nr IS NULL
                        AND (
                                SELECT COUNT(DISTINCT l$ma_others_j.term_prot_nr + 0)
                                FROM v2u_ko_matched_oceny_j l$ma_others_j
                                WHERE   l$ma_others_j.prot_id = l$tp.prot_id
                                    AND l$ma_others_j.term_prot_nr = l$tp.nr
                                    AND TRUNC(l$ma_others_j.subj_grade_date, 'DD') = TRUNC(g_j.subj_grade_date, 'DD')
                            ) = 1
                  ) AS V2u_Dz_Ids_t) nry

            FROM v2u_ko_grades_j g_j
            INNER JOIN v2u_ko_students students
                ON  (
                            students.id = g_j.student_id
                        AND students.job_uuid = g_j.job_uuid
                    )
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
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = sm_j.map_id
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
            LEFT JOIN v2u_classes_map classes_map
                ON  (
                            classes_map.id = cm_j.map_id
                    )
            INNER JOIN v2u_semesters semesters2
                ON  (
                            semesters2.code = semesters.semester_code
                    )
            LEFT JOIN v2u_ko_matched_trmpro_j ma_trmpro_j
                ON  (
                            ma_trmpro_j.student_id = g_j.student_id
                        AND ma_trmpro_j.subject_id = g_j.subject_id
                        AND ma_trmpro_j.specialty_id = g_j.specialty_id
                        AND ma_trmpro_j.semester_id = g_j.semester_id
                        AND ma_trmpro_j.classes_type = g_j.classes_type
                        AND ma_trmpro_j.job_uuid = g_j.job_uuid
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
                  ma_trmpro_j.job_uuid IS NULL
        )
        SELECT

              u.job_uuid
            , u.semester_id
            , u.specialty_id
            , u.subject_id
            , u.classes_type
            , u.student_id
            , u.subj_grade_date
            , u.subject_map_id
            , u.map_subj_code
            , u.classes_map_id
            , u.map_classes_type
            , u.coalesced_proto_type
            , u.prot_id
            , u.max_istniejacy_nr
            , u.istniejace_daty_zwrotow
            , ( SELECT VALUE(t)
                FROM TABLE(u.nry) t
                WHERE ROWNUM <= 1
              ) nr

            , CASE
                WHEN u.prot_id IS NULL
                THEN u.grade_key || ' not in v2u_ko_matched_protos_j'
                WHEN (SELECT COUNT(*) FROM table(u.nry)) = 0
                THEN u.grade_key || ' not in dz_terminy_protokolow'
                ELSE 'error (v2u_ko_matched_trmpro_j out of sync?)'
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
        , semester_id
        , specialty_id
        , subject_id
        , classes_type
        , student_id
        , subj_grade_date
        , subject_map_id
        , map_subj_code
        , classes_map_id
        , map_classes_type
        , coalesced_proto_type
        , prot_id
        , nr
        , reason
        , max_istniejacy_nr
        , istniejace_daty_zwrotow
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.classes_type
        , src.student_id
        , src.subj_grade_date
        , src.subject_map_id
        , src.map_subj_code
        , src.classes_map_id
        , src.map_classes_type
        , src.coalesced_proto_type
        , src.prot_id
        , src.nr
        , src.reason
        , src.max_istniejacy_nr
        , src.istniejace_daty_zwrotow
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subj_grade_date = src.subj_grade_date
        , tgt.subject_map_id = src.subject_map_id
        , tgt.map_subj_code = src.map_subj_code
        , tgt.classes_map_id = src.classes_map_id
        , tgt.map_classes_type = src.map_classes_type
        , tgt.coalesced_proto_type = src.coalesced_proto_type
        , tgt.prot_id = src.prot_id
        , tgt.nr = src.nr
        , tgt.reason = src.reason
        , tgt.max_istniejacy_nr = src.max_istniejacy_nr
        , tgt.istniejace_daty_zwrotow = src.istniejace_daty_zwrotow
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
