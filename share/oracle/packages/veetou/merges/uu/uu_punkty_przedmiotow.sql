MERGE INTO v2u_uu_punkty_przedmiotow tgt
USING
    (
        WITH punkty_przedmiotow AS
        (
            ----------------------------------------------------------------
            -- Ideally we should just use v2u_vx_punkty_przedmiotow_v, but
            -- it doesn't work due to DB bug (internal error).
            -- SELECT * FROM v2u_xv_punkty_przedmiotow_v
            ----------------------------------------------------------------
            SELECT * FROM v2u_dz_punkty_przedmiotow
            UNION ALL
            SELECT * FROM v2u_xr_punkty_przedmiotow
        ),
        u_00 AS
        ( -- join crucial tables
            SELECT
                  ss_j.job_uuid
                , ss_j.subject_id
                , ss_j.specialty_id
                , ss_j.semester_id
                , ma_pktprz_j.pktprz_id
                , ma_pktprz_j.prz_kod
                , ma_pktprz_j.prg_kod
                , ma_pktprz_j.cdyd_pocz
                , ma_pktprz_j.cdyd_kon
                , mi_pktprz_j.job_uuid mi_pktprz_job_uuid
                , subjects.subj_code
                , subjects.subj_ects
                , semesters.semester_code
                , subj_m_j.map_id subject_map_id
                , spec_m_j.map_id specialty_map_id
                , subject_map.map_subj_code
                , subject_map.map_subj_ects
                , specialty_map.map_program_code
                , ( '{subject: "' || COALESCE(
                          subject_map.map_subj_code
                        , subjects.subj_code
                    )
                    || '", ects: ' ||
                    TO_CHAR(
                        COALESCE( subject_map.map_subj_ects
                                , subjects.subj_ects
                                )
                    )
                    || ', semester: "' ||
                    semesters.semester_code
                    || '", program: "' ||
                    specialty_map.map_program_code
                    || '"}'
                  ) non_id_key
                , ( '{id: ' ||
                    TO_CHAR(ma_pktprz_j.pktprz_id)
                    || ', ects: ' ||
                    TO_CHAR(
                        COALESCE( subject_map.map_subj_ects
                                , subjects.subj_ects
                                )
                    )
                    || '}'
                  ) id_key
                , COALESCE(
                      subject_map.map_subj_code
                    , subjects.subj_code
                  ) coalesced_subj_code
                , COALESCE(
                      subject_map.map_subj_ects
                    , subjects.subj_ects
                  ) coalesced_subj_ects

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
            LEFT JOIN v2u_ko_matched_pktprz_j ma_pktprz_j
                ON  (
                            ma_pktprz_j.subject_id = ss_j.subject_id
                        AND ma_pktprz_j.semester_id = ss_j.semester_id
                        AND ma_pktprz_j.specialty_id = ss_j.specialty_id
                        AND ma_pktprz_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_pktprz_j mi_pktprz_j
                ON  (
                            mi_pktprz_j.subject_id = ss_j.subject_id
                        AND mi_pktprz_j.semester_id = ss_j.semester_id
                        AND mi_pktprz_j.specialty_id = ss_j.specialty_id
                        AND mi_pktprz_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j subj_m_j
                ON  (
                            subj_m_j.subject_id = ss_j.subject_id
                        AND subj_m_j.specialty_id = ss_j.specialty_id
                        AND subj_m_j.semester_id = ss_j.semester_id
                        AND subj_m_j.job_uuid = ss_j.job_uuid
                        AND subj_m_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = subj_m_j.map_id
                    )
            LEFT JOIN v2u_ko_specialty_map_j spec_m_j
                ON  (
                            spec_m_j.specialty_id = ss_j.specialty_id
                        AND spec_m_j.semester_id = ss_j.semester_id
                        AND spec_m_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_specialty_map specialty_map
                ON (
                            specialty_map.id = spec_m_j.map_id
                   )
        ),
        u_01 AS
        ( -- group by pktprz_id (if not NULL)
          -- or by {subject, ects, semester, program} otherwise
            SELECT
                  u_00.job_uuid
                , DECODE(
                      u_00.pktprz_id
                    , NULL
                    , u_00.non_id_key
                    , u_00.id_key
                  ) key
                , SET(CAST(
                    COLLECT(u_00.pktprz_id
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Dz_Ids_t
                  )) pktprz_ids
                , SET(CAST(
                    COLLECT(u_00.prz_kod
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Vchars1K_t
                  )) prz_kody1k
                , SET(CAST(
                    COLLECT(u_00.prg_kod
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Vchars1K_t
                  )) prg_kody1k
                , SET(CAST(
                    COLLECT(u_00.cdyd_pocz
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Vchars1K_t
                  )) cdyd_pocz1k
                , SET(CAST(
                    COLLECT(u_00.cdyd_kon
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Vchars1K_t
                  )) cdyd_kon1k
                , SET(CAST(
                    COLLECT(u_00.map_subj_code
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Vchars1K_t
                  )) map_subj_codes1k
                , SET(CAST(
                    COLLECT(u_00.map_subj_ects
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Ints4_t
                  )) map_subj_ectses
                , SET(CAST(
                    COLLECT(u_00.subj_code
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Vchars1K_t
                  )) subj_codes1k
                , SET(CAST(
                    COLLECT(u_00.subj_ects
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Integers_t
                  )) subj_ectses
                , SET(CAST(
                    COLLECT(u_00.coalesced_subj_code
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Vchars1K_t
                  )) coalesced_subj_codes1k
                , SET(CAST(
                    COLLECT(u_00.coalesced_subj_ects
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Integers_t
                  )) coalesced_subj_ectses
                , SET(CAST(
                    COLLECT(u_00.map_program_code
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Vchars1K_t
                  )) map_program_codes1k
                , SET(CAST(
                    COLLECT(u_00.semester_code
                            ORDER BY  u_00.subject_id
                                    , u_00.semester_id
                                    , u_00.specialty_id)
                    AS V2u_Vchars1K_t
                  )) semester_codes1k

                -- debugging

                , COUNT(u_00.pktprz_id) dbg_matched
                , COUNT(u_00.mi_pktprz_job_uuid) dbg_missing
                , COUNT(u_00.subject_map_id) dbg_subject_mapped
                , COUNT(u_00.specialty_map_id) dbg_specialty_mapped
            FROM u_00 u_00
            GROUP BY
                  u_00.job_uuid
                , DECODE(
                      u_00.pktprz_id
                    , NULL
                    , u_00.non_id_key
                    , u_00.id_key
                  )
        ),
        u_0 AS
        ( -- make necessary adjustments to raw values from u_01 and u_02
            SELECT
                  u_01.job_uuid
                , u_01.key

                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_01.pktprz_ids) t
                    WHERE ROWNUM <= 1
                  ) pktprz_id
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_01.prz_kody1k) t
                    WHERE ROWNUM <= 1
                  ) prz_kod
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_01.prg_kody1k) t
                    WHERE ROWNUM <= 1
                  ) prg_kod
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_01.cdyd_pocz1k) t
                    WHERE ROWNUM <= 1
                  ) cdyd_pocz
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_01.cdyd_kon1k) t
                    WHERE ROWNUM <= 1
                  ) cdyd_kon
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_01.coalesced_subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) coalesced_subj_code
                , ( SELECT VALUE(t)
                    FROM TABLE(u_01.coalesced_subj_ectses) t
                    WHERE ROWNUM <= 1
                  ) coalesced_subj_ects
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_01.map_program_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_program_code
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_01.semester_codes1k) t
                    WHERE ROWNUM <= 1
                  ) semester_code

                -- debugging
                , ( SELECT COUNT(*)
                    FROM TABLE(u_01.pktprz_ids)
                  ) dbg_pktprz_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_01.prz_kody1k)
                  ) dbg_prz_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_01.prg_kody1k)
                  ) dbg_prg_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_01.cdyd_pocz1k)
                  ) dbg_cdyd_pocz
                , ( SELECT COUNT(*)
                    FROM TABLE(u_01.cdyd_kon1k)
                  ) dbg_cdyd_kon
                , ( SELECT COUNT(*)
                    FROM TABLE(u_01.coalesced_subj_codes1k)
                  ) dbg_coalesced_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_01.coalesced_subj_ectses)
                  ) dbg_coalesced_subj_ectses
                , ( SELECT COUNT(*)
                    FROM TABLE(u_01.map_program_codes1k)
                  ) dbg_map_program_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_01.semester_codes1k)
                  ) dbg_semester_codes

                , u_01.dbg_matched
                , u_01.dbg_missing
                , u_01.dbg_subject_mapped
                , u_01.dbg_specialty_mapped
            FROM u_01 u_01
        ),
        u AS
        ( -- add some debugging fields
            SELECT
                  u_0.*
                , COUNT(DISTINCT u_0.coalesced_subj_ects)
                  OVER (PARTITION BY u_0.pktprz_id)
                  dbg_ectses_per_id
                , COUNT(DISTINCT u_0.coalesced_subj_ects)
                  OVER (PARTITION BY u_0.coalesced_subj_code
                                   , u_0.map_program_code
                                   , u_0.semester_code)
                  dbg_ectses_per_non_id
            FROM u_0 u_0
        ),
        v AS
        ( -- determine our (v$*) values for certain fields
            SELECT
                  u.*
                , u.pktprz_id v$id
                , DECODE( u.pktprz_id, NULL
                        , u.coalesced_subj_code
                        , u.prz_kod
                  ) v$prz_kod
                , DECODE( u.pktprz_id, NULL
                        , u.map_program_code
                        , u.prg_kod
                  ) v$prg_kod
                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id
                , DECODE( u.pktprz_id, NULL
                        , u.semester_code
                        , u.cdyd_pocz
                  ) v$cdyd_pocz
                , DECODE( u.pktprz_id, NULL
                        , u.semester_code
                        , u.cdyd_kon
                  ) v$cdyd_kon
                , u.coalesced_subj_ects v$ilosc
                , 'ECTS' v$tpkt_kod

                -- did we found unique row in the target table?
                , CASE
                    WHEN    u.dbg_matched > 0
                        AND u.dbg_subject_mapped = u.dbg_matched
                        AND u.dbg_specialty_mapped = u.dbg_matched
                        AND u.dbg_missing = 0
                        AND u.dbg_pktprz_ids = 1 AND u.pktprz_id IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                -- examine values we gonna propose
                , CASE
                    WHEN
                        -- all the instances were consistent
                        (
                            u.pktprz_id IS NOT NULL AND (
                                    u.prz_kod IS NOT NULL
                                AND u.dbg_prz_kody = 1
                                AND (
                                            u.prg_kod IS NULL
                                        AND u.dbg_prg_kody = 0
                                        OR
                                            u.prg_kod IS NOT NULL
                                        AND u.dbg_prg_kody = 1
                                    )
                                AND u.cdyd_pocz IS NOT NULL
                                AND u.dbg_cdyd_pocz = 1
                                AND (
                                            u.cdyd_kon IS NULL
                                        AND u.dbg_cdyd_kon = 0
                                        OR
                                            u.cdyd_kon IS NOT NULL
                                        AND u.dbg_cdyd_kon = 1
                                    )
                            )
                            OR
                            (
                                    u.coalesced_subj_code IS NOT NULL
                                AND u.dbg_coalesced_subj_codes = 1
                                AND (
                                            u.map_program_code IS NULL
                                        AND u.dbg_map_program_codes = 0
                                        OR
                                            u.map_program_code IS NOT NULL
                                        AND u.dbg_map_program_codes = 1
                                    )
                                AND u.semester_code IS NOT NULL
                                AND u.dbg_semester_codes = 1
                            )
                        )
                        AND u.coalesced_subj_ects IS NOT NULL
                        AND u.dbg_coalesced_subj_ectses = 1
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
        ),
        w AS
        ( -- provide our values (v$*) and original ones (u$*)
            SELECT
                  v.*
                , t.prz_kod u$prz_kod
                , t.prg_kod u$prg_kod
                , t.tpkt_kod u$tpkt_kod
                , t.ilosc u$ilosc
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.id u$id
                , t.cdyd_pocz u$cdyd_pocz
                , t.cdyd_kon u$cdyd_kon

                -- is it insert, update or nothing?

                , DECODE( v.dbg_unique_match, 1
                        , (CASE
                            WHEN    -- do we introduce any modification?
                                    DECODE(v.v$prz_kod, t.prz_kod, 1, 0) = 1
                                AND DECODE(v.v$prg_kod, t.prg_kod, 1, 0) = 1
                                AND DECODE(v.v$tpkt_kod, t.tpkt_kod, 1, 0) = 1
                                AND DECODE(v.v$ilosc, t.ilosc, 1, 0) = 1
                                AND DECODE(v.v$cdyd_pocz, t.cdyd_pocz, 1, 0) = 1
                                AND DECODE(v.v$cdyd_kon, t.cdyd_kon, 1, 0) = 1
                            THEN '-'
                            ELSE 'U'
                          END)
                        , 'I'
                  ) change_type

                , CASE
                    WHEN
                        -- ensure that
                        -- we haven't reached the target
                        v.pktprz_id IS NULL AND v.dbg_pktprz_ids = 0
                        -- maps for all instances existed but there were no
                        -- corresponding entry in target system
                        AND v.dbg_matched = 0
                        AND v.dbg_missing > 0
                        AND v.dbg_subject_mapped = v.dbg_missing
                        AND v.dbg_specialty_mapped = v.dbg_missing
                        -- there are no other colliding entries
                        AND v.dbg_ectses_per_non_id = 1
                        -- values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_insert

                , CASE
                    WHEN
                        -- ensure that
                        -- we UNIQUELLY matched a row in target table
                            v.dbg_unique_match = 1 /* AND v.pktprz_id > 0 */
                        -- there are no other colliding entries
                        AND v.dbg_ectses_per_id = 1
                        -- and values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_update

            FROM v v
            LEFT JOIN punkty_przedmiotow t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.id = v.pktprz_id
                    )
        )
        SELECT
              w.job_uuid
            , w.key pk_punkty_przedmiotu

            , DECODE(w.change_type, '-', w.u$prz_kod, w.v$prz_kod) prz_kod
            , DECODE(w.change_type, '-', w.u$prg_kod, w.v$prg_kod) prg_kod
            , DECODE(w.change_type, '-', w.u$tpkt_kod, w.v$tpkt_kod) tpkt_kod
            , DECODE(w.change_type, '-', w.u$ilosc, w.v$ilosc) ilosc
            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data
            , DECODE(w.change_type, 'I', w.v$id, w.u$id) id
            , DECODE(w.change_type, '-', w.u$cdyd_pocz, w.v$cdyd_pocz) cdyd_pocz
            , DECODE(w.change_type, '-', w.u$cdyd_kon, w.v$cdyd_kon) cdyd_kon

            , w.dbg_pktprz_ids
            , w.dbg_prz_kody
            , w.dbg_prg_kody
            , w.dbg_cdyd_pocz
            , w.dbg_cdyd_kon
            , w.dbg_coalesced_subj_codes
            , w.dbg_coalesced_subj_ectses
            , w.dbg_map_program_codes
            , w.dbg_semester_codes
            , w.dbg_ectses_per_id
            , w.dbg_ectses_per_non_id
            , w.dbg_unique_match
            , w.dbg_values_ok
            , w.dbg_matched
            , w.dbg_missing
            , w.dbg_subject_mapped
            , w.dbg_specialty_mapped

            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
              ) safe_to_change
        FROM w w
    ) src
