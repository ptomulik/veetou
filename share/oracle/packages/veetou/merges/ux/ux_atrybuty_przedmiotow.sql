--
-- Update KOD_WYDZ subjects' attribute
--
MERGE INTO v2u_ux_atrybuty_przedmiotow tgt
USING
    (
        WITH u_0 AS
        (
            -- determine what to use as a single output row;
            --  (*) if possible, use corresponding map_subj_code as primary key,
            --  (*) otherwise (incomplete or ambiguous subject map), use the
            --      subj_code as primary key.
            SELECT
                  -- primary key
                  ss_j.job_uuid
                , COALESCE(
                      subject_map.map_subj_code
                    , subjects.subj_code
                  ) coalesced_subj_code
                , 'KOD_WYDZ' pk_attribute

                -- other "indexes"

                , SET(CAST(
                        COLLECT(subject_map.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes1k
                , SET(CAST(
                        COLLECT(subjects.subj_code)
                        AS V2u_Vchars1K_t
                  )) subj_codes1k
                , SET(CAST(
                        COLLECT(rev_subject_map.subj_code)
                        AS V2u_Vchars1K_t
                  )) rev_subj_codes1k
                , SET(CAST(
                        COLLECT(atrybuty_przedmiotow.id)
                        AS V2u_Vchars1K_t
                  )) ids1k

                -- debugging

                , COUNT(sm_j.map_id) dbg_mapped -- includes NULL map_subj_codes

            FROM v2u_ko_subject_semesters_j ss_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = ss_j.subject_id
                        AND subjects.job_uuid = ss_j.job_uuid
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
            LEFT JOIN v2u_subject_map rev_subject_map
                ON  (
                            rev_subject_map.map_subj_code = subject_map.map_subj_code
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
        u AS
        ( -- make necessary adjustments to the raw values selected in u_0
            SELECT
                 -- passed through

                  u_0.job_uuid
                , u_0.coalesced_subj_code
                , u_0.pk_attribute
                , u_0.dbg_mapped

                -- adjusted

                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , CAST(MULTISET(
                    SELECT
                        SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.subj_codes1k) t
                    WHERE ROWNUM <= 20
                  ) AS V2u_Subj_20Codes_t) subj_codes
                , CAST(MULTISET(
                    SELECT
                        SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.rev_subj_codes1k) t
                    WHERE ROWNUM <= 20
                  ) AS V2u_Subj_20Codes_t) rev_subj_codes
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.ids1k) t
                    WHERE ROWNUM <= 1
                  ) id

                -- debugging

                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_subj_codes1k)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_codes1k)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.rev_subj_codes1k)
                  ) dbg_rev_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.ids1k)
                  ) dbg_ids
            FROM u_0 u_0
        ),
        v AS
        (
            SELECT
                  u.*
                , u.coalesced_subj_code pk_subject
                , u.pk_attribute v2u_tatr_kod
                , u.map_subj_code v2u_prz_kod
                , V2u_Get.Utw_Id(u.job_uuid) v2u_utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v2u_mod_id
                , TO_CLOB((
                    SELECT
                        LISTAGG(SUBSTR(VALUE(t), 1, 32), ', ')
                        WITHIN GROUP (ORDER BY VALUE(t))
                    FROM TABLE(DECODE(u.dbg_rev_subj_codes, 0
                                    , u.subj_codes
                                    , u.rev_subj_codes)) t
                  )) v2u_wartosc
                , CASE
                    WHEN
                            u.id IS NOT NULL
                        AND u.dbg_ids = 1
                        AND u.dbg_mapped > 0
                    THEN 1
                    ELSE 0
                  END dbg_unique_match
            FROM u u
        ),
        w AS
        ( -- provide our values (v2u_*) and original ones (org_*)
            SELECT
                  v.*
                , t.tatr_kod org_tatr_kod
                , t.prz_kod org_prz_kod
                , t.wart_lst_id org_wart_lst_id
                , t.prz_kod_rel org_prz_kod_rel
                , t.utw_id org_utw_id
                , t.utw_data org_utw_data
                , t.mod_id org_mod_id
                , t.mod_data org_mod_data
                , t.wartosc org_wartosc
                , t.wartosc_ang org_wartosc_ang
                , DECODE( v.dbg_unique_match, 1
                        , DECODE( TO_CHAR(t.wartosc)
                                , TO_CHAR(v.v2u_wartosc)
                                , '-'
                                , 'U'
                                )
                        , 'I'
                  ) change_type

                , CASE
                    WHEN
                            v.map_subj_code IS NOT NULL
                        AND v.dbg_map_subj_codes = 1
                        AND v.dbg_subj_codes > 0
                        AND v.dbg_rev_subj_codes > 0
                        -- no target ids found
                        AND v.id IS NULL
                        AND v.dbg_ids = 0
                        AND v.dbg_mapped > 0
                    THEN 1
                    ELSE 0
                  END safe_to_insert

                , CASE
                    WHEN
                            v.map_subj_code IS NOT NULL
                        AND v.dbg_map_subj_codes = 1
                        AND v.dbg_subj_codes > 0
                        AND v.dbg_rev_subj_codes > 0
                        -- single taraget id found
                        AND v.id IS NOT NULL
                        AND v.dbg_ids = 1
                        AND v.dbg_mapped > 0
                    THEN 1
                    ELSE 0
                  END safe_to_update
            FROM v v
            LEFT JOIN v2u_dz_atrybuty_przedmiotow t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.id = v.id
                    )
        )
        SELECT
              w.*

            , DECODE(w.change_type, 'I', w.v2u_tatr_kod, w.org_tatr_kod) tatr_kod
            , DECODE(w.change_type, 'I', w.v2u_prz_kod, w.org_prz_kod) prz_kod
            , DECODE(w.change_type, 'I', NULL, w.org_wart_lst_id) wart_lst_id
            , DECODE(w.change_type, 'I', NULL, w.org_prz_kod_rel, NULL) prz_kod_rel
            , DECODE(w.change_type, 'I', w.v2u_utw_id, w.org_utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.org_utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v2u_mod_id, w.org_mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.org_mod_data) mod_data
            , DECODE(w.change_type, '-', w.org_wartosc, w.v2u_wartosc) wartosc
            , DECODE(w.change_type, 'I', NULL, w.org_wartosc_ang) wartosc_ang
            -- id appears in w.*

            , DECODE(w.change_type, 'I', w.safe_to_insert,
                                    'U', w.safe_to_update,
                                     0
              ) safe_to_change

        FROM w w
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
        , rev_subj_codes
        -- DBG
        , dbg_mapped
        , dbg_map_subj_codes
        , dbg_subj_codes
        , dbg_rev_subj_codes
        , dbg_ids
        , dbg_unique_match
        -- INF
        , change_type
        , safe_to_change
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
        , src.rev_subj_codes
        -- DBG
        , src.dbg_mapped
        , src.dbg_map_subj_codes
        , src.dbg_subj_codes
        , src.dbg_rev_subj_codes
        , src.dbg_ids
        , src.dbg_unique_match
        -- INF
        , src.change_type
        , src.safe_to_change
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
        , tgt.rev_subj_codes = src.rev_subj_codes
        -- DBG
        , tgt.dbg_mapped = src.dbg_mapped
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_rev_subj_codes = src.dbg_rev_subj_codes
        , tgt.dbg_ids = src.dbg_ids
        , tgt.dbg_unique_match = src.dbg_unique_match
        -- INF
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
