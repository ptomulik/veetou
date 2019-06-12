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
                , studenci.os_id
                , ma_protos_j.prot_id

                , CAST(CAST(MULTISET(
                    SELECT
                          V2u_Fit.Attributes(
                            grade_i => VALUE(g_j)
                          , wartosc_oceny => VALUE(wo)
                          , subject_map => VALUE(subject_map)
                          , termin_protokolu => VALUE(tp)
                          , data_zwrotu_rank => DENSE_RANK() OVER (
                                PARTITION BY
                                          g_j.student_id
                                        , g_j.subject_id
                                        , g_j.specialty_id
                                        , g_j.semester_id
                                        , g_j.classes_type
                                        , g_j.job_uuid
                                ORDER BY  tp.data_zwrotu
                                        , tp.nr
                                )
                          )
                    FROM v2u_dz_oceny o
                    INNER JOIN v2u_dz_wartosci_ocen wo
                        ON  (
                                    wo.toc_kod = o.toc_kod
                                AND wo.kolejnosc = o.wart_oc_kolejnosc
                            )
                    INNER JOIN v2u_dz_terminy_protokolow tp
                        ON  (
                                    tp.prot_id = o.prot_id
                                AND tp.nr = o.term_prot_nr
                            )
                    WHERE   o.os_id = studenci.os_id
                        AND o.prot_id = ma_protos_j.prot_id
                        AND (
                                        wo.opis = g_j.map_subj_grade
                                    AND wo.toc_kod = g_j.map_subj_grade_type
                                OR      g_j.map_subj_grade IS NULL
                                    AND DECODE(g_j.map_subj_grade_type
                                              , wo.toc_kod, 1
                                              , NULL, 1
                                              , 0
                                              ) = 1
                            )
                    ) AS V2u_Integers_t ) AS V2u_20Ints_t
                  ) matching_scores

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
            LEFT JOIN v2u_dz_studenci studenci
                ON  (
                            studenci.indeks = students.student_index
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
            WHERE ma_oceny_j.student_id IS NULL
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
                , ( SELECT MAX(VALUE(t))
                    FROM TABLE(u.matching_scores) t
                  ) highest_score
            FROM u u
        )
        SELECT
              v.*
            , CASE
                WHEN v.os_id IS NULL
                THEN v.student_key || ' not found in v2u_dz_studenci'
                WHEN v.prot_id IS NULL
                THEN v.grade_key || ' not found in v2u_ko_matched_protos_j'
                WHEN v.highest_score IS NULL
                THEN v.grade_key || ' has no matching row in v2u_dz_oceny'
                WHEN v.highest_score = 0
                THEN v.grade_key || ' matched only rows of v2u_dz_oceny with matching_score = 0'
                WHEN v.highest_score > 0
                     AND
                     (  SELECT COUNT(*)
                        FROM TABLE(v.matching_scores) t
                        WHERE VALUE(t) <> 0 AND VALUE(t) = v.highest_score
                     ) > 1
                THEN v.grade_key || ' matched multiple rows of v2u_dz_oceny, all with matching_score = ' ||
                     (SELECT TO_CHAR(COUNT(*)) FROM TABLE(v.matching_scores)) ||
                    ' (ambiguity)'
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
        , matching_scores
        , highest_score
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
        , src.matching_scores
        , src.highest_score
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
        , tgt.matching_scores = src.matching_scores
        , tgt.highest_score = src.highest_score
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
