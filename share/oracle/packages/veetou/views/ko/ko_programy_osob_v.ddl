CREATE OR REPLACE VIEW v2u_ko_programy_osob_v
OF V2u_Ko_Program_Osoby_t
WITH OBJECT IDENTIFIER (id)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Program_Osoby_t(
                  id => j.id
                , student => VALUE(students)
                , specialty => VALUE(specialties)
                , program_osoby => VALUE(programy_osob)
                , semester_ids => j.semester_ids
            )
        FROM v2u_ko_programy_osob_j j
        INNER JOIN v2u_ko_students students
            ON (students.id = j.student_id AND
                students.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j.specialty_id AND
                specialties.job_uuid = j.job_uuid)
        INNER JOIN v2u_dz_programy_osob programy_osob
            ON (programy_osob.id = j.prgos_id)
    )
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
