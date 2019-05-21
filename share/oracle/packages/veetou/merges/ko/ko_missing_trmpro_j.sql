MERGE INTO v2u_ko_missing_trmpro_j tgt
USING
    (
        WITH u AS
        ( -- all grades except those falling into v2u_ko_matched_protos_j
            SELECT
                  g_j.job_uuid
                , g_j.semester_id
                , g_j.specialty_id
                , g_j.subject_id
                , g_j.classes_type
                , COALESCE(g_j.subj_grade_date, semesters2.end_date) proto_return_date
                , SET(CAST(
                        COLLECT(ma_prot_j.prot_id)
                        AS V2u_Dz_Ids_t
                  )) prot_ids
                , SET(CAST(
                        COLLECT(mi_prot_j.reason)
                        AS V2u_Vchars2K_t
                  )) mi_reasons2k
                , SET(CAST(
                        COLLECT(g_j.subj_grade ORDER BY g_j.subj_grade)
                        AS V2u_Vchars1K_t
                  )) subj_grades1k
                , SET(CAST(
                        COLLECT(g_j.subj_grade_date ORDER BY g_j.subj_grade_date)
                        AS V2u_Dates_t
                  )) subj_grade_dates_udt
                , MAX(terminy_protokolow.nr) KEEP (
                    DENSE_RANK LAST ORDER BY terminy_protokolow.nr
                  ) max_istniejacy_nr
                , SET(CAST(
                        COLLECT(terminy_protokolow.data_zwrotu
                                ORDER BY terminy_protokolow.data_zwrotu)
                        AS V2u_Dates_t
                  )) istniejace_daty_zwrotow_udt
            FROM v2u_ko_grades_j g_j
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
                        AND ma_trmpro_j.proto_return_date = COALESCE(g_j.subj_grade_date, semesters2.end_date)
                        AND ma_trmpro_j.job_uuid = g_j.job_uuid
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
            LEFT JOIN v2u_dz_terminy_protokolow terminy_protokolow
                ON  (
                            terminy_protokolow.prot_id = ma_prot_j.prot_id
                    )
            WHERE
                  ma_trmpro_j.job_uuid IS NULL
            GROUP BY
                  g_j.job_uuid
                , g_j.semester_id
                , g_j.specialty_id
                , g_j.subject_id
                , g_j.classes_type
                , COALESCE(g_j.subj_grade_date, semesters2.end_date)
        ),
        v AS
        (
            SELECT
                  u.*
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u.subj_grades1k) t
                  ) AS V2u_Subj_Grades_t) subj_grades
                , CAST(MULTISET(
                    SELECT VALUE(t)
                    FROM TABLE(u.subj_grade_dates_udt) t
                    WHERE ROWNUM <= 20
                  ) AS V2u_20Dates_t) subj_grade_dates
                , ( SELECT VALUE(t)
                    FROM TABLE(u.prot_ids) t
                    WHERE ROWNUM <= 1
                  ) prot_id
                , ( SELECT SUBSTR(VALUE(t), 1, 300)
                    FROM TABLE(u.mi_reasons2k) t
                    WHERE ROWNUM <= 1
                  ) mi_reason
            FROM u u
        ),
        w AS
        ( -- select additional fields
            SELECT
                  v.*
                , sm_j.map_id subject_map_id
                , subject_map.map_subj_code
                , cm_j.map_id classes_map_id
                , classes_map.map_classes_type
                , subjects.subj_code                -- for diagnostics
                , semesters.semester_code           -- for diagnostics
                , COALESCE(
                      subject_map.map_proto_type
                    , V2U_Get.Tpro_Kod(
                          subj_credit_kind => subjects.subj_credit_kind
                        , subj_grades => v.subj_grades
                      )
                  ) coalesced_proto_type
                , CAST(MULTISET(
                        SELECT VALUE(t)
                        FROM TABLE(v.istniejace_daty_zwrotow_udt) t
                        WHERE ROWNUM <= 20
                  ) AS V2u_20Dates_t ) istniejace_daty_zwrotow
            FROM v v
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = v.subject_id
                        AND subjects.job_uuid = v.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = v.semester_id
                        AND semesters.job_uuid = v.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = v.subject_id
                        AND sm_j.specialty_id = v.specialty_id
                        AND sm_j.semester_id = v.semester_id
                        AND sm_j.job_uuid = v.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = sm_j.map_id
                    )
            LEFT JOIN v2u_ko_classes_map_j cm_j
                ON  (
                            cm_j.subject_id = v.subject_id
                        AND cm_j.specialty_id = v.specialty_id
                        AND cm_j.semester_id = v.semester_id
                        AND cm_j.classes_type = v.classes_type
                        AND cm_j.job_uuid = v.job_uuid
                        AND cm_j.selected = 1
                    )
            LEFT JOIN v2u_classes_map classes_map
                ON  (
                            classes_map.id = cm_j.map_id
                    )
        )
        SELECT
              w.*
            , trmpro.nr
            , CASE
                WHEN w.prot_id IS NULL
                THEN w.mi_reason
                WHEN trmpro.nr IS NULL
                THEN '{subject: "'
                     ||
                     w.map_subj_code
                     || '", semester: "' ||
                     w.semester_code
                     || '", tzaj: "' ||
                     w.map_classes_type
                     || '", protocol: "' ||
                     w.coalesced_proto_type
                     || '", date: "' ||
                     w.proto_return_date
                     || '"} not in dz_terminy_protokolow'
                ELSE 'error (v2u_ko_matched_trmpro_j out of sync?)'
              END reason
        FROM w w
        LEFT JOIN v2u_semesters semesters
            ON  (
                        semesters.code = w.semester_code
                )
        LEFT JOIN v2u_dz_terminy_protokolow trmpro
            ON  (
                        trmpro.prot_id = w.prot_id
                    AND (
                                TO_CHAR(trmpro.data_zwrotu, 'YYYY-MM-DD')
                              = TO_CHAR(w.proto_return_date, 'YYYY-MM-DD')
                            OR (
                                        -- fallback date ...
                                        TO_CHAR(trmpro.data_zwrotu, 'YYYY-MM-DD')
                                      = TO_CHAR(semesters.end_date, 'YYYY-MM-DD')
                                    AND NOT EXISTS (
                                        SELECT NULL
                                        FROM v2u_dz_terminy_protokolow t
                                        WHERE   t.prot_id = w.prot_id
                                            AND TO_CHAR(t.data_zwrotu, 'YYYY-MM-DD')
                                              = TO_CHAR(w.proto_return_date, 'YYYY-MM-DD')
                                    )
                                )
                        )
                )
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.classes_type = src.classes_type
        AND tgt.proto_return_date = src.proto_return_date
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , subject_id
        , classes_type
        , proto_return_date
        , subj_grade_dates
        , subject_map_id
        , map_subj_code
        , classes_map_id
        , map_classes_type
        , coalesced_proto_type
        , prot_id
        , nr
        , reason
        , max_istniejacy_nr
        , istniejace_daty_zwrotow
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.classes_type
        , src.proto_return_date
        , src.subj_grade_dates
        , src.subject_map_id
        , src.map_subj_code
        , src.classes_map_id
        , src.map_classes_type
        , src.coalesced_proto_type
        , src.prot_id
        , src.nr
        , src.reason
        , src.max_istniejacy_nr
        , src.istniejace_daty_zwrotow
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.map_subj_code = src.map_subj_code
        , tgt.classes_map_id = src.classes_map_id
        , tgt.subj_grade_dates = src.subj_grade_dates
        , tgt.map_classes_type = src.map_classes_type
        , tgt.coalesced_proto_type = src.coalesced_proto_type
        , tgt.prot_id = src.prot_id
        , tgt.nr = src.nr
        , tgt.reason = src.reason
        , tgt.max_istniejacy_nr = src.max_istniejacy_nr
        , tgt.istniejace_daty_zwrotow = src.istniejace_daty_zwrotow
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
