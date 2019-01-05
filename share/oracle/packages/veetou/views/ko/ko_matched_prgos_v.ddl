CREATE OR REPLACE VIEW v2u_ko_matched_prgos_v
OF V2u_Ko_Matched_Prgos_V_t
WITH OBJECT IDENTIFIER (prgos_id, student_id, specialty_id, semester_id, job_uuid)
AS
    SELECT
          V2u_Ko_Matched_Prgos_V_t(
              student => VALUE(students)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , ects_attained => ma_prgos_j.ects_attained
            , program_osoby => VALUE(programy_osob)
            )
    FROM v2u_ko_matched_prgos_j ma_prgos_j
    INNER JOIN v2u_ko_students students
        ON  (
                    students.id = ma_prgos_j.student_id
                AND students.job_uuid = ma_prgos_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = ma_prgos_j.specialty_id
                AND specialties.job_uuid = ma_prgos_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ma_prgos_j.semester_id
                AND semesters.job_uuid = ma_prgos_j.job_uuid
            )
    INNER JOIN v2u_dz_programy_osob programy_osob
        ON  (
                    programy_osob.id = ma_prgos_j.prgos_id
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
