CREATE OR REPLACE VIEW v2u_ko_student_semesters_v
OF V2u_Ko_Student_Semester_V_t
WITH OBJECT IDENTIFIER (job_uuid, student_id, specialty_id, semester_id)
AS
    SELECT
        V2u_Ko_Student_Semester_V_t(
              student => VALUE(students)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , ects_attained => j.ects_attained
        ) spec_sem
    FROM v2u_ko_students students
    INNER JOIN v2u_ko_student_semesters_j j
        ON  (
                    j.student_id = students.id
                AND j.job_uuid = students.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = j.specialty_id
                AND specialties.job_uuid = students.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = j.semester_id
                AND semesters.job_uuid = students.job_uuid
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
