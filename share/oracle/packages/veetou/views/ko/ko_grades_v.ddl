CREATE OR REPLACE VIEW v2u_ko_grades_v
OF V2u_Ko_Grade_V_t
WITH OBJECT IDENTIFIER (job_uuid, student_id, subject_id, specialty_id, semester_id)
AS
    SELECT
        V2u_Ko_Grade_V_t(
              grade_j => VALUE(g_j)
            , student => VALUE(students)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
        )
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
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = g_j.specialty_id
                AND specialties.job_uuid = g_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = g_j.semester_id
                AND semesters.job_uuid = g_j.job_uuid
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
