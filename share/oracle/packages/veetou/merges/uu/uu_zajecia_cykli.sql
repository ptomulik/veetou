MERGE INTO v2u_uu_zajecia_cykli tgt
USING
    (
        WITH u_0 AS
        (
            -- determine what to use as a single output row;
            --  (*) if possible, use corresponding map_subj_code as primary key,
            --  (*) otherwise (incomplete or ambiguous subject map), use the
            --      subj_code as primary key.
            --  (*) similarly for map_classes_type vs. classes_type
            SELECT
                  cs_j.job_uuid
                , COALESCE(
                      subject_map.map_subj_code
                    , subjects.subj_code
                ) coalesced_subj_code
                , COALESCE(
                      cm_j.map_classes_type
                    , cs_j.classes_type
                ) coalesced_classes_type
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
                        COLLECT(cs_j.classes_type)
                        AS V2u_Vchars1K_t
                  )) classes_types1k
                , SET(CAST(
                        COLLECT(cm_j.map_classes_type)
                        AS V2u_Vchars1K_t
                  )) map_classes_types1k
                , SET(CAST(
                        COLLECT(cs_j.classes_hours)
                        AS V2u_Ints8_t
                  )) classes_hours_tab
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
                        COLLECT(ma_j.prz_kod ORDER BY ma_j.subject_map_id)
                        AS V2u_Vchars1K_t
                  )) prz_kody1k
                , SET(CAST(
                        COLLECT(ma_j.cdyd_kod ORDER BY ma_j.subject_map_id)
                        AS V2u_Vchars1K_t
                  )) cdyd_kody1k
                , SET(CAST(
                        COLLECT(ma_j.tzaj_kod ORDER BY ma_j.subject_map_id)
                        AS V2u_Vchars1K_t
                  )) tzaj_kody1k
                , SET(CAST(
                        COLLECT(ma_j.zajcykl_id ORDER BY ma_j.subject_map_id)
                        AS V2u_Dz_Ids_t
                  )) ids

                , COUNT(ma_j.zajcykl_id) dbg_matched
                , COUNT(mi_j.job_uuid) dbg_missing
                , COUNT(sm_j.map_id) dbg_subject_mapped
                , COUNT(cm_j.map_id) dbg_classes_mapped

            FROM v2u_ko_classes_semesters_j cs_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = cs_j.subject_id
                        AND subjects.job_uuid = cs_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = cs_j.semester_id
                        AND semesters.job_uuid = cs_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_zajcykl_j ma_j
                ON  (
                            ma_j.subject_id = cs_j.subject_id
                        AND ma_j.specialty_id = cs_j.specialty_id
                        AND ma_j.semester_id = cs_j.semester_id
                        AND ma_j.classes_type = cs_j.classes_type
                        AND ma_j.job_uuid = cs_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_zajcykl_j mi_j
                ON  (
                            mi_j.subject_id = cs_j.subject_id
                        AND mi_j.specialty_id = cs_j.specialty_id
                        AND mi_j.semester_id = cs_j.semester_id
                        AND mi_j.classes_type = cs_j.classes_type
                        AND mi_j.job_uuid = cs_j.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = cs_j.subject_id
                        AND sm_j.specialty_id = cs_j.specialty_id
                        AND sm_j.semester_id = cs_j.semester_id
                        AND sm_j.job_uuid = cs_j.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = sm_j.map_id
                    )
            LEFT JOIN v2u_ko_classes_map_j cm_j
                ON  (
                            cm_j.subject_id = cs_j.subject_id
                        AND cm_j.specialty_id = cs_j.specialty_id
                        AND cm_j.semester_id = cs_j.semester_id
                        AND cm_j.classes_type = cs_j.classes_type
                        AND cm_j.job_uuid = cs_j.job_uuid
                        AND cm_j.selected = 1
                    )
            LEFT JOIN v2u_ko_grades_j grades
                ON  (
                            grades.subject_id = cs_j.subject_id
                        AND grades.specialty_id = cs_j.specialty_id
                        AND grades.semester_id = cs_j.semester_id
                        AND grades.job_uuid = cs_j.job_uuid
                    )
            GROUP BY
                  cs_j.job_uuid
                , COALESCE(subject_map.map_subj_code, subjects.subj_code)
                , COALESCE(cm_j.map_classes_type, cs_j.classes_type)
                , semesters.semester_code
        ),
        u AS
        ( -- make necessary adjustments to the raw values selected in u_0
            SELECT
                  u_0.job_uuid
                , u_0.coalesced_subj_code
                , u_0.coalesced_classes_type
                , u_0.semester_code
                , ( SELECT SUBSTR(VALUE(t), 1, 16)
                    FROM TABLE(u_0.subj_credit_kinds1k) t
                    WHERE ROWNUM <= 1
                  ) subj_credit_kind
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_classes_types1k) t
                    WHERE ROWNUM <= 1
                  ) map_classes_type
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.classes_hours_tab) t
                    WHERE ROWNUM <= 1
                  ) classes_hours
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
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.tzaj_kody1k) t
                    WHERE ROWNUM <= 1
                  ) tzaj_kod
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.ids) t
                    WHERE ROWNUM <= 1
                  ) id

                -- columns used for debugging
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_codes1k)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_subj_codes1k)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_classes_types1k)
                  ) dbg_map_classes_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.classes_hours_tab)
                  ) dbg_classes_hours
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
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.tzaj_kody1k)
                  ) dbg_tzaj_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.ids)
                  ) dbg_ids

                , u_0.dbg_matched
                , u_0.dbg_missing
                , u_0.dbg_subject_mapped
                , u_0.dbg_classes_mapped
            FROM u_0 u_0
        ),
        v AS
        ( -- determine our (v2u_*) values for certain fields
            SELECT
                  u.*
                , u.map_subj_code v2u_prz_kod
                , u.semester_code v2u_cdyd_kod
                , u.map_classes_type v2u_tzaj_kod
                , V2u_Get.Utw_Id(u.job_uuid) v2u_utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v2u_mod_id
                , u.classes_hours v2u_liczba_godz
                , COALESCE(u.map_proto_type, V2u_Get.Tpro_Kod(
                          subj_credit_kind => u.subj_credit_kind
                        , subj_grades => u.subj_grades
                  )) v2u_tpro_kod

                -- did we found unique row in the target table?
                , CASE
                    WHEN    u.dbg_matched > 0
                        AND u.dbg_subject_mapped = u.dbg_matched
                        AND u.dbg_classes_mapped = u.dbg_matched
                        AND u.dbg_missing = 0
                        AND u.dbg_ids = 1 AND u.id IS NOT NULL
                        -- the following checks are little bit redundant but...
                        AND u.dbg_prz_kody = 1 AND u.prz_kod IS NOT NULL
                        AND u.dbg_cdyd_kody = 1 AND u.cdyd_kod IS NOT NULL
                        AND u.dbg_tzaj_kody = 1 AND u.tzaj_kod IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                -- examine values we gonna propose
                , CASE
                    WHEN
                        -- all the instances were consistent
                            u.dbg_map_proto_types <= 1
                        AND u.dbg_subj_credit_kinds = 1
                        AND u.dbg_classes_hours = 1
                        -- and we have correct tpro_kod value
                        AND u.classes_hours BETWEEN 0 AND 1200
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
                , t.tzaj_kod org_tzaj_kod
                , t.liczba_godz org_liczba_godz
                , t.limit_miejsc org_limit_miejsc
                , t.utw_id org_utw_id
                , t.utw_data org_utw_data
                , t.mod_id org_mod_id
                , t.mod_data org_mod_data
                , t.waga_pensum org_waga_pensum
                , t.tpro_kod org_tpro_kod
                , t.efekty_uczenia org_efekty_uczenia
                , t.efekty_uczenia_ang org_efekty_uczenia_ang
                , t.kryteria_oceniania org_kryteria_oceniania
                , t.kryteria_oceniania_ang org_kryteria_oceniania_ang
                , t.url org_url
                , t.zakres_tematow org_zakres_tematow
                , t.zakres_tematow_ang org_zakres_tematow_ang
                , t.metody_dyd org_metody_dyd
                , t.metody_dyd_ang org_metody_dyd_ang
                , t.literatura org_literatura
                , t.literatura_ang org_literatura_ang
                , t.czy_pokazywac_termin org_czy_pokazywac_termin

                -- is it insert, update or nothing?

                , DECODE( v.dbg_unique_match, 1
                        , (CASE
                            WHEN    -- do we introduce any modification?
                                    DECODE(v.v2u_prz_kod, t.prz_kod, 1, 0) = 1
                                AND DECODE(v.v2u_cdyd_kod, t.cdyd_kod, 1, 0) = 1
                                AND DECODE(v.v2u_tzaj_kod, t.tzaj_kod, 1, 0) = 1
                                AND DECODE(v.v2u_liczba_godz, t.liczba_godz, 1, 0) = 1
                                AND DECODE(v.v2u_tpro_kod, t.tpro_kod, 1, 0) = 1
                            THEN '-'
                            ELSE 'U'
                          END)
                        , 'I'
                  ) change_type

                , CASE
                    WHEN
                        -- ensure that:
                            v.dbg_subj_codes > 0
                        -- we reach for exactly one, NON-NULL map_subj_code
                        AND v.dbg_map_subj_codes = 1
                        AND v.map_subj_code IS NOT NULL
                        -- we reach for exactly one, NON-NULL map_classes_type
                        AND v.dbg_map_classes_types = 1
                        AND v.map_classes_type IS NOT NULL
                        -- not target ids found...
                        AND v.id IS NULL
                        AND v.dbg_ids = 0
                        -- .. but this was not due to missing mappings
                        AND v.dbg_subject_mapped > 0
                        AND v.dbg_classes_mapped > 0
                        -- and values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_insert

                , CASE
                    WHEN
                        -- ensure that:
                            v.dbg_subj_codes > 0
                        -- we reach for exactly one, NON-NULL map_subj_code
                        AND v.dbg_map_subj_codes = 1
                        AND v.map_subj_code IS NOT NULL
                        -- we reach for exactly one, NON-NULL map_classes_type
                        AND v.dbg_map_classes_types = 1
                        AND v.map_classes_type IS NOT NULL
                        -- and we uniquelly matched a row in target table
                        AND v.dbg_unique_match = 1
                        -- and values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_update

            FROM v v
            LEFT JOIN v2u_dz_zajecia_cykli t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.id = v.id
                    )
        )
        SELECT
              w.job_uuid
            , w.coalesced_subj_code pk_subject
            , w.semester_code pk_semester
            , w.coalesced_classes_type pk_classes

            , w.id
            , DECODE(w.change_type, '-', w.org_prz_kod, w.v2u_prz_kod) prz_kod
            , DECODE(w.change_type, '-', w.org_cdyd_kod, w.v2u_cdyd_kod) cdyd_kod
            , DECODE(w.change_type, '-', w.org_tzaj_kod, w.v2u_tzaj_kod) tzaj_kod
            , DECODE(w.change_type, '-', w.org_liczba_godz, w.v2u_liczba_godz) liczba_godz
            , DECODE(w.change_type, 'I', NULL, w.org_limit_miejsc) limit_miejsc
            , DECODE(w.change_type, 'I', w.v2u_utw_id, w.org_utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.org_utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v2u_mod_id, w.org_mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.org_mod_data) mod_data
            , DECODE(w.change_type, 'I', NULL, w.org_waga_pensum) waga_pensum
            , DECODE(w.change_type, '-', w.org_tpro_kod, w.v2u_tpro_kod) tpro_kod
            , DECODE(w.change_type, 'I', NULL, w.org_efekty_uczenia) efekty_uczenia
            , DECODE(w.change_type, 'I', NULL, w.org_efekty_uczenia_ang) efekty_uczenia_ang
            , DECODE(w.change_type, 'I', NULL, w.org_kryteria_oceniania) kryteria_oceniania
            , DECODE(w.change_type, 'I', NULL, w.org_kryteria_oceniania_ang) kryteria_oceniania_ang
            , DECODE(w.change_type, 'I', NULL, w.org_url) url
            , DECODE(w.change_type, 'I', NULL, w.org_zakres_tematow) zakres_tematow
            , DECODE(w.change_type, 'I', NULL, w.org_zakres_tematow_ang) zakres_tematow_ang
            , DECODE(w.change_type, 'I', NULL, w.org_metody_dyd) metody_dyd
            , DECODE(w.change_type, 'I', NULL, w.org_metody_dyd_ang) metody_dyd_ang
            , DECODE(w.change_type, 'I', NULL, w.org_literatura) literatura
            , DECODE(w.change_type, 'I', NULL, w.org_literatura_ang) literatura_ang
            , DECODE(w.change_type, 'I', NULL, w.org_czy_pokazywac_termin) czy_pokazywac_termin

            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
              ) safe_to_change


            , w.dbg_subj_codes
            , w.dbg_map_subj_codes
            , w.dbg_map_classes_types
            , w.dbg_map_proto_types
            , w.dbg_subj_credit_kinds
            , w.dbg_prz_kody
            , w.dbg_cdyd_kody
            , w.dbg_tzaj_kody
            , w.dbg_classes_hours
            , w.dbg_ids
            , w.dbg_unique_match
            , w.dbg_values_ok
            , w.dbg_matched
            , w.dbg_missing
            , w.dbg_subject_mapped
            , w.dbg_classes_mapped
        FROM w w
    ) src
