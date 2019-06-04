MERGE INTO v2u_ko_matched_trmpro_j tgt
USING
    (
--        SELECT
--              ma_protos_j.job_uuid
--            , ma_protos_j.semester_id
--            , ma_protos_j.specialty_id
--            , ma_protos_j.subject_id
--            , ma_protos_j.classes_type
--            , COALESCE(TO_CHAR(g_j.subj_grade_date, 'YYYY-MM-DD'), '-') subj_grade_date
--            , ma_protos_j.subject_map_id
--            , ma_protos_j.classes_map_id
--            , ma_protos_j.prz_kod
--            , ma_protos_j.cdyd_kod
--            , ma_protos_j.tpro_kod
--            , ma_protos_j.prot_id
--
--            , MIN(trmpro.nr) KEEP (
--                DENSE_RANK FIRST
--                ORDER BY
--                ABS(g_j.subj_grade_date - trmpro.data_zwrotu), trmpro.nr DESC
--              ) nr
--            , MIN(trmpro.data_zwrotu) KEEP (
--                DENSE_RANK FIRST
--                ORDER BY
--                ABS(g_j.subj_grade_date - trmpro.data_zwrotu), trmpro.nr DESC
--              ) data_zwrotu
--
--        FROM v2u_ko_matched_protos_j ma_protos_j
--        INNER JOIN v2u_ko_grades_j g_j
--            ON  (
--                        g_j.subject_id = ma_protos_j.subject_id
--                    AND g_j.specialty_id = ma_protos_j.specialty_id
--                    AND g_j.semester_id = ma_protos_j.semester_id
--                    AND g_j.job_uuid = ma_protos_j.job_uuid
--                    AND g_j.classes_type = ma_protos_j.classes_type
--                )
--        INNER JOIN v2u_semesters semesters
--            ON  (
--                        semesters.code = ma_protos_j.cdyd_kod
--                )
--        LEFT JOIN v2u_semesters grade_semesters
--            ON  (
--                        TRUNC(g_j.subj_grade_date, 'DD')
--                            BETWEEN TRUNC(grade_semesters.start_date, 'DD')
--                                AND TRUNC(grade_semesters.end_date, 'DD')
--                )
--        INNER JOIN v2u_dz_terminy_protokolow trmpro
--            ON  (
--                        trmpro.prot_id = ma_protos_j.prot_id
--                    AND (
--                                g_j.subj_grade_date IS NOT NULL
--                            AND (
--                                          TRUNC(g_j.subj_grade_date, 'DD')
--                                        = TRUNC(trmpro.data_zwrotu, 'DD')
--                                    -- fallback date...
--                                    OR NOT EXISTS(
--                                            SELECT NULL
--                                            FROM v2u_dz_terminy_protokolow t
--                                            WHERE t.prot_id = ma_protos_j.prot_id
--                                                AND TRUNC(t.data_zwrotu, 'DD')
--                                                  = TRUNC(g_j.subj_grade_date, 'DD')
--                                        )
--                                        AND TRUNC(trmpro.data_zwrotu, 'DD')
--                                            BETWEEN TRUNC(grade_semesters.start_date, 'DD')
--                                                AND TRUNC(grade_semesters.end_date, 'DD')
--                                        AND trmpro.utw_id LIKE 'V2U:%'
--                                )
--                            OR   g_j.subj_grade_date IS NULL
--                            AND (
--                                        TRUNC(trmpro.data_zwrotu, 'DD')
--                                        BETWEEN TRUNC(semesters.start_date, 'DD')
--                                            AND TRUNC(semesters.end_date, 'DD')
--                                )
--                        )
--                )
--        GROUP BY
--              ma_protos_j.job_uuid
--            , ma_protos_j.semester_id
--            , ma_protos_j.specialty_id
--            , ma_protos_j.subject_id
--            , ma_protos_j.classes_type
--            , COALESCE(TO_CHAR(g_j.subj_grade_date, 'YYYY-MM-DD'), '-')
--            , ma_protos_j.subject_map_id
--            , ma_protos_j.classes_map_id
--            , ma_protos_j.prz_kod
--            , ma_protos_j.cdyd_kod
--            , ma_protos_j.tpro_kod
--            , ma_protos_j.prot_id

        SELECT
              g_j.job_uuid
            , g_j.semester_id
            , g_j.specialty_id
            , g_j.subject_id
            , g_j.classes_type
            , g_j.student_id
            , TO_CHAR(g_j.subj_grade_date, 'YYYY-MM-DD') subj_grade_date
            , terminy_protokolow.prot_id
            , terminy_protokolow.nr
            , terminy_protokolow.data_zwrotu
        FROM v2u_ko_grades_j g_j
        INNER JOIN v2u_ko_matched_oceny_j ma_oceny_j
            ON  (
                        ma_oceny_j.student_id = g_j.student_id
                    AND ma_oceny_j.subject_id = g_j.subject_id
                    AND ma_oceny_j.semester_id = g_j.semester_id
                    AND ma_oceny_j.specialty_id = g_j.specialty_id
                    AND ma_oceny_j.classes_type = g_j.classes_type
                    AND ma_oceny_j.job_uuid = g_j.job_uuid
                    AND ma_oceny_j.selected = 1
                )
        INNER JOIN v2u_dz_terminy_protokolow terminy_protokolow
            ON  (
                        terminy_protokolow.prot_id = ma_oceny_j.prot_id
                    AND terminy_protokolow.nr = ma_oceny_j.term_prot_nr
                )

        UNION ALL

        SELECT
              g_j.job_uuid
            , g_j.semester_id
            , g_j.specialty_id
            , g_j.subject_id
            , g_j.classes_type
            , g_j.student_id
            , TO_CHAR(g_j.subj_grade_date, 'YYYY-MM-DD') subj_grade_date
            , terminy_protokolow.prot_id
            , terminy_protokolow.nr
            , terminy_protokolow.data_zwrotu
        FROM v2u_ko_grades_j g_j
        INNER JOIN v2u_ko_matched_protos_j ma_protos_j
            ON  (
                        ma_protos_j.student_id = g_j.student_id
                    AND ma_protos_j.subject_id = g_j.subject_id
                    AND ma_protos_j.semester_id = g_j.semester_id
                    AND ma_protos_j.specialty_id = g_j.specialty_id
                    AND ma_protos_j.classes_type = g_j.classes_type
                    AND ma_protos_j.job_uuid = g_j.job_uuid
                )
        INNER JOIN v2u_semesters semesters
            ON  (
                        semesters.code = ma_protos_j.cdyd_kod
                )
        LEFT JOIN v2u_semesters grade_semesters
            ON  (
                        TRUNC(g_j.subj_grade_date, 'DD')
                            BETWEEN TRUNC(grade_semesters.start_date, 'DD')
                                AND TRUNC(grade_semesters.end_date, 'DD')
                )
        INNER JOIN v2u_dz_terminy_protokolow terminy_protokolow
            ON  (
                        terminy_protokolow.prot_id = ma_protos_j.prot_id
                    AND (
                                g_j.subj_grade_date IS NOT NULL
                            AND (
                                          TRUNC(g_j.subj_grade_date, 'DD')
                                        = TRUNC(terminy_protokolow.data_zwrotu, 'DD')
                                    -- fallback date...
                                    OR NOT EXISTS(
                                            SELECT NULL
                                            FROM v2u_dz_terminy_protokolow t
                                            WHERE t.prot_id = ma_protos_j.prot_id
                                                AND TRUNC(t.data_zwrotu, 'DD')
                                                  = TRUNC(g_j.subj_grade_date, 'DD')
                                        )
                                        AND TRUNC(terminy_protokolow.data_zwrotu, 'DD')
                                            BETWEEN TRUNC(grade_semesters.start_date, 'DD')
                                                AND TRUNC(grade_semesters.end_date, 'DD')
                                        AND terminy_protokolow.utw_id LIKE 'V2U:%'
                                )
                            OR   g_j.subj_grade_date IS NULL
                            AND (
                                        TRUNC(terminy_protokolow.data_zwrotu, 'DD')
                                        BETWEEN TRUNC(semesters.start_date, 'DD')
                                            AND TRUNC(semesters.end_date, 'DD')
                                )
                        )
                )
        LEFT JOIN v2u_ko_matched_oceny_j ma_oceny_j
            ON  (
                        ma_oceny_j.student_id = g_j.student_id
                    AND ma_oceny_j.subject_id = g_j.subject_id
                    AND ma_oceny_j.semester_id = g_j.semester_id
                    AND ma_oceny_j.specialty_id = g_j.specialty_id
                    AND ma_oceny_j.classes_type = g_j.classes_type
                    AND ma_oceny_j.job_uuid = g_j.job_uuid
                    AND ma_oceny_j.selected = 1
                )
        WHERE ma_oceny_j.term_prot_nr IS NULL
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
--        , subject_map_id
--        , classes_map_id
--        , prz_kod
--        , cdyd_kod
--        , tpro_kod
        , prot_id
        , nr
        , data_zwrotu
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.classes_type
        , src.student_id
        , src.subj_grade_date
--        , src.subject_map_id
--        , src.classes_map_id
--        , src.prz_kod
--        , src.cdyd_kod
--        , src.tpro_kod
        , src.prot_id
        , src.nr
        , src.data_zwrotu
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subj_grade_date = src.subj_grade_date
--        , tgt.subject_map_id = src.subject_map_id
--        , tgt.classes_map_id = src.classes_map_id
--        , tgt.prz_kod = src.prz_kod
--        , tgt.cdyd_kod = src.cdyd_kod
--        , tgt.tpro_kod = src.tpro_kod
        , tgt.prot_id = src.prot_id
        , tgt.nr = src.nr
        , tgt.data_zwrotu = src.data_zwrotu
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
