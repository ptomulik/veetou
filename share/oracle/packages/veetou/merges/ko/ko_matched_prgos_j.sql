MERGE INTO v2u_ko_matched_prgos_j tgt
USING
    (
        SELECT
              ss_j.job_uuid
            , ss_j.semester_id
            , ss_j.specialty_id
            , ss_j.student_id
            , ss_j.ects_attained
            , sm_j.map_id specialty_map_id
            , programy_osob.id prgos_id
            , programy_osob.prg_kod
            , programy_osob.st_id
            , programy_osob.os_id
        FROM v2u_ko_student_semesters_j ss_j
        INNER JOIN v2u_ko_students students
            ON  (
                        students.id = ss_j.student_id
                    AND students.job_uuid = ss_j.job_uuid
                )
        INNER JOIN v2u_ko_semesters semesters
            ON  (
                        semesters.id = ss_j.semester_id
                    AND semesters.job_uuid = ss_j.job_uuid
                )
        LEFT JOIN v2u_semesters semesters2
            ON  (
                        semesters2.code = semesters.semester_code
                )
        INNER JOIN v2u_ko_specialty_map_j sm_j
            ON  (
                        sm_j.specialty_id = ss_j.specialty_id
                    AND sm_j.semester_id = ss_j.semester_id
                    AND sm_j.job_uuid = ss_j.job_uuid
                )
        INNER JOIN v2u_specialty_map specialty_map
            ON  (
                       specialty_map.id = sm_j.map_id
                )
        INNER JOIN v2u_dz_studenci studenci
            ON  (
                        studenci.indeks = students.student_index
                )
        INNER JOIN v2u_dz_programy_osob programy_osob
            ON  (
                        programy_osob.st_id = studenci.id
                    AND programy_osob.os_id = studenci.os_id
                    AND programy_osob.prg_kod = specialty_map.map_program_code
                )
        WHERE
                (semesters2.end_date > programy_osob.data_rozpoczecia)
            AND (semesters2.start_date < (
                        CASE
                        WHEN programy_osob.status IN ('DYP', 'SKR')
                        THEN programy_osob.plan_data_ukon
                        ELSE GREATEST(CURRENT_DATE, programy_osob.plan_data_ukon)
                        END
                    )
                )
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.semester_id = src.semester_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.student_id = src.student_id
        AND tgt.prgos_id = src.prgos_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , student_id
        , ects_attained
        , specialty_map_id
        , prgos_id
        , prg_kod
        , st_id
        , os_id
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.student_id
        , src.ects_attained
        , src.specialty_map_id
        , src.prgos_id
        , src.prg_kod
        , src.st_id
        , src.os_id
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.ects_attained = src.ects_attained
        , tgt.specialty_map_id = src.specialty_map_id
        , tgt.prg_kod = src.prg_kod
        , tgt.st_id = src.st_id
        , tgt.os_id = src.os_id
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