ON  (
            tgt.pk_subject = src.pk_subject
        AND tgt.pk_semester = src.pk_semester
        AND tgt.pk_classes = src.pk_classes
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , prz_kod
        , cdyd_kod
        , tzaj_kod
        , liczba_godz
        , limit_miejsc
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , waga_pensum
        , tpro_kod
        , efekty_uczenia
        , efekty_uczenia_ang
        , kryteria_oceniania
        , kryteria_oceniania_ang
        , url
        , zakres_tematow
        , zakres_tematow_ang
        , metody_dyd
        , metody_dyd_ang
        , literatura
        , literatura_ang
        , czy_pokazywac_termin
        -- KEY
        , job_uuid
        , pk_subject
        , pk_semester
        , pk_classes
        -- DBG
        , dbg_subj_codes
        , dbg_map_subj_codes
        , dbg_map_classes_types
        , dbg_map_proto_types
        , dbg_subj_credit_kinds
        , dbg_prz_kody
        , dbg_cdyd_kody
        , dbg_tzaj_kody
        , dbg_classes_hours
        , dbg_ids
        , dbg_unique_match
        , dbg_values_ok
        , dbg_matched
        , dbg_missing
        , dbg_subject_mapped
        , dbg_classes_mapped
        -- CTL
        , change_type
        , safe_to_change
        )
    VALUES
        ( src.id
        , src.prz_kod
        , src.cdyd_kod
        , src.tzaj_kod
        , src.liczba_godz
        , src.limit_miejsc
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.waga_pensum
        , src.tpro_kod
        , src.efekty_uczenia
        , src.efekty_uczenia_ang
        , src.kryteria_oceniania
        , src.kryteria_oceniania_ang
        , src.url
        , src.zakres_tematow
        , src.zakres_tematow_ang
        , src.metody_dyd
        , src.metody_dyd_ang
        , src.literatura
        , src.literatura_ang
        , src.czy_pokazywac_termin
        -- KEY
        , src.job_uuid
        , src.pk_subject
        , src.pk_semester
        , src.pk_classes
        -- DBG
        , src.dbg_subj_codes
        , src.dbg_map_subj_codes
        , src.dbg_map_classes_types
        , src.dbg_map_proto_types
        , src.dbg_subj_credit_kinds
        , src.dbg_prz_kody
        , src.dbg_cdyd_kody
        , src.dbg_tzaj_kody
        , src.dbg_classes_hours
        , src.dbg_ids
        , src.dbg_unique_match
        , src.dbg_values_ok
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_subject_mapped
        , src.dbg_classes_mapped
        -- CTL
        , src.change_type
        , src.safe_to_change
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.id = src.id
        , tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.tzaj_kod = src.tzaj_kod
        , tgt.liczba_godz = src.liczba_godz
        , tgt.limit_miejsc = src.limit_miejsc
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.waga_pensum = src.waga_pensum
        , tgt.tpro_kod = src.tpro_kod
        , tgt.efekty_uczenia = src.efekty_uczenia
        , tgt.efekty_uczenia_ang = src.efekty_uczenia_ang
        , tgt.kryteria_oceniania = src.kryteria_oceniania
        , tgt.kryteria_oceniania_ang = src.kryteria_oceniania_ang
        , tgt.url = src.url
        , tgt.zakres_tematow = src.zakres_tematow
        , tgt.zakres_tematow_ang = src.zakres_tematow_ang
        , tgt.metody_dyd = src.metody_dyd
        , tgt.metody_dyd_ang = src.metody_dyd_ang
        , tgt.literatura = src.literatura
        , tgt.literatura_ang = src.literatura_ang
        , tgt.czy_pokazywac_termin = src.czy_pokazywac_termin
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_subject = src.pk_subject
--        , tgt.pk_semester = src.pk_semester
--        , tgt.pk_classes = src.pk_classes
        -- DBG
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_map_classes_types = src.dbg_map_classes_types
        , tgt.dbg_map_proto_types = src.dbg_map_proto_types
        , tgt.dbg_subj_credit_kinds = src.dbg_subj_credit_kinds
        , tgt.dbg_prz_kody = src.dbg_prz_kody
        , tgt.dbg_cdyd_kody = src.dbg_cdyd_kody
        , tgt.dbg_tzaj_kody = src.dbg_tzaj_kody
        , tgt.dbg_classes_hours = src.dbg_classes_hours
        , tgt.dbg_ids = src.dbg_ids
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_values_ok = src.dbg_values_ok
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_subject_mapped = src.dbg_subject_mapped
        , tgt.dbg_classes_mapped = src.dbg_classes_mapped
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
