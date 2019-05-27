MERGE INTO v2u_ko_matched_oceny_j tgt
USING
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
                        ma_protos_j.subject_id = g_j.subject_id
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
                    --AND oceny.term_prot_nr = ma_protos_j.nr
                )
        INNER JOIN v2u_dz_wartosci_ocen wartosci_ocen
            ON  (
                        wartosci_ocen.toc_kod = oceny.toc_kod
                    AND wartosci_ocen.kolejnosc = oceny.wart_oc_kolejnosc
                )
        WHERE g_j.subj_grade_date IS NOT NULL
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.classes_type = src.classes_type
        AND tgt.subj_grade_date = src.subj_grade_date
        AND tgt.student_id = src.student_id
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
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subj_grade = src.subj_grade
        , tgt.map_subj_grade = src.map_subj_grade
        , tgt.map_subj_grade_type = src.map_subj_grade_type
        , tgt.os_id = src.os_id
        , tgt.prot_id = src.prot_id
        , tgt.term_prot_nr = src.term_prot_nr
        , tgt.opis = src.opis
        , tgt.ocena_missmatch = src.ocena_missmatch
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
