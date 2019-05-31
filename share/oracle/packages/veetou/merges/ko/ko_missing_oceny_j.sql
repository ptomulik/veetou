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
                , g_j.map_subj_grade
                , g_j.map_subj_grade_type
                , CAST(
                    COLLECT(studenci.os_id)
                    AS V2u_Dz_Ids_t
                  ) os_ids
                , CAST(
                    COLLECT(ma_protos_j.prot_id)
                    AS V2u_Dz_Ids_t
                ) prot_ids
                , CAST(
                    COLLECT(oceny.term_prot_nr)
                    AS V2u_Ints10_t
                ) term_prot_nry

            FROM v2u_ko_grades_j g_j
            INNER JOIN v2u_ko_students students
                ON  (
                            students.id = g_j.student_id
                        AND students.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_dz_studenci studenci
                ON  (
                            studenci.indeks = students.student_index
                    )
            LEFT JOIN v2u_ko_matched_oceny_j ma_oceny_j
                ON  (
                            ma_oceny_j.student_id = g_j.student_id
                        AND ma_oceny_j.subject_id = g_j.subject_id
                        AND ma_oceny_j.specialty_id = g_j.specialty_id
                        AND ma_oceny_j.semester_id = g_j.semester_id
                        AND ma_oceny_j.classes_type = g_j.classes_type
                        AND ma_oceny_j.subj_grade_date = g_j.subj_grade_date
                        AND ma_oceny_j.job_uuid = g_j.job_uuid
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
            LEFT JOIN v2u_ko_missing_protos_j mi_protos_j
                ON  (
                            mi_protos_j.student_id = g_j.student_id
                        AND mi_protos_j.subject_id = g_j.subject_id
                        AND mi_protos_j.specialty_id = g_j.specialty_id
                        AND mi_protos_j.semester_id = g_j.semester_id
                        AND mi_protos_j.classes_type = g_j.classes_type
                        AND mi_protos_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_semesters semesters
                ON  (
                            semesters.code = ma_protos_j.cdyd_kod
                    )
            LEFT JOIN v2u_dz_oceny oceny
                ON  (
                            oceny.os_id = studenci.os_id
                        AND oceny.prot_id = ma_protos_j.prot_id
                    )
            LEFT JOIN v2u_dz_terminy_protokolow terminy_protokolow
                ON  (
                            terminy_protokolow.prot_id = oceny.prot_id
                        AND terminy_protokolow.nr = oceny.term_prot_nr
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
                , g_j.map_subj_grade
                , g_j.map_subj_grade_type
        ),
--        v AS
--        (
--            SELECT
--                  u.*
--                , ( SELECT SUBSTR(VALUE(t), 1, 300)
--                    FROM TABLE(u.mi_trmpro_reasons2k) t
--                    WHERE ROWNUM <= 1
--                  ) mi_trmpro_reason
--                  -- FIXME: implement mi_etpos_reason
----                , ( SELECT SUBSTR(VALUE(t), 1, 300)
----                    FROM TABLE(u.mi_etpos_reasons2k) t
----                    WHERE ROWNUM <= 1
----                  ) mi_etpos_reason
--                , CASE
--                    WHEN u.mi_etpos_cnt <> 0
--                    THEN '{student: "", specialty: "", semester: ""} found in v2u_ko_missing_etpos_j (count: '
--                         || TO_CHAR(u.mi_etpos_cnt) ||
--                         ')'
--                    ELSE NULL
--                  END mi_etpos_reason
--                , CASE
--                    WHEN u.studenci_cnt = 0
--                    THEN '{student: ""} not found in v2u_dz_studenci'
--                    ELSE NULL
--                  END studenci_reason
--                , ( SELECT VALUE(t)
--                    FROM TABLE(u.os_ids) t
--                    WHERE ROWNUM <= 1
--                  ) os_id
--                , ( SELECT VALUE(t)
--                    FROM TABLE(u.prot_ids) t
--                    WHERE ROWNUM <= 1
--                  ) prot_id
--                , ( SELECT VALUE(t)
--                    FROM TABLE(u.term_prot_nry) t
--                    WHERE ROWNUM <= 1
--                  ) term_prot_nr
--                --
--                , ( SELECT COUNT(*)
--                    FROM TABLE(u.os_ids)
--                  ) dbg_os_ids
--                , ( SELECT COUNT(*)
--                    FROM TABLE(u.prot_ids)
--                  ) dbg_prot_ids
--                , ( SELECT COUNT(*)
--                    FROM TABLE(u.term_prot_nry)
--                  ) dbg_term_prot_nry
--            FROM u u
--        )
--        SELECT
--              v.*
--            , CASE
--                WHEN v.mi_trmpro_cnt = 1 AND v.mi_etpos_cnt = 1 AND v.studenci_cnt = 0
--                THEN v.mi_trmpro_reason || ' and ' || v.mi_etpos_reason || ' and ' || v.studenci_reason
----                WHEN v.mi_trmpro_cnt = 1 AND v.mi_etpos_cnt = 1
----                THEN v.mi_trmpro_reason || ' and ' || v.mi_etpos_reason
--                WHEN v.mi_trmpro_cnt = 1
--                THEN v.mi_trmpro_reason
--                WHEN v.mi_etpos_cnt = 1 AND v.studenci_cnt = 0
--                THEN v.mi_etpos_reason || ' and ' || v.studenci_reason
--                WHEN v.ma_trmpro_cnt = 1 AND v.semesters_cnt <> 1
--                THEN 'INNER JOIN v2u_semesters failed (count: '
--                     || TO_CHAR(v.semesters_cnt) ||
--                     ')'
--                WHEN v.ma_trmpro_cnt = 1 AND v.oceny_cnt <> 1
--                THEN 'INNER JOIN v2u_dz_oceny failed (count: '
--                     || TO_CHAR(v.oceny_cnt) ||
--                     ')'
--                WHEN v.oceny_cnt = 1 AND v.wartosci_ocen_cnt <> 1
--                THEN 'INNER JOIN v2u_dz_wartosci_ocen failed (count: '
--                     || TO_CHAR(v.wartosci_ocen_cnt) ||
--                     ')'
--                WHEN ma_trmpro_cnt <> 1
--                THEN 'INNER JOIN v2u_ko_matched_trmpro_j failed (count: '
--                     || TO_CHAR(v.ma_trmpro_cnt) ||
--                     ')'
--                ELSE 'error (v2u_ko_matched_oceny_j out of sync?)'
--              END reason
--        FROM v v
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
        , map_subj_grade
        , map_subj_grade_type
        , os_id
        , prot_id
        , term_prot_nr
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
        , src.map_subj_grade
        , src.map_subj_grade_type
        , src.os_id
        , src.prot_id
        , src.term_prot_nr
        , src.reason
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subj_grade = src.subj_grade
        , tgt.subj_grade_date = src.subj_grade_date
        , tgt.map_subj_grade = src.map_subj_grade
        , tgt.map_subj_grade_type = src.map_subj_grade_type
        , tgt.os_id = src.os_id
        , tgt.prot_id = src.prot_id
        , tgt.term_prot_nr = src.term_prot_nr
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
