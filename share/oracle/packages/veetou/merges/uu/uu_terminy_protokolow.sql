MERGE INTO v2u_uu_terminy_protokolow tgt
USING
    (
        WITH u_00 AS
        (
            SELECT
                  g_j.job_uuid
                , CASE
                    WHEN ma_trmpro_j.job_uuid IS NOT NULL
                    THEN
                      '{prot_id: '
                        || ma_trmpro_j.prot_id ||
                      ', nr: '
                        || ma_trmpro_j.nr ||
                      '}'
                    ELSE
                      '{subject: "'
                        || COALESCE( subject_map.map_subj_code
                                   , subjects.subj_code) ||
                      '", semester: "'
                        || semesters.semester_code ||
                      '", classes: "'
                        || COALESCE( classes_map.map_classes_type
                                   , g_j.classes_type ) ||
                      '", grade_date: "'
                        || COALESCE(TO_CHAR(g_j.subj_grade_date, 'YYYY-MM-DD'), '-') ||
                      '"}'
                  END pk_termin_protokolu

                , CASE
                    WHEN ma_trmpro_j.prot_id IS NOT NULL
                    THEN ma_trmpro_j.nr
                    WHEN mi_trmpro_j.prot_id IS NOT NULL
                    THEN ( SELECT MAX(t.nr)
                           FROM v2u_dz_terminy_protokolow t
                           WHERE t.prot_id = mi_trmpro_j.prot_id )
                        +
                        DENSE_RANK() OVER (
                                PARTITION BY
                                      g_j.job_uuid
                                    , mi_trmpro_j.prot_id
                                ORDER BY
                                      COALESCE(g_j.subj_grade_date,
                                               semesters2.end_date)
                            )
                    ELSE DENSE_RANK() OVER (
                            PARTITION BY
                                  g_j.job_uuid
                                , COALESCE( subject_map.map_subj_code
                                          , subjects.subj_code )
                                , semesters.semester_code
                                , COALESCE( classes_map.map_classes_type
                                          , g_j.classes_type )
                            ORDER BY
                                  COALESCE(g_j.subj_grade_date,
                                           semesters2.end_date)
                        )
                  END new_nr

                , subject_map.map_subj_code
                , subject_map.map_proto_type
                , classes_map.map_classes_type
                , subjects.subj_code
                , subjects.subj_credit_kind
                , semesters.semester_code
                , g_j.classes_type
                , g_j.subj_grade
                , g_j.subj_grade_date
                , COALESCE(g_j.subj_grade_date, semesters2.end_date) proto_return_date
                , ma_trmpro_j.prot_id
                , ma_trmpro_j.nr
                , mi_trmpro_j.prot_id mi_prot_id
                , mi_trmpro_j.coalesced_proto_type mi_coalesced_proto_type
                , mi_trmpro_j.max_istniejacy_nr max_istniejacy_nr
                , terminy_protokolow.status
                , terminy_protokolow.opis
                , terminy_protokolow.data_zwrotu
                , terminy_protokolow.egzamin_komisyjny
                , ma_trmpro_j.prz_kod
                , mi_trmpro_j.subject_id mi_subject_id
                , sm_j.map_id subject_map_id
                , cm_j.map_id classes_map_id

            FROM v2u_ko_grades_j g_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = g_j.subject_id
                        AND subjects.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = g_j.semester_id
                        AND semesters.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_semesters semesters2
                ON  (
                            semesters2.code = semesters.semester_code
                    )
            LEFT JOIN v2u_ko_matched_trmpro_j ma_trmpro_j
                ON  (
                            ma_trmpro_j.subject_id = g_j.subject_id
                        AND ma_trmpro_j.specialty_id = g_j.specialty_id
                        AND ma_trmpro_j.semester_id = g_j.semester_id
                        AND ma_trmpro_j.classes_type = g_j.classes_type
                        AND ma_trmpro_j.subj_grade_date =
                            COALESCE(TO_CHAR(g_j.subj_grade_date, 'YYYY-MM-DD'), '-')
                        AND ma_trmpro_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_trmpro_j mi_trmpro_j
                ON  (
                            mi_trmpro_j.subject_id = g_j.subject_id
                        AND mi_trmpro_j.specialty_id = g_j.specialty_id
                        AND mi_trmpro_j.semester_id = g_j.semester_id
                        AND mi_trmpro_j.classes_type = g_j.classes_type
                        AND mi_trmpro_j.subj_grade_date =
                            COALESCE(TO_CHAR(g_j.subj_grade_date, 'YYYY-MM-DD'), '-')
                        AND mi_trmpro_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = g_j.subject_id
                        AND sm_j.specialty_id = g_j.specialty_id
                        AND sm_j.semester_id = g_j.semester_id
                        AND sm_j.job_uuid = g_j.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = sm_j.map_id
                    )
            LEFT JOIN v2u_ko_classes_map_j cm_j
                ON  (
                            cm_j.subject_id = g_j.subject_id
                        AND cm_j.specialty_id = g_j.specialty_id
                        AND cm_j.semester_id = g_j.semester_id
                        AND cm_j.classes_type = g_j.classes_type
                        AND cm_j.job_uuid = g_j.job_uuid
                        AND cm_j.selected = 1
                    )
            LEFT JOIN v2u_classes_map classes_map
                ON  (
                            classes_map.id = cm_j.map_id
                    )
            LEFT JOIN v2u_dz_terminy_protokolow terminy_protokolow
                ON  (
                            terminy_protokolow.prot_id = ma_trmpro_j.prot_id
                        AND terminy_protokolow.nr = ma_trmpro_j.nr
                    )
            /* WHERE g_j.subj_grade IS NOT NULL */
        ),
        u_0 AS
        (
            -- determine what to use as a single output row;
            SELECT
                  u_00.job_uuid
                , u_00.pk_termin_protokolu

                , SET(CAST(
                        COLLECT(u_00.new_nr)
                        AS V2u_Integers_t
                  )) new_nrs

                , SET(CAST(
                        COLLECT(u_00.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.map_proto_type)
                        AS V2u_Vchars1K_t
                  )) map_proto_types1k
                , SET(CAST(
                        COLLECT(u_00.map_classes_type)
                        AS V2u_Vchars1K_t
                  )) map_classes_types1k
                , SET(CAST(
                        COLLECT(u_00.subj_code)
                        AS V2u_Vchars1K_t
                  )) subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.classes_type)
                        AS V2u_Chars1_t
                  )) classes_types
                , SET(CAST(
                        COLLECT(u_00.subj_credit_kind)
                        AS V2u_Vchars1K_t
                  )) subj_credit_kinds1k
                , SET(CAST(
                        COLLECT(u_00.subj_grade ORDER BY u_00.subj_grade)
                        AS V2u_Vchars1K_t
                  )) subj_grades1k
                , SET(CAST(
                        COLLECT(u_00.prot_id)
                        AS V2u_Dz_Ids_t
                  )) prot_ids
                , SET(CAST(
                        COLLECT(u_00.nr)
                        AS V2u_Ints10_t
                  )) nrs
                , SET(CAST(
                        COLLECT(u_00.status)
                        AS V2u_Vchars1K_t
                  )) statusy1k
                , SET(CAST(
                        COLLECT(u_00.opis)
                        AS V2u_Vchars1K_t
                  )) opisy1k
                , SET(CAST(
                        COLLECT(u_00.data_zwrotu)
                        AS V2u_Dates_t
                  )) daty_zwrotu
                , SET(CAST(
                        COLLECT(u_00.egzamin_komisyjny)
                        AS V2u_Vchars1K_t
                  )) egzaminy_komisyjne1k
                , SET(CAST(
                        COLLECT(u_00.subj_grade_date ORDER BY u_00.subj_grade_date)
                        AS V2u_Dates_t
                  )) subj_grade_dates
                , SET(CAST(
                        COLLECT(u_00.proto_return_date ORDER BY u_00.proto_return_date)
                        AS V2u_Dates_t
                  )) proto_return_dates
                , SET(CAST(
                        COLLECT(u_00.mi_prot_id)
                        AS V2u_Dz_Ids_t
                  )) mi_prot_ids
                , SET(CAST(
                        COLLECT(u_00.max_istniejacy_nr ORDER BY u_00.max_istniejacy_nr)
                        AS V2u_Ints10_t
                  )) max_istniejace_nry


                /* The ".. + 0" seems to be a workaround the following bug:
                 *
                 * BUG: The values of dbg_matched and dbg_subject_mapped get
                 * mixed randomly in this query. */
                , COUNT(u_00.prz_kod) dbg_matched
                , COUNT(u_00.mi_subject_id + 0) dbg_missing
                , COUNT(u_00.subject_map_id + 0) dbg_subject_mapped
                , COUNT(u_00.classes_map_id + 0) dbg_classes_mapped

            FROM u_00 u_00
            GROUP BY
                  u_00.job_uuid
                , u_00.pk_termin_protokolu
        ),
        u AS
        ( -- make necessary adjustments to the raw values selected i u_0
            SELECT
                  u_0.job_uuid
                , u_0.pk_termin_protokolu

                -- select first element from each collection
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.new_nrs) t
                    WHERE ROWNUM <= 1
                  ) new_nr

                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_proto_types1k) t
                    WHERE ROWNUM <= 1
                  ) map_proto_type
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_classes_types1k) t
                    WHERE ROWNUM <= 1
                  ) map_classes_type
                , ( SELECT SUBSTR(VALUE(t), 1, 16)
                    FROM TABLE(u_0.subj_credit_kinds1k) t
                    WHERE ROWNUM <= 1
                  ) subj_credit_kind
                , ( SELECT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) subj_code
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.classes_types) t
                    WHERE ROWNUM <= 1
                  ) classes_type
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.prot_ids) t
                    WHERE ROWNUM <= 1
                  ) prot_id
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.nrs) t
                    WHERE ROWNUM <= 1
                  ) nr
                , ( SELECT SUBSTR(VALUE(t), 1, 2)
                    FROM TABLE(u_0.statusy1k) t
                    WHERE ROWNUM <= 1
                  ) status
                , ( SELECT SUBSTR(VALUE(t), 1, 100)
                    FROM TABLE(u_0.opisy1k) t
                    WHERE ROWNUM <= 1
                  ) opis
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.daty_zwrotu) t
                    WHERE ROWNUM <= 1
                  ) data_zwrotu
                , ( SELECT SUBSTR(VALUE(t), 1, 1)
                    FROM TABLE(u_0.egzaminy_komisyjne1k) t
                    WHERE ROWNUM <= 1
                  ) egzamin_komisyjny
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.mi_prot_ids) t
                    WHERE ROWNUM <= 1
                  ) mi_prot_id
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.max_istniejace_nry) t
                    WHERE ROWNUM <= 1
                  ) max_istniejacy_nr

                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u_0.subj_grades1k) t
                  ) AS V2u_Subj_Grades_t) subj_grades

                , u_0.subj_grade_dates

                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.proto_return_dates) t
                    WHERE ROWNUM <= 1
                  ) proto_return_date

                -- columns used for debugging
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.new_nrs)
                  ) dbg_new_nrs
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_codes1k)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.classes_types)
                  ) dbg_classes_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_subj_codes1k)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_proto_types1k)
                  ) dbg_map_proto_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_classes_types1k)
                  ) dbg_map_classes_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_credit_kinds1k)
                  ) dbg_subj_credit_kinds
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prot_ids)
                  ) dbg_prot_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.nrs)
                  ) dbg_nrs
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.statusy1k) t
                  ) dbg_statusy
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.opisy1k) t
                  ) dbg_opisy
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.daty_zwrotu) t
                  ) dbg_daty_zwrotu
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.egzaminy_komisyjne1k) t
                  ) dbg_egzaminy_komisyjne
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_grades1k)
                  ) dbg_subj_grades
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_grade_dates)
                  ) dbg_subj_grade_dates
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.proto_return_dates)
                  ) dbg_proto_return_dates
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.mi_prot_ids)
                  ) dbg_mi_prot_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.max_istniejace_nry)
                  ) dbg_max_istniejace_nry

                , u_0.dbg_matched
                , u_0.dbg_missing
                , u_0.dbg_subject_mapped
                , u_0.dbg_classes_mapped
            FROM u_0 u_0
        ),
        v AS
        ( -- determine our (v$*) values for certain fields
            SELECT
                  u.*

                , DECODE( u.nr, NULL
                        , u.mi_prot_id
                        , u.prot_id
                  ) v$prot_id
                , DECODE( u.nr, NULL
                    , u.new_nr
                    , u.nr
                  ) v$nr
                , DECODE( u.nr, NULL
                        , 'P' /* P' - w przygotowaniu, 'Zd' - zamkniety */
                        , u.status
                  ) v$status
                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , DECODE( u.nr, NULL
                        , 'Termin ' || TO_CHAR(u.new_nr)
                        , u.opis
                  ) v$opis
                , DECODE( u.nr, NULL
                        , u.proto_return_date
                        , u.data_zwrotu
                  ) v$data_zwrotu
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id
                , DECODE( u.nr
                        , NULL
                        , 'N'
                        , u.egzamin_komisyjny
                ) v$egzamin_komisyjny

                -- did we find unique row in the target table?
                , CASE
                    WHEN    u.dbg_matched > 0
                        AND u.dbg_subject_mapped = u.dbg_matched
                        AND (
                                        u.classes_type = '-'
                                    AND u.dbg_classes_mapped = 0
                                OR
                                        u.classes_type <> '-'
                                    AND u.dbg_classes_mapped = u.dbg_matched
                            )
                        AND u.dbg_missing = 0
                        AND u.dbg_prot_ids = 1 AND u.prot_id IS NOT NULL
                        AND u.dbg_nrs = 1 AND u.nr IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                -- examine values we gonna propose
                , CASE
                    WHEN
                        -- all the instances were consistent
                            (
                                    u.dbg_statusy = 0
                                OR
                                        u.dbg_statusy = 1
                                    AND
                                        u.status IN ('P', 'Zd', 'A', 'X', 'Zn', 'Zt')
                            )
                        AND (
                                    u.dbg_opisy = 0
                                OR
                                        u.dbg_opisy = 1
                                    AND
                                        u.opis IS NOT NULL
                            )
                        AND (
                                        u.dbg_daty_zwrotu = 0
                                    AND u.data_zwrotu IS NULL
                                    AND u.dbg_proto_return_dates = 1
                                    AND u.proto_return_date IS NOT NULL
                                OR
                                        u.dbg_daty_zwrotu = 1
                                    AND u.data_zwrotu
                                        BETWEEN
                                            TO_DATE('1990-01-01', 'YYYY-MM-DD')
                                        AND
                                            TO_DATE('2030-12-31', 'YYYY-MM-DD')
                                    AND u.dbg_subj_grade_dates >= 1
                            )
                        AND (
                                    u.dbg_egzaminy_komisyjne = 0
                                OR
                                        u.dbg_egzaminy_komisyjne = 1
                                    AND
                                        UPPER(u.egzamin_komisyjny) IN ('T', 'N')
                            )
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
        ),
        w AS
        ( -- provide our values (v$*) and original ones (u$*)
            SELECT
                  v.*
                , t.prot_id u$prot_id
                , t.nr u$nr
                , t.status u$status
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.opis u$opis
                , t.data_zwrotu u$data_zwrotu
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.egzamin_komisyjny u$egzamin_komisyjny

                -- is it insert, update or nothing?

                , DECODE( v.dbg_unique_match, 1
                        , (CASE
                            WHEN    -- do we introduce any modification?
                                    DECODE(v.v$status, t.status, 1, 0) = 1
                                AND DECODE(v.v$opis, t.opis, 1, 0) = 1
                                AND DECODE(v.v$data_zwrotu, t.data_zwrotu, 1, 0) = 1
                                AND DECODE(v.v$egzamin_komisyjny, t.egzamin_komisyjny, 1, 0) = 1
                            THEN '-'
                            ELSE 'U'
                          END)
                        , 'I'
                  ) change_type

                , CASE
                    WHEN
                        -- ensure that
                        -- maps for all instances existed but there were no
                        -- corresponding subject in target system
                            v.dbg_matched = 0
                        AND v.dbg_missing > 0
                        AND v.dbg_subject_mapped = v.dbg_missing
                        AND (
                                        v.classes_type = '-'
                                    AND v.dbg_classes_mapped = 0
                                OR
                                        v.classes_type <> '-'
                                    AND v.dbg_classes_mapped = v.dbg_missing
                            )
                        AND v.dbg_new_nrs = 1
                        AND v.new_nr > 0
                        AND v.dbg_mi_prot_ids = 1
                        AND v.mi_prot_id IS NOT NULL
                        -- values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_insert

                , CASE
                    WHEN
                        -- ensure that
                        -- we have target subject code
                            v.map_subj_code IS NOT NULL
                        AND v.dbg_map_subj_codes = 1
                        AND v.dbg_subj_codes > 0
                        -- and we uniquelly matched a row in target table
                        AND v.dbg_unique_match = 1
                        -- and values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_update

            FROM v v
            LEFT JOIN v2u_dz_terminy_protokolow t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.prot_id = v.prot_id
                        AND t.nr = v.nr
                    )
        )
        SELECT
              w.job_uuid
            , w.pk_termin_protokolu

            , w.v$prot_id prot_id
            , w.v$nr nr
            , w.v$status status

            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data

            , w.v$opis opis
            , w.v$data_zwrotu data_zwrotu

            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data

            , w.v$egzamin_komisyjny egzamin_komisyjny

            , w.dbg_subj_codes
            , w.dbg_classes_types
            , w.dbg_map_subj_codes
            , w.dbg_map_proto_types
            , w.dbg_map_classes_types
            , w.dbg_subj_credit_kinds
            , w.dbg_prot_ids
            , w.dbg_nrs
            , w.dbg_statusy
            , w.dbg_opisy
            , w.dbg_daty_zwrotu
            , w.dbg_egzaminy_komisyjne
            , w.dbg_subj_grades
            , w.dbg_subj_grade_dates
            , w.dbg_mi_prot_ids
            , w.dbg_max_istniejace_nry
            , w.dbg_new_nrs
            , w.dbg_matched
            , w.dbg_missing
            , w.dbg_subject_mapped
            , w.dbg_classes_mapped
            , w.dbg_unique_match
            , w.dbg_values_ok

            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
            ) safe_to_change
        FROM w w
    ) src
