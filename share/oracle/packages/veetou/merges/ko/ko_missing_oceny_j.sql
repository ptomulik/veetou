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
                , students.student_index
                , subject_map.map_subj_code
                , subjects.subj_code
                , semesters.semester_code
                , classes_map.map_classes_type

                , MIN(studenci.os_id) KEEP (
                    DENSE_RANK FIRST
                    ORDER BY studenci.os_id, ma_protos_j.prot_id
                  ) os_id
                , MIN(ma_protos_j.prot_id) KEEP (
                    DENSE_RANK FIRST
                    ORDER BY studenci.os_id, ma_protos_j.prot_id
                  ) prot_id

                  -- the "+0" trick is used to workaround Oracle DB bug
                , COUNT(DISTINCT studenci.id + 0) dz_studenci_cnt
                , COUNT(DISTINCT ma_protos_j.prot_id + 0) ma_protos_cnt
                , COUNT(DISTINCT oceny.term_prot_nr + 0) dz_oceny_cnt

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
            INNER JOIN v2u_dz_studenci studenci
                ON  (
                            studenci.indeks = students.student_index
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
            LEFT JOIN v2u_ko_matched_oceny_j ma_oceny_j
                ON  (
                            ma_oceny_j.student_id = g_j.student_id
                        AND ma_oceny_j.subject_id = g_j.subject_id
                        AND ma_oceny_j.specialty_id = g_j.specialty_id
                        AND ma_oceny_j.semester_id = g_j.semester_id
                        AND ma_oceny_j.classes_type = g_j.classes_type
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
                  g_j.student_id
                , g_j.subject_id
                , g_j.semester_id
                , g_j.specialty_id
                , g_j.classes_type
                , g_j.job_uuid
                , g_j.subj_grade
                , g_j.subj_grade_date
                , g_j.map_subj_grade
                , g_j.map_subj_grade_type
                , students.student_index
                , subject_map.map_subj_code
                , subjects.subj_code
                , semesters.semester_code
                , classes_map.map_classes_type
        ),
        v AS
        (
            SELECT
                  u.*

                , '{student: "' ||
                      u.student_index
                    || '"}'
                  student_key

                , '{student: "' ||
                      u.student_index
                    || '", subject: "' ||
                      COALESCE(u.map_subj_code, u.subj_code)
                    || '", semester: "' ||
                      u.semester_code
                    || '", classes: "' ||
                      COALESCE(u.map_classes_type, u.classes_type)
                    || '"}'
                  grade_key

            FROM u u
        )
        SELECT
              v.*
            , CASE
                WHEN v.dz_studenci_cnt <> 1
                THEN v.student_key || ' found ' || TO_CHAR(v.dz_studenci_cnt) || ' times in v2u_dz_studenci'
                WHEN v.ma_protos_cnt <> 1
                THEN v.grade_key || ' found ' || TO_CHAR(v.ma_protos_cnt) || ' times in v2u_ko_matched_protos_j'
                WHEN v.dz_oceny_cnt = 0
                THEN v.grade_key || ' has no matching row in v2u_dz_oceny'
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
        , map_subj_grade
        , map_subj_grade_type
        , os_id
        , prot_id
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
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
