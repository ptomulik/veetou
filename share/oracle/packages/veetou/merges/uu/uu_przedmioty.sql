MERGE INTO v2u_uu_przedmioty tgt
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
                , SET(CAST(
                        COLLECT(subjects.subj_code)
                        AS V2u_Vchars1K_t
                  )) subj_codes1k
                , SET(CAST(
                        COLLECT(subject_map.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes1k
                , SET(CAST(
                        COLLECT(subject_map.map_subj_name)
                        AS V2u_Vchars1K_t
                  )) map_subj_names1k
                , SET(CAST(
                        COLLECT(subject_map.map_subj_lang)
                        AS V2u_Vchars1K_t
                  )) map_subj_languages1k
                , SET(CAST(
                        COLLECT(subject_map.map_org_unit)
                        AS V2u_Vchars1K_t
                  )) map_org_units1k
                , SET(CAST(
                        COLLECT(subject_map.map_org_unit_recipient)
                        AS V2u_Vchars1K_t
                  )) map_org_unit_recipients1k
                , SET(CAST(
                        COLLECT(subject_map.map_proto_type)
                        AS V2u_Vchars1K_t
                  )) map_proto_types1k
                , SET(CAST(
                        COLLECT(subject_map.map_grade_type)
                        AS V2u_Vchars1K_t
                  )) map_grade_types1k
                , SET(CAST(
                        COLLECT(faculties.code)
                        AS V2u_Vchars1K_t
                  )) faculty_codes1k
                , SET(CAST(
                        COLLECT(subjects.subj_name)
                        AS V2u_Vchars1K_t
                  )) subj_names1k
                , SET(CAST(
                        COLLECT(subjects.subj_credit_kind)
                        AS V2u_Vchars1K_t
                  )) subj_credit_kinds1k
                , SET(CAST(
                        COLLECT(grades.subj_grade)
                        AS V2u_Vchars1K_t
                  )) subj_grades1k
                , SET(CAST(
                        COLLECT(ma_przedm_j.prz_kod)
                        AS V2u_Vchars1K_t
                  )) prz_kody1k
                , COUNT(ma_przedm_j.prz_kod) dbg_matched
                , COUNT(mi_przedm_j.job_uuid) dbg_missing
                , COUNT(sm_j.map_id) dbg_mapped

            FROM v2u_ko_subject_semesters_j ss_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = ss_j.subject_id
                        AND subjects.job_uuid = ss_j.job_uuid
                    )
            INNER JOIN v2u_ko_specialties specialties
                ON  (
                            specialties.id = ss_j.specialty_id
                        AND specialties.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_przedm_j ma_przedm_j
                ON  (
                            ma_przedm_j.subject_id = ss_j.subject_id
                        AND ma_przedm_j.specialty_id = ss_j.specialty_id
                        AND ma_przedm_j.semester_id = ss_j.semester_id
                        AND ma_przedm_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_przedm_j mi_przedm_j
                ON  (
                            mi_przedm_j.subject_id = ss_j.subject_id
                        AND mi_przedm_j.specialty_id = ss_j.specialty_id
                        AND mi_przedm_j.semester_id = ss_j.semester_id
                        AND mi_przedm_j.job_uuid = ss_j.job_uuid
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
            LEFT JOIN v2u_faculties faculties
                ON  (
                            faculties.abbriev = specialties.faculty
                    )
            GROUP BY
                  ss_j.job_uuid
                , COALESCE(subject_map.map_subj_code, subjects.subj_code)
        ),
        u AS
        ( -- make necessary adjustments to the raw values selected i u_0
            SELECT
                  u_0.job_uuid
                , u_0.coalesced_subj_code

                -- select first element from each collection
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , ( SELECT SUBSTR(VALUE(t), 1, 200)
                    FROM TABLE(u_0.map_subj_names1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_name
                , ( SELECT SUBSTR(VALUE(t), 1, 3)
                    FROM TABLE(u_0.map_subj_languages1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_lang
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_org_units1k) t
                    WHERE ROWNUM <= 1
                  ) map_org_unit
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_org_unit_recipients1k) t
                    WHERE ROWNUM <= 1
                  ) map_org_unit_recipient
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_proto_types1k) t
                    WHERE ROWNUM <= 1
                  ) map_proto_type
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_grade_types1k) t
                    WHERE ROWNUM <= 1
                  ) map_grade_type
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.faculty_codes1k) t
                    WHERE ROWNUM <= 1
                  ) faculty_code
                , ( SELECT SUBSTR(VALUE(t), 1, 200)
                    FROM TABLE(u_0.subj_names1k) t
                    WHERE ROWNUM <= 1
                  ) subj_name
                , ( SELECT SUBSTR(VALUE(t), 1, 16)
                    FROM TABLE(u_0.subj_credit_kinds1k) t
                    WHERE ROWNUM <= 1
                  ) subj_credit_kind
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.prz_kody1k) t
                    WHERE ROWNUM <= 1
                  ) prz_kod
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u_0.subj_grades1k) t
                  ) AS V2u_Subj_Grades_t) subj_grades

                -- columns used for debugging
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_codes1k)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_subj_codes1k)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_subj_names1k)
                  ) dbg_map_subj_names
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_subj_languages1k)
                  ) dbg_languages
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_org_units1k)
                  ) dbg_org_units
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_org_unit_recipients1k)
                  ) dbg_org_unit_recipients
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_proto_types1k)
                  ) dbg_map_proto_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_grade_types1k)
                  ) dbg_map_grade_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.faculty_codes1k)
                  ) dbg_faculty_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_names1k)
                  ) dbg_subj_names
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_credit_kinds1k)
                  ) dbg_subj_credit_kinds
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prz_kody1k)
                  ) dbg_prz_kody

                , u_0.dbg_matched
                , u_0.dbg_missing
                , u_0.dbg_mapped
            FROM u_0 u_0
        ),
        v AS
        ( -- determine our (v$*) values for certain fields
            SELECT
                  u.*

                , u.map_subj_code v$kod
                , COALESCE(u.map_subj_name, u.subj_name) v$nazwa
                , COALESCE(u.map_org_unit, u.faculty_code) v$jed_org_kod
                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id
                , COALESCE(u.map_proto_type, V2u_Get.Tpro_Kod(
                          subj_credit_kind => u.subj_credit_kind
                        , subj_grades => u.subj_grades
                  )) v$tpro_kod
                , COALESCE(u.map_org_unit_recipient, u.faculty_code) v$jed_org_kod_biorca
                , u.map_subj_lang v$jzk_kod

                -- did we found unique row in the target table?
                , CASE
                    WHEN    u.dbg_matched > 0
                        AND u.dbg_mapped = u.dbg_matched
                        AND u.dbg_missing = 0
                        AND u.dbg_prz_kody = 1 AND u.prz_kod IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                -- examine values we gonna propose
                , CASE
                    WHEN
                        -- all the instances were consistent
                            u.dbg_subj_names <= 1
                        AND u.dbg_languages = 1
                        AND u.dbg_org_units <= 1
                        AND u.dbg_org_unit_recipients <= 1
                        AND u.dbg_map_proto_types <= 1
                        AND u.dbg_map_grade_types <= 1
                        AND u.dbg_faculty_codes = 1
                        AND u.dbg_subj_names = 1
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
        ( -- provide our values (v$*) and original ones (u$*)
            SELECT
                  v.*
                , t.kod u$kod
                , t.nazwa u$nazwa
                , t.jed_org_kod u$jed_org_kod
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.tpro_kod u$tpro_kod
                , t.czy_wielokrotne u$czy_wielokrotne
                , t.name u$name
                , t.skrocony_opis u$skrocony_opis
                , t.short_description u$short_description
                , t.jed_org_kod_biorca u$jed_org_kod_biorca
                , t.jzk_kod u$jzk_kod
                , t.kod_sok u$kod_sok
                , t.opis u$opis
                , t.description u$description
                , t.literatura u$literatura
                , t.bibliography u$bibliography
                , t.efekty_uczenia u$efekty_uczenia
                , t.efekty_uczenia_ang u$efekty_uczenia_ang
                , t.kryteria_oceniania u$kryteria_oceniania
                , t.kryteria_oceniania_ang u$kryteria_oceniania_ang
                , t.praktyki_zawodowe u$praktyki_zawodowe
                , t.praktyki_zawodowe_ang u$praktyki_zawodowe_ang
                , t.url u$url
                , t.kod_isced u$kod_isced
                , t.nazwa_pol u$nazwa_pol
                , t.guid u$guid
                , t.pw_nazwa_supl u$pw_nazwa_supl
                , t.pw_nazwa_supl_ang u$pw_nazwa_supl_ang

                -- is it insert, update or nothing?

                , DECODE( v.dbg_unique_match, 1
                        , (CASE
                            WHEN    -- do we introduce any modification?
                                    DECODE(v.v$kod, t.kod, 1, 0) = 1
                                AND DECODE(UPPER(v.v$nazwa), UPPER(t.nazwa), 1, 0) = 1
                                AND DECODE(v.v$jed_org_kod, t.jed_org_kod, 1, 0) = 1
                                AND DECODE(v.v$tpro_kod, t.tpro_kod, 1, 0) = 1
                                AND DECODE(v.v$jed_org_kod_biorca, t.jed_org_kod_biorca, 1, 0) = 1
                                AND DECODE(v.v$jzk_kod, t.jzk_kod, 1, 0) = 1
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
            LEFT JOIN v2u_dz_przedmioty t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.kod = v.prz_kod
                    )
        )
        SELECT
              w.job_uuid
            , w.coalesced_subj_code pk_subject

            , DECODE(w.change_type, 'I', w.v$kod, w.u$kod) kod
            , DECODE(w.change_type, '-', w.u$nazwa, w.v$nazwa) nazwa
            , DECODE(w.change_type, '-', w.u$jed_org_kod, w.v$jed_org_kod) jed_org_kod

            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data

            , DECODE(w.change_type, '-', w.u$tpro_kod, w.v$tpro_kod) tpro_kod
            , DECODE(w.change_type, 'I', NULL, w.u$czy_wielokrotne) czy_wielokrotne
            , DECODE(w.change_type, 'I', NULL, w.u$name) name
            , DECODE(w.change_type, 'I', NULL, w.u$skrocony_opis) skrocony_opis
            , DECODE(w.change_type, 'I', NULL, w.u$short_description) short_description
            , DECODE(w.change_type, '-', w.u$jed_org_kod_biorca, w.v$jed_org_kod_biorca) jed_org_kod_biorca
            , DECODE(w.change_type, '-', w.u$jzk_kod, w.v$jzk_kod) jzk_kod
            , DECODE(w.change_type, 'I', NULL, w.u$kod_sok) kod_sok
            , DECODE(w.change_type, 'I', NULL, w.u$opis) opis
            , DECODE(w.change_type, 'I', NULL, w.u$description) description
            , DECODE(w.change_type, 'I', NULL, w.u$literatura) literatura
            , DECODE(w.change_type, 'I', NULL, w.u$bibliography) bibliography
            , DECODE(w.change_type, 'I', NULL, w.u$efekty_uczenia) efekty_uczenia
            , DECODE(w.change_type, 'I', NULL, w.u$efekty_uczenia_ang) efekty_uczenia_ang
            , DECODE(w.change_type, 'I', NULL, w.u$kryteria_oceniania) kryteria_oceniania
            , DECODE(w.change_type, 'I', NULL, w.u$kryteria_oceniania_ang) kryteria_oceniania_ang
            , DECODE(w.change_type, 'I', NULL, w.u$praktyki_zawodowe) praktyki_zawodowe
            , DECODE(w.change_type, 'I', NULL, w.u$praktyki_zawodowe_ang) praktyki_zawodowe_ang
            , DECODE(w.change_type, 'I', NULL, w.u$url) url
            , DECODE(w.change_type, 'I', NULL, w.u$kod_isced) kod_isced
            , DECODE(w.change_type, 'I', NULL, w.u$nazwa_pol) nazwa_pol
            , DECODE(w.change_type, 'I', NULL, w.u$guid) guid
            , DECODE(w.change_type, 'I', NULL, w.u$pw_nazwa_supl) pw_nazwa_supl
            , DECODE(w.change_type, 'I', NULL, w.u$pw_nazwa_supl_ang) pw_nazwa_supl_ang

            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
              ) safe_to_change

            , w.dbg_subj_codes
            , w.dbg_map_subj_codes
            , w.dbg_map_subj_names
            , w.dbg_languages
            , w.dbg_org_units
            , w.dbg_org_unit_recipients
            , w.dbg_map_proto_types
            , w.dbg_map_grade_types
            , w.dbg_faculty_codes
            , w.dbg_subj_names
            , w.dbg_subj_credit_kinds
            , w.dbg_prz_kody
            , w.dbg_values_ok
            , w.dbg_unique_match
            , w.dbg_matched
            , w.dbg_missing
            , w.dbg_mapped
        FROM w w
    ) src
ON  (
            tgt.pk_subject = src.pk_subject
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( kod
        , nazwa
        , jed_org_kod
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , tpro_kod
        , czy_wielokrotne
        , name
        , skrocony_opis
        , short_description
        , jed_org_kod_biorca
        , jzk_kod
        , kod_sok
        , opis
        , description
        , literatura
        , bibliography
        , efekty_uczenia
        , efekty_uczenia_ang
        , kryteria_oceniania
        , kryteria_oceniania_ang
        , praktyki_zawodowe
        , praktyki_zawodowe_ang
        , url
        , kod_isced
        , nazwa_pol
        , guid
        , pw_nazwa_supl
        , pw_nazwa_supl_ang
        -- KEY
        , job_uuid
        , pk_subject
        -- DBG
        , dbg_subj_codes
        , dbg_map_subj_codes
        , dbg_map_subj_names
        , dbg_languages
        , dbg_org_units
        , dbg_org_unit_recipients
        , dbg_map_proto_types
        , dbg_map_grade_types
        , dbg_faculty_codes
        , dbg_subj_names
        , dbg_subj_credit_kinds
        , dbg_prz_kody
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
        ( src.kod
        , src.nazwa
        , src.jed_org_kod
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.tpro_kod
        , src.czy_wielokrotne
        , src.name
        , src.skrocony_opis
        , src.short_description
        , src.jed_org_kod_biorca
        , src.jzk_kod
        , src.kod_sok
        , src.opis
        , src.description
        , src.literatura
        , src.bibliography
        , src.efekty_uczenia
        , src.efekty_uczenia_ang
        , src.kryteria_oceniania
        , src.kryteria_oceniania_ang
        , src.praktyki_zawodowe
        , src.praktyki_zawodowe_ang
        , src.url
        , src.kod_isced
        , src.nazwa_pol
        , src.guid
        , src.pw_nazwa_supl
        , src.pw_nazwa_supl_ang
        -- KEY
        , src.job_uuid
        , src.pk_subject
        -- DBG
        , src.dbg_subj_codes
        , src.dbg_map_subj_codes
        , src.dbg_map_subj_names
        , src.dbg_languages
        , src.dbg_org_units
        , src.dbg_org_unit_recipients
        , src.dbg_map_proto_types
        , src.dbg_map_grade_types
        , src.dbg_faculty_codes
        , src.dbg_subj_names
        , src.dbg_subj_credit_kinds
        , src.dbg_prz_kody
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
          tgt.kod = src.kod
        , tgt.nazwa = src.nazwa
        , tgt.jed_org_kod = src.jed_org_kod
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.tpro_kod = src.tpro_kod
        , tgt.czy_wielokrotne = src.czy_wielokrotne
        , tgt.name = src.name
        , tgt.skrocony_opis = src.skrocony_opis
        , tgt.short_description = src.short_description
        , tgt.jed_org_kod_biorca = src.jed_org_kod_biorca
        , tgt.jzk_kod = src.jzk_kod
        , tgt.kod_sok = src.kod_sok
        , tgt.opis = src.opis
        , tgt.description = src.description
        , tgt.literatura = src.literatura
        , tgt.bibliography = src.bibliography
        , tgt.efekty_uczenia = src.efekty_uczenia
        , tgt.efekty_uczenia_ang = src.efekty_uczenia_ang
        , tgt.kryteria_oceniania = src.kryteria_oceniania
        , tgt.kryteria_oceniania_ang = src.kryteria_oceniania_ang
        , tgt.praktyki_zawodowe = src.praktyki_zawodowe
        , tgt.praktyki_zawodowe_ang = src.praktyki_zawodowe_ang
        , tgt.url = src.url
        , tgt.kod_isced = src.kod_isced
        , tgt.nazwa_pol = src.nazwa_pol
        , tgt.guid = src.guid
        , tgt.pw_nazwa_supl = src.pw_nazwa_supl
        , tgt.pw_nazwa_supl_ang = src.pw_nazwa_supl_ang
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_subject = src.pk_subject
        -- DBG
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_map_subj_names = src.dbg_map_subj_names
        , tgt.dbg_languages = src.dbg_languages
        , tgt.dbg_org_units = src.dbg_org_units
        , tgt.dbg_org_unit_recipients = src.dbg_org_unit_recipients
        , tgt.dbg_map_proto_types = src.dbg_map_proto_types
        , tgt.dbg_map_grade_types = src.dbg_map_grade_types
        , tgt.dbg_faculty_codes = src.dbg_faculty_codes
        , tgt.dbg_subj_names = src.dbg_subj_names
        , tgt.dbg_subj_credit_kinds = src.dbg_subj_credit_kinds
        , tgt.dbg_prz_kody = src.dbg_prz_kody
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
