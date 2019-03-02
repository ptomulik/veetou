MERGE INTO v2u_uu_etapy_osob tgt
USING
    (
        WITH u_00 AS
        (
            SELECT
                  ss_j.job_uuid
                , ss_j.student_id
                , ss_j.specialty_id
                , ss_j.semester_id
                , ss_j.ects_attained
                , students.student_index
                , semesters.semester_code
                , semesters.semester_number
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
                      TO_CHAR(ma_etpos_j.etpos_id)
                    , CASE
                        WHEN specialty_map.map_program_code IS NULL
                        THEN NULL
                        ELSE specialty_map.map_program_code
                             || '|' ||
                             u_00.semester_code
                             || '|' ||
                             TO_CHAR(u_00.semester_number)
                        END
                    , u_00.specialty_string
                      || '|' ||
                      u_00.semester_code
                      || '|' ||
                      TO_CHAR(u_00.semester_number)
                  ) coalesced_etap_osoby

                -- values

                , SET(CAST(
                    COLLECT(specialty_map.map_program_code)
                    AS V2u_Vchars1K_t
                  )) map_program_codes1k
                , SET(CAST(
                    COLLECT(ma_etpos_j.etpos_id)
                    AS V2u_Dz_Ids_t
                  )) ids
                , SET(CAST(
                    COLLECT(ma_prgos_j.prgos_id)
                    AS V2u_Dz_Ids_t
                  )) prgos_ids
                , SET(CAST(
                    COLLECT(ma_etpos_j.etp_kod)
                    AS V2u_Vchars1K_t
                  )) etp_kody1k
                , SET(CAST(
                    COLLECT(ma_prgos_j.prg_kod)
                    AS V2u_Vchars1K_t
                  )) prg_kody1k
                , SET(CAST(
                    COLLECT(sk_progs_j.prg_kod)
                    AS V2u_Vchars1K_t
                  )) skipped_prg_kody1k
                , SET(CAST(
                    COLLECT(u_00.semester_code)
                    AS V2u_Vchars1K_t
                  )) semester_codes1k
               , SET(CAST(
                    COLLECT(u_00.ects_attained)
                    AS V2u_Ints4_t
                  )) ects_attained_tab

                -- debugging

                , COUNT(ma_etpos_j.etpos_id) dbg_matched
                , COUNT(mi_etpos_j.job_uuid) dbg_missing
                , COUNT(sm_j.map_id) dbg_mapped

            FROM u_00 u_00
            LEFT JOIN v2u_ko_matched_etpos_j ma_etpos_j
                ON  (       ma_etpos_j.student_id = u_00.student_id
                        AND ma_etpos_j.specialty_id = u_00.specialty_id
                        AND ma_etpos_j.semester_id = u_00.semester_id
                        AND ma_etpos_j.job_uuid = u_00.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_etpos_j mi_etpos_j
                ON  (       mi_etpos_j.student_id = u_00.student_id
                        AND mi_etpos_j.specialty_id = u_00.specialty_id
                        AND mi_etpos_j.semester_id = u_00.semester_id
                        AND mi_etpos_j.job_uuid = u_00.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_prgos_j ma_prgos_j
                ON  (       ma_prgos_j.student_id = u_00.student_id
                        AND ma_prgos_j.specialty_id = u_00.specialty_id
                        AND ma_prgos_j.semester_id = u_00.semester_id
                        AND ma_prgos_j.job_uuid = u_00.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_prgos_j mi_prgos_j
                ON  (       mi_prgos_j.student_id = u_00.student_id
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
                      TO_CHAR(ma_etpos_j.etpos_id)
                    , CASE
                        WHEN specialty_map.map_program_code IS NULL
                        THEN NULL
                        ELSE specialty_map.map_program_code
                             || '|' ||
                             u_00.semester_code
                             || '|' ||
                             TO_CHAR(u_00.semester_number)
                        END
                    , u_00.specialty_string
                      || '|' ||
                      u_00.semester_code
                      || '|' ||
                      TO_CHAR(u_00.semester_number)
                  )
        ),
        u AS
        ( -- make necessary adjustments
            SELECT
                  -- pass through fields
                  u_0.job_uuid
                , u_0.student_index
                , u_0.coalesced_etap_osoby

                -- values

                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_program_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_program_code
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.ids) t
                    WHERE ROWNUM <= 1
                  ) id
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.prgos_ids) t
                    WHERE ROWNUM <= 1
                  ) prgos_id
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.prg_kody1k) t
                    WHERE ROWNUM <= 1
                  ) prg_kod
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.etp_kody1k) t
                    WHERE ROWNUM <= 1
                  ) etp_kod
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.semester_codes1k) t
                    WHERE ROWNUM <= 1
                  ) semester_code
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.ects_attained_tab) t
                    WHERE ROWNUM <= 1
                  ) ects_attained

                -- debugging

                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_program_codes1k)
                  ) dbg_map_program_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.ids)
                  ) dbg_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prgos_ids)
                  ) dbg_prgos_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.etp_kody1k)
                  ) dbg_etp_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prg_kody1k)
                  ) dbg_prg_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.skipped_prg_kody1k)
                  ) dbg_skipped_prg_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.semester_codes1k)
                  ) dbg_semester_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.ects_attained_tab)
                  ) dbg_ects_attained


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
        ( -- determine our (v$*) values of certain fields
            SELECT
                  u.*
                -- FIXME: implement etp_kod retrieval
                , COALESCE(u.etp_kod, '???') v$etp_kod
                , COALESCE(u.prg_kod, u.map_program_code) v$prg_kod
                , u.prgos_id v$prgos_id
                , u.semester_code v$cdyd_kod
                -- FIXME: implement ects_uzyskane. It's a cumulative number of
                --        ECTS at the beginning of semester.
                --, u.ects_attained v$ects_uzyskane

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
                        -- stage code is determined uniquely
                            ( u.etp_kod IS NOT NULL AND u.dbg_etp_kody = 1
                              OR '???' IS NOT NULL AND 0 = 1 ) -- FIXME: etp_kod
                        -- program code is determined uniquely
                        AND ( u.prg_kod IS NOT NULL AND u.dbg_prg_kody = 1
                              OR  u.map_program_code IS NOT NULL AND u.dbg_map_program_codes = 1 )
                        -- prgos_id is determined uniquely
                        AND u.prgos_id IS NOT NULL AND u.dbg_prgos_ids = 1
                        -- semester_code is determined uniquely
                        AND u.semester_code IS NOT NULL
                        AND u.dbg_semester_codes = 1
                        -- ects_attained is determined uniquely
                        -- AND u.ects_attained IS NOT NULL -- FIXME: implement ects_uzyskane
                        AND u.dbg_ects_attained = 1
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
        ),
        w AS
        ( -- provide our values (v$*) together with original ones (u$*)
            SELECT
                  v.*

                , t.id u$id
                , t.data_zakon u$data_zakon
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.status_zaliczenia u$status_zaliczenia
                , t.etp_kod u$etp_kod
                , t.prg_kod u$prg_kod
                , t.prgos_id u$prgos_id
                , t.cdyd_kod u$cdyd_kod
                , t.status_zal_komentarz u$status_zal_komentarz
                , t.liczba_war u$liczba_war
                , t.wym_cdyd_kod u$wym_cdyd_kod
                , t.czy_platny_na_2_kier u$czy_platny_na_2_kier
                , t.ects_uzyskane u$ects_uzyskane
                , t.czy_przedluzenie u$czy_przedluzenie
                , t.urlop_kod u$urlop_kod
                , t.ects_efekty_uczenia u$ects_efekty_uczenia
                , t.ects_przepisane u$ects_przepisane
                , t.kolejnosc u$kolejnosc
                , t.czy_erasmus u$czy_erasmus
                , t.jedn_dyplomujaca u$jedn_dyplomujaca

                , DECODE( v.dbg_unique_match, 1
                        , CASE WHEN
                                    DECODE(v.v$etp_kod, t.etp_kod, 1, 0) = 1
                                AND DECODE(v.v$prg_kod, t.prg_kod, 1, 0) = 1
                                AND DECODE(v.v$prgos_id, t.prgos_id, 1, 0) = 1
                                AND DECODE(v.v$cdyd_kod, t.cdyd_kod, 1, 0) = 1
                                -- FIXME: implement ects_uzyskane
                                --AND DECODE(v.v$ects_uzyskane, t.ects_uzyskane, 1, 0) = 1
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
                                v.dbg_unique_match = 1
                            -- values are correct
                            AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_update
            FROM v v
            LEFT JOIN v2u_dz_etapy_osob t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.id = v.id
                    )
        )
        SELECT
            -- KEY
              w.job_uuid
            , w.student_index pk_student
            , w.coalesced_etap_osoby pk_etap_osoby

            -- VAL

            , w.id
            , DECODE(w.change_type, 'I', NULL, w.u$data_zakon) data_zakon
            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data
            , DECODE(w.change_type, 'I', NULL, w.u$status_zaliczenia) status_zaliczenia
            , DECODE(w.change_type, '-', w.u$etp_kod, w.v$etp_kod) etp_kod
            , DECODE(w.change_type, '-', w.u$prg_kod, w.v$prg_kod) prg_kod
            , DECODE(w.change_type, '-', w.u$prgos_id, w.v$prgos_id) prgos_id
            , DECODE(w.change_type, '-', w.u$cdyd_kod, w.v$cdyd_kod) cdyd_kod
            , DECODE(w.change_type, 'I', NULL, w.u$status_zal_komentarz) status_zal_komentarz
            , DECODE(w.change_type, 'I', NULL, w.u$liczba_war) liczba_war
            , DECODE(w.change_type, 'I', NULL, w.u$wym_cdyd_kod) wym_cdyd_kod
            , DECODE(w.change_type, 'I', NULL, w.u$czy_platny_na_2_kier) czy_platny_na_2_kier
            -- FIXME: implement ects_uzyskane
            --, DECODE(w.change_type, '-', w.u$ects_uzyskane, w.v$ects_uzyskane) ects_uzyskane
            , DECODE(w.change_type, 'I', NULL, w.u$ects_uzyskane) ects_uzyskane
            , DECODE(w.change_type, 'I', NULL, w.u$czy_przedluzenie) czy_przedluzenie
            , DECODE(w.change_type, 'I', NULL, w.u$urlop_kod) urlop_kod
            , DECODE(w.change_type, 'I', NULL, w.u$ects_efekty_uczenia) ects_efekty_uczenia
            , DECODE(w.change_type, 'I', NULL, w.u$ects_przepisane) ects_przepisane
            , DECODE(w.change_type, 'I', NULL, w.u$kolejnosc) kolejnosc
            , DECODE(w.change_type, 'I', NULL, w.u$czy_erasmus) czy_erasmus
            , DECODE(w.change_type, 'I', NULL, w.u$jedn_dyplomujaca) jedn_dyplomujaca

            -- DBG

            , w.dbg_unique_match
            , w.dbg_values_ok
            , w.dbg_map_program_codes
            , w.dbg_ids
            , w.dbg_prgos_ids
            , w.dbg_etp_kody
            , w.dbg_prg_kody
            , w.dbg_semester_codes
            , w.dbg_ects_attained
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
        AND tgt.pk_etap_osoby = src.pk_etap_osoby
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , data_zakon
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , status_zaliczenia
        , etp_kod
        , prg_kod
        , prgos_id
        , cdyd_kod
        , status_zal_komentarz
        , liczba_war
        , wym_cdyd_kod
        , czy_platny_na_2_kier
        , ects_uzyskane
        , czy_przedluzenie
        , urlop_kod
        , ects_efekty_uczenia
        , ects_przepisane
        , kolejnosc
        , czy_erasmus
        , jedn_dyplomujaca
        -- KEY
        , job_uuid
        , pk_student
        , pk_etap_osoby
        -- DBG
        , dbg_unique_match
        , dbg_values_ok
        , dbg_map_program_codes
        , dbg_ids
        , dbg_prgos_ids
        , dbg_etp_kody
        , dbg_prg_kody
        , dbg_semester_codes
        , dbg_ects_attained
        , dbg_skipped_prg_kody
        , dbg_matched
        , dbg_missing
        , dbg_mapped
        -- CTL
        , change_type
        , safe_to_change
        )
    VALUES
        ( src.id
        , src.data_zakon
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.status_zaliczenia
        , src.etp_kod
        , src.prg_kod
        , src.prgos_id
        , src.cdyd_kod
        , src.status_zal_komentarz
        , src.liczba_war
        , src.wym_cdyd_kod
        , src.czy_platny_na_2_kier
        , src.ects_uzyskane
        , src.czy_przedluzenie
        , src.urlop_kod
        , src.ects_efekty_uczenia
        , src.ects_przepisane
        , src.kolejnosc
        , src.czy_erasmus
        , src.jedn_dyplomujaca
        -- KEY
        , src.job_uuid
        , src.pk_student
        , src.pk_etap_osoby
        -- DBG
        , src.dbg_unique_match
        , src.dbg_values_ok
        , src.dbg_map_program_codes
        , src.dbg_ids
        , src.dbg_prgos_ids
        , src.dbg_etp_kody
        , src.dbg_prg_kody
        , src.dbg_semester_codes
        , src.dbg_ects_attained
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
          tgt.id = src.id
        , tgt.data_zakon = src.data_zakon
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.status_zaliczenia = src.status_zaliczenia
        , tgt.etp_kod = src.etp_kod
        , tgt.prg_kod = src.prg_kod
        , tgt.prgos_id = src.prgos_id
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.status_zal_komentarz = src.status_zal_komentarz
        , tgt.liczba_war = src.liczba_war
        , tgt.wym_cdyd_kod = src.wym_cdyd_kod
        , tgt.czy_platny_na_2_kier = src.czy_platny_na_2_kier
        , tgt.ects_uzyskane = src.ects_uzyskane
        , tgt.czy_przedluzenie = src.czy_przedluzenie
        , tgt.urlop_kod = src.urlop_kod
        , tgt.ects_efekty_uczenia = src.ects_efekty_uczenia
        , tgt.ects_przepisane = src.ects_przepisane
        , tgt.kolejnosc = src.kolejnosc
        , tgt.czy_erasmus = src.czy_erasmus
        , tgt.jedn_dyplomujaca = src.jedn_dyplomujaca
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_student = src.pk_student
--        , tgt.pk_etap_osoby = src.pk_etap_osoby
        -- DBG
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_values_ok = src.dbg_values_ok
        , tgt.dbg_map_program_codes = src.dbg_map_program_codes
        , tgt.dbg_ids = src.dbg_ids
        , tgt.dbg_prgos_ids = src.dbg_prgos_ids
        , tgt.dbg_etp_kody = src.dbg_etp_kody
        , tgt.dbg_prg_kody = src.dbg_prg_kody
        , tgt.dbg_semester_codes = src.dbg_semester_codes
        , tgt.dbg_ects_attained = src.dbg_ects_attained
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