ON  (
            tgt.pk_termin_protokolu = src.pk_termin_protokolu
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( prot_id
        , nr
        , status
        , utw_id
        , utw_data
        , opis
        , data_zwrotu
        , mod_id
        , mod_data
        , egzamin_komisyjny
        -- KEY
        , job_uuid
        , pk_termin_protokolu
        -- DBG
        , dbg_subj_codes
        , dbg_classes_types
        , dbg_map_subj_codes
        , dbg_map_proto_types
        , dbg_map_classes_types
        , dbg_subj_credit_kinds
        , dbg_prot_ids
        , dbg_nrs
        , dbg_statusy
        , dbg_opisy
        , dbg_daty_zwrotu
        , dbg_egzaminy_komisyjne
        , dbg_subj_grades
        , dbg_subj_grade_dates
        , dbg_mi_prot_ids
        , dbg_max_istniejace_nry
        , dbg_new_nrs
        , dbg_matched
        , dbg_missing
        , dbg_subject_mapped
        , dbg_classes_mapped
        , dbg_unique_match
        , dbg_values_ok
        -- CTL
        , change_type
        , safe_to_change
        )
    VALUES
        ( src.prot_id
        , src.nr
        , src.status
        , src.utw_id
        , src.utw_data
        , src.opis
        , src.data_zwrotu
        , src.mod_id
        , src.mod_data
        , src.egzamin_komisyjny
        -- KEY
        , src.job_uuid
        , src.pk_termin_protokolu
        -- DBG
        , src.dbg_subj_codes
        , src.dbg_classes_types
        , src.dbg_map_subj_codes
        , src.dbg_map_proto_types
        , src.dbg_map_classes_types
        , src.dbg_subj_credit_kinds
        , src.dbg_prot_ids
        , src.dbg_nrs
        , src.dbg_statusy
        , src.dbg_opisy
        , src.dbg_daty_zwrotu
        , src.dbg_egzaminy_komisyjne
        , src.dbg_subj_grades
        , src.dbg_subj_grade_dates
        , src.dbg_mi_prot_ids
        , src.dbg_max_istniejace_nry
        , src.dbg_new_nrs
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_subject_mapped
        , src.dbg_classes_mapped
        , src.dbg_unique_match
        , src.dbg_values_ok
        -- CTL
        , src.change_type
        , src.safe_to_change
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.prot_id = src.prot_id
        , tgt.nr = src.nr
        , tgt.status = src.status
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.opis = src.opis
        , tgt.data_zwrotu = src.data_zwrotu
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.egzamin_komisyjny = src.egzamin_komisyjny
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_termin_protokolu = src.pk_termin_protokolu
        -- DBG
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_classes_types = src.dbg_classes_types
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_map_proto_types = src.dbg_map_proto_types
        , tgt.dbg_map_classes_types = src.dbg_map_classes_types
        , tgt.dbg_subj_credit_kinds = src.dbg_subj_credit_kinds
        , tgt.dbg_prot_ids = src.dbg_prot_ids
        , tgt.dbg_nrs = src.dbg_nrs
        , tgt.dbg_statusy = src.dbg_statusy
        , tgt.dbg_opisy = src.dbg_opisy
        , tgt.dbg_daty_zwrotu = src.dbg_daty_zwrotu
        , tgt.dbg_egzaminy_komisyjne = src.dbg_egzaminy_komisyjne
        , tgt.dbg_subj_grades = src.dbg_subj_grades
        , tgt.dbg_subj_grade_dates = src.dbg_subj_grade_dates
        , tgt.dbg_mi_prot_ids = src.dbg_mi_prot_ids
        , tgt.dbg_max_istniejace_nry = src.dbg_max_istniejace_nry
        , tgt.dbg_new_nrs = src.dbg_new_nrs
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_subject_mapped = src.dbg_subject_mapped
        , tgt.dbg_classes_mapped = src.dbg_classes_mapped
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_values_ok = src.dbg_values_ok
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
