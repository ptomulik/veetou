MERGE INTO v2u_ux_programy_osob tgt
USING
    (
        WITH u AS
        (
            SELECT
                  ss_j.job_uuid
                , ss_j.student_id
                , ss_j.specialty_id
                , ss_j.semester_id
                , students.student_index
                , V2U_Get.Faculty(specialties.faculty).code faculty_code
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
        ),
        v AS
        (
            SELECT
                  u.job_uuid
                , u.student_index student_index
                , COALESCE(
                      TO_CHAR(ma_prgos_j.prgos_id)
                    , specialty_map.map_program_code
                    , u.specialty_string
                  ) coalesced_prgos_id
                , SET(CAST(
                    COLLECT(specialty_map.map_program_code)
                    AS V2u_Vchars1K_t
                  )) map_program_codes
                , SET(CAST(
                    COLLECT(u.faculty_code)
                    AS V2u_Vchars1K_t
                  )) faculty_codes
                , SET(CAST(
                    COLLECT(ma_prgos_j.prgos_id)
                    AS V2u_Dz_Ids_t
                  )) matched_ids
                , SET(CAST(
                    COLLECT(ma_prgos_j.prg_kod)
                    AS V2u_Vchars1K_t
                  )) matched_prg_kody
                , SET(CAST(
                    COLLECT(ma_prgos_j.st_id)
                    AS V2u_Dz_Ids_t
                  )) matched_st_ids
                , SET(CAST(
                    COLLECT(ma_prgos_j.os_id)
                    AS V2u_Dz_Ids_t
                  )) matched_os_ids
                , SET(CAST(
                    COLLECT(sk_progs_j.prg_kod)
                    AS V2u_Vchars1K_t
                  )) skipped_prg_kody
                , COUNT(DISTINCT specialty_map.map_program_code) dbg_map_program_codes
                , COUNT(DISTINCT u.faculty_code) dbg_faculty_codes
                , COUNT(DISTINCT ma_prgos_j.prgos_id) dbg_matched_ids
                , COUNT(DISTINCT ma_prgos_j.prg_kod) dbg_matched_prg_kody
                , COUNT(DISTINCT ma_prgos_j.st_id) dbg_matched_st_ids
                , COUNT(DISTINCT ma_prgos_j.os_id) dbg_matched_os_ids
                , COUNT(DISTINCT sk_progs_j.prg_kod) dbg_skipped_prg_kody
                , COUNT(ma_prgos_j.job_uuid) dbg_matched
                , COUNT(mi_prgos_j.job_uuid) dbg_missing
                , COUNT(sm_j.job_uuid) dbg_mapped
            FROM u u
            LEFT JOIN v2u_ko_matched_prgos_j ma_prgos_j
                ON  (
                            ma_prgos_j.student_id = u.student_id
                        AND ma_prgos_j.specialty_id = u.specialty_id
                        AND ma_prgos_j.semester_id = u.semester_id
                        AND ma_prgos_j.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_prgos_j mi_prgos_j
                ON  (
                            mi_prgos_j.student_id = u.student_id
                        AND mi_prgos_j.specialty_id = u.specialty_id
                        AND mi_prgos_j.semester_id = u.semester_id
                        AND mi_prgos_j.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_ko_skipped_programs_j sk_progs_j
                ON  (
                            sk_progs_j.specialty_id =  u.specialty_id
                        AND sk_progs_j.semester_id = u.semester_id
                        AND sk_progs_j.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_ko_specialty_map_j sm_j
                ON  (
                            sm_j.specialty_id = u.specialty_id
                        AND sm_j.semester_id = u.semester_id
                        AND sm_j.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_specialty_map specialty_map
                ON  (
                            specialty_map.id = sm_j.map_id
                    )
            GROUP BY
                  u.job_uuid
                , u.student_index
                , COALESCE(
                      TO_CHAR(ma_prgos_j.prgos_id)
                    , specialty_map.map_program_code
                    , u.specialty_string
                  )
        ),
        w AS
        (
            SELECT
                  v.job_uuid
                , v.student_index
                , v.coalesced_prgos_id
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(v.map_program_codes) t
                    WHERE ROWNUM <= 1
                  ) map_program_code
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(v.faculty_codes) t
                    WHERE ROWNUM <= 1
                  ) faculty_code
                , ( SELECT VALUE(t)
                    FROM TABLE(v.matched_ids) t
                    WHERE ROWNUM <= 1
                  ) matched_id
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(v.matched_prg_kody) t
                    WHERE ROWNUM <= 1
                  ) matched_prg_kod
                , ( SELECT VALUE(t)
                    FROM TABLE(v.matched_st_ids) t
                    WHERE ROWNUM <= 1
                  ) matched_st_id
                , ( SELECT VALUE(t)
                    FROM TABLE(v.matched_os_ids) t
                    WHERE ROWNUM <= 1
                  ) matched_os_id
                , v.dbg_map_program_codes
                , v.dbg_faculty_codes
                , v.dbg_matched_ids
                , v.dbg_matched_prg_kody
                , v.dbg_matched_st_ids
                , v.dbg_matched_os_ids
                , v.dbg_skipped_prg_kody
                , v.dbg_matched
                , v.dbg_missing
                , v.dbg_mapped
                , studenci.id new_st_id
                , studenci.os_id new_os_id
                , CASE
                    WHEN
                            v.dbg_matched > 0
                        AND v.dbg_mapped = v.dbg_matched
                        AND v.dbg_missing = 0
                        AND v.dbg_matched_ids = 1
                    THEN 1
                    ELSE 0
                  END dbg_unique_match
            FROM v v
            LEFT JOIN v2u_dz_studenci studenci
                ON  (
                            studenci.indeks = v.student_index
                    )
        )
        SELECT
              w.*
            , DECODE(w.dbg_unique_match, 1, programy_osob.os_id, w.new_os_id) os_id
            , DECODE(w.dbg_unique_match, 1, programy_osob.prg_kod, w.map_program_code) prg_kod
            , DECODE(w.dbg_unique_match, 1, programy_osob.utw_id, V2U_Get.Utw_Id(w.job_uuid)) utw_id
            , DECODE(w.dbg_unique_match, 1, programy_osob.utw_data, NULL) utw_data
            , DECODE(w.dbg_unique_match, 1, programy_osob.mod_id, V2U_Get.Mod_Id(w.job_uuid)) mod_id
            , DECODE(w.dbg_unique_match, 1, programy_osob.mod_data, NULL) mod_data
            , DECODE(w.dbg_unique_match, 1, programy_osob.st_id, w.new_st_id) st_id
            , DECODE(w.dbg_unique_match, 1, programy_osob.czy_glowny, NULL) czy_glowny
            , DECODE(w.dbg_unique_match, 1, programy_osob.id, NULL) id
            , DECODE(w.dbg_unique_match, 1, programy_osob.data_nast_zal, NULL) data_nast_zal
            , DECODE(w.dbg_unique_match, 1, programy_osob.uprawnienia_zawodowe, NULL) uprawnienia_zawodowe
            , DECODE(w.dbg_unique_match, 1, programy_osob.uprawnienia_zawodowe_ang, NULL) uprawnienia_zawodowe_ang
            , DECODE(w.dbg_unique_match, 1, programy_osob.jed_org_kod, w.faculty_code) jed_org_kod
            , DECODE(w.dbg_unique_match, 1, programy_osob.dok_upr_id, NULL) dok_upr_id
            , DECODE(w.dbg_unique_match, 1, programy_osob.data_przyjecia, NULL) data_przyjecia
            , DECODE(w.dbg_unique_match, 1, programy_osob.plan_data_ukon, NULL) plan_data_ukon
            , DECODE(w.dbg_unique_match, 1, programy_osob.czy_zgloszony, NULL) czy_zgloszony
            , DECODE(w.dbg_unique_match, 1, programy_osob.status, NULL) status
            , DECODE(w.dbg_unique_match, 1, programy_osob.data_rozpoczecia, NULL) data_rozpoczecia
            , DECODE(w.dbg_unique_match, 1, programy_osob.numer_s, NULL) numer_s
            , DECODE(w.dbg_unique_match, 1, programy_osob.numer_swiadectwa, NULL) numer_swiadectwa
            , DECODE(w.dbg_unique_match, 1, programy_osob.tecz_id, NULL) tecz_id
            , DECODE(w.dbg_unique_match, 1, programy_osob.data_arch, NULL) data_arch
            , DECODE(w.dbg_unique_match, 1, programy_osob.warunki_przyjec_na_prog, NULL) warunki_przyjec_na_prog
            , DECODE(w.dbg_unique_match, 1, programy_osob.warunki_przyjec_na_prog_ang, NULL) warunki_przyjec_na_prog_ang
            , DECODE(w.dbg_unique_match, 1, programy_osob.numer_do_banku, NULL) numer_do_banku
            , DECODE(w.dbg_unique_match, 1, programy_osob.numer_do_banku_sygn, NULL) numer_do_banku_sygn
            , DECODE(w.dbg_unique_match, 1, programy_osob.numer_5_proc, NULL) numer_5_proc
            , DECODE(w.dbg_unique_match, 1, programy_osob.numer_5_proc_sygn, NULL) numer_5_proc_sygn
            , DECODE(w.dbg_unique_match, 1, programy_osob.status_arch, NULL) status_arch
            , DECODE(w.dbg_unique_match, 1, programy_osob.osiagniecia, NULL) osiagniecia
            , DECODE(w.dbg_unique_match, 1, programy_osob.osiagniecia_ang, NULL) osiagniecia_ang
            , DECODE(w.dbg_unique_match, 1, programy_osob.nr_kierunku_ustawa, NULL) nr_kierunku_ustawa
            , DECODE(w.dbg_unique_match, 1, programy_osob.limit_ects, NULL) limit_ects
            , DECODE(w.dbg_unique_match, 1, programy_osob.dodatkowe_ects_uczelnia, NULL) dodatkowe_ects_uczelnia
            , DECODE(w.dbg_unique_match, 1, programy_osob.wykorzystane_ects_obce, NULL) wykorzystane_ects_obce
            , DECODE(w.dbg_unique_match, 1, programy_osob.limit_ects_podpiecia, NULL) limit_ects_podpiecia
            , DECODE(w.dbg_unique_match, 1, programy_osob.prgos_id, NULL) prgos_id
            , DECODE(w.dbg_unique_match, 1, programy_osob.osiagniecia_programu, NULL) osiagniecia_programu
            , DECODE(w.dbg_unique_match, 1, programy_osob.osiagniecia_programu_ang, NULL) osiagniecia_programu_ang
            , DECODE(w.dbg_unique_match, 1, programy_osob.wynik_studiow, NULL) wynik_studiow
            , DECODE(w.dbg_unique_match, 1, programy_osob.wynik_studiow_ang, NULL) wynik_studiow_ang
            , DECODE(w.dbg_unique_match, 1, programy_osob.umowa_data_przeczytania, NULL) umowa_data_przeczytania
            , DECODE(w.dbg_unique_match, 1, programy_osob.umowa_data_podpisania, NULL) umowa_data_podpisania
            , DECODE(w.dbg_unique_match, 1, programy_osob.umowa_sygnatura, NULL) umowa_sygnatura
            , DECODE(w.dbg_unique_match, 1, programy_osob.kod_isced, NULL) kod_isced
            --
            , w.student_index pk_student_index
            , w.coalesced_prgos_id pk_program_osoby
            , CASE
                WHEN
                        w.map_program_code IS NOT NULL
                    AND w.dbg_map_program_codes = 1
                    -- maps for all instances existed but there were no
                    -- corresponding prgoses in target system
                    AND w.dbg_matched = 0
                    AND w.dbg_missing > 0
                    AND w.dbg_mapped = w.dbg_missing
                    -- ensure that there are no other propositions
                    AND w.dbg_matched_prg_kody <= 1
                    AND w.dbg_skipped_prg_kody = 0
                    -- ensure we found target entry for the student
                    AND w.new_os_id IS NOT NULL
                    AND w.new_st_id IS NOT NULL
                    --
                    AND w.faculty_code IS NOT NULL
                    AND w.dbg_faculty_codes = 1
                THEN 1
                ELSE 0
             END safe_to_add
        FROM w w
        LEFT JOIN v2u_dz_programy_osob programy_osob
            ON  (
                        programy_osob.id = w.matched_id
                    AND w.dbg_unique_match = 1
                )
    ) src
ON  (
            tgt.pk_student_index = src.pk_student_index
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
        , job_uuid
        , pk_student_index
        , pk_program_osoby
        , dbg_unique_match
        , dbg_map_program_codes
        , dbg_faculty_codes
        , dbg_matched_ids
        , dbg_matched_prg_kody
        , dbg_matched_st_ids
        , dbg_matched_os_ids
        , dbg_skipped_prg_kody
        , dbg_matched
        , dbg_missing
        , dbg_mapped
        , safe_to_add
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
        , src.job_uuid
        , src.pk_student_index
        , src.pk_program_osoby
        , src.dbg_unique_match
        , src.dbg_map_program_codes
        , src.dbg_faculty_codes
        , src.dbg_matched_ids
        , src.dbg_matched_prg_kody
        , src.dbg_matched_st_ids
        , src.dbg_matched_os_ids
        , src.dbg_skipped_prg_kody
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_mapped
        , src.safe_to_add
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
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_student_index = src.pk_student_index
--        , tgt.pk_program_osoby = src.pk_program_osoby
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_map_program_codes = src.dbg_map_program_codes
        , tgt.dbg_faculty_codes = src.dbg_faculty_codes
        , tgt.dbg_matched_ids = src.dbg_matched_ids
        , tgt.dbg_matched_prg_kody = src.dbg_matched_prg_kody
        , tgt.dbg_matched_st_ids = src.dbg_matched_st_ids
        , tgt.dbg_matched_os_ids = src.dbg_matched_os_ids
        , tgt.dbg_skipped_prg_kody = src.dbg_skipped_prg_kody
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_mapped = src.dbg_mapped
        , tgt.safe_to_add = src.safe_to_add
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
