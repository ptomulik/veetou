MERGE INTO v2u_uu_punkty_przedmiotow tgt
USING
    (
        u_00 AS
        (
            SELECT
                  ss_j.job_uuid
                , ss_j.subject_id
                , ss_j.specialty_id
                , ss_j.semester_id
                , subjects.subject_code
                , semesters.semester_code
                , SUBSTR(
                    specialties.university
                    || ':' ||
                    specialties.faculty
                    || ':' ||
                    V2U_Get.Studies_Tier(specialties.studies_modetier)
                    || ':' ||
                    V2U_Get.Studies_Mode(specialties.studies_modetier)
                    || ':' ||
                    V2U_Get.Acronym(specialties.studies_field)
                    || ':' ||
                    V2U_Get.Acronym(specialties.studies_specialty)
                  , 1, 128
                  ) specialty_string
            FROM v2u_ko_subject_semesters_j ss_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = ss_j.subject_id
                        AND subject.job_uuid = ss_j.job_uuid
                    )
            INNER JOIN v2u_ko_specialties specialties
                ON  (
                            specialties.id = ss_j.specialty_id
                        AND specialties.job_uuid = ss_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = ss_j.semester_id
                        AND semesters.job_uuid = ss_j.job_uuid
                    )
        ),
        u_0 AS
        (
            -- determine what to use as a single output row;
            SELECT
                  u_00.job_uuid
                , COALESCE(
                      TO_CHAR(ma_prgos_j.prgos_id)
                    , CASE
                        WHEN specialty_map.map_program_code IS NULL
                        THEN NULL
                        ELSE specialty_map.map_program_code
                             || '|' ||
                             u_00.semester_code
                        END
                    , u_00.specialty_string
                      || '|' ||
                      u_00.semester_code
                  ) coalesced_program_code
                , COALESCE(
                          subject_map.map_subj_code
                        , subjects.subj_code
                  ) coalesced_subj_code
--                , SET(CAST(
--                        COLLECT(subjects.subj_code)
--                        AS V2u_Vchars1K_t
--                  )) subj_codes1k
--                , SET(CAST(
--                        COLLECT(subject_map.map_subj_code)
--                        AS V2u_Vchars1K_t
--                  )) map_subj_codes1k
--                , SET(CAST(
--                        COLLECT(subject_map.map_subj_name)
--                        AS V2u_Vchars1K_t
--                  )) map_subj_names1k
--                , SET(CAST(
--                        COLLECT(subject_map.map_subj_lang)
--                        AS V2u_Vchars1K_t
--                  )) map_subj_languages1k
--                , SET(CAST(
--                        COLLECT(subject_map.map_org_unit)
--                        AS V2u_Vchars1K_t
--                  )) map_org_units1k
--                , SET(CAST(
--                        COLLECT(subject_map.map_org_unit_recipient)
--                        AS V2u_Vchars1K_t
--                  )) map_org_unit_recipients1k
--                , SET(CAST(
--                        COLLECT(subject_map.map_proto_type)
--                        AS V2u_Vchars1K_t
--                  )) map_proto_types1k
--                , SET(CAST(
--                        COLLECT(subject_map.map_grade_type)
--                        AS V2u_Vchars1K_t
--                  )) map_grade_types1k
--                , SET(CAST(
--                        COLLECT(faculties.code)
--                        AS V2u_Vchars1K_t
--                  )) faculty_codes1k
--                , SET(CAST(
--                        COLLECT(subjects.subj_name)
--                        AS V2u_Vchars1K_t
--                  )) subj_names1k
--                , SET(CAST(
--                        COLLECT(subjects.subj_credit_kind)
--                        AS V2u_Vchars1K_t
--                  )) subj_credit_kinds1k
--                , SET(CAST(
--                        COLLECT(grades.subj_grade)
--                        AS V2u_Vchars1K_t
--                  )) subj_grades1k
--                , SET(CAST(
--                        COLLECT(ma_przedm_j.prz_kod)
--                        AS V2u_Vchars1K_t
--                  )) prz_kody1k
--                , COUNT(ma_przedm_j.prz_kod) dbg_matched
--                , COUNT(mi_przedm_j.job_uuid) dbg_missing
--                , COUNT(sm_j.map_id) dbg_mapped

            FROM u_00 u_00
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

--            , DECODE(w.change_type, 'I', w.v$kod, w.u$kod) kod

            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data


            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
              ) safe_to_change

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
        ( prz_kod
        , prg_kod
        , tpkt_kod
        , ilosc
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , id
        , cdyd_pocz
        , cdyd_kon
        -- KEY
        , job_uuid
        , pk_punkty_przedmiotu
        -- DBG
        -- CTL
        , change_type
        , safe_to_change
        )
    VALUES
        ( src.prz_kod
        , src.prg_kod
        , src.tpkt_kod
        , src.ilosc
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.id
        , src.cdyd_pocz
        , src.cdyd_kon
        -- src.KEY
        , src.job_uuid
        , src.pk_punkty_przedmiotu
        -- src.DBG
        -- src.CTL
        , src.change_type
        , src.safe_to_change
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.prz_kod = src.prz_kod
        , tgt.prg_kod = src.prg_kod
        , tgt.tpkt_kod = src.tpkt_kod
        , tgt.ilosc = src.ilosc
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.id = src.id
        , tgt.cdyd_pocz = src.cdyd_pocz
        , tgt.cdyd_kon = src.cdyd_kon
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_punkty_przedmiotu = src.pk_punkty_przedmiotu
        -- DBG
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
