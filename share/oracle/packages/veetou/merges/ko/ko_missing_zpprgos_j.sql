MERGE INTO v2u_ko_missing_zpprgos_j tgt
USING
    (
        WITH u AS (
            SELECT
                  g_j.job_uuid
                , g_j.semester_id
                , g_j.specialty_id
                , g_j.subject_id
                , g_j.student_id
                , subj_m_j.map_id subject_map_id
                , CAST(SET(CAST(
                    COLLECT(spec_m_j.map_id ORDER BY spec_m_j.map_id)
                    AS V2u_Ids_t
                  )) AS V2u_20Ids_t) specialty_map_ids
                , specialties.university
                , specialties.faculty
                , specialties.studies_modetier
                , specialties.studies_field
                , specialties.studies_specialty
                , semesters.semester_code
                , subjects.subj_code
                , subject_map.map_subj_code
                , SET(CAST(
                    COLLECT(specialty_map.map_program_code ORDER BY map_program_code)
                    AS V2u_Vchars1K_t
                  )) map_program_codes1k
                , students.student_index
                , studenci.os_id
                , CAST(SET(CAST(
                    COLLECT(programy_osob.id ORDER BY programy_osob.id)
                    AS V2u_Dz_Ids_t
                  )) AS V2u_Dz_20Ids_t) prgos_ids
                , CAST(SET(CAST(
                    COLLECT(etapy_osob.id ORDER BY etapy_osob.id)
                    AS V2u_Dz_Ids_t
                  )) AS V2u_Dz_20Ids_t) etpos_ids
                , CAST(SET(CAST(
                    COLLECT(zal_przedm_prgos.prgos_id ORDER BY zal_przedm_prgos.prgos_id)
                    AS V2u_Dz_Ids_t
                  )) AS V2u_Dz_20Ids_t) zal_przedm_prgos_ids

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
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = g_j.subject_id
                        AND subjects.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_students students
                ON  (
                            students.id = g_j.student_id
                        AND students.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_dz_studenci studenci
                ON  (
                            studenci.indeks = students.student_index
                    )
            INNER JOIN v2u_ko_specialties specialties
                ON  (
                            specialties.id = g_j.specialty_id
                        AND specialties.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_zpprgos_j ma_zpprgos_j
                ON  (
                            ma_zpprgos_j.student_id = g_j.student_id
                        AND ma_zpprgos_j.subject_id = g_j.subject_id
                        AND ma_zpprgos_j.specialty_id = g_j.specialty_id
                        AND ma_zpprgos_j.semester_id = g_j.semester_id
                        AND ma_zpprgos_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j subj_m_j
                ON  (
                            subj_m_j.subject_id = g_j.subject_id
                        AND subj_m_j.specialty_id = g_j.specialty_id
                        AND subj_m_j.semester_id = g_j.semester_id
                        AND subj_m_j.job_uuid = g_j.job_uuid
                        AND subj_m_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = subj_m_j.map_id
                    )
            LEFT JOIN v2u_ko_specialty_map_j spec_m_j
                ON  (
                            spec_m_j.specialty_id = g_j.specialty_id
                        AND spec_m_j.semester_id = g_j.semester_id
                        AND spec_m_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_specialty_map specialty_map
                ON  (
                            specialty_map.id = spec_m_j.map_id
                    )
            LEFT JOIN v2u_dz_programy_osob programy_osob
                ON  (
                            programy_osob.st_id = studenci.id
                        AND programy_osob.os_id = studenci.os_id
                        AND programy_osob.prg_kod = specialty_map.map_program_code
                        AND (semesters2.end_date > programy_osob.data_rozpoczecia)
                        AND (semesters2.start_date < (
                                    CASE
                                    WHEN programy_osob.status IN ('DYP', 'SKR')
                                    THEN programy_osob.plan_data_ukon
                                    ELSE GREATEST(CURRENT_DATE, programy_osob.plan_data_ukon)
                                    END
                                )
                            )
                    )
            LEFT JOIN v2u_dz_etapy_osob etapy_osob
                ON  (
                            etapy_osob.prgos_id = programy_osob.id
                        AND etapy_osob.cdyd_kod = semesters.semester_code
                    )
            LEFT JOIN v2u_dz_zal_przedm_prgos zal_przedm_prgos
                ON  (
                            zal_przedm_prgos.os_id = studenci.os_id
                        AND zal_przedm_prgos.cdyd_kod = semesters.semester_code
                        AND zal_przedm_prgos.prz_kod = subject_map.map_subj_code
                    )
            WHERE
                    ma_zpprgos_j.job_uuid IS NULL
            GROUP BY
                  g_j.job_uuid
                , g_j.semester_id
                , g_j.specialty_id
                , g_j.subject_id
                , g_j.student_id
                , subj_m_j.map_id
                , specialties.university
                , specialties.faculty
                , specialties.studies_modetier
                , specialties.studies_field
                , specialties.studies_specialty
                , semesters.semester_code
                , subjects.subj_code
                , subject_map.map_subj_code
                , students.student_index
                , studenci.os_id
        )
        SELECT
              u.job_uuid
            , u.semester_id
            , u.specialty_id
            , u.subject_id
            , u.student_id
            , u.subject_map_id
            , u.specialty_map_ids
            , u.semester_code
            , u.map_subj_code
--            , u.map_program_codes
            , u.os_id
            , CASE
                WHEN (SELECT COUNT(*) FROM TABLE(u.prgos_ids)) = 1
                THEN (SELECT VALUE(t) FROM TABLE(u.prgos_ids) t WHERE ROWNUM<=1)
                ELSE NULL
              END prgos_id
            , u.prgos_ids
            , CASE
                WHEN (SELECT COUNT(*) FROM TABLE(u.etpos_ids)) = 1
                THEN (SELECT VALUE(t) FROM TABLE(u.etpos_ids) t WHERE ROWNUM<=1)
                ELSE NULL
              END etpos_id
            , u.etpos_ids
            , CASE
                WHEN u.subject_map_id IS NULL
                THEN 'no subject_map for {subject: "' ||
                        u.subj_code
                    || '", semester: "' ||
                        u.semester_code
                    || '"}'
                WHEN u.map_subj_code IS NULL
                THEN 'map_subj_code IS NULL for {subject: "' ||
                        u.subj_code
                    || '", semester: "' ||
                        u.semester_code
                    || '"}'
                WHEN u.os_id IS NULL
                THEN  '{student: "' ||
                        u.student_index
                    || '"} not in v2u_dz_studenci'
                WHEN (SELECT COUNT(*) FROM TABLE(u.specialty_map_ids)) = 0
                THEN 'no specialty map for {university: "' ||
                        u.university
                    || '", faculty: "' ||
                        u.faculty
                    || '", studies_modetier: "' ||
                        u.studies_modetier
                    || '", studies_field: "' ||
                        u.studies_field
                    || '", studies_specialty: "' ||
                        u.studies_specialty
                    || '", semester: "' ||
                        u.semester_code
                    || '"}'
                WHEN (SELECT COUNT(*) FROM TABLE(u.map_program_codes1k)) = 0
                THEN 'all map_program_codes are NULL for {university: "' ||
                        u.university
                    || '", faculty: "' ||
                        u.faculty
                    || '", studies_modetier: "' ||
                        u.studies_modetier
                    || '", studies_field: "' ||
                        u.studies_field
                    || '", studies_specialty: "' ||
                        u.studies_specialty
                    || '", semester: "' ||
                        u.semester_code
                    || '"}'
                WHEN (SELECT COUNT(*) FROM TABLE(u.prgos_ids)) = 0
                THEN '{student: "' ||
                        u.student_index
                    || '", programs: "' ||
                        (SELECT LISTAGG(VALUE(t), ', ') WITHIN GROUP (ORDER BY VALUE(t))
                         FROM TABLE(u.map_program_codes1k) t)
                    || '", semester: "' ||
                        u.semester_code
                    || '"} not in v2u_dz_programy_osob'
                WHEN (SELECT COUNT(*) FROM TABLE(u.zal_przedm_prgos_ids)) = 0
                THEN '{student: "' ||
                        u.student_index
                    || '", subject: "' ||
                        u.map_subj_code
                    || '", programs: "' ||
                        (SELECT LISTAGG(VALUE(t), ', ') WITHIN GROUP (ORDER BY VALUE(t))
                         FROM TABLE(u.map_program_codes1k) t)
                    || '", semester: "' ||
                        u.semester_code
                    || '"} not in v2u_dz_zal_przedm_prgos'
                ELSE 'error (v2u_ko_matched_zpprgos_j out of sync?)'
              END reason
        FROM u u
    ) src
ON  (
            tgt.student_id = src.student_id
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , subject_id
        , student_id
        , subject_map_id
        , specialty_map_ids
        , semester_code
        , map_subj_code
        , os_id
        , prgos_id
        , prgos_ids
        , etpos_id
        , etpos_ids
        , reason
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.student_id
        , src.subject_map_id
        , src.specialty_map_ids
        , src.semester_code
        , src.map_subj_code
        , src.os_id
        , src.prgos_id
        , src.prgos_ids
        , src.etpos_id
        , src.etpos_ids
        , src.reason
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.specialty_map_ids = src.specialty_map_ids
        , tgt.semester_code = src.semester_code
        , tgt.map_subj_code = src.map_subj_code
        , tgt.os_id = src.os_id
        , tgt.prgos_id = src.prgos_id
        , tgt.prgos_ids = src.prgos_ids
        , tgt.etpos_id = src.etpos_id
        , tgt.etpos_ids = src.etpos_ids
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
