MERGE INTO v2u_uu_zal_przedm_prgos tgt
USING
    (
        WITH u_00 AS
        (
            SELECT
                  g_j.job_uuid
                , subjects.subj_code
                , COALESCE(
                      ma_zpprgos_j.prz_kod
                    , mi_zpprgos_j.map_subj_code
                  ) map_subj_code
                , students.student_index
                , semesters.semester_code
                , COALESCE(
                      ma_zpprgos_j.os_id
                    , mi_zpprgos_j.os_id
                  ) os_id
                , zal_prz_prgos.cdyd_kod
                , zal_prz_prgos.prz_kod
                , COALESCE(
                      ma_zpprgos_j.prgos_id
                    , mi_zpprgos_j.prgos_id
                  ) prgos_id
                , COALESCE(
                      zal_prz_prgos.stan
                    , 'A'
                  ) stan
                , COALESCE(
                      zal_prz_prgos.etpos_id
                    , ma_zpprgos_j.etpos_id
                    , mi_zpprgos_j.etpos_id
                  ) etpos_id

                , CASE
                    WHEN ma_zpprgos_j.student_id IS NOT NULL
                    THEN '{os_id: "' ||
                        ma_zpprgos_j.os_id
                        || '", cdyd_kod: "' ||
                        ma_zpprgos_j.cdyd_kod
                        || '", prz_kod: "' ||
                        ma_zpprgos_j.prz_kod
                        || '", prgos_id: "' ||
                        ma_zpprgos_j.prgos_id
                        || '"}'
                    ELSE '{student: "' ||
                        students.student_index
                        || '", studies: "' ||
                        specialties.university
                        || '|' ||
                        specialties.faculty
                        || '|' ||
                        V2U_Get.Studies_Tier(specialties.studies_modetier)
                        || '|' ||
                        V2U_Get.Studies_Mode(specialties.studies_modetier)
                        || '|' ||
                        V2U_Get.Acronym(specialties.studies_field)
                        || '|' ||
                        V2U_Get.Acronym(specialties.studies_specialty)
                        || '", subject: "' ||
                        COALESCE(mi_zpprgos_j.map_subj_code, subjects.subj_code)
                        || '", semester: "' ||
                        semesters.semester_code
                        || '"}'
                  END pk_zal_przedm_prgos

                -- DEBUGGING
                , ma_zpprgos_j.student_id ma_id
                , mi_zpprgos_j.student_id mi_id
                , COALESCE(
                      ma_zpprgos_j.subject_map_id
                    , mi_zpprgos_j.subject_map_id
                  ) subject_map_id

            FROM v2u_ko_grades_j g_j
            INNER JOIN v2u_ko_students students
                ON  (
                            students.id = g_j.student_id
                        AND students.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = g_j.subject_id
                        AND subjects.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_specialties specialties
                ON  (
                            specialties.id = g_j.specialty_id
                        AND specialties.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = g_j.semester_id
                        AND semesters.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_zpprgos_j ma_zpprgos_j
                ON (
                            ma_zpprgos_j.student_id = g_j.student_id
                        AND ma_zpprgos_j.subject_id = g_j.subject_id
                        AND ma_zpprgos_j.specialty_id = g_j.specialty_id
                        AND ma_zpprgos_j.semester_id = g_j.semester_id
                        AND ma_zpprgos_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_zpprgos_j mi_zpprgos_j
                ON  (
                            mi_zpprgos_j.student_id = g_j.student_id
                        AND mi_zpprgos_j.subject_id = g_j.subject_id
                        AND mi_zpprgos_j.specialty_id = g_j.specialty_id
                        AND mi_zpprgos_j.semester_id = g_j.semester_id
                        AND mi_zpprgos_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_dz_zal_przedm_prgos zal_prz_prgos
                ON  (
                            zal_prz_prgos.os_id = ma_zpprgos_j.os_id
                        AND zal_prz_prgos.cdyd_kod = ma_zpprgos_j.cdyd_kod
                        AND zal_prz_prgos.prz_kod = ma_zpprgos_j.prz_kod
                        AND zal_prz_prgos.prgos_id = ma_zpprgos_j.prgos_id
                    )
        ),
        u_0 AS
        (
            -- determine what to use as a single output row...
            SELECT
                  u_00.job_uuid
                , u_00.pk_zal_przedm_prgos
                , SET(CAST(COLLECT(u_00.subj_code) AS V2u_Vchars1K_t)) subj_codes1k
                , SET(CAST(COLLECT(u_00.map_subj_code) AS V2u_Vchars1K_t)) map_subj_codes1k
                , SET(CAST(COLLECT(u_00.student_index) AS V2u_Vchars1K_t)) student_indexes1k
                , SET(CAST(COLLECT(u_00.semester_code) AS V2u_Vchars1K_t)) semester_codes1k
                , SET(CAST(COLLECT(u_00.os_id) AS V2u_Dz_Ids_t)) os_ids
                , SET(CAST(COLLECT(u_00.cdyd_kod) AS V2u_Vchars1K_t)) cdyd_kody1k
                , SET(CAST(COLLECT(u_00.prz_kod) AS V2u_Vchars1K_t)) prz_kody1k
                , SET(CAST(COLLECT(u_00.prgos_id) AS V2u_Dz_Ids_t)) prgos_ids
                , SET(CAST(COLLECT(u_00.etpos_id) AS V2u_Dz_Ids_t)) etpos_ids
                , SET(CAST(COLLECT(u_00.stan) AS V2u_Vchars1K_t)) stany1k

                -- DBG
                  -- "+ 0" trick is used to workaround oracle bug
                , COUNT(u_00.ma_id + 0) dbg_matched
                , COUNT(u_00.mi_id + 0) dbg_missing
                , COUNT(u_00.subject_map_id + 0) dbg_subject_mapped
            FROM u_00 u_00
            GROUP BY
                  u_00.job_uuid
                , u_00.pk_zal_przedm_prgos
        ),
        u AS
        (
            -- make necessary adjustments to the raw values selectedin u_0
            SELECT
                  u_0.job_uuid
                , u_0.pk_zal_przedm_prgos
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) AS V2u_Subj_20Codes_t) subj_codes
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , ( SELECT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.student_indexes1k) t
                    WHERE ROWNUM <= 1
                  ) student_index
                , ( SELECT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.semester_codes1k) t
                    WHERE ROWNUM <= 1
                  ) semester_code
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.os_ids) t
                    WHERE ROWNUM <= 1
                  ) os_id
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.cdyd_kody1k) t
                    WHERE ROWNUM <= 1
                  ) cdyd_kod
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.prz_kody1k) t
                    WHERE ROWNUM <= 1
                  ) prz_kod
                , ( SELECT SUBSTR(VALUE(t), 1, 1)
                    FROM TABLE(u_0.stany1k) t
                    WHERE ROWNUM <= 1
                  ) stan
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.prgos_ids) t
                    WHERE ROWNUM <= 1
                  ) prgos_id
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.etpos_ids) t
                    WHERE ROWNUM <= 1
                  ) etpos_id

                -- DBG

                , u_0.dbg_matched
                , u_0.dbg_missing
                , u_0.dbg_subject_mapped
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_codes1k)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_subj_codes1k)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.student_indexes1k)
                  ) dbg_student_indexes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.semester_codes1k)
                  ) dbg_semester_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.os_ids)
                  ) dbg_os_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.cdyd_kody1k)
                  ) dbg_cdyd_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prz_kody1k)
                  ) dbg_prz_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.stany1k)
                  ) dbg_stany
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prgos_ids)
                  ) dbg_prgos_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.etpos_ids)
                  ) dbg_etpos_ids
            FROM u_0 u_0
        ),
        v AS
        (
            SELECT
                  u.*
                , u.os_id v$os_id
                , COALESCE(u.cdyd_kod, u.semester_code) v$cdyd_kod
                , COALESCE(u.prz_kod, u.map_subj_code) v$prz_kod
                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id
                , u.stan v$stan
                , u.prgos_id v$prgos_id
                , u.etpos_id v$etpos_id

                , ( SELECT COUNT(*)
                    FROM v2u_dz_przedmioty_cykli pc
                    WHERE   pc.prz_kod = COALESCE(u.prz_kod, u.map_subj_code)
                        AND pc.cdyd_kod = COALESCE(u.cdyd_kod, u.semester_code)
                  ) dbg_przedmioty_cykli

                , CASE
                    WHEN    u.dbg_matched > 0
                        AND u.dbg_subject_mapped = u.dbg_matched
                        AND u.dbg_missing = 0
                        AND u.dbg_os_ids = 1 AND u.os_id IS NOT NULL
                        AND u.dbg_cdyd_kody = 1 AND u.cdyd_kod IS NOT NULL
                        AND u.dbg_prz_kody = 1 AND u.prz_kod IS NOT NULL
                        AND u.dbg_prgos_ids = 1 AND u.prgos_id IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                , CASE
                    WHEN    u.dbg_stany = 1
                        AND u.stan IN ('A', 'O', 'P', 'Z')
                        AND (
                                    u.dbg_etpos_ids = 0 AND u.etpos_id IS NULL
                                OR  u.dbg_etpos_ids = 1 AND u.etpos_id IS NOT NULL
                            )
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
        ),
        w AS
        ( -- provide our value (v$*) and original ones (u$*)
            SELECT
                  v.*

                , t.os_id u$os_id
                , t.prz_kod u$prz_kod
                , t.cdyd_kod u$cdyd_kod
                , t.prgos_id u$prgos_id
                , t.stan u$stan
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.etpos_id u$etpos_id
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.do_sredniej u$do_sredniej
                , t.do_sredniej_zmiana_os_id u$do_sredniej_zmiana_os_id
                , t.do_sredniej_zmiana_data u$do_sredniej_zmiana_data
                , t.podp_data u$podp_data
                , t.podp_os_id u$podp_os_id
                , t.czy_platny_ects_ustawa u$czy_platny_ects_ustawa
                , t.kto_placi u$kto_placi
                , t.podp_etpos_data u$podp_etpos_data
                , t.podp_etpos_os_id u$podp_etpos_os_id
                , t.katprz_id u$katprz_id
                , t.pw_ponadprogramowy u$pw_ponadprogramowy

                -- is it insert, update or nothing?

                , DECODE( v.dbg_unique_match, 1
                        , (CASE
                            WHEN    -- do we introduce any modification?
                                    DECODE(v.v$stan, t.stan, 1, 0) = 1
                                AND DECODE(v.v$etpos_id, t.etpos_id, 1, 0) = 1
                            THEN '-'
                            ELSE 'U'
                          END)
                        , 'I'
                  ) change_type

                , CASE
                    WHEN
                        -- ensure that:
                            v.dbg_subj_codes > 0
                        AND v.dbg_student_indexes = 1
                        -- we reach for exactly one, NON-NULL record in zaliczenia_przemiotow
                        AND v.dbg_os_ids = 1
                        AND v.os_id IS NOT NULL
                        AND v.dbg_prgos_ids = 1
                        AND v.prgos_id IS NOT NULL
                        AND v.dbg_semester_codes = 1
                        AND v.semester_code IS NOT NULL
                        AND v.dbg_map_subj_codes = 1
                        AND v.map_subj_code IS NOT NULL
                        -- and there is a single corresponding entry in v2u_dz_przedmioty_cykli
                        AND v.dbg_przedmioty_cykli = 1
                        -- and no target rows can be found...
                        AND NOT EXISTS (
                            SELECT NULL
                            FROM v2u_dz_zal_przedm_prgos zp
                            WHERE   zp.os_id = v.os_id
                                AND zp.cdyd_kod = v.semester_code
                                AND zp.prz_kod = v.map_subj_code
                                AND zp.prgos_id = v.prgos_id
                        )
                        -- .. but this was not due to missing mappings
                        AND v.dbg_subject_mapped > 0
                        -- and values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_insert

                , CASE
                    WHEN
                        -- ensure that:
                            v.dbg_subj_codes > 0
                        AND v.dbg_student_indexes = 1
                        -- and we uniquelly matched a row in target table
                        AND v.dbg_unique_match = 1
                        -- and there is corresponding entry in v2u_dz_przedmioty_cykli
                        AND v.dbg_przedmioty_cykli = 1
                        -- and values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_update

            FROM v v
            LEFT JOIN v2u_dz_zal_przedm_prgos t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.os_id = v.os_id
                        AND t.cdyd_kod = v.cdyd_kod
                        AND t.prz_kod = v.prz_kod
                        AND t.prgos_id = v.prgos_id
                    )
        )
        SELECT
              w.job_uuid
            , w.pk_zal_przedm_prgos

            , DECODE(w.change_type, '-', w.u$os_id, w.v$os_id) os_id
            , DECODE(w.change_type, '-', w.u$prz_kod, w.v$prz_kod) prz_kod
            , DECODE(w.change_type, '-', w.u$cdyd_kod, w.v$cdyd_kod) cdyd_kod
            , DECODE(w.change_type, '-', w.u$prgos_id, w.v$prgos_id) prgos_id
            , DECODE(w.change_type, '-', w.u$stan, w.v$stan) stan
            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, '-', w.u$etpos_id, w.v$etpos_id) etpos_id
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data
            , DECODE(w.change_type, 'I', NULL, w.u$do_sredniej) do_sredniej
            , DECODE(w.change_type, 'I', NULL, w.u$do_sredniej_zmiana_os_id) do_sredniej_zmiana_os_id
            , DECODE(w.change_type, 'I', NULL, w.u$do_sredniej_zmiana_data) do_sredniej_zmiana_data
            , DECODE(w.change_type, 'I', NULL, w.u$podp_data) podp_data
            , DECODE(w.change_type, 'I', NULL, w.u$podp_os_id) podp_os_id
            , DECODE(w.change_type, 'I', NULL, w.u$czy_platny_ects_ustawa) czy_platny_ects_ustawa
            , DECODE(w.change_type, 'I', NULL, w.u$kto_placi) kto_placi
            , DECODE(w.change_type, 'I', NULL, w.u$podp_etpos_data) podp_etpos_data
            , DECODE(w.change_type, 'I', NULL, w.u$podp_etpos_os_id) podp_etpos_os_id
            , DECODE(w.change_type, 'I', NULL, w.u$katprz_id) katprz_id
            , DECODE(w.change_type, 'I', NULL, w.u$pw_ponadprogramowy) pw_ponadprogramowy

            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
              ) safe_to_change

            , w.dbg_matched
            , w.dbg_missing
            , w.dbg_os_ids
            , w.dbg_cdyd_kody
            , w.dbg_prz_kody
            , w.dbg_prgos_ids
            , w.dbg_etpos_ids
            , w.dbg_map_subj_codes
            , w.dbg_przedmioty_cykli
            , w.dbg_semester_codes
            , w.dbg_stany
            , w.dbg_student_indexes
            , w.dbg_subj_codes
            , w.dbg_subject_mapped
            , w.dbg_unique_match
            , w.dbg_values_ok
        FROM w w
    ) src
