MERGE INTO v2u_uu_protokoly tgt
USING
    (
        WITH u_0 AS
        (
            -- determine what to use as a single output row;
            SELECT
                  g_j.job_uuid
                , COALESCE(
                          subject_map.map_subj_code
                        , subjects.subj_code
                  ) coalesced_subj_code
                , semesters.semester_code
                , COALESCE(
                          classes_map.map_classes_type
                        , g_j.classes_type
                  ) coalesced_classes_type
                , COALESCE(
                          ma_prot_j.proto_type
                        , mi_prot_j.proto_type
                  ) coalesced_proto_type
                , SET(CAST(
                        COLLECT(subject_map.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes1k
                , SET(CAST(
                        COLLECT(subject_map.map_proto_type)
                        AS V2u_Vchars1K_t
                  )) map_proto_types1k
                , SET(CAST(
                        COLLECT(classes_map.map_classes_type)
                        AS V2u_Vchars1K_t
                  )) map_classes_types1k
                , SET(CAST(
                        COLLECT(subjects.subj_code)
                        AS V2u_Vchars1K_t
                  )) subj_codes1k
                , SET(CAST(
                        COLLECT(g_j.classes_type)
                        AS V2u_Chars1_t
                  )) classes_types
                , SET(CAST(
                        COLLECT(subjects.subj_credit_kind)
                        AS V2u_Vchars1K_t
                  )) subj_credit_kinds1k
                , SET(CAST(
                        COLLECT(g_j.subj_grade ORDER BY g_j.subj_grade)
                        AS V2u_Vchars1K_t
                  )) subj_grades1k
                , SET(CAST(
                        COLLECT(ma_prot_j.prot_id)
                        AS V2u_Dz_Ids_t
                  )) prot_ids
                , SET(CAST(
                        COLLECT(protokoly.opis)
                        AS V2u_Vchars1K_t
                  )) opisy1k
                , SET(CAST(
                        COLLECT(protokoly.czy_do_sredniej)
                        AS V2u_Vchars1K_t
                  )) czy_do_sredniej1k
                , SET(CAST(
                        COLLECT(protokoly.edycja)
                        AS V2u_Vchars1K_t
                  )) edycje1k
                , SET(CAST(
                        COLLECT(protokoly.opis_ang)
                        AS V2u_Vchars1K_t
                  )) opis_ang1k
                , SET(CAST(
                        COLLECT(ma_zajcykl_j.zaj_cyk_id)
                        AS V2u_Dz_Ids_t
                  )) zaj_cyk_ids

                  -- "+ 0" trick is used to workaround oracle bug
                , COUNT(ma_prot_j.prz_kod) dbg_matched
                , COUNT(mi_prot_j.subject_id + 0) dbg_missing
                , COUNT(sm_j.map_id + 0) dbg_subject_mapped
                , COUNT(cm_j.map_id + 0) dbg_classes_mapped

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
            LEFT JOIN v2u_ko_matched_protos_j ma_prot_j
                ON  (
                            ma_prot_j.subject_id = g_j.subject_id
                        AND ma_prot_j.specialty_id = g_j.specialty_id
                        AND ma_prot_j.semester_id = g_j.semester_id
                        AND ma_prot_j.classes_type = g_j.classes_type
                        AND ma_prot_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_protos_j mi_prot_j
                ON  (
                            mi_prot_j.subject_id = g_j.subject_id
                        AND mi_prot_j.specialty_id = g_j.specialty_id
                        AND mi_prot_j.semester_id = g_j.semester_id
                        AND mi_prot_j.classes_type = g_j.classes_type
                        AND mi_prot_j.job_uuid = g_j.job_uuid
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
            LEFT JOIN v2u_dz_protokoly protokoly
                ON  (
                            protokoly.id = ma_prot_j.prot_id
                    )
            LEFT JOIN v2u_ko_matched_zajcykl_j ma_zajcykl_j
                ON  (
                            ma_zajcykl_j.subject_id = g_j.subject_id
                        AND ma_zajcykl_j.specialty_id = g_j.specialty_id
                        AND ma_zajcykl_j.semester_id = g_j.semester_id
                        AND ma_zajcykl_j.classes_type = g_j.classes_type
                        AND ma_zajcykl_j.job_uuid = g_j.job_uuid
                    )
            GROUP BY
                  g_j.job_uuid
                , COALESCE(subject_map.map_subj_code, subjects.subj_code)
                , semesters.semester_code
                , COALESCE(classes_map.map_classes_type, g_j.classes_type)
                , COALESCE(ma_prot_j.proto_type, mi_prot_j.proto_type)
        ),
        u AS
        ( -- make necessary adjustments to the raw values selected i u_0
            SELECT
                  u_0.job_uuid
                , u_0.coalesced_subj_code
                , u_0.semester_code
                , u_0.coalesced_classes_type
                , u_0.coalesced_proto_type

                -- select first element from each collection
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
                , ( SELECT SUBSTR(VALUE(t), 1, 100)
                    FROM TABLE(u_0.opisy1k) t
                    WHERE ROWNUM <= 1
                  ) opis
                , ( SELECT SUBSTR(VALUE(t), 1, 1)
                    FROM TABLE(u_0.czy_do_sredniej1k) t
                    WHERE ROWNUM <= 1
                  ) czy_do_sredniej
                , ( SELECT SUBSTR(VALUE(t), 1, 1)
                    FROM TABLE(u_0.edycje1k) t
                    WHERE ROWNUM <= 1
                  ) edycja
                , ( SELECT SUBSTR(VALUE(t), 1, 100)
                    FROM TABLE(u_0.opis_ang1k) t
                    WHERE ROWNUM <= 1
                  ) opis_ang
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.zaj_cyk_ids) t
                    WHERE ROWNUM <= 1
                  ) zaj_cyk_id
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u_0.subj_grades1k) t
                  ) AS V2u_Subj_Grades_t) subj_grades

                -- columns used for debugging
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
                    FROM TABLE(u_0.opisy1k)
                  ) dbg_opisy
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.czy_do_sredniej1k)
                  ) dbg_czy_do_sredniej
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.edycje1k)
                  ) dbg_edycje
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.opis_ang1k)
                  ) dbg_opisy_ang
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.zaj_cyk_ids)
                  ) dbg_zaj_cyk_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_grades1k)
                  ) dbg_subj_grades

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

                , u.zaj_cyk_id v$zaj_cyk_id
                , DECODE(u.prot_id, NULL
                        , CASE u.coalesced_proto_type
                            WHEN 'E' THEN 'Egzamin'
                            WHEN 'S' THEN 'Ocena łączna'
                            WHEN 'Z' THEN 'Zaliczenie'
                            WHEN 'O' THEN 'Zaliczenie na ocenę'
                            ELSE 'error: unknown protocol type "'
                                || u.coalesced_proto_type ||
                                '"'
                          END
                        , u.opis
                  ) v$opis
                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id
                , u.coalesced_proto_type v$tpro_kod
                , u.prot_id v$id
                , u.coalesced_subj_code v$prz_kod
                , u.semester_code v$cdyd_kod
                , DECODE(u.prot_id, NULL, 'T', u.czy_do_sredniej) v$czy_do_sredniej
                , DECODE(u.prot_id, NULL, NULL, u.edycja) v$edycja
                , DECODE(u.prot_id, NULL, NULL, u.opis_ang) v$opis_ang

                -- did we found unique row in the target table?
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
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                -- examine values we gonna propose
                , CASE
                    WHEN
                        -- all the instances were consistent
                            u.dbg_subj_codes = 1
                        AND u.dbg_classes_types = 1
                        AND (
                                    u.dbg_map_subj_codes = 1
                                AND u.coalesced_subj_code = u.map_subj_code
                            )
                        AND u.dbg_map_proto_types <= 1
                        AND u.dbg_subj_credit_kinds = 1
                        AND u.dbg_opisy <= 1
                        AND u.dbg_czy_do_sredniej <= 1
                        AND u.dbg_edycje <= 1
                        AND u.dbg_opisy_ang <= 1
                        AND (
                                        u.classes_type = '-'
                                    AND u.dbg_map_classes_types = 0
                                    AND u.zaj_cyk_id IS NULL
                                    AND u.dbg_zaj_cyk_ids = 0
                                OR
                                        u.classes_type <> '-'
                                    AND u.dbg_map_classes_types = 1
                                    AND u.zaj_cyk_id IS NOT NULL
                                    AND u.dbg_zaj_cyk_ids = 1
                            )

                        -- and we have correct tpro_kod value
                        AND u.coalesced_proto_type IN ('E', 'Z', 'O', 'S')
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
        ),
        w AS
        ( -- provide our values (v$*) and original ones (u$*)
            SELECT
                  v.*
                , t.zaj_cyk_id u$zaj_cyk_id
                , t.opis u$opis
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.tpro_kod u$tpro_kod
                , t.id u$id
                , t.prz_kod u$prz_kod
                , t.cdyd_kod u$cdyd_kod
                , t.czy_do_sredniej u$czy_do_sredniej
                , t.edycja u$edycja
                , t.opis_ang u$opis_ang

                -- is it insert, update or nothing?

                , DECODE( v.dbg_unique_match, 1
                        , (CASE
                            WHEN    -- do we introduce any modification?
                                    DECODE(v.v$zaj_cyk_id, t.zaj_cyk_id, 1, 0) = 1
                                AND DECODE(v.v$opis, t.opis, 1, 0) = 1
                                AND DECODE(v.v$tpro_kod, t.tpro_kod, 1, 0) = 1
                                AND DECODE(v.v$prz_kod, t.prz_kod, 1, 0) = 1
                                AND DECODE(v.v$cdyd_kod, t.cdyd_kod, 1, 0) = 1
                                AND DECODE(v.v$czy_do_sredniej, t.czy_do_sredniej, 1, 0) = 1
                                AND DECODE(v.v$edycja, t.edycja, 1, 0) = 1
                                AND DECODE(v.v$opis_ang, t.opis_ang, 1, 0) = 1
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
            LEFT JOIN v2u_dz_protokoly t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.id = v.prot_id
                    )
        )
        SELECT
              w.job_uuid
            , DECODE(w.dbg_unique_match, 1,
                  '{id: ' || w.prot_id || '}'
                , '{subject: "'
                    || w.coalesced_subj_code ||
                  '", semester: "'
                    || w.semester_code ||
                  '", proto: "'
                    || w.coalesced_proto_type ||
                  '", classes: "'
                    || w.coalesced_classes_type ||
                  '"}'
              ) pk_protokol

            , w.v$zaj_cyk_id zaj_cyk_id
            , w.v$opis opis

            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data

            , w.v$tpro_kod tpro_kod
            , DECODE(w.change_type, 'I', NULL, w.u$id) id
            , w.v$prz_kod prz_kod
            , w.v$cdyd_kod cdyd_kod
            , w.v$czy_do_sredniej czy_do_sredniej
            , w.v$edycja edycja
            , w.v$opis_ang opis_ang


            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
              ) safe_to_change

            , w.dbg_subj_codes
            , w.dbg_classes_types
            , w.dbg_map_subj_codes
            , w.dbg_map_proto_types
            , w.dbg_map_classes_types
            , w.dbg_subj_credit_kinds
            , w.dbg_prot_ids
            , w.dbg_opisy
            , w.dbg_czy_do_sredniej
            , w.dbg_edycje
            , w.dbg_opisy_ang
            , w.dbg_zaj_cyk_ids
            , w.dbg_subj_grades
            , w.dbg_values_ok
            , w.dbg_unique_match
            , w.dbg_matched
            , w.dbg_missing
            , w.dbg_subject_mapped
            , w.dbg_classes_mapped
        FROM w w
    ) src
ON  (
            tgt.pk_protokol = src.pk_protokol
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( zaj_cyk_id
        , opis
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , tpro_kod
        , id
        , prz_kod
        , cdyd_kod
        , czy_do_sredniej
        , edycja
        , opis_ang
        -- KEY
        , job_uuid
        , pk_protokol
        -- DBG
        , dbg_subj_codes
        , dbg_classes_types
        , dbg_map_subj_codes
        , dbg_map_proto_types
        , dbg_map_classes_types
        , dbg_subj_credit_kinds
        , dbg_prot_ids
        , dbg_opisy
        , dbg_czy_do_sredniej
        , dbg_edycje
        , dbg_opisy_ang
        , dbg_zaj_cyk_ids
        , dbg_subj_grades
        , dbg_values_ok
        , dbg_unique_match
        , dbg_matched
        , dbg_missing
        , dbg_subject_mapped
        , dbg_classes_mapped
        -- CTL
        , change_type
        , safe_to_change
        )
    VALUES
        ( src.zaj_cyk_id
        , src.opis
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.tpro_kod
        , src.id
        , src.prz_kod
        , src.cdyd_kod
        , src.czy_do_sredniej
        , src.edycja
        , src.opis_ang
        -- KEY
        , src.job_uuid
        , src.pk_protokol
        -- DBG
        , src.dbg_subj_codes
        , src.dbg_classes_types
        , src.dbg_map_subj_codes
        , src.dbg_map_proto_types
        , src.dbg_map_classes_types
        , src.dbg_subj_credit_kinds
        , src.dbg_prot_ids
        , src.dbg_opisy
        , src.dbg_czy_do_sredniej
        , src.dbg_edycje
        , src.dbg_opisy_ang
        , src.dbg_zaj_cyk_ids
        , src.dbg_subj_grades
        , src.dbg_values_ok
        , src.dbg_unique_match
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_subject_mapped
        , src.dbg_classes_mapped
        -- CTL
        , src.change_type
        , src.safe_to_change
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.zaj_cyk_id = src.zaj_cyk_id
        , tgt.opis = src.opis
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.tpro_kod = src.tpro_kod
        , tgt.id = src.id
        , tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.czy_do_sredniej = src.czy_do_sredniej
        , tgt.edycja = src.edycja
        , tgt.opis_ang = src.opis_ang
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_protokol = src.pk_protokol
        -- DBG
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_classes_types = src.dbg_classes_types
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_map_proto_types = src.dbg_map_proto_types
        , tgt.dbg_map_classes_types = src.dbg_map_classes_types
        , tgt.dbg_subj_credit_kinds = src.dbg_subj_credit_kinds
        , tgt.dbg_prot_ids = src.dbg_prot_ids
        , tgt.dbg_opisy = src.dbg_opisy
        , tgt.dbg_czy_do_sredniej = src.dbg_czy_do_sredniej
        , tgt.dbg_edycje = src.dbg_edycje
        , tgt.dbg_opisy_ang = src.dbg_opisy_ang
        , tgt.dbg_zaj_cyk_ids = src.dbg_zaj_cyk_ids
        , tgt.dbg_subj_grades = src.dbg_subj_grades
        , tgt.dbg_values_ok = src.dbg_values_ok
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_subject_mapped = src.dbg_subject_mapped
        , tgt.dbg_classes_mapped = src.dbg_classes_mapped
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
