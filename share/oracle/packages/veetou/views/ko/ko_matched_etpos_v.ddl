CREATE OR REPLACE VIEW v2u_ko_matched_etpos_v
OF V2u_Ko_Matched_Etpos_V_t
WITH OBJECT IDENTIFIER (etpos_id, student_id, specialty_id, semester_id, job_uuid)
AS
    SELECT
          V2u_Ko_Matched_Etpos_V_t(
              student => VALUE(students)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , ects_attained => ma_etpos_j.ects_attained
            , specialty_map_id => ma_etpos_j.specialty_map_id
            , etap_osoby => VALUE(etapy_osob)
            , etp_kod_missmatch => ma_etpos_j.etp_kod_missmatch
            )
    FROM v2u_ko_matched_etpos_j ma_etpos_j
    INNER JOIN v2u_ko_students students
        ON  (
                    students.id = ma_etpos_j.student_id
                AND students.job_uuid = ma_etpos_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = ma_etpos_j.specialty_id
                AND specialties.job_uuid = ma_etpos_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ma_etpos_j.semester_id
                AND semesters.job_uuid = ma_etpos_j.job_uuid
            )
    INNER JOIN v2u_dz_etapy_osob etapy_osob
        ON  (
                    etapy_osob.id = ma_etpos_j.etpos_id
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
