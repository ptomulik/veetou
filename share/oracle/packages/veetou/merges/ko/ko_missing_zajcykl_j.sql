MERGE INTO v2u_ko_missing_zajcykl_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  j1.job_uuid job_uuid
                , j1.subject_id subject_id
                , j1.specialty_id specialty_id
                , j1.semester_id semester_id
                , j1.classes_type classes_type
                , j1.classes_hours classes_hours
                , COUNT(DISTINCT j3.map_id) subject_maps_count
                , COUNT(DISTINCT subject_map.map_subj_code) map_subj_codes_count
                , COUNT(DISTINCT j4.map_id) classes_maps_count
                , COUNT(DISTINCT classes_map.map_classes_type) map_class_types_count
                , MIN(subjects.subj_code) KEEP (
                        DENSE_RANK FIRST ORDER BY subjects.subj_code
                  ) subj_code
                , MIN(semesters.semester_code) KEEP (
                        DENSE_RANK FIRST ORDER BY semesters.semester_code
                  ) semester_code
                , MIN(subject_map.map_subj_code) KEEP (
                        DENSE_RANK FIRST ORDER BY subject_map.map_subj_code
                  ) tried_map_subj_code
                , MIN(classes_map.map_classes_type) KEEP (
                        DENSE_RANK FIRST ORDER BY classes_map.map_classes_type
                  ) tried_map_classes_type
                , CAST(COLLECT(zajecia_cykli.tzaj_kod) AS V2u_Vchars1024_t) istniejace_tzaj_kody
            FROM v2u_ko_classes_semesters_j j1
            INNER JOIN v2u_ko_subjects subjects
                ON (subjects.id = j1.subject_id AND
                    subjects.job_uuid = j1.job_uuid)
            INNER JOIN v2u_ko_semesters semesters
                ON (semesters.id = j1.subject_id AND
                    semesters.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_ko_matched_zajcykl_j j2
                ON (j2.subject_id = j1.subject_id AND
                    j2.specialty_id = j1.specialty_id AND
                    j2.semester_id = j1.semester_id AND
                    j2.classes_type = j1.classes_type AND
                    j2.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_ko_subject_map_j j3
                ON (j3.subject_id = j1.subject_id AND
                    j3.specialty_id = j1.specialty_id AND
                    j3.semester_id = j1.semester_id AND
                    j3.job_uuid = j1.job_uuid AND
                    j3.selected = 1)
            LEFT JOIN v2u_subject_map subject_map
                ON (subject_map.id = j3.map_id)
            LEFT JOIN v2u_ko_classes_map_j j4
                ON (j4.subject_id = j1.subject_id AND
                    j4.specialty_id = j1.specialty_id AND
                    j4.semester_id = j1.semester_id AND
                    j4.classes_type = j1.classes_type AND
                    j4.job_uuid = j1.job_uuid AND
                    j4.selected = 1)
            LEFT JOIN v2u_classes_map classes_map
                ON (classes_map.id = j4.map_id)
            -- join dz_zajecia_cykli without classes_type to find what other
            -- classes types we have at the destination
            LEFT JOIN v2u_dz_zajecia_cykli zajecia_cykli
                ON (zajecia_cykli.prz_kod = subject_map.map_subj_code AND
                    zajecia_cykli.cdyd_kod = semesters.semester_code)
            WHERE j2.id IS NULL
            GROUP BY
                  j1.job_uuid
                , j1.subject_id
                , j1.specialty_id
                , j1.semester_id
                , j1.classes_type
                , j1.classes_hours
        )
        SELECT
              u.job_uuid job_uuid
            , u.subject_id subject_id
            , u.specialty_id specialty_id
            , u.semester_id semester_id
            , u.classes_type classes_type
            , u.classes_hours classes_hours
            , CASE
                WHEN u.subject_maps_count <> 1
                THEN TO_CHAR(u.subject_maps_count)
                     ||
                     ' suitable subject map(s) for '
                     ||
                     u.subj_code
                     || ':' ||
                     u.semester_code
                WHEN u.map_subj_codes_count <> 1
                THEN TO_CHAR(u.map_subj_codes_count)
                     ||
                     ' non-null map_subj_code(s) for '
                     ||
                     u.subj_code
                     || ':' ||
                     u.semester_code
                WHEN u.classes_maps_count <> 1
                THEN TO_CHAR(u.classes_maps_count)
                     ||
                     ' suitable classes map(s) for '
                     ||
                     u.subj_code
                     || ':' ||
                     u.semester_code
                     || ':' ||
                     u.classes_type
                WHEN u.map_class_types_count <> 1
                THEN TO_CHAR(u.map_class_types_count)
                     ||
                     ' non-null map_classes_type(s) for '
                     ||
                     u.subj_code
                     || ':' ||
                     u.semester_code
                     || ':' ||
                     u.classes_type
                WHEN (SELECT COUNT(*) FROM TABLE(u.istniejace_tzaj_kody)) < 1
                THEN u.tried_map_subj_code
                     || ':' ||
                     u.semester_code
                     || ':*' ||
                    ' not in v2u_dz_zajecia_cykli'
                WHEN (SELECT COUNT(*)
                      FROM TABLE(u.istniejace_tzaj_kody) t
                      WHERE VALUE(t) = u.tried_map_classes_type) < 1
                THEN
                    u.tried_map_subj_code
                     || ':' ||
                     u.semester_code
                     || ':' ||
                     u.tried_map_classes_type
                     ||
                     ' not in v2u_dz_zajecia_cykli'
                ELSE 'error (v2u_ko_matched_zajcykl_j out of sync?)'
              END reason
            , u.tried_map_subj_code tried_map_subj_code
            , u.tried_map_classes_type tried_map_classes_type
            , CAST(MULTISET(
                    SELECT DISTINCT SUBSTR(VALUE(t), 1, 3)
                    FROM TABLE(u.istniejace_tzaj_kody) t
                    WHERE ROWNUM <= 5
              ) AS V2u_5Chars3_t) istniejace_tzaj_kody
        FROM u u
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.subject_id = src.subject_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.semester_id = src.semester_id AND
     tgt.classes_type = src.classes_type)
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , subject_id
        , specialty_id
        , semester_id
        , classes_type
        , classes_hours
        , reason
        , tried_map_subj_code
        , tried_map_classes_type
        , istniejace_tzaj_kody
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.classes_type
        , src.classes_hours
        , src.reason
        , src.tried_map_subj_code
        , src.tried_map_classes_type
        , src.istniejace_tzaj_kody
        )
WHEN MATCHED THEN UPDATE SET
      tgt.classes_hours = src.classes_hours
    , tgt.reason = src.reason
    , tgt.tried_map_subj_code = src.tried_map_subj_code
    , tgt.tried_map_classes_type = src.tried_map_classes_type
    , tgt.istniejace_tzaj_kody = src.istniejace_tzaj_kody
;
-- vim: set ft=sql ts=4 sw=4 et:
