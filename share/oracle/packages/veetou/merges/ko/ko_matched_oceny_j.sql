MERGE INTO v2u_ko_matched_oceny_j tgt
USING
    (
        SELECT
              ma_trmpro_j.job_uuid
            , ma_trmpro_j.semester_id
            , ma_trmpro_j.specialty_id
            , ma_trmpro_j.subject_id
            , ma_etpos_j.student_id
            , ma_trmpro_j.classes_type
            , g_j.subj_grade
            , g_j.subj_grade_date
            , ma_etpos_j.os_id
            , ma_trmpro_j.prot_id
            , oceny.term_prot_nr
            , CASE
                WHEN g_j.ocena_opis <> wartosci_ocen.opis
                THEN '"' || g_j.ocena_opis || '" <> "' || wartosci_ocen.opis || '"'
                WHEN g_j.toc_kod <> oceny.toc_kod
                THEN '[' || g_j.toc_kod || '] <> [' || oceny.toc_kod || ']'
                ELSE NULL
              END ocena_missmatch

        FROM v2u_ko_grades_j g_j
        INNER JOIN v2u_ko_matched_trmpro_j ma_trmpro_j
            ON  (
                        ma_trmpro_j.subject_id = g_j.subject_id
                    AND ma_trmpro_j.specialty_id = g_j.specialty_id
                    AND ma_trmpro_j.semester_id = g_j.semester_id
                    AND ma_trmpro_j.job_uuid = g_j.job_uuid
                    AND ma_trmpro_j.classes_type = g_j.classes_type
                )
        INNER JOIN v2u_ko_matched_etpos_j ma_etpos_j
            ON  (
                        ma_etpos_j.student_id = g_j.student_id
                    AND ma_etpos_j.specialty_id = g_j.specialty_id
                    AND ma_etpos_j.semester_id = g_j.semester_id
                    AND ma_etpos_j.job_uuid = g_j.job_uuid
                )
        INNER JOIN v2u_semesters semesters
            ON  (
                        semesters.code = ma_trmpro_j.cdyd_kod
                )
        INNER JOIN v2u_dz_oceny oceny
            ON  (
                        oceny.os_id = ma_etpos_j.os_id
                    AND oceny.prot_id = ma_trmpro_j.prot_id
                    AND oceny.term_prot_nr = ma_trmpro_j.nr
                )
        INNER JOIN v2u_dz_wartosci_ocen wartosci_ocen
            ON  (
                        wartosci_ocen.toc_kod = oceny.toc_kod
                    AND wartosci_ocen.kolejnosc = oceny.wart_oc_kolejnosc
                )
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.classes_type = src.classes_type
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
        , os_id
        , prot_id
        , term_prot_nr
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
        , src.os_id
        , src.prot_id
        , src.term_prot_nr
        , src.ocena_missmatch
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subj_grade = src.subj_grade
        , tgt.subj_grade_date = src.subj_grade_date
        , tgt.os_id = src.os_id
        , tgt.prot_id = src.prot_id
        , tgt.term_prot_nr = src.term_prot_nr
        , tgt.ocena_missmatch = src.ocena_missmatch
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
