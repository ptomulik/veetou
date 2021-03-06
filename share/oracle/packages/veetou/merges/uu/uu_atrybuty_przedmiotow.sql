--
-- Update KOD_WYDZ subjects' attribute
--
MERGE INTO v2u_uu_atrybuty_przedmiotow tgt
USING
    (
        WITH u_00 AS
        (
            -- determine what to use as a single output row;
            --  (*) if possible, use map_subj_code as primary key,
            --  (*) otherwise (incomplete or ambiguous subject map), use the
            --      subj_code as primary key.
            SELECT
                  ss_j.job_uuid
                , CASE
                    WHEN atrybuty_przedmiotow.id IS NOT NULL
                    THEN '{id: "'|| atrybuty_przedmiotow.id ||'"}'
                    ELSE '{subject: "' ||
                          COALESCE(
                              subject_map.map_subj_code
                            , subjects.subj_code
                          )
                        || '", attribute: "KOD_WYDZ"}'
                  END pk_atrybut_przedmiotu
                , subject_map.map_subj_code
                , subjects.subj_code
                , rev_subject_map.subj_code rev_subj_code
                , atrybuty_przedmiotow.id
                , sm_j.map_id subject_map_id

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
            LEFT JOIN v2u_subject_map rev_subject_map
                ON  (
                            rev_subject_map.map_subj_code = subject_map.map_subj_code
                        AND DECODE(rev_subject_map.expr_subj_name, 'REJECT', 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_subj_hours_w, -1, 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_subj_hours_c, -1, 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_subj_hours_l, -1, 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_subj_hours_p, -1, 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_subj_hours_s, -1, 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_subj_credit_kind, 'REJECT', 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_subj_ects, -1, 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_subj_tutor, 'REJECT', 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_university, 'REJECT', 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_faculty, 'REJECT', 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_studies_modetier, 'REJECT', 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_studies_field, 'REJECT', 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_studies_specialty, 'REJECT', 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_semester_code, 'REJECT', 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_semester_number, -1, 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_ects_mandatory, -1, 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_ects_other, -1, 1, 0) = 0
                        AND DECODE(rev_subject_map.expr_ects_total, -1, 1, 0) = 0
                    )
            LEFT JOIN v2u_dz_atrybuty_przedmiotow atrybuty_przedmiotow
                ON  (
                            atrybuty_przedmiotow.prz_kod = subject_map.map_subj_code
                        AND atrybuty_przedmiotow.tatr_kod = 'KOD_WYDZ'
                    )
        ),
        u_0 AS
        (
            SELECT
                  u_00.job_uuid
                , u_00.pk_atrybut_przedmiotu

                , SET(CAST(
                        COLLECT(u_00.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.subj_code)
                        AS V2u_Vchars1K_t
                  )) subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.rev_subj_code)
                        AS V2u_Vchars1K_t
                  )) rev_subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.id)
                        AS V2u_Vchars1K_t
                  )) ids1k

                -- debugging

                  -- "+ 0" trick is used to workaround oracle bug
                , COUNT(u_00.subject_map_id + 0) dbg_mapped -- includes NULL map_subj_codes

            FROM u_00 u_00
            GROUP BY
                  u_00.job_uuid
                , u_00.pk_atrybut_przedmiotu
        ),
        u AS
        ( -- make necessary adjustments to the raw values selected in u_0
            SELECT
                 -- passed through

                  u_0.job_uuid
                , u_0.pk_atrybut_przedmiotu
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
        ( -- determine our (v$*) values of certain fields
            SELECT
                  u.*
                , 'KOD_WYDZ' v$tatr_kod
                , u.map_subj_code v$prz_kod
                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id
                , TO_CLOB((
                    SELECT
                        LISTAGG(SUBSTR(VALUE(t), 1, 32), ', ')
                        WITHIN GROUP (ORDER BY VALUE(t))
                    FROM TABLE(
                            DECODE(u.dbg_rev_subj_codes, 0
                                 , u.subj_codes
                                 , u.rev_subj_codes)
                        ) t
                  )) v$wartosc
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
        ( -- provide our values (v$*) and original ones (u$*)
            SELECT
                  v.*
                , t.tatr_kod u$tatr_kod
                , t.prz_kod u$prz_kod
                , t.wart_lst_id u$wart_lst_id
                , t.prz_kod_rel u$prz_kod_rel
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.wartosc u$wartosc
                , t.wartosc_ang u$wartosc_ang
                , DECODE( v.dbg_unique_match, 1
                        , DECODE(TO_CHAR(t.wartosc), TO_CHAR(v.v$wartosc), '-', 'U')
                        , 'I'
                  ) change_type

                , CASE
                    WHEN
                        -- ensure that:
                        -- at least one subj_code contributes this row
                            v.dbg_subj_codes > 0
                        -- we reach for exactly one, NON-NULL  map_subj_code
                        AND v.dbg_map_subj_codes = 1
                        AND v.map_subj_code IS NOT NULL
                        -- at least one subj_code in reverse map lookup
                        AND v.dbg_rev_subj_codes > 0
                        -- no target ids found...
                        AND v.id IS NULL
                        AND v.dbg_ids = 0
                        -- ..but this wasn't due to missing mappings
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
                        -- single target id found
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

            , DECODE(w.change_type, 'I', w.v$tatr_kod, w.u$tatr_kod) tatr_kod
            , DECODE(w.change_type, 'I', w.v$prz_kod, w.u$prz_kod) prz_kod
            , DECODE(w.change_type, 'I', NULL, w.u$wart_lst_id) wart_lst_id
            , DECODE(w.change_type, 'I', NULL, w.u$prz_kod_rel, NULL) prz_kod_rel
            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data
            , DECODE(w.change_type, '-', w.u$wartosc, w.v$wartosc) wartosc
            , DECODE(w.change_type, 'I', NULL, w.u$wartosc_ang) wartosc_ang
            -- id appears in w.*

            , w.subj_codes dbg_subj_codes_tab
            , w.rev_subj_codes dbg_rev_subj_codes_tab

            , DECODE(w.change_type, 'I', w.safe_to_insert,
                                    'U', w.safe_to_update,
                                     0
              ) safe_to_change

        FROM w w
    ) src
ON  (
            tgt.pk_atrybut_przedmiotu = src.pk_atrybut_przedmiotu
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
        , pk_atrybut_przedmiotu
        -- DBG
        , dbg_mapped
        , dbg_map_subj_codes
        , dbg_subj_codes
        , dbg_subj_codes_tab
        , dbg_rev_subj_codes
        , dbg_rev_subj_codes_tab
        , dbg_ids
        , dbg_unique_match
        -- CTL
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
        , src.pk_atrybut_przedmiotu
        -- DBG
        , src.dbg_mapped
        , src.dbg_map_subj_codes
        , src.dbg_subj_codes
        , src.dbg_subj_codes_tab
        , src.dbg_rev_subj_codes
        , src.dbg_rev_subj_codes_tab
        , src.dbg_ids
        , src.dbg_unique_match
        -- CTL
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
--        , tgt.pk_atrybut_przedmiotu = src.pk_atrybut_przedmiotu
        -- DBG
        , tgt.dbg_mapped = src.dbg_mapped
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_subj_codes_tab = src.dbg_subj_codes_tab
        , tgt.dbg_rev_subj_codes = src.dbg_rev_subj_codes
        , tgt.dbg_rev_subj_codes_tab = src.dbg_rev_subj_codes_tab
        , tgt.dbg_ids = src.dbg_ids
        , tgt.dbg_unique_match = src.dbg_unique_match
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
