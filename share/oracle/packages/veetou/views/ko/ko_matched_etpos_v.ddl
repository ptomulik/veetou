CREATE OR REPLACE VIEW v2u_ko_matched_etpos_v
OF V2u_Ko_Matched_Etpos_V_t
WITH OBJECT IDENTIFIER (student_id, specialty_id, semester_id, job_uuid)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Matched_Etpos_V_t(
                  student => VALUE(students)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
                , specialty_map => VALUE(specialty_map)
                , etap_osoby => VALUE(etapy_osob)
                , program_osoby => VALUE(programy_osob)
                , etp_kod_missmatch => me_j.etp_kod_missmatch
                , st_id => me_j.st_id
                , os_id => me_j.os_id
            )
        FROM v2u_ko_matched_etpos_j me_j
        INNER JOIN v2u_ko_students students
            ON (students.id = me_j.student_id AND
                students.job_uuid = me_j.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = me_j.specialty_id AND
                specialties.job_uuid = me_j.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = me_j.semester_id AND
                semesters.job_uuid = me_j.job_uuid)
        INNER JOIN v2u_specialty_map specialty_map
            ON (specialty_map.id = me_j.specialty_map_id)
        INNER JOIN v2u_dz_etapy_osob etapy_osob
            ON (etapy_osob.id = me_j.etpos_id)
        INNER JOIN v2u_dz_programy_osob programy_osob
            ON (programy_osob.id = me_j.prgos_id)
    )
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
