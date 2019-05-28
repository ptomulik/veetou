CREATE OR REPLACE VIEW v2u_ko_matched_oceny_v
OF V2u_Ko_Matched_Ocena_V_t
WITH OBJECT IDENTIFIER (
              subj_grade_date
            , classes_type
            , student_id
            , subject_id
            , specialty_id
            , semester_id
            , job_uuid
            )
AS
    SELECT
          V2u_Ko_Matched_Ocena_V_t(
              matched_ocena_j => VALUE(ma_oceny_j)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , student => VALUE(students)
            , protokol => VALUE(protokoly)
            , termin_protokolu => VALUE(terminy_protokolow)
            , ocena => VALUE(oceny)
            , wartosc_oceny => VALUE(wartosci_ocen)
        )
    FROM v2u_ko_matched_oceny_j ma_oceny_j
    INNER JOIN v2u_ko_students students
        ON  (
                    students.id = ma_oceny_j.student_id
                AND students.job_uuid = ma_oceny_j.job_uuid
            )
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = ma_oceny_j.subject_id
                AND subjects.job_uuid = ma_oceny_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = ma_oceny_j.specialty_id
                AND specialties.job_uuid = ma_oceny_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ma_oceny_j.semester_id
                AND semesters.job_uuid = ma_oceny_j.job_uuid
            )
    INNER JOIN v2u_dz_protokoly protokoly
        ON  (
                    protokoly.id = ma_oceny_j.prot_id
            )
    INNER JOIN v2u_dz_terminy_protokolow terminy_protokolow
        ON  (
                    terminy_protokolow.prot_id = ma_oceny_j.prot_id
                AND terminy_protokolow.nr = ma_oceny_j.term_prot_nr
            )
    INNER JOIN v2u_dz_oceny oceny
        ON  (
                    oceny.os_id = ma_oceny_j.os_id
                AND oceny.prot_id = ma_oceny_j.prot_id
                AND oceny.term_prot_nr = ma_oceny_j.term_prot_nr
            )
    INNER JOIN v2u_dz_wartosci_ocen wartosci_ocen
        ON  (
                    wartosci_ocen.toc_kod = oceny.toc_kod
                AND wartosci_ocen.kolejnosc = oceny.wart_oc_kolejnosc
            )
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
