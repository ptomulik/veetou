MERGE INTO v2u_uu_przedmioty_cykli tgt
USING
    (
        WITH u_0 AS
        (
            -- determine what to use as a single output row;
            --  (*) if possible, use corresponding map_subj_code as primary key,
            --  (*) otherwise (incomplete or ambiguous subject map), use the
            --      subj_code as primary key.
            SELECT
                  ss_j.job_uuid
                , COALESCE(
                      subject_map.map_subj_code
                    , subjects.subj_code
                ) coalesced_subj_code
                , semesters.semester_code
                , SET(CAST(
                        COLLECT(subjects.subj_code)
                        AS V2u_Vchars1K_t
                  )) subj_codes1k
                , SET(CAST(
                        COLLECT(subject_map.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes1k
                , SET(CAST(
                        COLLECT(subject_map.map_proto_type)
                        AS V2u_Vchars1K_t
                  )) map_proto_types1k
                , SET(CAST(
                        COLLECT(subjects.subj_credit_kind)
                        AS V2u_Vchars1K_t
                  )) subj_credit_kinds1k
                , SET(CAST(
                        COLLECT(grades.subj_grade)
                        AS V2u_Vchars1K_t
                  )) subj_grades1k
                , SET(CAST(
                        COLLECT(ma_j.prz_kod
                                ORDER BY ma_j.subject_map_id)
                        AS V2u_Vchars1K_t
                  )) prz_kody1k
                , SET(CAST(
                        COLLECT(ma_j.cdyd_kod
                                ORDER BY ma_j.subject_map_id)
                        AS V2u_Vchars1K_t
                  )) cdyd_kody1k

                , COUNT(ma_j.prz_kod) dbg_matched
                , COUNT(mi_j.job_uuid) dbg_missing
                , COUNT(sm_j.map_id) dbg_mapped

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
            LEFT JOIN v2u_ko_matched_przcykl_j ma_j
                ON  (
                            ma_j.subject_id = ss_j.subject_id
                        AND ma_j.specialty_id = ss_j.specialty_id
                        AND ma_j.semester_id = ss_j.semester_id
                        AND ma_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_przcykl_j mi_j
                ON  (
                            mi_j.subject_id = ss_j.subject_id
                        AND mi_j.specialty_id = ss_j.specialty_id
                        AND mi_j.semester_id = ss_j.semester_id
                        AND mi_j.job_uuid = ss_j.job_uuid
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
                        AND grades.job_uuid = ss_j.job_uuid
                    )
            GROUP BY
                  ss_j.job_uuid
                , COALESCE(subject_map.map_subj_code, subjects.subj_code)
                , semesters.semester_code
        ),
        u AS
        ( -- make necessary adjustments to the raw values selected in u_0
            SELECT
                  u_0.job_uuid
                , u_0.coalesced_subj_code
                , u_0.semester_code
                , ( SELECT SUBSTR(VALUE(t), 1, 16)
                    FROM TABLE(u_0.subj_credit_kinds1k) t
                    WHERE ROWNUM <= 1
                  ) subj_credit_kind
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , ( SELECT SUBSTR(VALUE(t), 1, 1)
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
                , ( SELECT SUBSTR(VALUE(t), 1, 5)
                    FROM TABLE(u_0.cdyd_kody1k) t
                    WHERE ROWNUM <= 1
                  ) cdyd_kod

                -- columns used for debugging
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
        ( -- determine our (v2u_*) values for certain fields
            SELECT
                  u.*
                , u.map_subj_code v2u_prz_kod
                , u.semester_code v2u_cdyd_kod
                , V2u_Get.Utw_Id(u.job_uuid) v2u_utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v2u_mod_id
                , COALESCE(u.map_proto_type, V2u_Get.Tpro_Kod(
                          subj_credit_kind => u.subj_credit_kind
                        , subj_grades => u.subj_grades
                  )) v2u_tpro_kod

                -- did we found unique row in the target table?
                , CASE
                    WHEN    u.dbg_matched > 0
                        AND u.dbg_mapped = u.dbg_matched
                        AND u.dbg_missing = 0
                        AND u.dbg_prz_kody = 1
                        AND u.prz_kod IS NOT NULL
                        AND u.dbg_cdyd_kody = 1
                        AND u.cdyd_kod IS NOT NULL
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
        ( -- provide our value (v2u_*) and original ones (org_*)
            SELECT
                  v.*
                , t.prz_kod org_prz_kod
                , t.cdyd_kod org_cdyd_kod
                , t.utw_id org_utw_id
                , t.utw_data org_utw_data
                , t.mod_id org_mod_id
                , t.mod_data org_mod_data
                , t.tpro_kod org_tpro_kod
                , t.uczestnicy org_uczestnicy
                , t.url org_url
                , t.uwagi org_uwagi
                , t.notes org_notes
                , t.literatura org_literatura
                , t.literatura_ang org_literatura_ang
                , t.opis org_opis
                , t.opis_ang org_opis_ang
                , t.skrocony_opis org_skrocony_opis
                , t.skrocony_opis_ang org_skrocony_opis_ang
                , t.status_sylabusu org_status_sylabusu
                , t.guid org_guid

                -- is it insert, update or nothing?

                , DECODE( v.dbg_unique_match, 1
                        , (CASE
                            WHEN    -- do we introduce any modification?
                                    DECODE(v.v2u_prz_kod, t.prz_kod, 1, 0) = 1
                                AND DECODE(v.v2u_cdyd_kod, t.cdyd_kod, 1, 0) = 1
                                AND DECODE(v.v2u_tpro_kod, t.tpro_kod, 1, 0) = 1
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
            , w.coalesced_subj_code pk_subject
            , w.semester_code pk_semester

            , DECODE(w.change_type, 'I', w.v2u_prz_kod, w.org_prz_kod) prz_kod
            , DECODE(w.change_type, 'I', w.v2u_cdyd_kod, w.org_cdyd_kod) cdyd_kod
            , DECODE(w.change_type, 'I', w.v2u_utw_id, w.org_utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.org_utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v2u_mod_id, w.org_mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.org_mod_data) mod_data
            , DECODE(w.change_type, '-', w.org_tpro_kod, w.v2u_tpro_kod) tpro_kod
            , DECODE(w.change_type, 'I', NULL, w.org_uczestnicy) uczestnicy
            , DECODE(w.change_type, 'I', NULL, w.org_url) url
            , DECODE(w.change_type, 'I', NULL, w.org_uwagi) uwagi
            , DECODE(w.change_type, 'I', NULL, w.org_notes) notes
            , DECODE(w.change_type, 'I', NULL, w.org_literatura) literatura
            , DECODE(w.change_type, 'I', NULL, w.org_literatura_ang) literatura_ang
            , DECODE(w.change_type, 'I', NULL, w.org_opis) opis
            , DECODE(w.change_type, 'I', NULL, w.org_opis_ang) opis_ang
            , DECODE(w.change_type, 'I', NULL, w.org_skrocony_opis) skrocony_opis
            , DECODE(w.change_type, 'I', NULL, w.org_skrocony_opis_ang) skrocony_opis_ang
            , DECODE(w.change_type, 'I', NULL, w.org_status_sylabusu) status_sylabusu
            , DECODE(w.change_type, 'I', NULL, w.org_guid) guid

            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
              ) safe_to_change

            , w.dbg_subj_codes
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
            tgt.pk_subject = src.pk_subject
        AND tgt.pk_semester = src.pk_semester
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
        , pk_subject
        , pk_semester
        -- DBG
        , dbg_subj_codes
        , dbg_map_subj_codes
        , dbg_subj_credit_kinds
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
        , src.pk_subject
        , src.pk_semester
        -- DBG
        , src.dbg_subj_codes
        , src.dbg_map_subj_codes
        , src.dbg_subj_credit_kinds
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
--        , tgt.pk_subject = src.pk_subject
--        , tgt.pk_semester = src.pk_semester
        -- DBG
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_subj_credit_kinds = src.dbg_subj_credit_kinds
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_mapped = src.dbg_mapped
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
