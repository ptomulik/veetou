MERGE INTO v2u_ko_matched_zpprgos_j tgt
USING
    (
        SELECT
              g_j.job_uuid
            , g_j.semester_id
            , g_j.specialty_id
            , g_j.subject_id
            , g_j.student_id
            , subject_map.id subject_map_id
            , specialty_map.id specialty_map_id
            , studenci.id st_id
            , zal_przedm_prgos.os_id
            , zal_przedm_prgos.cdyd_kod
            , zal_przedm_prgos.prz_kod
            , programy_osob.id prgos_id
            , etapy_osob.id etpos_id

        FROM v2u_ko_grades_j g_j
        INNER JOIN v2u_ko_semesters semesters
            ON  (
                        semesters.id = g_j.semester_id
                    AND semesters.job_uuid = g_j.job_uuid
                )
        LEFT JOIN v2u_semesters semesters2
            ON  (
                        semesters2.code = semesters.semester_code
                )
        INNER JOIN v2u_ko_students students
            ON  (
                        students.id = g_j.student_id
                    AND students.job_uuid = g_j.job_uuid
                )
        INNER JOIN v2u_dz_studenci studenci
            ON  (
                        studenci.indeks = students.student_index
                )
        INNER JOIN v2u_ko_specialty_map_j spec_m_j
            ON  (
                        spec_m_j.specialty_id = g_j.specialty_id
                    AND spec_m_j.semester_id = g_j.semester_id
                    AND spec_m_j.job_uuid = g_j.job_uuid
                )
        INNER JOIN v2u_specialty_map specialty_map
            ON  (
                        specialty_map.id = spec_m_j.map_id
                )
        INNER JOIN v2u_dz_programy_osob programy_osob
            ON  (
                        programy_osob.st_id = studenci.id
                    AND programy_osob.os_id = studenci.os_id
                    AND programy_osob.prg_kod = specialty_map.map_program_code
                )
        LEFT JOIN v2u_dz_etapy_osob etapy_osob
            ON  (
                        etapy_osob.prgos_id = programy_osob.id
                    AND etapy_osob.cdyd_kod = semesters.semester_code
                )
        INNER JOIN v2u_ko_subject_map_j subj_m_j
            ON  (
                        subj_m_j.subject_id = g_j.subject_id
                    AND subj_m_j.specialty_id = g_j.specialty_id
                    AND subj_m_j.semester_id = g_j.semester_id
                    AND subj_m_j.job_uuid = g_j.job_uuid
                    AND subj_m_j.selected = 1
                )
        INNER JOIN v2u_subject_map subject_map
            ON  (
                        subject_map.id = subj_m_j.map_id
                    AND subject_map.map_subj_code IS NOT NULL
                )
        INNER JOIN v2u_dz_zal_przedm_prgos zal_przedm_prgos
            ON  (
                        zal_przedm_prgos.os_id = studenci.os_id
                    AND zal_przedm_prgos.prz_kod = subject_map.map_subj_code
                    AND zal_przedm_prgos.cdyd_kod = semesters.semester_code
                    AND zal_przedm_prgos.prgos_id = programy_osob.id
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
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.student_id = src.student_id
        AND tgt.os_id = src.os_id
        AND tgt.cdyd_kod = src.cdyd_kod
        AND tgt.prz_kod = src.prz_kod
        AND tgt.prgos_id = src.prgos_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , subject_id
        , student_id
        , subject_map_id
        , specialty_map_id
        , st_id
        , os_id
        , cdyd_kod
        , prz_kod
        , prgos_id
        , etpos_id
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.student_id
        , src.subject_map_id
        , src.specialty_map_id
        , src.st_id
        , src.os_id
        , src.cdyd_kod
        , src.prz_kod
        , src.prgos_id
        , src.etpos_id
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.specialty_map_id = src.specialty_map_id
        , tgt.st_id = src.st_id
        , tgt.etpos_id = src.etpos_id
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
