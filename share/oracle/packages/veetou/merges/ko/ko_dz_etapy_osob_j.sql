MERGE INTO v2u_ko_dz_etapy_osob_j tgt
USING
    (
        SELECT
              j1.job_uuid job_uuid
            , j1.student_id student_id
            , j1.specialty_id specialty_id
            , j1.semester_id semester_id
            , j2.map_id specialty_map_id
            , etapy_osob.id etpos_id
        FROM v2u_ko_student_semesters_j j1
        INNER JOIN v2u_ko_students students
            ON (students.id = j1.student_id AND
                students.job_uuid = j1.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j1.semester_id AND
                semesters.job_uuid = j1.job_uuid)
        INNER JOIN v2u_ko_specialty_map_j j2
            ON (j2.specialty_id = j1.specialty_id AND
                j2.semester_id = j1.semester_id AND
                j2.job_uuid = j1.job_uuid)
        LEFT JOIN v2u_specialty_map specialty_map
            ON (specialty_map.id = j2.map_id)
        INNER JOIN v2u_dz_studenci studenci
            ON (studenci.indeks = students.student_index)
        INNER JOIN v2u_dz_programy_osob programy_osob
            ON (programy_osob.st_id = studenci.id AND
                programy_osob.os_id = studenci.os_id AND
                programy_osob.prg_kod = specialty_map.map_program_code)
        INNER JOIN v2u_dz_etapy_osob etapy_osob
            ON (etapy_osob.prgos_id = programy_osob.id AND
                etapy_osob.cdyd_kod = semesters.semester_code AND
                etapy_osob.etp_kod LIKE ('%-S' || TO_CHAR(semesters.semester_number, 'FM9') || '-%-%'))
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.student_id = src.student_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.semester_id = src.semester_id AND
     tgt.specialty_map_id = src.specialty_map_id AND
     tgt.etpos_id = src.etpos_id)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     student_id,     specialty_id,     semester_id,     specialty_map_id,     etpos_id)
    VALUES (src.job_uuid, src.student_id, src.specialty_id, src.semester_id, src.specialty_map_id, src.etpos_id)
;
-- vim: set ft=sql ts=4 sw=4 et:
