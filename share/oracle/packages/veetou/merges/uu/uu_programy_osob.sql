MERGE INTO v2u_uu_programy_osob tgt
USING
    (
        WITH u_00 AS
        (
            SELECT
                  ss_j.job_uuid
                , ss_j.student_id
                , ss_j.specialty_id
                , ss_j.semester_id
                , students.student_index
                , V2U_Get.Faculty(specialties.faculty).code faculty_code
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
                    || '|' ||
                    semesters.semester_code
                  , 1, 128
                  ) specialty_string
            FROM v2u_ko_student_semesters_j ss_j
            INNER JOIN v2u_ko_students students
                ON  (
                            students.id = ss_j.student_id
                        AND students.job_uuid = ss_j.job_uuid
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
        ( -- decide what to use as a single row
            SELECT

                -- key

                  u_00.job_uuid
                , u_00.student_index
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
                  ) coalesced_program_osoby

                -- values

                , SET(CAST(
                    COLLECT(specialty_map.map_program_code)
                    AS V2u_Vchars1K_t
                  )) map_program_codes1k
                , SET(CAST(
                    COLLECT(specialty_map.map_org_unit)
                    AS V2u_Vchars1K_t
                  )) map_org_units1k
                , SET(CAST(
                    COLLECT(u_00.faculty_code)
                    AS V2u_Vchars1K_t
                  )) faculty_codes1k
                , SET(CAST(
                    COLLECT(ma_prgos_j.prgos_id)
                    AS V2u_Dz_Ids_t
                  )) ids
                , SET(CAST(
                    COLLECT(ma_prgos_j.prg_kod)
                    AS V2u_Vchars1K_t
                  )) prg_kody1k
                , SET(CAST(
                    COLLECT(studenci.id ORDER BY studenci.id)
                    AS V2u_Dz_Ids_t
                  )) st_ids
                , SET(CAST(
                    COLLECT(studenci.os_id ORDER BY studenci.id)
                    AS V2u_Dz_Ids_t
                  )) os_ids
                , SET(CAST(
                    COLLECT(sk_progs_j.prg_kod)
                    AS V2u_Vchars1K_t
                  )) skipped_prg_kody1k

                -- debugging

                , COUNT(ma_prgos_j.prgos_id) dbg_matched
                , COUNT(mi_prgos_j.job_uuid) dbg_missing
                , COUNT(sm_j.map_id) dbg_mapped

            FROM u_00 u_00
            LEFT JOIN v2u_ko_matched_prgos_j ma_prgos_j
                ON  (
                            ma_prgos_j.student_id = u_00.student_id
                        AND ma_prgos_j.specialty_id = u_00.specialty_id
                        AND ma_prgos_j.semester_id = u_00.semester_id
                        AND ma_prgos_j.job_uuid = u_00.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_prgos_j mi_prgos_j
                ON  (
                            mi_prgos_j.student_id = u_00.student_id
                        AND mi_prgos_j.specialty_id = u_00.specialty_id
                        AND mi_prgos_j.semester_id = u_00.semester_id
                        AND mi_prgos_j.job_uuid = u_00.job_uuid
                    )
            LEFT JOIN v2u_ko_skipped_programs_j sk_progs_j
                ON  (
                            sk_progs_j.specialty_id =  u_00.specialty_id
                        AND sk_progs_j.semester_id = u_00.semester_id
                        AND sk_progs_j.job_uuid = u_00.job_uuid
                    )
            LEFT JOIN v2u_ko_specialty_map_j sm_j
                ON  (
                            sm_j.specialty_id = u_00.specialty_id
                        AND sm_j.semester_id = u_00.semester_id
                        AND sm_j.job_uuid = u_00.job_uuid
                    )
            LEFT JOIN v2u_specialty_map specialty_map
                ON  (
                            specialty_map.id = sm_j.map_id
                    )
            LEFT JOIN v2u_dz_studenci studenci
                ON  (
                            studenci.indeks = u_00.student_index
                    )
            GROUP BY
                  u_00.job_uuid
                , u_00.student_index
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
                  )
        ),
        u AS
        ( -- make necessary adjustments
            SELECT
                  -- pass through fields
                  u_0.job_uuid
                , u_0.student_index
                , u_0.coalesced_program_osoby

                -- values

                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_program_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_program_code
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_org_units1k) t
                    WHERE ROWNUM <= 1
                  ) map_org_unit
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.faculty_codes1k) t
                    WHERE ROWNUM <= 1
                  ) faculty_code
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.ids) t
                    WHERE ROWNUM <= 1
                  ) id
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.prg_kody1k) t
                    WHERE ROWNUM <= 1
                  ) prg_kod
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.st_ids) t
                    WHERE ROWNUM <= 1
                  ) st_id
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.os_ids) t
                    WHERE ROWNUM <= 1
                  ) os_id

                -- debugging

                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_program_codes1k)
                  ) dbg_map_program_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_org_units1k)
                  ) dbg_map_org_units
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.faculty_codes1k)
                  ) dbg_faculty_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.ids)
                  ) dbg_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prg_kody1k)
                  ) dbg_prg_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.st_ids)
                  ) dbg_st_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.os_ids)
                  ) dbg_os_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.skipped_prg_kody1k)
                  ) dbg_skipped_prg_kody


                , u_0.dbg_matched
                , u_0.dbg_missing
                , u_0.dbg_mapped

            FROM u_0 u_0
            LEFT JOIN v2u_dz_studenci studenci
                ON  (
                            studenci.indeks = u_0.student_index
                    )
        ),
        v AS
        ( -- determine our (v2u_*) values of certain fields
            SELECT
                  u.*
                , u.os_id v2u_os_id
                , u.st_id v2u_st_id
                --, u.map_program_code v2u_prg_kod
                , COALESCE(u.prg_kod, u.map_program_code) v2u_prg_kod
                , COALESCE(u.map_org_unit, u.faculty_code) v2u_jed_org_kod

                , V2u_Get.Utw_Id(u.job_uuid) v2u_utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v2u_mod_id

                -- have we matched unique row in target table?

                , CASE
                    WHEN
                            u.dbg_matched > 0
                        AND u.dbg_mapped = u.dbg_matched
                        AND u.dbg_missing = 0
                        AND u.dbg_ids = 1
                        AND u.id IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                -- examine values we found

                , CASE
                    WHEN
                        -- ensure that:
                        -- program code is determined uniquely
                           (u.prg_kod IS NOT NULL AND u.dbg_prg_kody = 1
                         OR u.map_program_code IS NOT NULL AND u.dbg_map_program_codes = 1)
                        AND u.dbg_map_program_codes = 1
                        AND u.dbg_prg_kody = 1
                        -- org_unit is determined uniquely
                        AND u.dbg_map_org_units <= 1
                        AND u.dbg_faculty_codes = 1
                        AND COALESCE(u.map_org_unit, u.faculty_code) IS NOT NULL
                        -- student is determined uniquely
                        AND u.os_id IS NOT NULL
                        AND u.dbg_os_ids = 1
                        AND u.st_id IS NOT NULL
                        AND u.dbg_st_ids = 1
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
        ),
        w AS
        ( -- provide our values (v2u_*) together with original ones (org_*)
            SELECT
                  v.*

                , t.os_id o$os_id
                , t.prg_kod o$prg_kod
                , t.utw_id o$utw_id
                , t.utw_data o$utw_data
                , t.mod_id o$mod_id
                , t.mod_data o$mod_data
                , t.st_id o$st_id
                , t.czy_glowny o$czy_glowny
                , t.id o$id
                , t.data_nast_zal o$data_nast_zal
                , t.uprawnienia_zawodowe o$uprawnienia_zawodowe
                , t.uprawnienia_zawodowe_ang o$uprawnienia_zawodowe_ang
                , t.jed_org_kod o$jed_org_kod
                , t.dok_upr_id o$dok_upr_id
                , t.data_przyjecia o$data_przyjecia
                , t.plan_data_ukon o$plan_data_ukon
                , t.czy_zgloszony o$czy_zgloszony
                , t.status o$status
                , t.data_rozpoczecia o$data_rozpoczecia
                , t.numer_s o$numer_s
                , t.numer_swiadectwa o$numer_swiadectwa
                , t.tecz_id o$tecz_id
                , t.data_arch o$data_arch
                , t.warunki_przyjec_na_prog o$warunkiprzyjec_na_prog
                , t.warunki_przyjec_na_prog_ang o$warunkiprzyjec_na_prog_ang
                , t.numer_do_banku o$numer_do_banku
                , t.numer_do_banku_sygn o$numer_do_banku_sygn
                , t.numer_5_proc o$numer_5_proc
                , t.numer_5_proc_sygn o$numer_5_proc_sygn
                , t.status_arch o$status_arch
                , t.osiagniecia o$osiagniecia
                , t.osiagniecia_ang o$osiagniecia_ang
                , t.nr_kierunku_ustawa o$nr_kierunku_ustawa
                , t.limit_ects o$limit_ects
                , t.dodatkowe_ects_uczelnia o$dodatkowe_ects_uczelnia
                , t.wykorzystane_ects_obce o$wykorzystane_ects_obce
                , t.limit_ects_podpiecia o$limit_ects_podpiecia
                , t.prgos_id o$prgos_id
                , t.osiagniecia_programu o$osiagniecia_programu
                , t.osiagniecia_programu_ang o$osiagniecia_programu_ang
                , t.wynik_studiow o$wynik_studiow
                , t.wynik_studiow_ang o$wynik_studiow_ang
                , t.umowa_data_przeczytania o$umowa_data_przeczytania
                , t.umowa_data_podpisania o$umowa_data_podpisania
                , t.umowa_sygnatura o$umowa_sygnatura
                , t.kod_isced o$kod_isced

                , DECODE( v.dbg_unique_match, 1
                        , CASE WHEN
                                    DECODE(v.v2u_os_id, t.os_id, 1, 0) = 1
                                AND DECODE(v.v2u_prg_kod, t.prg_kod, 1, 0) = 1
                                AND DECODE(v.v2u_st_id, t.st_id, 1, 0) = 1
                                AND DECODE(v.v2u_jed_org_kod, t.jed_org_kod, 1, 0) = 1
                            THEN '-'
                            ELSE 'U'
                          END
                        , 'I'
                  ) change_type

                , CASE
                    WHEN
                            -- no target ids are found
                                v.dbg_ids = 0
                            AND v.id IS NULL
                            -- maps for all instances existed but there were no
                            -- corresponding prgos in target system ...
                            AND v.dbg_matched = 0
                            AND v.dbg_missing > 0
                            AND v.dbg_mapped = v.dbg_missing
                            -- and we haven't skipped possibly matching programs
                            AND v.dbg_skipped_prg_kody = 0
                            -- values are correct
                            AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_insert

                , CASE
                    WHEN
                            -- single target id is found
                                v.dbg_ids = 1
                            AND v.id IS NOT NULL
                            -- maps for all instances existed but there were no
                            -- corresponding subject in target system
                            AND v.dbg_matched = 0
                            AND v.dbg_missing > 0
                            AND v.dbg_mapped = v.dbg_missing
                            -- and we haven't skipped possibly matching programs
                            AND v.dbg_skipped_prg_kody = 0
                            -- values are correct
                            AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_update
            FROM v v
            LEFT JOIN v2u_dz_programy_osob t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.id = v.id
                    )
        )
        SELECT
            -- KEY
              w.job_uuid
            , w.student_index pk_student
            , w.coalesced_program_osoby pk_program_osoby

            -- VAL

            , DECODE(w.change_type, '-', w.o$os_id, w.v2u_os_id) os_id
            , DECODE(w.change_type, '-', w.o$prg_kod, w.v2u_prg_kod) prg_kod
            , DECODE(w.change_type, 'I', w.v2u_utw_id, o$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, o$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v2u_mod_id, o$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, o$mod_data) mod_data
            , DECODE(w.change_type, '-', w.o$st_id, w.v2u_st_id) st_id
            , DECODE(w.change_type, 'I', NULL, w.o$czy_glowny) czy_glowny
            , w.id
            , DECODE(w.change_type, 'I', NULL, w.o$data_nast_zal) data_nast_zal
            , DECODE(w.change_type, 'I', NULL, w.o$uprawnienia_zawodowe) uprawnienia_zawodowe
            , DECODE(w.change_type, 'I', NULL, w.o$uprawnienia_zawodowe_ang) uprawnienia_zawodowe_ang
            , DECODE(w.change_type, '-', w.o$jed_org_kod, w.v2u_jed_org_kod) jed_org_kod
            , DECODE(w.change_type, 'I', NULL, w.o$dok_upr_id) dok_upr_id
            , DECODE(w.change_type, 'I', NULL, w.o$data_przyjecia) data_przyjecia
            , DECODE(w.change_type, 'I', NULL, w.o$plan_data_ukon) plan_data_ukon
            , DECODE(w.change_type, 'I', NULL, w.o$czy_zgloszony) czy_zgloszony
            , DECODE(w.change_type, 'I', NULL, w.o$status) status
            , DECODE(w.change_type, 'I', NULL, w.o$data_rozpoczecia) data_rozpoczecia
            , DECODE(w.change_type, 'I', NULL, w.o$numer_s) numer_s
            , DECODE(w.change_type, 'I', NULL, w.o$numer_swiadectwa) numer_swiadectwa
            , DECODE(w.change_type, 'I', NULL, w.o$tecz_id) tecz_id
            , DECODE(w.change_type, 'I', NULL, w.o$data_arch) data_arch
            , DECODE(w.change_type, 'I', NULL, w.o$warunkiprzyjec_na_prog) warunki_przyjec_na_prog
            , DECODE(w.change_type, 'I', NULL, w.o$warunkiprzyjec_na_prog_ang) warunki_przyjec_na_prog_ang
            , DECODE(w.change_type, 'I', NULL, w.o$numer_do_banku) numer_do_banku
            , DECODE(w.change_type, 'I', NULL, w.o$numer_do_banku_sygn) numer_do_banku_sygn
            , DECODE(w.change_type, 'I', NULL, w.o$numer_5_proc) numer_5_proc
            , DECODE(w.change_type, 'I', NULL, w.o$numer_5_proc_sygn) numer_5_proc_sygn
            , DECODE(w.change_type, 'I', NULL, w.o$status_arch) status_arch
            , DECODE(w.change_type, 'I', NULL, w.o$osiagniecia) osiagniecia
            , DECODE(w.change_type, 'I', NULL, w.o$osiagniecia_ang) osiagniecia_ang
            , DECODE(w.change_type, 'I', NULL, w.o$nr_kierunku_ustawa) nr_kierunku_ustawa
            , DECODE(w.change_type, 'I', NULL, w.o$limit_ects) limit_ects
            , DECODE(w.change_type, 'I', NULL, w.o$dodatkowe_ects_uczelnia) dodatkowe_ects_uczelnia
            , DECODE(w.change_type, 'I', NULL, w.o$wykorzystane_ects_obce) wykorzystane_ects_obce
            , DECODE(w.change_type, 'I', NULL, w.o$limit_ects_podpiecia) limit_ects_podpiecia
            , DECODE(w.change_type, 'I', NULL, w.o$prgos_id) prgos_id
            , DECODE(w.change_type, 'I', NULL, w.o$osiagniecia_programu) osiagniecia_programu
            , DECODE(w.change_type, 'I', NULL, w.o$osiagniecia_programu_ang) osiagniecia_programu_ang
            , DECODE(w.change_type, 'I', NULL, w.o$wynik_studiow) wynik_studiow
            , DECODE(w.change_type, 'I', NULL, w.o$wynik_studiow_ang) wynik_studiow_ang
            , DECODE(w.change_type, 'I', NULL, w.o$umowa_data_przeczytania) umowa_data_przeczytania
            , DECODE(w.change_type, 'I', NULL, w.o$umowa_data_podpisania) umowa_data_podpisania
            , DECODE(w.change_type, 'I', NULL, w.o$umowa_sygnatura) umowa_sygnatura
            , DECODE(w.change_type, 'I', NULL, w.o$kod_isced) kod_isced

            -- DBG

            , w.dbg_unique_match
            , w.dbg_map_program_codes
            , w.dbg_map_org_units
            , w.dbg_faculty_codes
            , w.dbg_ids
            , w.dbg_prg_kody
            , w.dbg_st_ids
            , w.dbg_os_ids
            , w.dbg_skipped_prg_kody
            , w.dbg_matched
            , w.dbg_missing
            , w.dbg_mapped

            -- CTL
            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
              ) safe_to_change

        FROM w w
    ) src
ON  (
            tgt.pk_student = src.pk_student
        AND tgt.pk_program_osoby = src.pk_program_osoby
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( os_id
        , prg_kod
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , st_id
        , czy_glowny
        , id
        , data_nast_zal
        , uprawnienia_zawodowe
        , uprawnienia_zawodowe_ang
        , jed_org_kod
        , dok_upr_id
        , data_przyjecia
        , plan_data_ukon
        , czy_zgloszony
        , status
        , data_rozpoczecia
        , numer_s
        , numer_swiadectwa
        , tecz_id
        , data_arch
        , warunki_przyjec_na_prog
        , warunki_przyjec_na_prog_ang
        , numer_do_banku
        , numer_do_banku_sygn
        , numer_5_proc
        , numer_5_proc_sygn
        , status_arch
        , osiagniecia
        , osiagniecia_ang
        , nr_kierunku_ustawa
        , limit_ects
        , dodatkowe_ects_uczelnia
        , wykorzystane_ects_obce
        , limit_ects_podpiecia
        , prgos_id
        , osiagniecia_programu
        , osiagniecia_programu_ang
        , wynik_studiow
        , wynik_studiow_ang
        , umowa_data_przeczytania
        , umowa_data_podpisania
        , umowa_sygnatura
        , kod_isced
        -- KEY
        , job_uuid
        , pk_student
        , pk_program_osoby
        -- DBG
        , dbg_unique_match
        , dbg_map_program_codes
        , dbg_map_org_units
        , dbg_faculty_codes
        , dbg_ids
        , dbg_prg_kody
        , dbg_st_ids
        , dbg_os_ids
        , dbg_skipped_prg_kody
        , dbg_matched
        , dbg_missing
        , dbg_mapped
        -- CTL
        , change_type
        , safe_to_change
        )
    VALUES
        ( src.os_id
        , src.prg_kod
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.st_id
        , src.czy_glowny
        , src.id
        , src.data_nast_zal
        , src.uprawnienia_zawodowe
        , src.uprawnienia_zawodowe_ang
        , src.jed_org_kod
        , src.dok_upr_id
        , src.data_przyjecia
        , src.plan_data_ukon
        , src.czy_zgloszony
        , src.status
        , src.data_rozpoczecia
        , src.numer_s
        , src.numer_swiadectwa
        , src.tecz_id
        , src.data_arch
        , src.warunki_przyjec_na_prog
        , src.warunki_przyjec_na_prog_ang
        , src.numer_do_banku
        , src.numer_do_banku_sygn
        , src.numer_5_proc
        , src.numer_5_proc_sygn
        , src.status_arch
        , src.osiagniecia
        , src.osiagniecia_ang
        , src.nr_kierunku_ustawa
        , src.limit_ects
        , src.dodatkowe_ects_uczelnia
        , src.wykorzystane_ects_obce
        , src.limit_ects_podpiecia
        , src.prgos_id
        , src.osiagniecia_programu
        , src.osiagniecia_programu_ang
        , src.wynik_studiow
        , src.wynik_studiow_ang
        , src.umowa_data_przeczytania
        , src.umowa_data_podpisania
        , src.umowa_sygnatura
        , src.kod_isced
        -- KEY
        , src.job_uuid
        , src.pk_student
        , src.pk_program_osoby
        -- DBG
        , src.dbg_unique_match
        , src.dbg_map_program_codes
        , src.dbg_map_org_units
        , src.dbg_faculty_codes
        , src.dbg_ids
        , src.dbg_prg_kody
        , src.dbg_st_ids
        , src.dbg_os_ids
        , src.dbg_skipped_prg_kody
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_mapped
        -- CTL
        , src.change_type
        , src.safe_to_change
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.os_id = src.os_id
        , tgt.prg_kod = src.prg_kod
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.st_id = src.st_id
        , tgt.czy_glowny = src.czy_glowny
        , tgt.id = src.id
        , tgt.data_nast_zal = src.data_nast_zal
        , tgt.uprawnienia_zawodowe = src.uprawnienia_zawodowe
        , tgt.uprawnienia_zawodowe_ang = src.uprawnienia_zawodowe_ang
        , tgt.jed_org_kod = src.jed_org_kod
        , tgt.dok_upr_id = src.dok_upr_id
        , tgt.data_przyjecia = src.data_przyjecia
        , tgt.plan_data_ukon = src.plan_data_ukon
        , tgt.czy_zgloszony = src.czy_zgloszony
        , tgt.status = src.status
        , tgt.data_rozpoczecia = src.data_rozpoczecia
        , tgt.numer_s = src.numer_s
        , tgt.numer_swiadectwa = src.numer_swiadectwa
        , tgt.tecz_id = src.tecz_id
        , tgt.data_arch = src.data_arch
        , tgt.warunki_przyjec_na_prog = src.warunki_przyjec_na_prog
        , tgt.warunki_przyjec_na_prog_ang = src.warunki_przyjec_na_prog_ang
        , tgt.numer_do_banku = src.numer_do_banku
        , tgt.numer_do_banku_sygn = src.numer_do_banku_sygn
        , tgt.numer_5_proc = src.numer_5_proc
        , tgt.numer_5_proc_sygn = src.numer_5_proc_sygn
        , tgt.status_arch = src.status_arch
        , tgt.osiagniecia = src.osiagniecia
        , tgt.osiagniecia_ang = src.osiagniecia_ang
        , tgt.nr_kierunku_ustawa = src.nr_kierunku_ustawa
        , tgt.limit_ects = src.limit_ects
        , tgt.dodatkowe_ects_uczelnia = src.dodatkowe_ects_uczelnia
        , tgt.wykorzystane_ects_obce = src.wykorzystane_ects_obce
        , tgt.limit_ects_podpiecia = src.limit_ects_podpiecia
        , tgt.prgos_id = src.prgos_id
        , tgt.osiagniecia_programu = src.osiagniecia_programu
        , tgt.osiagniecia_programu_ang = src.osiagniecia_programu_ang
        , tgt.wynik_studiow = src.wynik_studiow
        , tgt.wynik_studiow_ang = src.wynik_studiow_ang
        , tgt.umowa_data_przeczytania = src.umowa_data_przeczytania
        , tgt.umowa_data_podpisania = src.umowa_data_podpisania
        , tgt.umowa_sygnatura = src.umowa_sygnatura
        , tgt.kod_isced = src.kod_isced
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_student = src.pk_student
--        , tgt.pk_program_osoby = src.pk_program_osoby
        -- DBG
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_map_program_codes = src.dbg_map_program_codes
        , tgt.dbg_map_org_units = src.dbg_map_org_units
        , tgt.dbg_faculty_codes = src.dbg_faculty_codes
        , tgt.dbg_ids = src.dbg_ids
        , tgt.dbg_prg_kody = src.dbg_prg_kody
        , tgt.dbg_st_ids = src.dbg_st_ids
        , tgt.dbg_os_ids = src.dbg_os_ids
        , tgt.dbg_skipped_prg_kody = src.dbg_skipped_prg_kody
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_mapped = src.dbg_mapped
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
