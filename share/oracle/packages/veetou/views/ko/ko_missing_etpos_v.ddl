CREATE OR REPLACE VIEW v2u_ko_missing_etpos_v
OF V2u_Ko_Missing_Etpos_V_t
WITH OBJECT IDENTIFIER (job_uuid, student_id, specialty_id, semester_id)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Missing_Etpos_V_t(
                  student => VALUE(students)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
                , ects_attained => student_semesters.ects_attained
                , tried_specialty_map_ids => j.tried_specialty_map_ids
                , prgos_ids_all_semesters => j.prgos_ids_all_semesters
                , all_etpos_ids_for_semester => j.all_etpos_ids_for_semester
                , tried_program_codes => j.tried_program_codes
                , all_etpos_progs_for_semester => j.all_etpos_progs_for_semester
            )
        FROM v2u_ko_missing_etpos_j j
        INNER JOIN v2u_ko_students students
            ON (students.id = j.student_id AND
                students.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j.specialty_id AND
                specialties.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j.semester_id AND
                semesters.job_uuid = j.job_uuid)
        LEFT JOIN v2u_ko_student_semesters_j student_semesters
            ON (student_semesters.student_id = j.student_id AND
                student_semesters.specialty_id = j.specialty_id AND
                student_semesters.semester_id = j.semester_id AND
                student_semesters.job_uuid = j.job_uuid)
    )
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
