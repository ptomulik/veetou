MERGE INTO v2u_ux_atrybuty_przedmiotow tgt
USING
    (
        WITH u AS
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
                  )) subj_codes
                , SET(CAST(
                        COLLECT(subject_map.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes
                , SET(CAST(
                        COLLECT(atrybuty_przedmiotow.id)
                        AS V2u_Vchars1K_t
                  )) ids
                -- note; this also accounts maps with NULL map_subj_code
                , COUNT(sm_j.map_id) dbg_mapped
            FROM v2u_ko_subject_semesters_j ss_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = ss_j.subject_id
                        AND subjects.job_uuid = ss_j.job_uuid
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
            LEFT JOIN v2u_dz_atrybuty_przedmiotow atrybuty_przedmiotow
                ON  (
                            atrybuty_przedmiotow.prz_kod = subject_map.map_subj_code
                        AND atrybuty_przedmiotow.tatr_kod = 'KOD_WYDZ'
                    )
            GROUP BY
                  ss_j.job_uuid
                , COALESCE(
                      subject_map.map_subj_code
                    , subjects.subj_code
                  )
        ),
        v AS
        (
            SELECT
                  u.job_uuid
                , u.coalesced_subj_code

                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.map_subj_codes) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , CAST(MULTISET(
                    SELECT
                        SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u.subj_codes) t
                    WHERE ROWNUM <= 20
                  ) AS V2u_Subj_20Codes_t) subj_codes
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.ids) t
                    WHERE ROWNUM <= 1
                  ) id

                -- columns used for debugging
                , ( SELECT COUNT(*)
                    FROM TABLE(u.map_subj_codes)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u.subj_codes)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u.ids)
                  ) dbg_ids
                , u.dbg_mapped
            FROM u u
        ),
        w AS
        ( -- look back into v2u_subject_map to find all codes that we map onto
          -- map_subj_code; this may yield more subjects than we already found
          -- from v2u_ko_subject_semesters_j + v2u_ko_subjects
            SELECT
                  v.map_subj_code
                , SET(CAST(
                    COLLECT(subject_map.subj_code)
                    AS V2u_Vchars1K_t
                  )) all_subj_codes
                , COUNT(DISTINCT subject_map.subj_code) dbg_all_subj_codes
            FROM v v
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.map_subj_code = v.map_subj_code
                    )
            GROUP BY
                    v.map_subj_code
        ),
        x AS
        (
            SELECT
                  v.*
                , v.coalesced_subj_code pk_subject
                , 'KOD_WYDZ' pk_attribute
                , 'KOD_WYDZ' v2u_tatr_kod
                , v.map_subj_code v2u_prz_kod
                , V2u_Get.Utw_Id(v.job_uuid) v2u_utw_id
                , V2u_Get.Mod_Id(v.job_uuid) v2u_mod_id
                , CAST(MULTISET(
                    SELECT(SUBSTR(VALUE(t), 1, 32))
                    FROM TABLE(w.all_subj_codes) t
                    WHERE VALUE(t) IS NOT NULL AND ROWNUM <= 20
                  ) AS V2u_Subj_20Codes_t) all_subj_codes
                , w.dbg_all_subj_codes
                , TO_CLOB(( SELECT
                        LISTAGG(SUBSTR(VALUE(t), 1, 32), ', ')
                        WITHIN GROUP (ORDER BY VALUE(t))
                    FROM TABLE(w.all_subj_codes) t
                  )) v2u_wartosc
                , CASE
                    WHEN
                            v.id IS NOT NULL
                        AND v.dbg_ids = 1
                        AND v.dbg_mapped > 0
                    THEN 1
                    ELSE 0
                  END dbg_unique_match
            FROM v v
            INNER JOIN w w
                ON  (
                            v.map_subj_code = w.map_subj_code
                    )
        )
        SELECT
              x.*

            , DECODE(x.dbg_unique_match, 1, ap.tatr_kod, x.v2u_tatr_kod) tatr_kod
            , DECODE(x.dbg_unique_match, 1, ap.prz_kod, x.v2u_prz_kod) prz_kod
            , DECODE(x.dbg_unique_match, 1, ap.wart_lst_id, NULL) wart_lst_id
            , DECODE(x.dbg_unique_match, 1, ap.prz_kod_rel, NULL) prz_kod_rel
            , DECODE(x.dbg_unique_match, 1, ap.utw_id, x.v2u_utw_id) utw_id
            , DECODE(x.dbg_unique_match, 1, ap.utw_data, NULL) utw_data
            , DECODE(x.dbg_unique_match, 1, ap.mod_id, x.v2u_mod_id) mod_id
            , DECODE(x.dbg_unique_match, 1, ap.mod_data, NULL) mod_data
            , DECODE(x.dbg_unique_match, 1, ap.wartosc, x.v2u_wartosc) wartosc
            , DECODE(x.dbg_unique_match, 1, ap.wartosc_ang, NULL) wartosc_ang
            -- id appears in x.*

            , CASE
                WHEN
                        x.map_subj_code IS NOT NULL
                    AND x.dbg_map_subj_codes = 1
                    AND x.dbg_subj_codes > 0
                    --AND x.dbg_subj_codes = (SELECT COUNT(1) FROM TABLE(x.subj_codes))
                    AND x.dbg_all_subj_codes > 0
                    --AND x.dbg_all_subj_codes = (SELECT COUNT(1) FROM TABLE(x.all_subj_codes))
                    AND x.id IS NOT NULL
                    AND x.dbg_ids = 0
                    AND x.dbg_mapped > 0
                THEN 1
                ELSE 0
              END safe_to_add
        FROM x x
        LEFT JOIN v2u_dz_atrybuty_przedmiotow ap
            ON  (
                        x.dbg_unique_match = 1
                    AND ap.id = x.id
                )
    ) src
ON  (
            tgt.pk_subject = src.pk_subject
        AND tgt.pk_attribute = src.pk_attribute
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( tatr_kod
        , prz_kod
        , wart_lst_id
        , prz_kod_rel
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , wartosc
        , wartosc_ang
        , id
        , job_uuid
        , pk_subject
        , pk_attribute
        , subj_codes
        , all_subj_codes
        -- DBG
        , dbg_map_subj_codes
        , dbg_subj_codes
        , dbg_all_subj_codes
        , dbg_ids
        , safe_to_add
        )
    VALUES
        ( src.tatr_kod
        , src.prz_kod
        , src.wart_lst_id
        , src.prz_kod_rel
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.wartosc
        , src.wartosc_ang
        , src.id
        , src.job_uuid
        , src.pk_subject
        , src.pk_attribute
        , src.subj_codes
        , src.all_subj_codes
        -- DBG
        , src.dbg_map_subj_codes
        , src.dbg_subj_codes
        , src.dbg_all_subj_codes
        , src.dbg_ids
        , src.safe_to_add
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.tatr_kod = src.tatr_kod
        , tgt.prz_kod = src.prz_kod
        , tgt.wart_lst_id = src.wart_lst_id
        , tgt.prz_kod_rel = src.prz_kod_rel
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.wartosc = src.wartosc
        , tgt.wartosc_ang = src.wartosc_ang
        , tgt.id = src.id
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_subject = src.pk_subject
--        , tgt.pk_attribute = src.pk_attribute
        , tgt.subj_codes = src.subj_codes
        , tgt.all_subj_codes = src.all_subj_codes
        -- DBG
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_all_subj_codes = src.dbg_all_subj_codes
        , tgt.dbg_ids = src.dbg_ids
        , tgt.safe_to_add = src.safe_to_add
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
