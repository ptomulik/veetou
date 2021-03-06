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
                , specialty_map.map_program_code
                , specialty_map.map_org_unit
                , V2U_Get.Faculty(specialties.faculty).code faculty_code
                , semesters.semester_code
                , ma_prgos_j.prgos_id
                , ma_prgos_j.prg_kod
                , studenci.id st_id
                , studenci.os_id os_id
                , sk_progs_j.prg_kod skipped_prg_kod
                , sm_j.map_id specialty_map_id

                , CASE
                    WHEN ma_prgos_j.prgos_id IS NOT NULL
                    THEN '{id: ' || ma_prgos_j.prgos_id || '}'
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
                        || '", semester: "' ||
                        semesters.semester_code
                        || '"}'
                    END pk_program_osoby

                , ma_prgos_j.student_id ma_id
                , mi_prgos_j.student_id mi_id

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
            LEFT JOIN v2u_ko_matched_prgos_j ma_prgos_j
                ON  (
                            ma_prgos_j.student_id = ss_j.student_id
                        AND ma_prgos_j.specialty_id = ss_j.specialty_id
                        AND ma_prgos_j.semester_id = ss_j.semester_id
                        AND ma_prgos_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_prgos_j mi_prgos_j
                ON  (
                            mi_prgos_j.student_id = ss_j.student_id
                        AND mi_prgos_j.specialty_id = ss_j.specialty_id
                        AND mi_prgos_j.semester_id = ss_j.semester_id
                        AND mi_prgos_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_skipped_programs_j sk_progs_j
                ON  (
                            sk_progs_j.specialty_id =  ss_j.specialty_id
                        AND sk_progs_j.semester_id = ss_j.semester_id
                        AND sk_progs_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_specialty_map_j sm_j
                ON  (
                            sm_j.specialty_id = ss_j.specialty_id
                        AND sm_j.semester_id = ss_j.semester_id
                        AND sm_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_specialty_map specialty_map
                ON  (
                            specialty_map.id = sm_j.map_id
                    )
            LEFT JOIN v2u_dz_studenci studenci
                ON  (
                            studenci.indeks = students.student_index
                    )
        ),
        u_0 AS
        ( -- decide what to use as a single row
            SELECT

                -- key

                  u_00.job_uuid
                , u_00.pk_program_osoby

                -- values

                , SET(CAST(
                    COLLECT(u_00.map_program_code)
                    AS V2u_Vchars1K_t
                  )) map_program_codes1k
                , SET(CAST(
                    COLLECT(u_00.map_org_unit)
                    AS V2u_Vchars1K_t
                  )) map_org_units1k
                , SET(CAST(
                    COLLECT(u_00.faculty_code)
                    AS V2u_Vchars1K_t
                  )) faculty_codes1k
                , SET(CAST(
                    COLLECT(u_00.prgos_id)
                    AS V2u_Dz_Ids_t
                  )) ids
                , SET(CAST(
                    COLLECT(u_00.prg_kod)
                    AS V2u_Vchars1K_t
                  )) prg_kody1k
                , SET(CAST(
                    COLLECT(u_00.st_id ORDER BY u_00.st_id)
                    AS V2u_Dz_Ids_t
                  )) st_ids
                , SET(CAST(
                    COLLECT(u_00.os_id ORDER BY u_00.st_id)
                    AS V2u_Dz_Ids_t
                  )) os_ids
                , SET(CAST(
                    COLLECT(u_00.skipped_prg_kod)
                    AS V2u_Vchars1K_t
                  )) skipped_prg_kody1k

                -- debugging

                  -- "+ 0" trick is used to workaround oracle bug
                , COUNT(u_00.ma_id + 0) dbg_matched
                , COUNT(u_00.mi_id + 0) dbg_missing
                , COUNT(u_00.specialty_map_id + 0) dbg_mapped

            FROM u_00 u_00

            GROUP BY
                  u_00.job_uuid
                , u_00.pk_program_osoby
        ),
        u AS
        ( -- make necessary adjustments
            SELECT
                  -- pass through fields
                  u_0.job_uuid
                , u_0.pk_program_osoby

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
        ),
        v AS
        ( -- determine our (v$*) values of certain fields
            SELECT
                  u.*
                , u.os_id v$os_id
                , u.st_id v$st_id
                , COALESCE(u.prg_kod, u.map_program_code) v$prg_kod
                , COALESCE(u.map_org_unit, u.faculty_code) v$jed_org_kod

                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id

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
        ( -- provide our values (v$*) together with original ones (u$*)
            SELECT
                  v.*

                , t.os_id u$os_id
                , t.prg_kod u$prg_kod
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.st_id u$st_id
                , t.czy_glowny u$czy_glowny
                , t.id u$id
                , t.data_nast_zal u$data_nast_zal
                , t.uprawnienia_zawodowe u$uprawnienia_zawodowe
                , t.uprawnienia_zawodowe_ang u$uprawnienia_zawodowe_ang
                , t.jed_org_kod u$jed_org_kod
                , t.dok_upr_id u$dok_upr_id
                , t.data_przyjecia u$data_przyjecia
                , t.plan_data_ukon u$plan_data_ukon
                , t.czy_zgloszony u$czy_zgloszony
                , t.status u$status
                , t.data_rozpoczecia u$data_rozpoczecia
                , t.numer_s u$numer_s
                , t.numer_swiadectwa u$numer_swiadectwa
                , t.tecz_id u$tecz_id
                , t.data_arch u$data_arch
                , t.warunki_przyjec_na_prog u$warunkiprzyjec_na_prog
                , t.warunki_przyjec_na_prog_ang u$warunkiprzyjec_na_prog_ang
                , t.numer_do_banku u$numer_do_banku
                , t.numer_do_banku_sygn u$numer_do_banku_sygn
                , t.numer_5_proc u$numer_5_proc
                , t.numer_5_proc_sygn u$numer_5_proc_sygn
                , t.status_arch u$status_arch
                , t.osiagniecia u$osiagniecia
                , t.osiagniecia_ang u$osiagniecia_ang
                , t.nr_kierunku_ustawa u$nr_kierunku_ustawa
                , t.limit_ects u$limit_ects
                , t.dodatkowe_ects_uczelnia u$dodatkowe_ects_uczelnia
                , t.wykorzystane_ects_obce u$wykorzystane_ects_obce
                , t.limit_ects_podpiecia u$limit_ects_podpiecia
                , t.prgos_id u$prgos_id
                , t.osiagniecia_programu u$osiagniecia_programu
                , t.osiagniecia_programu_ang u$osiagniecia_programu_ang
                , t.wynik_studiow u$wynik_studiow
                , t.wynik_studiow_ang u$wynik_studiow_ang
                , t.umowa_data_przeczytania u$umowa_data_przeczytania
                , t.umowa_data_podpisania u$umowa_data_podpisania
                , t.umowa_sygnatura u$umowa_sygnatura
                , t.kod_isced u$kod_isced

                , DECODE( v.dbg_unique_match, 1
                        , CASE WHEN
                                    DECODE(v.v$os_id, t.os_id, 1, 0) = 1
                                AND DECODE(v.v$prg_kod, t.prg_kod, 1, 0) = 1
                                AND DECODE(v.v$st_id, t.st_id, 1, 0) = 1
                                AND DECODE(v.v$jed_org_kod, t.jed_org_kod, 1, 0) = 1
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
                                v.dbg_unique_match = 1
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
            , w.pk_program_osoby

            -- VAL

            , DECODE(w.change_type, '-', w.u$os_id, w.v$os_id) os_id
            , DECODE(w.change_type, '-', w.u$prg_kod, w.v$prg_kod) prg_kod
            , DECODE(w.change_type, 'I', w.v$utw_id, u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, u$mod_data) mod_data
            , DECODE(w.change_type, '-', w.u$st_id, w.v$st_id) st_id
            , DECODE(w.change_type, 'I', NULL, w.u$czy_glowny) czy_glowny
            , w.id
            , DECODE(w.change_type, 'I', NULL, w.u$data_nast_zal) data_nast_zal
            , DECODE(w.change_type, 'I', NULL, w.u$uprawnienia_zawodowe) uprawnienia_zawodowe
            , DECODE(w.change_type, 'I', NULL, w.u$uprawnienia_zawodowe_ang) uprawnienia_zawodowe_ang
            , DECODE(w.change_type, '-', w.u$jed_org_kod, w.v$jed_org_kod) jed_org_kod
            , DECODE(w.change_type, 'I', NULL, w.u$dok_upr_id) dok_upr_id
            , DECODE(w.change_type, 'I', NULL, w.u$data_przyjecia) data_przyjecia
            , DECODE(w.change_type, 'I', NULL, w.u$plan_data_ukon) plan_data_ukon
            , DECODE(w.change_type, 'I', NULL, w.u$czy_zgloszony) czy_zgloszony
            , DECODE(w.change_type, 'I', NULL, w.u$status) status
            , DECODE(w.change_type, 'I', NULL, w.u$data_rozpoczecia) data_rozpoczecia
            , DECODE(w.change_type, 'I', NULL, w.u$numer_s) numer_s
            , DECODE(w.change_type, 'I', NULL, w.u$numer_swiadectwa) numer_swiadectwa
            , DECODE(w.change_type, 'I', NULL, w.u$tecz_id) tecz_id
            , DECODE(w.change_type, 'I', NULL, w.u$data_arch) data_arch
            , DECODE(w.change_type, 'I', NULL, w.u$warunkiprzyjec_na_prog) warunki_przyjec_na_prog
            , DECODE(w.change_type, 'I', NULL, w.u$warunkiprzyjec_na_prog_ang) warunki_przyjec_na_prog_ang
            , DECODE(w.change_type, 'I', NULL, w.u$numer_do_banku) numer_do_banku
            , DECODE(w.change_type, 'I', NULL, w.u$numer_do_banku_sygn) numer_do_banku_sygn
            , DECODE(w.change_type, 'I', NULL, w.u$numer_5_proc) numer_5_proc
            , DECODE(w.change_type, 'I', NULL, w.u$numer_5_proc_sygn) numer_5_proc_sygn
            , DECODE(w.change_type, 'I', NULL, w.u$status_arch) status_arch
            , DECODE(w.change_type, 'I', NULL, w.u$osiagniecia) osiagniecia
            , DECODE(w.change_type, 'I', NULL, w.u$osiagniecia_ang) osiagniecia_ang
            , DECODE(w.change_type, 'I', NULL, w.u$nr_kierunku_ustawa) nr_kierunku_ustawa
            , DECODE(w.change_type, 'I', NULL, w.u$limit_ects) limit_ects
            , DECODE(w.change_type, 'I', NULL, w.u$dodatkowe_ects_uczelnia) dodatkowe_ects_uczelnia
            , DECODE(w.change_type, 'I', NULL, w.u$wykorzystane_ects_obce) wykorzystane_ects_obce
            , DECODE(w.change_type, 'I', NULL, w.u$limit_ects_podpiecia) limit_ects_podpiecia
            , DECODE(w.change_type, 'I', NULL, w.u$prgos_id) prgos_id
            , DECODE(w.change_type, 'I', NULL, w.u$osiagniecia_programu) osiagniecia_programu
            , DECODE(w.change_type, 'I', NULL, w.u$osiagniecia_programu_ang) osiagniecia_programu_ang
            , DECODE(w.change_type, 'I', NULL, w.u$wynik_studiow) wynik_studiow
            , DECODE(w.change_type, 'I', NULL, w.u$wynik_studiow_ang) wynik_studiow_ang
            , DECODE(w.change_type, 'I', NULL, w.u$umowa_data_przeczytania) umowa_data_przeczytania
            , DECODE(w.change_type, 'I', NULL, w.u$umowa_data_podpisania) umowa_data_podpisania
            , DECODE(w.change_type, 'I', NULL, w.u$umowa_sygnatura) umowa_sygnatura
            , DECODE(w.change_type, 'I', NULL, w.u$kod_isced) kod_isced

            -- DBG

            , w.dbg_unique_match
            , w.dbg_values_ok
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
            tgt.pk_program_osoby = src.pk_program_osoby
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
        , pk_program_osoby
        -- DBG
        , dbg_unique_match
        , dbg_values_ok
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
        , src.pk_program_osoby
        -- DBG
        , src.dbg_unique_match
        , src.dbg_values_ok
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
--        , tgt.pk_program_osoby = src.pk_program_osoby
        -- DBG
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_values_ok = src.dbg_values_ok
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
