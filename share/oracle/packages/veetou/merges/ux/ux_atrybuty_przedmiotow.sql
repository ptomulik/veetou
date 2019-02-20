MERGE INTO v2u_ux_atrybuty_przedmiotow tgt
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
                        AS V2u_Vchars1024_t
                  )) subj_codes
                , SET(CAST(
                        COLLECT(subject_map.map_subj_code)
                        AS V2u_Vchars1024_t
                  )) map_subj_codes
                , SET(CAST(
                        COLLECT(atrybuty_przedmiotow.id)
                        AS V2u_Vchars1024_t
                  )) ids
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

                  -- "unaggregate'
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
        ( -- look back into subject_map to find all codes that we gonna map
          -- onto map_subj_code
            SELECT
                  v.map_subj_code
                , SET(CAST(
                    COLLECT(subject_map.subj_code)
                    AS V2u_Vchars1024_t
                  )) all_subj_codes
                , COUNT(DISTINCT subject_map.subj_code) dbg_all_subj_codes
            FROM v v
            INNER JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.map_subj_code = v.map_subj_code
                    )
            GROUP BY
                    v.map_subj_code
        )
        SELECT
              v.*
            , V2u_Get.Utw_Id(v.job_uuid) utw_id
            , V2u_Get.Mod_Id(v.job_uuid) mod_id
            , 'KOD_WYDZ' tatr_kod
            , v.map_subj_code prz_kod
            , CAST(MULTISET(
                SELECT(SUBSTR(VALUE(t), 1, 32))
                FROM TABLE(w.all_subj_codes) t
                WHERE ROWNUM <= 20
              ) AS V2u_Subj_20Codes_t) all_subj_codes
            , COALESCE(w.dbg_all_subj_codes, 0) dbg_all_subj_codes
            , ( SELECT
                    LISTAGG(SUBSTR(VALUE(t), 1, 32), ', ')
                    WITHIN GROUP (ORDER BY VALUE(t))
                FROM TABLE(w.all_subj_codes) t
              ) wartosc
            , CASE
                WHEN
                        v.map_subj_code IS NOT NULL
                    AND v.dbg_map_subj_codes = 1
                    AND v.dbg_subj_codes > 0 AND v.dbg_subj_codes <= 20
                    AND w.dbg_all_subj_codes > 0 AND w.dbg_all_subj_codes <= 20
                    AND v.dbg_mapped > 0
                    AND v.dbg_ids = 0
                THEN 1
                ELSE 0
              END safe_to_add
        FROM v v
        LEFT JOIN w w
            ON  (
                    v.map_subj_code = w.map_subj_code
                )
    ) src
ON  (
            tgt.coalesced_subj_code = src.coalesced_subj_code
        AND tgt.tatr_kod = src.tatr_kod
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        (
          tatr_kod
        , prz_kod
        , utw_id
        , mod_id
        , wartosc
        , id
        , job_uuid
        , subj_codes
        , all_subj_codes
        , coalesced_subj_code
        -- DBG
        , dbg_map_subj_codes
        , dbg_subj_codes
        , dbg_all_subj_codes
        , dbg_ids
        , safe_to_add
        )
    VALUES
        (
          src.tatr_kod
        , src.prz_kod
        , src.utw_id
        , src.mod_id
        , src.wartosc
        , src.id
        , src.job_uuid
        , src.subj_codes
        , src.all_subj_codes
        , src.coalesced_subj_code
        -- DBG
        , src.dbg_map_subj_codes
        , src.dbg_subj_codes
        , src.dbg_all_subj_codes
        , src.dbg_ids
        , src.safe_to_add
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.prz_kod = src.prz_kod
        , tgt.utw_id = src.utw_id
        , tgt.mod_id = src.mod_id
        , tgt.wartosc = src.wartosc
        , tgt.id = src.id
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
