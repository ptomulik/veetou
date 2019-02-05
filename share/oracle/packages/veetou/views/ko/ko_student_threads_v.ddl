CREATE OR REPLACE VIEW v2u_ko_student_threads_v
OF V2u_Ko_Student_Thread_t
WITH OBJECT IDENTIFIER (job_uuid, student_id, specialty_id, specialty_map_id, thread_index)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Student_Thread_t(
                  VALUE(students)
                , VALUE(specialties)
                , VALUE(specialty_map)
                , j.semester_ids
                , j.thread_index
                , j.max_admission_semester
            )
        FROM v2u_ko_student_threads_j j
        INNER JOIN v2u_ko_students students
            ON (students.id = j.student_id AND
                students.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j.specialty_id AND
                specialties.job_uuid = j.job_uuid)
        INNER JOIN v2u_specialty_map specialty_map
            ON (specialty_map.id = j.specialty_map_id)
    )
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
