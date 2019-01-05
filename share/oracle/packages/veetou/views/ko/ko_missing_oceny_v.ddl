CREATE OR REPLACE VIEW v2u_ko_missing_oceny_v
OF V2u_Ko_Missing_Ocena_V_t
WITH OBJECT IDENTIFIER  ( student_id
                        , subject_id
                        , specialty_id
                        , semester_id
                        , classes_type
                        , job_uuid
                        )
AS
    SELECT
          V2u_Ko_Missing_Ocena_V_t(
              missing_ocena_j => VALUE(mi_oceny_j)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , student => VALUE(students)
            , protokol => VALUE(protokoly)
        )
    FROM v2u_ko_missing_oceny_j mi_oceny_j
    INNER JOIN v2u_ko_students students
        ON  (
                    students.id = mi_oceny_j.student_id
                AND students.job_uuid = mi_oceny_j.job_uuid
            )
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = mi_oceny_j.subject_id
                AND subjects.job_uuid = mi_oceny_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = mi_oceny_j.specialty_id
                AND specialties.job_uuid = mi_oceny_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = mi_oceny_j.semester_id
                AND semesters.job_uuid = mi_oceny_j.job_uuid
            )
    LEFT JOIN v2u_dz_protokoly protokoly
        ON  (
                    protokoly.id = mi_oceny_j.prot_id
            )
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
