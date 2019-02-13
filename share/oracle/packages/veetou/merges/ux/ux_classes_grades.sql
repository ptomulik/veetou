MERGE INTO v2u_ux_classes_grades tgt
USING
    (
        SELECT
              g_j.job_uuid v2u_job_uuid
            , g_j.student_id v2u_student_id
            , g_j.subject_id v2u_subject_id
            , g_j.specialty_id v2u_specialty_id
            , g_j.semester_id v2u_semester_id
            , COALESCE(cm_j.classes_type, '?') v2u_classes_type
            , classes_map.map_classes_type v2u_map_classes_type
            , cm_j.classes_hours v2u_classes_hours
            , students.student_index v2u_student_index
            , students.student_name v2u_student_name
            , students.first_name v2u_first_name
            , students.last_name v2u_last_name
            , subjects.subj_code v2u_subj_code
            , subject_map.map_subj_code v2u_map_subj_code
            , subjects.subj_name v2u_subj_name
            , subjects.subj_hours_w v2u_subj_hours_w
            , subjects.subj_hours_c v2u_subj_hours_c
            , subjects.subj_hours_l v2u_subj_hours_l
            , subjects.subj_hours_p v2u_subj_hours_p
            , subjects.subj_hours_s v2u_subj_hours_s
            , subjects.subj_credit_kind v2u_subj_credit_kind
            , subjects.subj_ects v2u_subj_ects
            , subjects.subj_tutor v2u_subj_tutor
            , g_j.subj_grade v2u_subj_grade
            , g_j.subj_grade_date v2u_subj_grade_date
            , specialties.university v2u_university
            , specialties.faculty v2u_faculty
            , specialties.studies_modetier v2u_studies_modetier
            , specialties.studies_field v2u_studies_field
            , specialties.studies_specialty v2u_studies_specialty
            , semesters.semester_code v2u_semester_code
            , semesters.semester_number v2u_semester_number
            , semesters.ects_mandatory v2u_ects_mandatory
            , semesters.ects_other v2u_ects_other
            , semesters.ects_total v2u_ects_total
            -- FIXME: this should really come from some prebuilt map...
            , V2u_Get.Tpro_Kod(
                  subj_credit_kind => subjects.subj_credit_kind
                , subj_grades => V2u_Subj_Grades_t(g_j.subj_grade)
--                            CAST(COLLECT(g_j.subj_grade)
--                                 OVER (PARTITION BY
--                                          g_j.subject_id
--                                        , g_j.specialty_id
--                                        , g_j.semester_id
--                                        , g_j.job_uuid)
--                            AS V2u_Vchars1024_t)
              ) v2u_tpro_kod
            --, 'FIX' v2u_tpro_kod
            -- USOS
            -- FIXME: os_id should come from dz_studenci
            , ma_etpos_j.os_id os_id
            -- FIXME: st_id should come from dz_studenci
            , ma_etpos_j.st_id st_id
            , ma_etpos_j.etpos_id
            , ma_etpos_j.prgos_id
            , etapy_osob.prg_kod
            , etapy_osob.etp_kod
            , ma_przcykl_j.cdyd_kod cdyd_kod
            , COALESCE(
                      zajecia_cykli.tpro_kod
                    , przedmioty_cykli.tpro_kod
                    , przedmioty.tpro_kod
              ) tpro_kod
            , ma_przedm_j.prz_kod
            , ma_zajcykl_j.tzaj_kod

            -- DBG
            , COUNT (DISTINCT cm_j.classes_type)
                OVER (PARTITION BY
                          g_j.job_uuid
                        , g_j.student_id
                        , g_j.subject_id
                        , g_j.specialty_id
                        , g_j.semester_id)
              dbg_classes_type
            , COUNT (DISTINCT ma_etpos_j.os_id)
                OVER (PARTITION BY
                          g_j.job_uuid
                        , g_j.student_id
                        , g_j.subject_id
                        , g_j.specialty_id
                        , g_j.semester_id)
              dbg_os_id
            , COUNT (DISTINCT ma_etpos_j.st_id)
                OVER (PARTITION BY
                          g_j.job_uuid
                        , g_j.student_id
                        , g_j.subject_id
                        , g_j.specialty_id
                        , g_j.semester_id)
              dbg_st_id
            , COUNT (DISTINCT ma_etpos_j.etpos_id)
                OVER (PARTITION BY
                          g_j.job_uuid
                        , g_j.student_id
                        , g_j.subject_id
                        , g_j.specialty_id
                        , g_j.semester_id)
              dbg_etpos_id
            , COUNT (DISTINCT ma_etpos_j.prgos_id)
                OVER (PARTITION BY
                          g_j.job_uuid
                        , g_j.student_id
                        , g_j.subject_id
                        , g_j.specialty_id
                        , g_j.semester_id)
              dbg_prgos_id
            , COUNT (DISTINCT etapy_osob.prg_kod)
                OVER (PARTITION BY
                          g_j.job_uuid
                        , g_j.student_id
                        , g_j.subject_id
                        , g_j.specialty_id
                        , g_j.semester_id)
              dbg_prg_kod
            , COUNT (DISTINCT etapy_osob.etp_kod)
                OVER (PARTITION BY
                          g_j.job_uuid
                        , g_j.student_id
                        , g_j.subject_id
                        , g_j.specialty_id
                        , g_j.semester_id)
              dbg_etp_kod
            , COUNT (DISTINCT ma_przcykl_j.cdyd_kod)
                OVER (PARTITION BY
                          g_j.job_uuid
                        , g_j.student_id
                        , g_j.subject_id
                        , g_j.specialty_id
                        , g_j.semester_id)
              dbg_cdyd_kod
            , COUNT (DISTINCT ma_przedm_j.prz_kod)
                OVER (PARTITION BY
                          g_j.job_uuid
                        , g_j.student_id
                        , g_j.subject_id
                        , g_j.specialty_id
                        , g_j.semester_id)
              dbg_prz_kod
            , COUNT (DISTINCT ma_zajcykl_j.tzaj_kod)
                OVER (PARTITION BY
                          g_j.job_uuid
                        , g_j.student_id
                        , g_j.subject_id
                        , g_j.specialty_id
                        , g_j.semester_id)
              dbg_tzaj_kod
        FROM v2u_ko_grades_j g_j
        INNER JOIN v2u_ko_students students
            ON (g_j.student_id = students.id AND
                g_j.job_uuid = students.job_uuid)
        INNER JOIN v2u_ko_subjects subjects
            ON (g_j.subject_id = subjects.id AND
                g_j.job_uuid = subjects.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (g_j.specialty_id = specialties.id AND
                g_j.job_uuid = specialties.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (g_j.semester_id = semesters.id AND
                g_j.job_uuid = semesters.job_uuid)
        LEFT JOIN v2u_ko_classes_map_j cm_j
            ON (cm_j.semester_id = g_j.semester_id AND
                cm_j.specialty_id = g_j.specialty_id AND
                cm_j.subject_id = g_j.subject_id AND
                cm_j.job_uuid = g_j.job_uuid AND
                cm_j.selected = 1)
        -- FIXME: add 'map_classes_type' attribute to v2u_classes_map_j and get
        --        rid of this join
        LEFT JOIN v2u_classes_map classes_map
            ON (classes_map.id = cm_j.map_id)
        LEFT JOIN v2u_ko_subject_map_j sm_j
            ON (sm_j.subject_id = g_j.subject_id AND
                sm_j.specialty_id = g_j.specialty_id AND
                sm_j.semester_id = g_j.semester_id AND
                sm_j.job_uuid = g_j.job_uuid AND
                sm_j.selected = 1)
        -- FIXME: add 'map_subj_code' attribute to v2u_subject_map_j and get
        --        rid of this join
        LEFT JOIN v2u_subject_map subject_map
            ON (subject_map.id = sm_j.map_id)
        LEFT JOIN v2u_ko_matched_etpos_j ma_etpos_j
            ON (ma_etpos_j.semester_id = g_j.semester_id AND
                ma_etpos_j.specialty_id = g_j.specialty_id AND
                ma_etpos_j.student_id = g_j.student_id AND
                ma_etpos_j.job_uuid = g_j.job_uuid)
        -- FIXME: add 'prg_kod' attribute to v2u_matched_etpos_j and get
        --        rid of this join
        LEFT JOIN v2u_dz_etapy_osob etapy_osob
            ON (etapy_osob.id = ma_etpos_j.etpos_id)
--        LEFT JOIN v2u_ko_matched_prgos_j ma_prgos_j
--            ON (ma_prgos_j.student_id = g_j.student_id AND
--                ma_prgos_j.specialty_id = g_j.specialty_id AND
--                ma_prgos_j.semester_id = g_j.semester_id AND
--                ma_prgos_j.job_uuid = g_j.job_uuid )
--        -- FIXME: add 'prg_kod' attribute to v2u_matched_prgos_j and get
--        --        rid of this join
--        LEFT JOIN v2u_dz_programy_osob programy_osob
--            ON (programy_osob.id = ma_prgos_j.prgos_id)
        LEFT JOIN v2u_ko_matched_przedm_j ma_przedm_j
            ON (ma_przedm_j.subject_id = g_j.subject_id AND
                ma_przedm_j.specialty_id = g_j.specialty_id AND
                ma_przedm_j.semester_id = g_j.semester_id AND
                ma_przedm_j.job_uuid = g_j.job_uuid)
        LEFT JOIN v2u_dz_przedmioty przedmioty
            ON (ma_przedm_j.prz_kod = przedmioty.kod)
        LEFT JOIN v2u_ko_matched_przcykl_j ma_przcykl_j
            ON (ma_przcykl_j.subject_id = g_j.subject_id AND
                ma_przcykl_j.specialty_id = g_j.specialty_id AND
                ma_przcykl_j.semester_id = g_j.semester_id AND
                ma_przcykl_j.job_uuid = g_j.job_uuid)
        LEFT JOIN v2u_dz_przedmioty_cykli przedmioty_cykli
            ON (ma_przcykl_j.prz_kod = przedmioty_cykli.prz_kod AND
                ma_przcykl_j.cdyd_kod = przedmioty_cykli.cdyd_kod)
        LEFT JOIN v2u_ko_matched_zajcykl_j ma_zajcykl_j
            ON (ma_zajcykl_j.subject_id = g_j.subject_id AND
                ma_zajcykl_j.specialty_id = g_j.specialty_id AND
                ma_zajcykl_j.semester_id = g_j.semester_id AND
                ma_zajcykl_j.classes_type = cm_j.classes_type)
        LEFT JOIN v2u_dz_zajecia_cykli zajecia_cykli
            ON (ma_zajcykl_j.zajcykl_id = zajecia_cykli.id)
    ) src
ON  ( tgt.v2u_job_uuid = src.v2u_job_uuid AND
      tgt.v2u_student_id = src.v2u_student_id AND
      tgt.v2u_subject_id = src.v2u_subject_id AND
      tgt.v2u_specialty_id = src.v2u_specialty_id AND
      tgt.v2u_semester_id = src.v2u_semester_id AND
      tgt.v2u_classes_type = src.v2u_classes_type )
WHEN NOT MATCHED THEN
    INSERT
        ( v2u_job_uuid
        , v2u_student_id
        , v2u_subject_id
        , v2u_specialty_id
        , v2u_semester_id
        , v2u_classes_type
        , v2u_map_classes_type
        , v2u_classes_hours
        , v2u_student_index
        , v2u_student_name
        , v2u_first_name
        , v2u_last_name
        , v2u_subj_code
        , v2u_map_subj_code
        , v2u_subj_name
        , v2u_subj_hours_w
        , v2u_subj_hours_c
        , v2u_subj_hours_l
        , v2u_subj_hours_p
        , v2u_subj_hours_s
        , v2u_subj_credit_kind
        , v2u_subj_ects
        , v2u_subj_tutor
        , v2u_subj_grade
        , v2u_subj_grade_date
        , v2u_university
        , v2u_faculty
        , v2u_studies_modetier
        , v2u_studies_field
        , v2u_studies_specialty
        , v2u_semester_code
        , v2u_semester_number
        , v2u_ects_mandatory
        , v2u_ects_other
        , v2u_ects_total
        , v2u_tpro_kod
        -- USOS
        , os_id
        , st_id
        , etpos_id
        , prgos_id
        , prg_kod
        , etp_kod
        , cdyd_kod
        , tpro_kod
        , prz_kod
        , tzaj_kod
        -- DBG
        , dbg_classes_type
        , dbg_os_id
        , dbg_st_id
        , dbg_etpos_id
        , dbg_prgos_id
        , dbg_prg_kod
        , dbg_etp_kod
        , dbg_cdyd_kod
        , dbg_prz_kod
        , dbg_tzaj_kod
        )
    VALUES
        ( src.v2u_job_uuid
        , src.v2u_student_id
        , src.v2u_subject_id
        , src.v2u_specialty_id
        , src.v2u_semester_id
        , src.v2u_classes_type
        , src.v2u_map_classes_type
        , src.v2u_classes_hours
        , src.v2u_student_index
        , src.v2u_student_name
        , src.v2u_first_name
        , src.v2u_last_name
        , src.v2u_subj_code
        , src.v2u_map_subj_code
        , src.v2u_subj_name
        , src.v2u_subj_hours_w
        , src.v2u_subj_hours_c
        , src.v2u_subj_hours_l
        , src.v2u_subj_hours_p
        , src.v2u_subj_hours_s
        , src.v2u_subj_credit_kind
        , src.v2u_subj_ects
        , src.v2u_subj_tutor
        , src.v2u_subj_grade
        , src.v2u_subj_grade_date
        , src.v2u_university
        , src.v2u_faculty
        , src.v2u_studies_modetier
        , src.v2u_studies_field
        , src.v2u_studies_specialty
        , src.v2u_semester_code
        , src.v2u_semester_number
        , src.v2u_ects_mandatory
        , src.v2u_ects_other
        , src.v2u_ects_total
        , src.v2u_tpro_kod
        -- USOS
        , src.os_id
        , src.st_id
        , src.etpos_id
        , src.prgos_id
        , src.prg_kod
        , src.etp_kod
        , src.cdyd_kod
        , src.tpro_kod
        , src.prz_kod
        , src.tzaj_kod
        -- DBG
        , src.dbg_classes_type
        , src.dbg_os_id
        , src.dbg_st_id
        , src.dbg_etpos_id
        , src.dbg_prgos_id
        , src.dbg_prg_kod
        , src.dbg_etp_kod
        , src.dbg_cdyd_kod
        , src.dbg_prz_kod
        , src.dbg_tzaj_kod
        )
WHEN MATCHED THEN UPDATE SET
          tgt.v2u_map_classes_type = src.v2u_map_classes_type
        , tgt.v2u_classes_hours = src.v2u_classes_hours
        , tgt.v2u_student_index = src.v2u_student_index
        , tgt.v2u_student_name = src.v2u_student_name
        , tgt.v2u_first_name = src.v2u_first_name
        , tgt.v2u_last_name = src.v2u_last_name
        , tgt.v2u_subj_code = src.v2u_subj_code
        , tgt.v2u_map_subj_code = src.v2u_map_subj_code
        , tgt.v2u_subj_name = src.v2u_subj_name
        , tgt.v2u_subj_hours_w = src.v2u_subj_hours_w
        , tgt.v2u_subj_hours_c = src.v2u_subj_hours_c
        , tgt.v2u_subj_hours_l = src.v2u_subj_hours_l
        , tgt.v2u_subj_hours_p = src.v2u_subj_hours_p
        , tgt.v2u_subj_hours_s = src.v2u_subj_hours_s
        , tgt.v2u_subj_credit_kind = src.v2u_subj_credit_kind
        , tgt.v2u_subj_ects = src.v2u_subj_ects
        , tgt.v2u_subj_tutor = src.v2u_subj_tutor
        , tgt.v2u_subj_grade = src.v2u_subj_grade
        , tgt.v2u_subj_grade_date = src.v2u_subj_grade_date
        , tgt.v2u_university = src.v2u_university
        , tgt.v2u_faculty = src.v2u_faculty
        , tgt.v2u_studies_modetier = src.v2u_studies_modetier
        , tgt.v2u_studies_field = src.v2u_studies_field
        , tgt.v2u_studies_specialty = src.v2u_studies_specialty
        , tgt.v2u_semester_code = src.v2u_semester_code
        , tgt.v2u_semester_number = src.v2u_semester_number
        , tgt.v2u_ects_mandatory = src.v2u_ects_mandatory
        , tgt.v2u_ects_other = src.v2u_ects_other
        , tgt.v2u_ects_total = src.v2u_ects_total
        , tgt.v2u_tpro_kod = src.v2u_tpro_kod
        -- USOS
        , tgt.os_id = src.os_id
        , tgt.st_id = src.st_id
        , tgt.etpos_id = src.etpos_id
        , tgt.prgos_id = src.prgos_id
        , tgt.prg_kod = src.prg_kod
        , tgt.etp_kod = src.etp_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.tpro_kod = src.tpro_kod
        , tgt.prz_kod = src.prz_kod
        , tgt.tzaj_kod = src.tzaj_kod
        -- DBG
        , tgt.dbg_classes_type = src.dbg_classes_type
        , tgt.dbg_os_id = src.dbg_os_id
        , tgt.dbg_st_id = src.dbg_st_id
        , tgt.dbg_etpos_id = src.dbg_etpos_id
        , tgt.dbg_prgos_id = src.dbg_prgos_id
        , tgt.dbg_prg_kod = src.dbg_prg_kod
        , tgt.dbg_etp_kod = src.dbg_etp_kod
        , tgt.dbg_cdyd_kod = src.dbg_cdyd_kod
        , tgt.dbg_prz_kod = src.dbg_prz_kod
        , tgt.dbg_tzaj_kod = src.dbg_tzaj_kod
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
