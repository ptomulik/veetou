MERGE INTO v2u_uu_studenci tgt
USING
    (
        WITH u_0 AS
        (
            -- determine what to use as a single output row;
            SELECT
                  -- primary key
                  students.job_uuid
                , students.student_index

                -- other "indexes"
                , SET(CAST(
                    COLLECT(studenci.id)
                    AS V2u_Dz_Ids_t
                )) ids

                -- values
                , SET(CAST(
                    COLLECT(students.first_name ORDER BY students.id)
                    AS V2u_Vchars1k_t
                )) first_names1k
                , SET(CAST(
                    COLLECT(students.last_name ORDER BY students.id)
                    AS V2u_Vchars1k_t
                )) last_names1k

                -- debugging

                , COUNT(studenci.id) dbg_matched

            FROM v2u_ko_students students
            LEFT JOIN v2u_dz_studenci studenci
                ON  (
                            studenci.indeks = students.student_index
                    )
            GROUP BY
                  students.job_uuid
                , students.student_index
        ),
        u AS
        ( -- make necessary adjustments to the raw values selected in u_0
            SELECT
                 -- passed through

                  u_0.job_uuid
                , u_0.student_index
                , u_0.dbg_matched

                -- adjusted

                , ( SELECT SUBSTR(VALUE(t), 1, 48)
                    FROM TABLE(u_0.first_names1k) t
                    WHERE ROWNUM <= 1
                  ) dbg_first_name
                , ( SELECT SUBSTR(VALUE(t), 1, 48)
                    FROM TABLE(u_0.last_names1k) t
                    WHERE ROWNUM <= 1
                  ) dbg_last_name
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.ids) t
                    WHERE ROWNUM <= 1
                  ) id

                -- debugging

                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.first_names1k)
                  ) dbg_first_names
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.last_names1k)
                  ) dbg_last_names
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.ids)
                  ) dbg_ids
            FROM u_0 u_0
        ),
        v AS
        ( -- determine our (v$*) values of certain fields
            SELECT
                  u.*
                , u.student_index pk_student
                , u.student_index v$indeks
                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id
                , CASE
                    WHEN
                            u.id IS NOT NULL
                        AND u.dbg_ids = 1
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                -- examine values we found
                , CASE
                    WHEN
                        -- all the instances were consistent
                            u.dbg_first_names = 1
                        AND u.dbg_last_names = 1
                        -- and we have correct first and last name
                        AND u.dbg_first_name IS NOT NULL
                        AND u.dbg_last_name IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
        ),
        w AS
        ( -- provide our values (v$*) and original ones (u$*)
            SELECT
                  v.*

                , t.indeks u$indeks
                , t.jed_org_kod u$jed_org_kod
                , t.typ_ind_kod u$typ_ind_kod
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.os_id u$os_id
                , t.indeks_glowny u$indeks_glowny

                , DECODE( v.dbg_unique_match, 1
                        , '-' -- we never update records of this table
                        , 'I'
                  ) change_type

                , CASE
                    WHEN
                            -- no target ids are found
                                v.dbg_ids = 0
                            AND v.id IS NULL
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
                            -- values are correct
                            AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_update
            FROM v v
            LEFT JOIN v2u_dz_studenci t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.id = v.id
                    )
        )
        SELECT
              w.job_uuid
            , w.pk_student

            , w.id
            , DECODE(w.change_type, 'I', w.v$indeks, w.u$indeks) indeks
            , DECODE(w.change_type, 'I', NULL, w.u$jed_org_kod) jed_org_kod
            , DECODE(w.change_type, 'I', NULL, w.u$typ_ind_kod) typ_ind_kod
            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data
            , DECODE(w.change_type, 'I', NULL, w.u$os_id) os_id
            , DECODE(w.change_type, 'I', NULL, w.u$indeks_glowny) indeks_glowny

            , w.dbg_first_name
            , w.dbg_last_name
            , w.dbg_first_names
            , w.dbg_last_names
            , w.dbg_ids
            , w.dbg_matched
            , w.dbg_unique_match
            , w.dbg_values_ok

            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert,
                                    'U', w.safe_to_update,
                                     0
              ) safe_to_change

        FROM w w
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.pk_student = src.pk_student
    )
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , indeks
        , jed_org_kod
        , typ_ind_kod
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , os_id
        , indeks_glowny
        -- KEY
        , job_uuid
        , pk_student
        -- DBG
        , dbg_first_name
        , dbg_last_name
        , dbg_first_names
        , dbg_last_names
        , dbg_ids
        , dbg_matched
        , dbg_unique_match
        , dbg_values_ok
        -- CTL
        , change_type
        , safe_to_change
        )
    VALUES
        ( src.id
        , src.indeks
        , src.jed_org_kod
        , src.typ_ind_kod
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.os_id
        , src.indeks_glowny
        -- KEY
        , src.job_uuid
        , src.pk_student
        -- DBG
        , src.dbg_first_name
        , src.dbg_last_name
        , src.dbg_first_names
        , src.dbg_last_names
        , src.dbg_ids
        , src.dbg_matched
        , src.dbg_unique_match
        , src.dbg_values_ok
        -- CTL
        , src.change_type
        , src.safe_to_change
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.id = src.id
        , tgt.indeks = src.indeks
        , tgt.jed_org_kod = src.jed_org_kod
        , tgt.typ_ind_kod = src.typ_ind_kod
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.os_id = src.os_id
        , tgt.indeks_glowny = src.indeks_glowny
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_student = src.pk_student
        -- DBG
        , tgt.dbg_first_name = src.dbg_first_name
        , tgt.dbg_last_name = src.dbg_last_name
        , tgt.dbg_first_names = src.dbg_first_names
        , tgt.dbg_last_names = src.dbg_last_names
        , tgt.dbg_ids = src.dbg_ids
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_values_ok = src.dbg_values_ok
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
