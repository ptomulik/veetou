MERGE INTO v2u_ko_matched_oceny_j tgt
USING
    (
        WITH t AS
        (
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
                , studenci.os_id
                , ma_protos_j.prot_id
                , oceny.term_prot_nr
                , V2u_Fit.Attributes(
                    grade_i => VALUE(g_j)
                  , wartosc_oceny => VALUE(wartosci_ocen)
                  , termin_protokolu => VALUE(terminy_protokolow)
                  , data_zwrotu_rank => DENSE_RANK() OVER (
                        --PARTITION BY terminy_protokolow.prot_id
                        PARTITION BY
                                  g_j.student_id
                                , g_j.subject_id
                                , g_j.specialty_id
                                , g_j.semester_id
                                , g_j.classes_type
                                , g_j.job_uuid
                        ORDER BY  terminy_protokolow.data_zwrotu
                                , terminy_protokolow.nr
                        )
                  ) matching_score
                , wartosci_ocen.opis
                , CASE
                    WHEN g_j.map_subj_grade <> wartosci_ocen.opis
                    THEN '"' || g_j.map_subj_grade || '" <> "' || wartosci_ocen.opis || '"'
                    WHEN g_j.map_subj_grade_type <> oceny.toc_kod
                    THEN '[' || g_j.map_subj_grade_type || '] <> [' || oceny.toc_kod || ']'
                    ELSE NULL
                  END ocena_missmatch

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
            INNER JOIN v2u_ko_matched_protos_j ma_protos_j
                ON  (
                            ma_protos_j.student_id = g_j.student_id
                        AND ma_protos_j.subject_id = g_j.subject_id
                        AND ma_protos_j.specialty_id = g_j.specialty_id
                        AND ma_protos_j.semester_id = g_j.semester_id
                        AND ma_protos_j.classes_type = g_j.classes_type
                        AND ma_protos_j.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_semesters semesters
                ON  (
                            semesters.code = ma_protos_j.cdyd_kod
                    )
            INNER JOIN v2u_dz_oceny oceny
                ON  (
                            oceny.os_id = studenci.os_id
                        AND oceny.prot_id = ma_protos_j.prot_id
                    )
            INNER JOIN v2u_dz_terminy_protokolow terminy_protokolow
                ON  (
                            terminy_protokolow.prot_id = oceny.prot_id
                        AND terminy_protokolow.nr = oceny.term_prot_nr
                    )
            INNER JOIN v2u_dz_wartosci_ocen wartosci_ocen
                ON  (
                            wartosci_ocen.toc_kod = oceny.toc_kod
                        AND wartosci_ocen.kolejnosc = oceny.wart_oc_kolejnosc
                    )
            /* WHERE g_j.subj_grade_date IS NOT NULL */
        ),
        u AS
        (
            SELECT
                  t.*
                , MAX(t.matching_score) OVER (
                        PARTITION BY
                              t.student_id
                            , t.subject_id
                            , t.specialty_id
                            , t.semester_id
                            , t.classes_type
                            , t.job_uuid
                  ) highest_score
            FROM t t
        ),
        v AS
        (
            SELECT
                  u.*
                , CASE
                    WHEN u.matching_score > 0 AND u.matching_score = u.highest_score
                    THEN 1
                    ELSE NULL
                  END is_candidate
            FROM u u
        ),
        w AS
        (
            SELECT
                  v.*
                , COUNT(v.is_candidate) OVER (
                        PARTITION BY
                              v.student_id
                            , v.subject_id
                            , v.specialty_id
                            , v.semester_id
                            , v.classes_type
                            , v.job_uuid
                  ) candidates_count
            FROM v v
        )
        SELECT
              w.*
            , CASE
                WHEN w.is_candidate IS NOT NULL AND w.candidates_count = 1
                THEN 1
                ELSE 0
              END selected
            , CASE
                WHEN w.matching_score = 0
                THEN 'matching_score = 0'
                WHEN w.matching_score <> w.highest_score
                THEN 'matching_score (' ||
                        TO_CHAR(w.matching_score)
                    || ') <> highest_score (' ||
                        TO_CHAR(w.highest_score)
                    || ')'
                WHEN w.candidates_count <> 1
                THEN 'candidates_count (' ||
                        TO_CHAR(w.candidates_count)
                    || ') <> 1'
                WHEN w.is_candidate IS NULL
                THEN 'is_candidate IS NULL'
                ELSE 'is_candidate = 1 AND candidates_count = 1'
            END reason
        FROM w w
    ) src
ON  (
            tgt.student_id = src.student_id
        AND tgt.subject_id = src.subject_id
        AND tgt.semester_id = src.semester_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.classes_type = src.classes_type
        AND tgt.os_id = src.os_id
        AND tgt.prot_id = src.prot_id
        AND tgt.term_prot_nr = src.term_prot_nr
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
        , opis
        , ocena_missmatch
        , matching_score
        , highest_score
        , selected
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
        , src.opis
        , src.ocena_missmatch
        , src.matching_score
        , src.highest_score
        , src.selected
        , src.reason
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subj_grade = src.subj_grade
        , tgt.map_subj_grade = src.map_subj_grade
        , tgt.map_subj_grade_type = src.map_subj_grade_type
        , tgt.opis = src.opis
        , tgt.ocena_missmatch = src.ocena_missmatch
        , tgt.matching_score = src.matching_score
        , tgt.highest_score = src.highest_score
        , tgt.selected = src.selected
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
