MERGE INTO v2u_ko_missing_protos_j tgt
USING
    (
        WITH u AS
        (
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
                    g_j.subj_grade IS NOT NULL
                AND ma_j.job_uuid IS NULL
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
                , ma_zajcykl_j.zaj_cyk_id
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u.subj_grades1k) t
                  ) AS V2u_Subj_Grades_t) subj_grades
            FROM u u
            LEFT JOIN v2u_ko_matched_zajcykl_j ma_zajcykl_j
                ON  (
                            ma_zajcykl_j.subject_id = u.subject_id
                        AND ma_zajcykl_j.specialty_id = u.specialty_id
                        AND ma_zajcykl_j.semester_id = u.semester_id
                        AND ma_zajcykl_j.classes_type = u.classes_type
                        AND ma_zajcykl_j.job_uuid = u.job_uuid
                    )
        ),
        w AS
        ( -- select additional fields
            SELECT
                  v.job_uuid
                , v.semester_id
                , v.specialty_id
                , v.subject_id
                , v.classes_type
                , v.zaj_cyk_id
                , sm_j.map_id subject_map_id
                , subject_map.map_subj_code
                , cm_j.map_id classes_map_id
                , classes_map.map_classes_type
                , subjects.subj_code                -- for diagnostics
                , semesters.semester_code           -- for diagnostics
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
              w.job_uuid
            , w.semester_id
            , w.specialty_id
            , w.subject_id
            , w.classes_type
            , w.zaj_cyk_id
            , w.subj_grades
            , w.subject_map_id
            , w.map_subj_code
            , w.classes_map_id
            , w.map_classes_type
            , w.subj_code                -- for diagnostics
            , w.semester_code           -- for diagnostics
            , CASE
                WHEN w.classes_type = '-' AND w.subject_map_id IS NULL
                THEN 'no subject map for '
                     ||
                     w.subj_code
                     || ':' ||
                     w.semester_code
                WHEN w.map_subj_code IS NULL
                THEN 'map_subj_code IS NULL for '
                     ||
                     w.subj_code
                     || ':' ||
                     w.semester_code
                WHEN w.classes_map_id IS NULL
                THEN 'no classes map for '
                     ||
                     w.subj_code
                     || ':' ||
                     w.semester_code
                     || ':' ||
                     w.classes_type
                WHEN w.map_classes_type IS NULL
                THEN 'map_classes_type IS NULL for '
                     ||
                     w.subj_code
                     || ':' ||
                     w.semester_code
                     || ':' ||
                     w.classes_type
                THEN w.map_subj_code
                     || ':' ||
                     w.semester_code
                     || ':' ||
                     w.map_classes_type
                     ||
                     ' not in dz_zajecia_cykli'
                ELSE 'error (v2u_ko_matched_proto_j out of sync?)'
              END reason
        FROM w w
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
        , reason
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
        , src.reason
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.map_subj_code = src.map_subj_code
        , tgt.classes_map_id = src.classes_map_id
        , tgt.map_classes_type = src.map_classes_type
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
