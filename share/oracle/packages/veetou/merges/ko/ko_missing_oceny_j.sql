MERGE INTO v2u_ko_missing_oceny_j tgt
USING
    (
        WITH u AS
        ( -- all grades except those falling into v2u_ko_matched_oceny_j
            SELECT
                  g_j.job_uuid
                , g_j.semester_id
                , g_j.specialty_id
                , g_j.subject_id
                , g_j.student_id
                , g_j.classes_type
                , g_j.subj_grade
                , g_j.subj_grade_date
                , g_j.tr_id
                , COUNT(mi_trmpro_j.job_uuid) mi_trmpro_cnt
                , COUNT(mi_etpos_j.job_uuid) mi_etpos_cnt
                , COUNT(ma_trmpro_j.job_uuid) ma_trmpro_cnt
                , COUNT(ma_etpos_j.job_uuid) ma_etpos_cnt
                , COUNT(semesters.code) semesters_cnt
                , COUNT(oceny.os_id) oceny_cnt
                , COUNT(wartosci_ocen.toc_kod) wartosci_ocen_cnt
                , SET(CAST(
                        COLLECT(mi_trmpro_j.reason)
                        AS V2u_Vchars1K_t
                  )) mi_trmpro_reasons1k
                  -- FIXME: implement mi_etpos_reasons1k
--                , SET(CAST(
--                        COLLECT(mi_etpos_j.reason)
--                        AS V2u_Vchars1K_t
--                  )) mi_etpos_reasons1k
            FROM v2u_ko_grades_j g_j
            LEFT JOIN v2u_ko_matched_oceny_j ma_oceny_j
                ON  (
                            ma_oceny_j.student_id = g_j.student_id
                        AND ma_oceny_j.subject_id = g_j.subject_id
                        AND ma_oceny_j.specialty_id = g_j.specialty_id
                        AND ma_oceny_j.semester_id = g_j.semester_id
                        AND ma_oceny_j.classes_type = g_j.classes_type
                        AND ma_oceny_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_trmpro_j mi_trmpro_j
                ON  (
                            mi_trmpro_j.subject_id = g_j.subject_id
                        AND mi_trmpro_j.specialty_id = g_j.specialty_id
                        AND mi_trmpro_j.semester_id = g_j.semester_id
                        AND mi_trmpro_j.classes_type = g_j.classes_type
                        AND mi_trmpro_j.subj_grade_date = g_j.subj_grade_date
                        AND mi_trmpro_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_etpos_j mi_etpos_j
                ON  (
                            mi_etpos_j.student_id = g_j.student_id
                        AND mi_etpos_j.specialty_id = g_j.specialty_id
                        AND mi_etpos_j.semester_id = g_j.semester_id
                        AND mi_etpos_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_trmpro_j ma_trmpro_j
                ON  (
                            ma_trmpro_j.subject_id = g_j.subject_id
                        AND ma_trmpro_j.specialty_id = g_j.specialty_id
                        AND ma_trmpro_j.semester_id = g_j.semester_id
                        AND ma_trmpro_j.classes_type = g_j.classes_type
                        AND ma_trmpro_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_etpos_j ma_etpos_j
                ON  (
                            ma_etpos_j.student_id = g_j.student_id
                        AND ma_etpos_j.specialty_id = g_j.specialty_id
                        AND ma_etpos_j.semester_id = g_j.semester_id
                        AND ma_etpos_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_semesters semesters
                ON  (
                            semesters.code = ma_trmpro_j.cdyd_kod
                    )
            LEFT JOIN v2u_dz_oceny oceny
                ON  (
                            oceny.os_id = ma_etpos_j.os_id
                        AND oceny.prot_id = ma_trmpro_j.prot_id
                        AND oceny.term_prot_nr = ma_trmpro_j.nr
                    )
            LEFT JOIN v2u_dz_wartosci_ocen wartosci_ocen
                ON  (
                            wartosci_ocen.toc_kod = oceny.toc_kod
                        AND wartosci_ocen.kolejnosc = oceny.wart_oc_kolejnosc
                    )
            WHERE ma_oceny_j.job_uuid IS NULL
            GROUP BY
                  g_j.job_uuid
                , g_j.semester_id
                , g_j.specialty_id
                , g_j.subject_id
                , g_j.student_id
                , g_j.classes_type
                , g_j.subj_grade
                , g_j.subj_grade_date
                , g_j.tr_id
        ),
        v AS
        (
            SELECT
                  u.*
                , ( SELECT SUBSTR(VALUE(t), 1, 200)
                    FROM TABLE(u.mi_trmpro_reasons1k) t
                    WHERE ROWNUM <= 1
                  ) mi_trmpro_reason
                  -- FIXME: implement mi_etpos_reason
--                , ( SELECT SUBSTR(VALUE(t), 1, 200)
--                    FROM TABLE(u.mi_etpos_reasons1k) t
--                    WHERE ROWNUM <= 1
--                  ) mi_etpos_reason
                , CASE
                    WHEN u.mi_etpos_cnt <> 0
                    THEN 'student|specialty|semester found in v2u_ko_missing_etpos_j (count: '
                         || TO_CHAR(u.mi_etpos_cnt) ||
                         ')'
                    ELSE NULL
                  END mi_etpos_reason
            FROM u u
        )
        SELECT
              v.*
            , CASE
                WHEN v.mi_trmpro_cnt = 1 AND v.mi_etpos_cnt = 1
                THEN v.mi_trmpro_reason || ' and ' || v.mi_etpos_reason
                WHEN v.mi_trmpro_cnt = 1
                THEN v.mi_trmpro_reason
                WHEN v.mi_etpos_cnt = 1
                THEN v.mi_etpos_reason
                WHEN v.ma_trmpro_cnt = 1 AND v.semesters_cnt <> 1
                THEN 'INNER JOIN v2u_semesters failed (count: '
                     || TO_CHAR(v.semesters_cnt) ||
                     ')'
                WHEN v.ma_trmpro_cnt = 1 AND v.ma_etpos_cnt = 1 AND v.oceny_cnt <> 1
                THEN 'INNER JOIN v2u_dz_oceny failed (count: '
                     || TO_CHAR(v.oceny_cnt) ||
                     ')'
                WHEN v.oceny_cnt = 1 AND v.wartosci_ocen_cnt <> 1
                THEN 'INNER JOIN v2u_dz_wartosci_ocen failed (count: '
                     || TO_CHAR(v.wartosci_ocen_cnt) ||
                     ')'
                WHEN ma_trmpro_cnt <> 1
                THEN 'INNER JOIN v2u_ko_matched_trmpro_j failed (count: '
                     || TO_CHAR(v.ma_trmpro_cnt) ||
                     ')'
                WHEN ma_etpos_cnt <> 1
                THEN 'INNER JOIN v2u_ko_matched_etpos_j failed (count: '
                     || TO_CHAR(v.ma_etpos_cnt) ||
                     ')'
                ELSE 'error (v2u_ko_matched_oceny_j out of sync?)'
              END reason
        FROM v v
    ) src
ON  (
            tgt.subject_id = src.subject_id
        AND tgt.student_id = src.student_id
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
        , student_id
        , classes_type
        , subj_grade
        , subj_grade_date
        , tr_id
        , reason
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.student_id
        , src.classes_type
        , src.subj_grade
        , src.subj_grade_date
        , src.tr_id
        , src.reason
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subj_grade = src.subj_grade
        , tgt.subj_grade_date = src.subj_grade_date
        , tgt.tr_id = src.tr_id
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
