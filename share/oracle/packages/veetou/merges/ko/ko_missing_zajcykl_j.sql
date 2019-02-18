MERGE INTO v2u_ko_missing_zajcykl_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  cs_j.job_uuid job_uuid
                , cs_j.subject_id subject_id
                , cs_j.specialty_id specialty_id
                , cs_j.semester_id semester_id
                , cs_j.classes_type classes_type

                , MIN(cs_j.classes_hours) KEEP (
                        DENSE_RANK FIRST ORDER BY cs_j.classes_hours
                  ) classes_hours
                , MIN(subjects.subj_code) KEEP (
                        DENSE_RANK FIRST ORDER BY subjects.subj_code
                  ) subj_code
                , MIN(sm_j.map_id) KEEP (
                        DENSE_RANK FIRST ORDER BY sm_j.map_id
                  ) subject_map_id
                , MIN(sm_j.matching_score) KEEP (
                        DENSE_RANK FIRST ORDER BY sm_j.matching_score
                  ) subject_matching_score
                , MIN(subject_map.map_subj_code) KEEP (
                        DENSE_RANK FIRST ORDER BY subject_map.map_subj_code
                  ) map_subj_code
                , MIN(cm_j.map_id) KEEP (
                        DENSE_RANK FIRST ORDER BY cm_j.map_id
                  ) classes_map_id
                , MIN(cm_j.matching_score) KEEP (
                        DENSE_RANK FIRST ORDER BY cm_j.matching_score
                  ) classes_matching_score
                , MIN(classes_map.map_classes_type) KEEP (
                        DENSE_RANK FIRST ORDER BY classes_map.map_classes_type
                  ) map_classes_type
                , MIN(semesters.semester_code) KEEP (
                        DENSE_RANK FIRST ORDER BY semesters.semester_code
                  ) semester_code
                , CAST(
                    COLLECT(zajecia_cykli.tzaj_kod)
                    AS V2u_Vchars1024_t
                  ) istniejace_tzaj_kody

                -- debugging info

                , COUNT(DISTINCT cs_j.classes_hours) dbg_classes_hours
                , COUNT(DISTINCT sm_j.map_id) dbg_subject_maps
                , COUNT(DISTINCT subject_map.map_subj_code) dbg_map_subj_codes
                , COUNT(DISTINCT cm_j.map_id) dbg_classes_maps
                , COUNT(DISTINCT classes_map.map_classes_type) dbg_map_class_types
                , COUNT(DISTINCT semesters.semester_code) dbg_semester_codes

            FROM v2u_ko_classes_semesters_j cs_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = cs_j.subject_id
                        AND subjects.job_uuid = cs_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = cs_j.subject_id
                        AND semesters.job_uuid = cs_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_zajcykl_j ma_j
                ON  (
                            ma_j.subject_id = cs_j.subject_id
                        AND ma_j.specialty_id = cs_j.specialty_id
                        AND ma_j.semester_id = cs_j.semester_id
                        AND ma_j.classes_type = cs_j.classes_type
                        AND ma_j.job_uuid = cs_j.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                                sm_j.subject_id = cs_j.subject_id
                        AND sm_j.specialty_id = cs_j.specialty_id
                        AND sm_j.semester_id = cs_j.semester_id
                        AND sm_j.job_uuid = cs_j.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON (subject_map.id = sm_j.map_id)
            LEFT JOIN v2u_ko_classes_map_j cm_j
                ON  (
                            cm_j.subject_id = cs_j.subject_id
                        AND cm_j.specialty_id = cs_j.specialty_id
                        AND cm_j.semester_id = cs_j.semester_id
                        AND cm_j.classes_type = cs_j.classes_type
                        AND cm_j.job_uuid = cs_j.job_uuid
                        AND cm_j.selected = 1
                    )
            LEFT JOIN v2u_classes_map classes_map
                ON  (classes_map.id = cm_j.map_id)
            -- join dz_zajecia_cykli without classes_type to find what other
            -- classes types we have at the destination
            LEFT JOIN dz_zajecia_cykli zajecia_cykli
                ON  (
                            zajecia_cykli.prz_kod = subject_map.map_subj_code
                        AND zajecia_cykli.cdyd_kod = semesters.semester_code
                    )
            WHERE ma_j.id IS NULL
            GROUP BY
                  cs_j.job_uuid
                , cs_j.subject_id
                , cs_j.specialty_id
                , cs_j.semester_id
                , cs_j.classes_type
        )
        SELECT
              u.job_uuid job_uuid
            , u.subject_id subject_id
            , u.specialty_id specialty_id
            , u.semester_id semester_id
            , u.classes_type classes_type
            , u.classes_hours classes_hours
            , u.subject_map_id
            , u.subject_matching_score
            , u.classes_map_id
            , u.classes_matching_score
            , CASE
                WHEN u.dbg_subject_maps <> 1
                THEN TO_CHAR(u.dbg_subject_maps)
                     ||
                     ' suitable subject map(s) for '
                     ||
                     u.subj_code
                     || ':' ||
                     u.semester_code
                WHEN u.dbg_map_subj_codes <> 1
                THEN TO_CHAR(u.dbg_map_subj_codes)
                     ||
                     ' non-null map_subj_code(s) for '
                     ||
                     u.subj_code
                     || ':' ||
                     u.semester_code
                WHEN u.dbg_classes_maps <> 1
                THEN TO_CHAR(u.dbg_classes_maps)
                     ||
                     ' suitable classes map(s) for '
                     ||
                     u.subj_code
                     || ':' ||
                     u.semester_code
                     || ':' ||
                     u.classes_type
                WHEN u.dbg_map_class_types <> 1
                THEN TO_CHAR(u.dbg_map_class_types)
                     ||
                     ' non-null map_classes_type(s) for '
                     ||
                     u.subj_code
                     || ':' ||
                     u.semester_code
                     || ':' ||
                     u.classes_type
                WHEN (SELECT COUNT(*) FROM TABLE(u.istniejace_tzaj_kody)) < 1
                THEN u.map_subj_code
                     || ':' ||
                     u.semester_code
                     || ':*' ||
                    ' not in dz_zajecia_cykli'
                WHEN (SELECT COUNT(*)
                      FROM TABLE(u.istniejace_tzaj_kody) t
                      WHERE VALUE(t) = u.map_classes_type) < 1
                THEN
                    u.map_subj_code
                     || ':' ||
                     u.semester_code
                     || ':' ||
                     u.map_classes_type
                     ||
                     ' not in dz_zajecia_cykli'
                ELSE 'error (v2u_ko_matched_zajcykl_j out of sync?)'
              END reason
            , u.dbg_classes_hours
            , u.dbg_subject_maps
            , u.dbg_map_subj_codes
            , u.dbg_classes_maps
            , u.dbg_map_class_types
            , u.dbg_semester_codes
            , u.map_subj_code map_subj_code
            , u.map_classes_type map_classes_type
            , CAST(MULTISET(
                    SELECT DISTINCT SUBSTR(VALUE(t), 1, 3)
                    FROM TABLE(u.istniejace_tzaj_kody) t
                    WHERE ROWNUM <= 5
              ) AS V2u_5Chars3_t) istniejace_tzaj_kody
        FROM u u
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
        , classes_hours
        , subject_map_id
        , subject_matching_score
        , map_subj_code
        , classes_map_id
        , classes_matching_score
        , map_classes_type
        , istniejace_tzaj_kody
        , reason
        , dbg_classes_hours
        , dbg_subject_maps
        , dbg_map_subj_codes
        , dbg_classes_maps
        , dbg_map_class_types
        , dbg_semester_codes
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.classes_type
        , src.classes_hours
        , src.subject_map_id
        , src.subject_matching_score
        , src.map_subj_code
        , src.classes_map_id
        , src.classes_matching_score
        , src.map_classes_type
        , src.istniejace_tzaj_kody
        , src.reason
        , src.dbg_classes_hours
        , src.dbg_subject_maps
        , src.dbg_map_subj_codes
        , src.dbg_classes_maps
        , src.dbg_map_class_types
        , src.dbg_semester_codes
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.classes_hours = src.classes_hours
        , tgt.subject_map_id = src.subject_map_id
        , tgt.subject_matching_score = src.subject_matching_score
        , tgt.map_subj_code = src.map_subj_code
        , tgt.classes_map_id = src.classes_map_id
        , tgt.classes_matching_score = src.classes_matching_score
        , tgt.map_classes_type = src.map_classes_type
        , tgt.istniejace_tzaj_kody = src.istniejace_tzaj_kody
        , tgt.reason = src.reason
        , tgt.dbg_classes_hours = src.dbg_classes_hours
        , tgt.dbg_subject_maps = src.dbg_subject_maps
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_classes_maps = src.dbg_classes_maps
        , tgt.dbg_map_class_types = src.dbg_map_class_types
        , tgt.dbg_semester_codes = src.dbg_semester_codes
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
