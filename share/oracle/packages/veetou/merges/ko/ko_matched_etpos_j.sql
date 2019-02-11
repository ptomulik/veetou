MERGE INTO v2u_ko_matched_etpos_j tgt
USING
    (
        SELECT
              ss_j.job_uuid
            , ss_j.student_id
            , ss_j.specialty_id
            , ss_j.semester_id
            , sm_j.map_id specialty_map_id
            , etapy_osob.id etpos_id
            , studenci.id st_id
            , studenci.os_id os_id
            , programy_osob.id prgos_id
            , CASE
                WHEN
                    (SUBSTR(etapy_osob.etp_kod, 8, 1)
                   = TO_CHAR(semesters.semester_number, 'FM9'))
                THEN
                    NULL
                ELSE
                    '"' || etapy_osob.etp_kod
                    || '" !~ ' ||
                    TO_CHAR(semesters.semester_number, 'FM9')
              END etp_kod_missmatch
        FROM v2u_ko_student_semesters_j ss_j
        INNER JOIN v2u_ko_students students
            ON (students.id = ss_j.student_id AND
                students.job_uuid = ss_j.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = ss_j.semester_id AND
                semesters.job_uuid = ss_j.job_uuid)
        INNER JOIN v2u_ko_specialty_map_j sm_j
            ON (sm_j.specialty_id = ss_j.specialty_id AND
                sm_j.semester_id = ss_j.semester_id AND
                sm_j.job_uuid = ss_j.job_uuid)
        LEFT JOIN v2u_specialty_map specialty_map
            ON (specialty_map.id = sm_j.map_id)
        INNER JOIN v2u_dz_studenci studenci
            ON (studenci.indeks = students.student_index)
        INNER JOIN v2u_dz_programy_osob programy_osob
            ON (programy_osob.st_id = studenci.id AND
                programy_osob.os_id = studenci.os_id AND
                programy_osob.prg_kod = specialty_map.map_program_code)
        INNER JOIN v2u_dz_etapy_osob etapy_osob
            ON (etapy_osob.prgos_id = programy_osob.id AND
                etapy_osob.cdyd_kod = semesters.semester_code)
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.student_id = src.student_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.semester_id = src.semester_id)
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , student_id
        , specialty_id
        , semester_id
        , etpos_id
        , prgos_id
        , specialty_map_id
        , etp_kod_missmatch
        , st_id
        , os_id
        )
    VALUES
        ( src.job_uuid
        , src.student_id
        , src.specialty_id
        , src.semester_id
        , src.etpos_id
        , src.prgos_id
        , src.specialty_map_id
        , src.etp_kod_missmatch
        , src.st_id
        , src.os_id
        )
WHEN MATCHED THEN UPDATE SET
      tgt.etpos_id = src.etpos_id
    , tgt.prgos_id = src.prgos_id
    , tgt.specialty_map_id = src.specialty_map_id
    , tgt.etp_kod_missmatch = src.etp_kod_missmatch
    , tgt.st_id = src.st_id
    , tgt.os_id = src.os_id
;
-- vim: set ft=sql ts=4 sw=4 et:
