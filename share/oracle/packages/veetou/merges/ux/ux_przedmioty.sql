MERGE INTO v2u_ux_przedmioty tgt
USING
    (
        WITH u AS
        (
            SELECT
                  ss_j.job_uuid
                , COALESCE(
                          subject_map.map_subj_code
                        , subjects.subj_code
                  ) coalesced_subj_code
                , SET(CAST(
                        COLLECT(subjects.subj_code)
                        AS V2u_Vchars1K_t
                  )) subj_codes
                , SET(CAST(
                        COLLECT(subject_map.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes
                , SET(CAST(
                        COLLECT(subject_map.map_subj_lang)
                        AS V2u_Vchars1K_t
                  )) map_subj_languages
                , SET(CAST(
                        COLLECT(subject_map.map_org_unit)
                        AS V2u_Vchars1K_t
                  )) map_org_units
                , SET(CAST(
                        COLLECT(subject_map.map_org_unit_recipient)
                        AS V2u_Vchars1K_t
                  )) map_org_unit_recipients
                , SET(CAST(
                        COLLECT(faculties.code)
                        AS V2u_Vchars1K_t
                  )) faculty_codes
                , SET(CAST(
                        COLLECT(subjects.subj_name)
                        AS V2u_Vchars1K_t
                  )) subj_names
                , SET(CAST(
                        COLLECT(subjects.subj_credit_kind)
                        AS V2u_Vchars1K_t
                  )) subj_credit_kinds
                , SET(CAST(
                        COLLECT(grades.subj_grade)
                        AS V2u_Vchars1K_t
                  )) subj_grades
                , SET(CAST(
                        COLLECT(ma_przedm_j.prz_kod)
                        AS V2u_Vchars1K_t
                  )) prz_kody
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
        v AS
        (
            SELECT
                  u.job_uuid
                , u.coalesced_subj_code

                -- select first element from each collection
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.map_subj_codes) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , ( SELECT SUBSTR(VALUE(t), 1, 3)
                    FROM TABLE(u.map_subj_languages) t
                    WHERE ROWNUM <= 1
                  ) map_subj_lang
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.map_org_units) t
                    WHERE ROWNUM <= 1
                  ) map_org_unit
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.map_org_unit_recipients) t
                    WHERE ROWNUM <= 1
                  ) map_org_unit_recipient
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.faculty_codes) t
                    WHERE ROWNUM <= 1
                  ) faculty_code
                , ( SELECT SUBSTR(VALUE(t), 1, 200)
                    FROM TABLE(u.subj_names) t
                    WHERE ROWNUM <= 1
                  ) subj_name
                , ( SELECT SUBSTR(VALUE(t), 1, 16)
                    FROM TABLE(u.subj_credit_kinds) t
                    WHERE ROWNUM <= 1
                  ) subj_credit_kind
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.prz_kody) t
                    WHERE ROWNUM <= 1
                  ) prz_kod
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u.subj_grades) t
                  ) AS V2u_Subj_Grades_t) subj_grades

                -- columns used for debugging
                , ( SELECT COUNT(*)
                    FROM TABLE(u.subj_codes)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u.map_subj_codes)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u.map_subj_languages)
                  ) dbg_languages
                , ( SELECT COUNT(*)
                    FROM TABLE(u.map_org_units)
                  ) dbg_org_units
                , ( SELECT COUNT(*)
                    FROM TABLE(u.map_org_unit_recipients)
                  ) dbg_org_unit_recipients
                , ( SELECT COUNT(*)
                    FROM TABLE(u.faculty_codes)
                  ) dbg_faculty_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u.subj_names)
                  ) dbg_subj_names
                , ( SELECT COUNT(*)
                    FROM TABLE(u.subj_credit_kinds)
                  ) dbg_subj_credit_kinds
                , ( SELECT COUNT(*)
                    FROM TABLE(u.prz_kody)
                  ) dbg_prz_kody

                , u.dbg_matched
                , u.dbg_missing
                , u.dbg_mapped
            FROM u u
        ),
        w AS
        (
            SELECT
                  v.*

                , v.map_subj_code new_kod
                , v.subj_name new_nazwa
                , COALESCE(v.map_org_unit, v.faculty_code) new_jed_org_kod
                , V2u_Get.Utw_Id(v.job_uuid) new_utw_id
                , V2u_Get.Mod_Id(v.job_uuid) new_mod_id
                , V2u_Get.Tpro_Kod(
                          subj_credit_kind => v.subj_credit_kind
                        , subj_grades => v.subj_grades
                  ) new_tpro_kod
                , COALESCE(v.map_org_unit_recipient, v.faculty_code) new_jed_org_kod_biorca
                , v.map_subj_lang new_jzk_kod

                , CASE
                    WHEN    v.dbg_matched > 0
                        AND v.dbg_mapped = v.dbg_matched
                        AND v.dbg_missing = 0
                        AND v.dbg_prz_kody = 1
                        AND v.dbg_prz_kody IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_unique_match
            FROM v v
        )
        SELECT
              w.job_uuid
            , w.coalesced_subj_code pk_subject

            , DECODE(w.dbg_unique_match, 1, przedmioty.kod, w.new_kod) kod
            , DECODE(w.dbg_unique_match, 1, przedmioty.nazwa, w.new_nazwa) nazwa
            , DECODE(w.dbg_unique_match, 1, przedmioty.jed_org_kod, w.new_jed_org_kod) jed_org_kod
            , DECODE(w.dbg_unique_match, 1, przedmioty.utw_id, w.new_utw_id) utw_id
            , DECODE(w.dbg_unique_match, 1, przedmioty.utw_data, NULL) utw_data
            , DECODE(w.dbg_unique_match, 1, przedmioty.mod_id, w.new_mod_id) mod_id
            , DECODE(w.dbg_unique_match, 1, przedmioty.mod_data, NULL) mod_data
            , DECODE(w.dbg_unique_match, 1, przedmioty.tpro_kod, w.new_tpro_kod) tpro_kod
            , DECODE(w.dbg_unique_match, 1, przedmioty.czy_wielokrotne, NULL) czy_wielokrotne
            , DECODE(w.dbg_unique_match, 1, przedmioty.name, NULL) name
            , DECODE(w.dbg_unique_match, 1, przedmioty.skrocony_opis, NULL) skrocony_opis
            , DECODE(w.dbg_unique_match, 1, przedmioty.short_description, NULL) short_description
            , DECODE(w.dbg_unique_match, 1, przedmioty.jed_org_kod_biorca, w.new_jed_org_kod_biorca) jed_org_kod_biorca
            , DECODE(w.dbg_unique_match, 1, przedmioty.jzk_kod, w.new_jzk_kod) jzk_kod
            , DECODE(w.dbg_unique_match, 1, przedmioty.kod_sok, NULL) kod_sok
            , DECODE(w.dbg_unique_match, 1, przedmioty.opis, NULL) opis
            , DECODE(w.dbg_unique_match, 1, przedmioty.description, NULL) description
            , DECODE(w.dbg_unique_match, 1, przedmioty.literatura, NULL) literatura
            , DECODE(w.dbg_unique_match, 1, przedmioty.bibliography, NULL) bibliography
            , DECODE(w.dbg_unique_match, 1, przedmioty.efekty_uczenia, NULL) efekty_uczenia
            , DECODE(w.dbg_unique_match, 1, przedmioty.efekty_uczenia_ang, NULL) efekty_uczenia_ang
            , DECODE(w.dbg_unique_match, 1, przedmioty.kryteria_oceniania, NULL) kryteria_oceniania
            , DECODE(w.dbg_unique_match, 1, przedmioty.kryteria_oceniania_ang, NULL) kryteria_oceniania_ang
            , DECODE(w.dbg_unique_match, 1, przedmioty.praktyki_zawodowe, NULL) praktyki_zawodowe
            , DECODE(w.dbg_unique_match, 1, przedmioty.praktyki_zawodowe_ang, NULL) praktyki_zawodowe_ang
            , DECODE(w.dbg_unique_match, 1, przedmioty.url, NULL) url
            , DECODE(w.dbg_unique_match, 1, przedmioty.kod_isced, NULL) kod_isced
            , DECODE(w.dbg_unique_match, 1, przedmioty.nazwa_pol, NULL) nazwa_pol
            , DECODE(w.dbg_unique_match, 1, przedmioty.guid, NULL) guid
            , DECODE(w.dbg_unique_match, 1, przedmioty.pw_nazwa_supl, NULL) pw_nazwa_supl
            , DECODE(w.dbg_unique_match, 1, przedmioty.pw_nazwa_supl_ang, NULL) pw_nazwa_supl_ang

            , w.dbg_subj_codes
            , w.dbg_map_subj_codes
            , w.dbg_languages
            , w.dbg_org_units
            , w.dbg_org_unit_recipients
            , w.dbg_faculty_codes
            , w.dbg_subj_names
            , w.dbg_subj_credit_kinds
            , w.dbg_prz_kody
            , w.dbg_unique_match
            , w.dbg_matched
            , w.dbg_missing
            , w.dbg_mapped
            ---
            , CASE
                WHEN
                    -- ensure that
                    -- we have target subject code
                        w.map_subj_code IS NOT NULL
                    AND w.dbg_map_subj_codes = 1
                    AND w.dbg_subj_codes > 0
                    -- maps for all instances existed but there were no
                    -- corresponding subject in target system
                    AND w.dbg_matched = 0
                    AND w.dbg_missing > 0
                    AND w.dbg_mapped = w.dbg_missing
                    -- all the instances were consistent
                    AND w.dbg_languages = 1
                    AND w.dbg_org_units <= 1
                    AND w.dbg_org_unit_recipients <= 1
                    AND w.dbg_faculty_codes = 1
                    AND w.dbg_subj_names = 1
                    AND w.dbg_subj_credit_kinds = 1
                    -- and we have correct tpro_kod value
                    AND V2u_Get.Tpro_Kod(
                          subj_credit_kind => w.subj_credit_kind
                        , subj_grades => w.subj_grades
                        ) <> '?'
                THEN 1
                ELSE 0
                END safe_to_add
        FROM w w
        LEFT JOIN v2u_dz_przedmioty przedmioty
            ON  (
                        dbg_unique_match = 1
                    AND przedmioty.kod = w.prz_kod
                )
    ) src
