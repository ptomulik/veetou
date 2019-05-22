MERGE INTO v2u_ko_missing_protos_j tgt
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
                , SET(CAST(
                        COLLECT(g_j.subj_grade ORDER BY g_j.subj_grade)
                        AS V2u_Vchars1K_t
                  )) subj_grades1k
            FROM v2u_ko_grades_j g_j
            LEFT JOIN v2u_ko_matched_protos_j ma_j
                ON  (
                            ma_j.subject_id = g_j.subject_id
                        AND ma_j.specialty_id = g_j.specialty_id
                        AND ma_j.semester_id = g_j.semester_id
                        AND ma_j.classes_type = g_j.classes_type
                        AND ma_j.job_uuid = g_j.job_uuid
                    )
            WHERE
                  ma_j.job_uuid IS NULL
            GROUP BY
                  g_j.job_uuid
                , g_j.semester_id
                , g_j.specialty_id
                , g_j.subject_id
                , g_j.classes_type
        ),
        v AS
        (
            SELECT
                  u.*
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u.subj_grades1k) t
                  ) AS V2u_Subj_Grades_t) subj_grades
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
                , ma_zajcykl_j.zaj_cyk_id
                , CAST(MULTISET(
                    SELECT DISTINCT p.tpro_kod
                    FROM v2u_dz_protokoly p
                    WHERE   p.prz_kod = subject_map.map_subj_code
                        AND p.cdyd_kod = semesters.semester_code
                        AND (
                                        v.classes_type = '-'
                                    AND p.zaj_cyk_id IS NULL
                                OR
                                EXISTS
                                    (
                                        SELECT NULL
                                        FROM v2u_dz_zajecia_cykli z
                                        WHERE z.id = p.zaj_cyk_id
                                    )
                            )
                        AND ROWNUM <= 20
                    ORDER BY p.tpro_kod
                  ) AS V2u_Prot_20Codes_t) istniejace_tpro_kody
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
            LEFT JOIN v2u_ko_matched_zajcykl_j ma_zajcykl_j
                ON  (
                            ma_zajcykl_j.subject_id = v.subject_id
                        AND ma_zajcykl_j.specialty_id = v.specialty_id
                        AND ma_zajcykl_j.semester_id = v.semester_id
                        AND ma_zajcykl_j.classes_type = v.classes_type
                        AND ma_zajcykl_j.job_uuid = v.job_uuid
                    )
        )
        SELECT
              w.*
            , protokoly.id prot_id
            , CASE
                WHEN w.classes_type = '-' AND w.subject_map_id IS NULL
                THEN 'no subject map for {subject: "'
                     ||
                     w.subj_code
                     || '", semester: "' ||
                     w.semester_code
                     || '"}'
                WHEN w.map_subj_code IS NULL
                THEN 'map_subj_code IS NULL for {subject: "'
                     ||
                     w.subj_code
                     || '", semester: ' ||
                     w.semester_code
                    || '"}'
                WHEN w.classes_type <> '-' AND w.classes_map_id IS NULL
                THEN 'no classes map for {subject: "'
                     ||
                     w.subj_code
                     || '", semester: "' ||
                     w.semester_code
                     || '", classes: "' ||
                     w.classes_type
                     || '"}'
                WHEN w.classes_type <> '-' AND w.map_classes_type IS NULL
                THEN 'map_classes_type IS NULL for {subject: "'
                     ||
                     w.subj_code
                     || '", semester: "' ||
                     w.semester_code
                     || '", classes: "' ||
                     w.classes_type
                     || '"}'
                WHEN w.classes_type <> '-' AND w.zaj_cyk_id IS NULL
                THEN '{subject: "'
                     ||
                     w.map_subj_code
                     || '", semester: "' ||
                     w.semester_code
                     || '", tzaj: "' ||
                     w.map_classes_type
                     || '"} not in v2u_ko_matched_zajcykl_j'
                WHEN protokoly.id IS NULL
                THEN '{subject: "'
                     ||
                     w.map_subj_code
                     || '", semester: "' ||
                     w.semester_code
                     || '", tzaj: "' ||
                     w.map_classes_type
                     || '", protocol: "' ||
                     w.coalesced_proto_type
                     || '"} not in v2u_dz_protokoly'
                ELSE 'error (v2u_ko_matched_protos_j out of sync?)'
              END reason
        FROM w w
        LEFT JOIN v2u_dz_protokoly protokoly
            ON  (
                        protokoly.prz_kod = w.map_subj_code
                    AND protokoly.cdyd_kod = w.semester_code
--                    AND protokoly.tpro_kod = w.coalesced_proto_type
                    AND (
                                protokoly.zaj_cyk_id = w.zaj_cyk_id
                            OR  (w.classes_type = '-' AND protokoly.zaj_cyk_id IS NULL)
                        )
                )
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.classes_type = src.classes_type
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , subject_id
        , specialty_id
        , semester_id
        , classes_type
        , subject_map_id
        , map_subj_code
        , classes_map_id
        , map_classes_type
        , coalesced_proto_type
        , zaj_cyk_id
        , prot_id
        , reason
        , istniejace_tpro_kody
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.classes_type
        , src.subject_map_id
        , src.map_subj_code
        , src.classes_map_id
        , src.map_classes_type
        , src.coalesced_proto_type
        , src.zaj_cyk_id
        , src.prot_id
        , src.reason
        , src.istniejace_tpro_kody
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.map_subj_code = src.map_subj_code
        , tgt.classes_map_id = src.classes_map_id
        , tgt.map_classes_type = src.map_classes_type
        , tgt.coalesced_proto_type = src.coalesced_proto_type
        , tgt.zaj_cyk_id = src.zaj_cyk_id
        , tgt.prot_id = src.prot_id
        , tgt.reason = src.reason
        , tgt.istniejace_tpro_kody = src.istniejace_tpro_kody
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