ON  (
            tgt.pk_punkty_przedmiotu = src.pk_punkty_przedmiotu
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
        , dbg_pktprz_ids
        , dbg_prz_kody
        , dbg_prg_kody
        , dbg_cdyd_pocz
        , dbg_cdyd_kon
        , dbg_coalesced_subj_codes
        , dbg_coalesced_subj_ectses
        , dbg_map_program_codes
        , dbg_semester_codes
        , dbg_ectses_per_id
        , dbg_ectses_per_non_id
        , dbg_unique_match
        , dbg_values_ok
        , dbg_matched
        , dbg_missing
        , dbg_subject_mapped
        , dbg_specialty_mapped
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
        , src.dbg_pktprz_ids
        , src.dbg_prz_kody
        , src.dbg_prg_kody
        , src.dbg_cdyd_pocz
        , src.dbg_cdyd_kon
        , src.dbg_coalesced_subj_codes
        , src.dbg_coalesced_subj_ectses
        , src.dbg_map_program_codes
        , src.dbg_semester_codes
        , src.dbg_ectses_per_id
        , src.dbg_ectses_per_non_id
        , src.dbg_unique_match
        , src.dbg_values_ok
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_subject_mapped
        , src.dbg_specialty_mapped
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
        , tgt.dbg_pktprz_ids = src.dbg_pktprz_ids
        , tgt.dbg_prz_kody = src.dbg_prz_kody
        , tgt.dbg_prg_kody = src.dbg_prg_kody
        , tgt.dbg_cdyd_pocz = src.dbg_cdyd_pocz
        , tgt.dbg_cdyd_kon = src.dbg_cdyd_kon
        , tgt.dbg_coalesced_subj_codes = src.dbg_coalesced_subj_codes
        , tgt.dbg_coalesced_subj_ectses = src.dbg_coalesced_subj_ectses
        , tgt.dbg_map_program_codes = src.dbg_map_program_codes
        , tgt.dbg_semester_codes = src.dbg_semester_codes
        , tgt.dbg_ectses_per_id = src.dbg_ectses_per_id
        , tgt.dbg_ectses_per_non_id = src.dbg_ectses_per_non_id
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_values_ok = src.dbg_values_ok
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_subject_mapped = src.dbg_subject_mapped
        , tgt.dbg_specialty_mapped = src.dbg_specialty_mapped
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
