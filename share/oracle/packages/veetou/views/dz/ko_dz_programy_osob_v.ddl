CREATE OR REPLACE VIEW v2u_ko_dz_programy_osob_v
OF V2u_Ko_Dz_Program_Osoby_t
WITH OBJECT IDENTIFIER (v2u_job_uuid, v2u_student_id, v2u_specialty_id, v2u_specialty_map_id, v2u_thread_index)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Dz_Program_Osoby_t(
                  student => VALUE(students)
                , specialty => VALUE(specialties)
                , specialty_map => VALUE(specialty_map)
                , program_osoby => VALUE(programy_osob)
                , semester_ids => threads.semester_ids
                , thread_id => threads.id
                , thread_index => threads.thread_index
                , max_admission_semester => threads.max_admission_semester
            )
        FROM v2u_ko_dz_programy_osob_j j
        INNER JOIN v2u_ko_student_threads_j threads
            ON (threads.id = j.v2u_thread_id AND
                threads.job_uuid = j.v2u_job_uuid)
        INNER JOIN v2u_ko_students students
            ON (students.id = threads.student_id AND
                students.job_uuid = threads.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = threads.specialty_id AND
                specialties.job_uuid = threads.job_uuid)
        INNER JOIN v2u_specialty_map specialty_map
            ON (specialty_map.id = threads.specialty_map_id)
        INNER JOIN v2u_dz_programy_osob programy_osob
            ON (programy_osob.id = j.dz_programy_osob_id)
    )
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
