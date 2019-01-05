MERGE INTO v2u_uu_przedmioty_cykli tgt
USING
    (
        WITH u_00 AS
        (
            SELECT
                  ss_j.job_uuid
                , subject_map.map_subj_code
                , subject_map.map_proto_type
                , subjects.subj_code
                , subjects.subj_credit_kind
                , semesters.semester_code
                , grades.subj_grade
                , ma_przcykl_j.prz_kod
                , ma_przcykl_j.cdyd_kod
                , ma_przcykl_j.subject_map_id ma_map_id
                , ma_przcykl_j.subject_id ma_id
                , mi_przcykl_j.subject_id mi_id
                , sm_j.map_id sm_j_map_id
                , CASE
                    WHEN ma_przcykl_j.prz_kod IS NOT NULL
                    THEN '{prz_kod: "' ||
                            ma_przcykl_j.prz_kod
                        || '", cdyd_kod: "' ||
                            ma_przcykl_j.cdyd_kod
                        || '"}'
                    ELSE '{subject: "' ||
                            COALESCE( subject_map.map_subj_code
                                    , subjects.subj_code)
                        || '", semester: "' ||
                            semesters.semester_code
                        || '"}'
                    END pk_przedmiot_cyklu
            FROM v2u_ko_subject_semesters_j ss_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = ss_j.subject_id
                        AND subjects.job_uuid = ss_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = ss_j.semester_id
                        AND semesters.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_przcykl_j ma_przcykl_j
                ON  (
                            ma_przcykl_j.subject_id = ss_j.subject_id
                        AND ma_przcykl_j.specialty_id = ss_j.specialty_id
                        AND ma_przcykl_j.semester_id = ss_j.semester_id
                        AND ma_przcykl_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_przcykl_j mi_przcykl_j
                ON  (
                            mi_przcykl_j.subject_id = ss_j.subject_id
                        AND mi_przcykl_j.specialty_id = ss_j.specialty_id
                        AND mi_przcykl_j.semester_id = ss_j.semester_id
                        AND mi_przcykl_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = ss_j.subject_id
                        AND sm_j.specialty_id = ss_j.specialty_id
                        AND sm_j.semester_id = ss_j.semester_id
                        AND sm_j.job_uuid = ss_j.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = sm_j.map_id
                    )
            LEFT JOIN v2u_ko_grades_j grades
                ON  (
                            grades.subject_id = ss_j.subject_id
                        AND grades.specialty_id = ss_j.specialty_id
                        AND grades.semester_id = ss_j.semester_id
                        AND grades.classes_type = '-'
                        AND grades.job_uuid = ss_j.job_uuid
                    )
        ),
        u_0 AS
        (
            -- determine what to use as a single output row;
            --  (*) if possible, use corresponding map_subj_code as primary key,
            --  (*) otherwise (incomplete or ambiguous subject map), use the
            --      subj_code as primary key.
            SELECT
                  u_00.job_uuid
                , u_00.pk_przedmiot_cyklu
                , SET(CAST(
                        COLLECT(u_00.semester_code)
                        AS V2u_Vchars1K_t
                  )) semester_codes1k
                , SET(CAST(
                        COLLECT(u_00.subj_code)
                        AS V2u_Vchars1K_t
                  )) subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.map_proto_type)
                        AS V2u_Vchars1K_t
                  )) map_proto_types1k
                , SET(CAST(
                        COLLECT(u_00.subj_credit_kind)
                        AS V2u_Vchars1K_t
                  )) subj_credit_kinds1k
                , SET(CAST(
                        COLLECT(u_00.subj_grade)
                        AS V2u_Vchars1K_t
                  )) subj_grades1k
                , SET(CAST(
                        COLLECT(u_00.prz_kod ORDER BY u_00.ma_map_id)
                        AS V2u_Vchars1K_t
                  )) prz_kody1k
                , SET(CAST(
                        COLLECT(u_00.cdyd_kod ORDER BY u_00.ma_map_id)
                        AS V2u_Vchars1K_t
                  )) cdyd_kody1k

                  -- "+ 0" trick is used to workaround oracle bug
                , COUNT(u_00.ma_id + 0) dbg_matched
                , COUNT(u_00.mi_id + 0) dbg_missing
                , COUNT(u_00.sm_j_map_id + 0) dbg_mapped

            FROM u_00 u_00
            GROUP BY
                  u_00.job_uuid
                , u_00.pk_przedmiot_cyklu
        ),
        u AS
        ( -- make necessary adjustments to the raw values selected in u_0
            SELECT
                  u_0.job_uuid
                , u_0.pk_przedmiot_cyklu
                , ( SELECT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.semester_codes1k) t
                    WHERE ROWNUM <= 1
                  ) semester_code
                , ( SELECT SUBSTR(VALUE(t), 1, 16)
                    FROM TABLE(u_0.subj_credit_kinds1k) t
                    WHERE ROWNUM <= 1
                  ) subj_credit_kind
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_proto_types1k) t
                    WHERE ROWNUM <= 1
                  ) map_proto_type
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u_0.subj_grades1k) t
                  ) AS V2u_Subj_Grades_t) subj_grades
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.prz_kody1k) t
                    WHERE ROWNUM <= 1
                  ) prz_kod
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.cdyd_kody1k) t
                    WHERE ROWNUM <= 1
                  ) cdyd_kod

                -- columns used for debugging
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.semester_codes1k)
                  ) dbg_semester_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_codes1k)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_subj_codes1k)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_proto_types1k)
                  ) dbg_map_proto_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_credit_kinds1k)
                  ) dbg_subj_credit_kinds
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prz_kody1k)
                  ) dbg_prz_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.cdyd_kody1k)
                  ) dbg_cdyd_kody

                , u_0.dbg_matched
                , u_0.dbg_missing
                , u_0.dbg_mapped
            FROM u_0 u_0
        ),
        v AS
        ( -- determine our (v$*) values for certain fields
            SELECT
                  u.*
                , u.map_subj_code v$prz_kod
                , u.semester_code v$cdyd_kod
                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id
                , COALESCE(u.map_proto_type, V2u_Get.Tpro_Kod(
                          subj_credit_kind => u.subj_credit_kind
                        , subj_grades => u.subj_grades
                  )) v$tpro_kod

                -- did we found unique row in the target table?
                , CASE
                    WHEN    u.dbg_matched > 0
                        AND u.dbg_mapped = u.dbg_matched
                        AND u.dbg_missing = 0
                        AND u.dbg_prz_kody = 1 AND u.prz_kod IS NOT NULL
                        AND u.dbg_cdyd_kody = 1 AND u.cdyd_kod IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                -- examine values we gonna propose
                , CASE
                    WHEN
                        -- all the instances were consistent
                            u.dbg_map_proto_types <= 1
                        AND u.dbg_subj_credit_kinds = 1
                        -- and we have correct tpro_kod value
                        AND COALESCE(u.map_proto_type, V2u_Get.Tpro_Kod(
                              subj_credit_kind => u.subj_credit_kind
                            , subj_grades => u.subj_grades
                            )) IN ('E', 'Z', 'O', 'S')
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
        ),
        w AS
        ( -- provide our value (v$*) and original ones (u$*)
            SELECT
                  v.*
                , t.prz_kod u$prz_kod
                , t.cdyd_kod u$cdyd_kod
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.tpro_kod u$tpro_kod
                , t.uczestnicy u$uczestnicy
                , t.url u$url
                , t.uwagi u$uwagi
                , t.notes u$notes
                , t.literatura u$literatura
                , t.literatura_ang u$literatura_ang
                , t.opis u$opis
                , t.opis_ang u$opis_ang
                , t.skrocony_opis u$skrocony_opis
                , t.skrocony_opis_ang u$skrocony_opis_ang
                , t.status_sylabusu u$status_sylabusu
                , t.guid u$guid

                -- is it insert, update or nothing?

                , DECODE( v.dbg_unique_match, 1
                        , (CASE
                            WHEN    -- do we introduce any modification?
                                    DECODE(v.v$prz_kod, t.prz_kod, 1, 0) = 1
                                AND DECODE(v.v$cdyd_kod, t.cdyd_kod, 1, 0) = 1
                                AND DECODE(v.v$tpro_kod, t.tpro_kod, 1, 0) = 1
                            THEN '-'
                            ELSE 'U'
                          END)
                        , 'I'
                  ) change_type

                , CASE
                    WHEN
                        -- ensure that
                        -- we have single target subject code
                            v.map_subj_code IS NOT NULL
                        AND v.dbg_map_subj_codes = 1
                        AND v.dbg_subj_codes > 0
                        AND v.dbg_semester_codes = 1
                        -- maps for all instances existed but there were no
                        -- corresponding subject in target system
                        AND v.dbg_matched = 0
                        AND v.dbg_missing > 0
                        AND v.dbg_mapped = v.dbg_missing
                        -- values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_insert

                , CASE
                    WHEN
                        -- ensure that
                        -- we have target subject code
                            v.map_subj_code IS NOT NULL
                        AND v.dbg_map_subj_codes = 1
                        AND v.dbg_subj_codes > 0
                        AND v.dbg_semester_codes = 1
                        -- and we uniquelly matched a row in target table
                        AND v.dbg_unique_match = 1
                        -- and values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_update

            FROM v v
            LEFT JOIN v2u_dz_przedmioty_cykli t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.prz_kod = v.prz_kod
                        AND t.cdyd_kod = v.cdyd_kod
                    )
        )
        SELECT
              w.job_uuid
            , w.pk_przedmiot_cyklu

            , DECODE(w.change_type, 'I', w.v$prz_kod, w.u$prz_kod) prz_kod
            , DECODE(w.change_type, 'I', w.v$cdyd_kod, w.u$cdyd_kod) cdyd_kod
            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data
            , DECODE(w.change_type, '-', w.u$tpro_kod, w.v$tpro_kod) tpro_kod
            , DECODE(w.change_type, 'I', NULL, w.u$uczestnicy) uczestnicy
            , DECODE(w.change_type, 'I', NULL, w.u$url) url
            , DECODE(w.change_type, 'I', NULL, w.u$uwagi) uwagi
            , DECODE(w.change_type, 'I', NULL, w.u$notes) notes
            , DECODE(w.change_type, 'I', NULL, w.u$literatura) literatura
            , DECODE(w.change_type, 'I', NULL, w.u$literatura_ang) literatura_ang
            , DECODE(w.change_type, 'I', NULL, w.u$opis) opis
            , DECODE(w.change_type, 'I', NULL, w.u$opis_ang) opis_ang
            , DECODE(w.change_type, 'I', NULL, w.u$skrocony_opis) skrocony_opis
            , DECODE(w.change_type, 'I', NULL, w.u$skrocony_opis_ang) skrocony_opis_ang
            , DECODE(w.change_type, 'I', NULL, w.u$status_sylabusu) status_sylabusu
            , DECODE(w.change_type, 'I', NULL, w.u$guid) guid

            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
              ) safe_to_change

            , w.dbg_subj_codes
            , w.dbg_semester_codes
            , w.dbg_map_subj_codes
            , w.dbg_map_proto_types
            , w.dbg_subj_credit_kinds
            , w.dbg_prz_kody
            , w.dbg_cdyd_kody
            , w.dbg_values_ok
            , w.dbg_unique_match
            , w.dbg_matched
            , w.dbg_missing
            , w.dbg_mapped
        FROM w w
    ) src