ON  (
            tgt.pk_subject = src.pk_subject
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , pk_subject
        , kod
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
        , dbg_subj_codes
        , dbg_map_subj_codes
        , dbg_languages
        , dbg_org_units
        , dbg_org_unit_recipients
        , dbg_faculty_codes
        , dbg_subj_names
        , dbg_subj_credit_kinds
        , dbg_prz_kody
        , dbg_unique_match
        , dbg_matched
        , dbg_missing
        , dbg_mapped
        , safe_to_add
        )
    VALUES
        ( src.job_uuid
        , src.pk_subject
        , src.kod
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
        , src.dbg_subj_codes
        , src.dbg_map_subj_codes
        , src.dbg_languages
        , src.dbg_org_units
        , src.dbg_org_unit_recipients
        , src.dbg_faculty_codes
        , src.dbg_subj_names
        , src.dbg_subj_credit_kinds
        , src.dbg_prz_kody
        , src.dbg_unique_match
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_mapped
        , src.safe_to_add
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
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_languages = src.dbg_languages
        , tgt.dbg_org_units = src.dbg_org_units
        , tgt.dbg_org_unit_recipients = src.dbg_org_unit_recipients
        , tgt.dbg_faculty_codes = src.dbg_faculty_codes
        , tgt.dbg_subj_names = src.dbg_subj_names
        , tgt.dbg_subj_credit_kinds = src.dbg_subj_credit_kinds
        , tgt.dbg_prz_kody = src.dbg_prz_kody
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_mapped = src.dbg_mapped
        , tgt.safe_to_add = src.safe_to_add
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
