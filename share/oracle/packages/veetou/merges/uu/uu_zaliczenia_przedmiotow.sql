MERGE INTO v2u_uu_zaliczenia_przedmiotow tgt
USING
    (
        WITH u_00 AS
        (
            SELECT
                  g_j.job_uuid
                , subjects.subj_code
                , COALESCE(
                      ma_zalprz_j.prz_kod
                    , mi_zalprz_j.map_subj_code
                  ) map_subj_code
                , students.student_index
                , semesters.semester_code
                , COALESCE(
                      ma_zalprz_j.os_id
                    , mi_zalprz_j.os_id
                  ) os_id
                , zal_prz.cdyd_kod
                , zal_prz.prz_kod
                , COALESCE(zal_prz.status_rej, 'X') status_rej
                , COALESCE(zal_prz.status_zal, 'X') status_zal

                , CASE
                    WHEN ma_zalprz_j.student_id IS NOT NULL
                    THEN '{os_id: "' ||
                        ma_zalprz_j.os_id
                        || '", cdyd_kod: "' ||
                        ma_zalprz_j.cdyd_kod
                        || '", prz_kod: "' ||
                        ma_zalprz_j.prz_kod
                        || '"}'
                    ELSE '{student: "' ||
                        students.student_index
                        || '", subject: "' ||
                        COALESCE(mi_zalprz_j.map_subj_code, subjects.subj_code)
                        || '", semester: "' ||
                        semesters.semester_code
                        || '"}'
                  END pk_zalicz_przedmiotu

                -- DEBUGGING
                , ma_zalprz_j.student_id ma_id
                , mi_zalprz_j.student_id mi_id
                , COALESCE(
                      ma_zalprz_j.subject_map_id
                    , mi_zalprz_j.subject_map_id
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
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = g_j.semester_id
                        AND semesters.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_zalprz_j ma_zalprz_j
                ON (
                            ma_zalprz_j.student_id = g_j.student_id
                        AND ma_zalprz_j.subject_id = g_j.subject_id
                        AND ma_zalprz_j.specialty_id = g_j.specialty_id
                        AND ma_zalprz_j.semester_id = g_j.semester_id
                        AND ma_zalprz_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_zalprz_j mi_zalprz_j
                ON  (
                            mi_zalprz_j.student_id = g_j.student_id
                        AND mi_zalprz_j.subject_id = g_j.subject_id
                        AND mi_zalprz_j.specialty_id = g_j.specialty_id
                        AND mi_zalprz_j.semester_id = g_j.semester_id
                        AND mi_zalprz_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_dz_zaliczenia_przedmiotow zal_prz
                ON  (
                            zal_prz.os_id = ma_zalprz_j.os_id
                        AND zal_prz.cdyd_kod = ma_zalprz_j.cdyd_kod
                        AND zal_prz.prz_kod = ma_zalprz_j.prz_kod
                    )
        ),
        u_0 AS
        (
            -- determine what to use as a single output row...
            SELECT
                  u_00.job_uuid
                , u_00.pk_zalicz_przedmiotu
                , SET(CAST(COLLECT(u_00.subj_code) AS V2u_Vchars1K_t)) subj_codes1k
                , SET(CAST(COLLECT(u_00.map_subj_code) AS V2u_Vchars1K_t)) map_subj_codes1k
                , SET(CAST(COLLECT(u_00.student_index) AS V2u_Vchars1K_t)) student_indexes1k
                , SET(CAST(COLLECT(u_00.semester_code) AS V2u_Vchars1K_t)) semester_codes1k
                , SET(CAST(COLLECT(u_00.os_id) AS V2u_Dz_Ids_t)) os_ids
                , SET(CAST(COLLECT(u_00.cdyd_kod) AS V2u_Vchars1K_t)) cdyd_kody1k
                , SET(CAST(COLLECT(u_00.prz_kod) AS V2u_Vchars1K_t)) prz_kody1k
                , SET(CAST(COLLECT(u_00.status_rej) AS V2u_Vchars1K_t)) statusy_rej1k
                , SET(CAST(COLLECT(u_00.status_zal) AS V2u_Vchars1K_t)) statusy_zal1k

                -- DBG
                  -- "+ 0" trick is used to workaround oracle bug
                , COUNT(u_00.ma_id + 0) dbg_matched
                , COUNT(u_00.mi_id + 0) dbg_missing
                , COUNT(u_00.subject_map_id + 0) dbg_subject_mapped
            FROM u_00 u_00
            GROUP BY
                  u_00.job_uuid
                , u_00.pk_zalicz_przedmiotu
        ),
        u AS
        (
            -- make necessary adjustments to the raw values selectedin u_0
            SELECT
                  u_0.job_uuid
                , u_0.pk_zalicz_przedmiotu
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
                    FROM TABLE(u_0.statusy_rej1k) t
                    WHERE ROWNUM <= 1
                  ) status_rej
                , ( SELECT SUBSTR(VALUE(t), 1, 1)
                    FROM TABLE(u_0.statusy_zal1k) t
                    WHERE ROWNUM <= 1
                  ) status_zal

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
                    FROM TABLE(u_0.statusy_rej1k)
                  ) dbg_statusy_rej
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.statusy_zal1k)
                  ) dbg_statusy_zal
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
                , u.status_rej v$status_rej
                , u.status_zal v$status_zal

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
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                , CASE
                    WHEN    u.dbg_statusy_rej = 1
                        AND u.status_rej IN ('A', 'O', 'P', 'U', 'V', 'X', 'Z')
                        AND u.dbg_statusy_zal = 1
                        AND u.status_zal IN ('A', 'N', 'X')
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
        ),
        w AS
        ( -- provide our value (v$*) and original ones (u$*)
            SELECT
                  v.*

                , t.status_rej u$status_rej
                , t.opis_statusu_rej u$opis_statusu_rej
                , t.status_zal u$status_zal
                , t.opis_statusu_zal u$opis_statusu_zal
                , t.suma_ocen u$suma_ocen
                , t.liczba_ocen u$liczba_ocen
                , t.os_id u$os_id
                , t.cdyd_kod u$cdyd_kod
                , t.prz_kod u$prz_kod
                , t.utw_data u$utw_data
                , t.utw_id u$utw_id
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.nr_wyb u$nr_wyb

                -- is it insert, update or nothing?

                , DECODE( v.dbg_unique_match, 1
                        , (CASE
                            WHEN    -- do we introduce any modification?
                                    DECODE(v.v$status_rej, t.status_rej, 1, 0) = 1
                                AND DECODE(v.v$status_zal, t.status_zal, 1, 0) = 1
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
                        AND v.dbg_semester_codes = 1
                        AND v.semester_code IS NOT NULL
                        AND v.dbg_map_subj_codes = 1
                        AND v.map_subj_code IS NOT NULL
                        -- and there is a single corresponding entry in v2u_dz_przedmioty_cykli
                        AND v.dbg_przedmioty_cykli = 1
                        -- and no target rows can be found...
                        AND NOT EXISTS (
                            SELECT NULL
                            FROM v2u_dz_zaliczenia_przedmiotow zp
                            WHERE   zp.os_id = v.os_id
                                AND zp.cdyd_kod = v.semester_code
                                AND zp.prz_kod = v.map_subj_code
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
            LEFT JOIN v2u_dz_zaliczenia_przedmiotow t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.os_id = v.os_id
                        AND t.cdyd_kod = v.cdyd_kod
                        AND t.prz_kod = v.prz_kod
                    )
        )
        SELECT
              w.job_uuid
            , w.pk_zalicz_przedmiotu

            , DECODE(w.change_type, '-', w.u$status_rej, w.v$status_rej) status_rej
            , DECODE(w.change_type, 'I', NULL, w.u$opis_statusu_rej) opis_statusu_rej
            , DECODE(w.change_type, '-', w.u$status_zal, w.v$status_zal) status_zal
            , DECODE(w.change_type, 'I', NULL, w.u$opis_statusu_zal) opis_statusu_zal
            , DECODE(w.change_type, 'I', NULL, w.u$suma_ocen) suma_ocen
            , DECODE(w.change_type, 'I', NULL, w.u$liczba_ocen) liczba_ocen
            , DECODE(w.change_type, '-', w.u$os_id, w.v$os_id) os_id
            , DECODE(w.change_type, '-', w.u$cdyd_kod, w.v$cdyd_kod) cdyd_kod
            , DECODE(w.change_type, '-', w.u$prz_kod, w.v$prz_kod) prz_kod
            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data
            , DECODE(w.change_type, 'I', NULL, w.u$nr_wyb) nr_wyb

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
            , w.dbg_map_subj_codes
            , w.dbg_przedmioty_cykli
            , w.dbg_semester_codes
            , w.dbg_statusy_rej
            , w.dbg_statusy_zal
            , w.dbg_student_indexes
            , w.dbg_subj_codes
            , w.dbg_subject_mapped
            , w.dbg_unique_match
            , w.dbg_values_ok
        FROM w w
    ) src
ON  (
            tgt.pk_zalicz_przedmiotu = src.pk_zalicz_przedmiotu
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( status_rej
        , opis_statusu_rej
        , status_zal
        , opis_statusu_zal
        , suma_ocen
        , liczba_ocen
        , os_id
        , cdyd_kod
        , prz_kod
        , utw_data
        , utw_id
        , mod_id
        , mod_data
        , nr_wyb
        -- KEY
        , job_uuid
        , pk_zalicz_przedmiotu
        -- DBG
        , dbg_matched
        , dbg_missing
        , dbg_os_ids
        , dbg_cdyd_kody
        , dbg_prz_kody
        , dbg_map_subj_codes
        , dbg_przedmioty_cykli
        , dbg_semester_codes
        , dbg_statusy_rej
        , dbg_statusy_zal
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
        ( src.status_rej
        , src.opis_statusu_rej
        , src.status_zal
        , src.opis_statusu_zal
        , src.suma_ocen
        , src.liczba_ocen
        , src.os_id
        , src.cdyd_kod
        , src.prz_kod
        , src.utw_data
        , src.utw_id
        , src.mod_id
        , src.mod_data
        , src.nr_wyb
        -- KEY
        , src.job_uuid
        , src.pk_zalicz_przedmiotu
        -- DBG
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_os_ids
        , src.dbg_cdyd_kody
        , src.dbg_prz_kody
        , src.dbg_map_subj_codes
        , src.dbg_przedmioty_cykli
        , src.dbg_semester_codes
        , src.dbg_statusy_rej
        , src.dbg_statusy_zal
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
          tgt.status_rej = src.status_rej
        , tgt.opis_statusu_rej = src.opis_statusu_rej
        , tgt.status_zal = src.status_zal
        , tgt.opis_statusu_zal = src.opis_statusu_zal
        , tgt.suma_ocen = src.suma_ocen
        , tgt.liczba_ocen = src.liczba_ocen
        , tgt.utw_data = src.utw_data
        , tgt.utw_id = src.utw_id
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.nr_wyb = src.nr_wyb
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_zalicz_przedmiotu = src.pk_zalicz_przedmiotu
        -- DBG
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_os_ids = src.dbg_os_ids
        , tgt.dbg_cdyd_kody = src.dbg_cdyd_kody
        , tgt.dbg_prz_kody = src.dbg_prz_kody
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_przedmioty_cykli = src.dbg_przedmioty_cykli
        , tgt.dbg_semester_codes = src.dbg_semester_codes
        , tgt.dbg_statusy_rej = src.dbg_statusy_rej
        , tgt.dbg_statusy_zal = src.dbg_statusy_zal
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
