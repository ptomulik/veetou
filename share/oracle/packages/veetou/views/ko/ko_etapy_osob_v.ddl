CREATE OR REPLACE VIEW v2u_ko_etapy_osob_v
OF V2u_Ko_Etap_Osoby_t
WITH OBJECT IDENTIFIER (id)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Etap_Osoby_t(
                  id => j.id
                , student => VALUE(students)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
                , specialty_map => VALUE(specialty_map)
                , etap_osoby => VALUE(etapy_osob)
                , semester_number_missmatch => j.semester_number_missmatch
            )
        FROM v2u_ko_etapy_osob_j j
        INNER JOIN v2u_ko_students students
            ON (students.id = j.student_id AND
                students.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j.specialty_id AND
                specialties.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j.semester_id AND
                semesters.job_uuid = j.job_uuid)
        INNER JOIN v2u_specialty_map specialty_map
            ON (specialty_map.id = j.specialty_map_id)
        INNER JOIN v2u_dz_etapy_osob etapy_osob
            ON (etapy_osob.id = j.etpos_id)
    )
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