ON  (
            tgt.pk_zal_przedm_prgos = src.pk_zal_przedm_prgos
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( os_id
        , prz_kod
        , cdyd_kod
        , prgos_id
        , stan
        , utw_id
        , utw_data
        , etpos_id
        , mod_id
        , mod_data
        , do_sredniej
        , do_sredniej_zmiana_os_id
        , do_sredniej_zmiana_data
        , podp_data
        , podp_os_id
        , czy_platny_ects_ustawa
        , kto_placi
        , podp_etpos_data
        , podp_etpos_os_id
        , katprz_id
        , pw_ponadprogramowy
        -- KEY
        , job_uuid
        , pk_zal_przedm_prgos
        -- DBG
        , dbg_matched
        , dbg_missing
        , dbg_os_ids
        , dbg_cdyd_kody
        , dbg_prz_kody
        , dbg_prgos_ids
        , dbg_etpos_ids
        , dbg_map_subj_codes
        , dbg_przedmioty_cykli
        , dbg_semester_codes
        , dbg_stany
        , dbg_student_indexes
        , dbg_subj_codes
        , dbg_subject_mapped
        , dbg_unique_match
        , dbg_values_ok
        -- CTL
        , change_type
        , safe_to_change
        )
    VALUES
        ( src.os_id
        , src.prz_kod
        , src.cdyd_kod
        , src.prgos_id
        , src.stan
        , src.utw_id
        , src.utw_data
        , src.etpos_id
        , src.mod_id
        , src.mod_data
        , src.do_sredniej
        , src.do_sredniej_zmiana_os_id
        , src.do_sredniej_zmiana_data
        , src.podp_data
        , src.podp_os_id
        , src.czy_platny_ects_ustawa
        , src.kto_placi
        , src.podp_etpos_data
        , src.podp_etpos_os_id
        , src.katprz_id
        , src.pw_ponadprogramowy
        -- KEY
        , src.job_uuid
        , src.pk_zal_przedm_prgos
        -- DBG
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_os_ids
        , src.dbg_cdyd_kody
        , src.dbg_prz_kody
        , src.dbg_prgos_ids
        , src.dbg_etpos_ids
        , src.dbg_map_subj_codes
        , src.dbg_przedmioty_cykli
        , src.dbg_semester_codes
        , src.dbg_stany
        , src.dbg_student_indexes
        , src.dbg_subj_codes
        , src.dbg_subject_mapped
        , src.dbg_unique_match
        , src.dbg_values_ok
        -- CTL
        , src.change_type
        , src.safe_to_change
        )
WHEN MATCHED THEN UPDATE SET
          tgt.os_id = src.os_id
        , tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.prgos_id = src.prgos_id
        , tgt.stan = src.stan
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.etpos_id = src.etpos_id
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.do_sredniej = src.do_sredniej
        , tgt.do_sredniej_zmiana_os_id = src.do_sredniej_zmiana_os_id
        , tgt.do_sredniej_zmiana_data = src.do_sredniej_zmiana_data
        , tgt.podp_data = src.podp_data
        , tgt.podp_os_id = src.podp_os_id
        , tgt.czy_platny_ects_ustawa = src.czy_platny_ects_ustawa
        , tgt.kto_placi = src.kto_placi
        , tgt.podp_etpos_data = src.podp_etpos_data
        , tgt.podp_etpos_os_id = src.podp_etpos_os_id
        , tgt.katprz_id = src.katprz_id
        , tgt.pw_ponadprogramowy = src.pw_ponadprogramowy
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_zal_przedm_prgos = src.pk_zal_przedm_prgos
        -- DBG
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_os_ids = src.dbg_os_ids
        , tgt.dbg_cdyd_kody = src.dbg_cdyd_kody
        , tgt.dbg_prz_kody = src.dbg_prz_kody
        , tgt.dbg_prgos_ids = src.dbg_prgos_ids
        , tgt.dbg_etpos_ids = src.dbg_etpos_ids
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_przedmioty_cykli = src.dbg_przedmioty_cykli
        , tgt.dbg_semester_codes = src.dbg_semester_codes
        , tgt.dbg_stany = src.dbg_stany
        , tgt.dbg_student_indexes = src.dbg_student_indexes
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_subject_mapped = src.dbg_subject_mapped
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_values_ok = src.dbg_values_ok
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