ON  (
            tgt.pk_przedmiot_cyklu = src.pk_przedmiot_cyklu
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( prz_kod
        , cdyd_kod
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , tpro_kod
        , uczestnicy
        , url
        , uwagi
        , notes
        , literatura
        , literatura_ang
        , opis
        , opis_ang
        , skrocony_opis
        , skrocony_opis_ang
        , status_sylabusu
        , guid
        -- KEY
        , job_uuid
        , pk_przedmiot_cyklu
        -- DBG
        , dbg_subj_codes
        , dbg_semester_codes
        , dbg_map_subj_codes
        , dbg_map_proto_types
        , dbg_subj_credit_kinds
        , dbg_prz_kody
        , dbg_cdyd_kody
        , dbg_values_ok
        , dbg_unique_match
        , dbg_matched
        , dbg_missing
        , dbg_mapped
        -- CTL
        , change_type
        , safe_to_change
        )
    VALUES
        ( src.prz_kod
        , src.cdyd_kod
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.tpro_kod
        , src.uczestnicy
        , src.url
        , src.uwagi
        , src.notes
        , src.literatura
        , src.literatura_ang
        , src.opis
        , src.opis_ang
        , src.skrocony_opis
        , src.skrocony_opis_ang
        , src.status_sylabusu
        , src.guid
        -- KEY
        , src.job_uuid
        , src.pk_przedmiot_cyklu
        -- DBG
        , src.dbg_subj_codes
        , src.dbg_semester_codes
        , src.dbg_map_subj_codes
        , src.dbg_map_proto_types
        , src.dbg_subj_credit_kinds
        , src.dbg_prz_kody
        , src.dbg_cdyd_kody
        , src.dbg_values_ok
        , src.dbg_unique_match
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_mapped
        -- CTL
        , src.change_type
        , src.safe_to_change
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.tpro_kod = src.tpro_kod
        , tgt.uczestnicy = src.uczestnicy
        , tgt.url = src.url
        , tgt.uwagi = src.uwagi
        , tgt.notes = src.notes
        , tgt.literatura = src.literatura
        , tgt.literatura_ang = src.literatura_ang
        , tgt.opis = src.opis
        , tgt.opis_ang = src.opis_ang
        , tgt.skrocony_opis = src.skrocony_opis
        , tgt.skrocony_opis_ang = src.skrocony_opis_ang
        , tgt.status_sylabusu = src.status_sylabusu
        , tgt.guid = src.guid
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_przedmiot_cyklu = src.pk_przedmiot_cyklu
        -- DBG
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_semester_codes = src.dbg_semester_codes
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_map_proto_types = src.dbg_map_proto_types
        , tgt.dbg_subj_credit_kinds = src.dbg_subj_credit_kinds
        , tgt.dbg_prz_kody = src.dbg_prz_kody
        , tgt.dbg_cdyd_kody = src.dbg_cdyd_kody
        , tgt.dbg_values_ok = src.dbg_values_ok
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_mapped = src.dbg_mapped
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
