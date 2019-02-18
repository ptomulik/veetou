CREATE OR REPLACE VIEW v2u_ko_missing_prgos_v
OF V2u_Ko_Missing_Prgos_V_t
WITH OBJECT IDENTIFIER (job_uuid, student_id, specialty_id, semester_id)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Missing_Prgos_V_t(
                  student => VALUE(students)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
                , ects_attained => ss_j.ects_attained
            )
        FROM v2u_ko_student_semesters_j ss_j
        INNER JOIN v2u_ko_missing_prgos_j mi_prgos_j
            ON  (
                        ss_j.student_id = mi_prgos_j.student_id
                    AND ss_j.specialty_id = mi_prgos_j.specialty_id
                    AND ss_j.semester_id = mi_prgos_j.semester_id
                    AND ss_j.job_uuid = mi_prgos_j.job_uuid
                )
        INNER JOIN v2u_ko_students students
            ON  (
                        students.id = mi_prgos_j.student_id
                    AND students.job_uuid = mi_prgos_j.job_uuid
                )
        INNER JOIN v2u_ko_specialties specialties
            ON  (
                        specialties.id = mi_prgos_j.specialty_id
                    AND specialties.job_uuid = mi_prgos_j.job_uuid
                )
        INNER JOIN v2u_ko_semesters semesters
            ON  (
                        semesters.id = mi_prgos_j.semester_id
                    AND semesters.job_uuid = mi_prgos_j.job_uuid
                )
    )
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
