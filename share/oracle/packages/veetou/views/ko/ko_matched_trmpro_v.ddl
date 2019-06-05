CREATE OR REPLACE VIEW v2u_ko_matched_trmpro_v
OF V2u_Ko_Matched_Trmpro_V_t
WITH OBJECT IDENTIFIER (prot_id, nr, subject_id, specialty_id, semester_id, job_uuid)
AS
    SELECT
          V2u_Ko_Matched_Trmpro_V_t(
              matched_trmpro_j => VALUE(ma_trmpro_j)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , student => VALUE(students)
            , protokol => VALUE(protokoly)
            , termin_protokolu => VALUE(terminy_protokolow)
        )
    FROM v2u_ko_matched_trmpro_j ma_trmpro_j
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = ma_trmpro_j.subject_id
                AND subjects.job_uuid = ma_trmpro_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = ma_trmpro_j.specialty_id
                AND specialties.job_uuid = ma_trmpro_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ma_trmpro_j.semester_id
                AND semesters.job_uuid = ma_trmpro_j.job_uuid
            )
    INNER JOIN v2u_ko_students students
        ON  (
                    students.id = ma_trmpro_j.student_id
                AND students.job_uuid = ma_trmpro_j.job_uuid
            )
    INNER JOIN v2u_dz_terminy_protokolow terminy_protokolow
        ON  (
                    terminy_protokolow.prot_id = ma_trmpro_j.prot_id
                AND terminy_protokolow.nr = ma_trmpro_j.nr
            )
    LEFT JOIN v2u_dz_protokoly protokoly
        ON  (
                protokoly.id = ma_trmpro_j.prot_id
            )
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
