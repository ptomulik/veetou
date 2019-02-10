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
                , COUNT(DISTINCT j4.map_id) subject_maps_count
                , COUNT(DISTINCT subject_map.map_subj_code) map_subj_codes_count
                , COUNT(DISTINCT j5.map_id) classes_maps_count
                , COUNT(DISTINCT classes_map.map_classes_type) map_class_types_count
                , MIN(classes_map.map_classes_type) KEEP (
                        DENSE_RANK FIRST ORDER BY classes_map.map_classes_type
                  ) tried_map_classes_type
                , CAST(COLLECT(j6.tzaj_kod) AS V2u_Vchars1024_t) istniejace_tzaj_kody
            FROM v2u_ko_classes_semesters_j j1
            LEFT JOIN v2u_ko_matched_zajcykl_j j2
                ON (j2.subject_id = j1.subject_id AND
                    j2.specialty_id = j1.specialty_id AND
                    j2.semester_id = j1.semester_id AND
                    j2.classes_type = j1.classes_type AND
                    j2.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_ko_subject_map_j j4
                ON (j4.subject_id = j1.subject_id AND
                    j4.specialty_id = j1.specialty_id AND
                    j4.semester_id = j1.semester_id AND
                    j4.job_uuid = j1.job_uuid AND
                    j4.selected = 1)
            LEFT JOIN v2u_subject_map subject_map
                ON (subject_map.id = j4.map_id)
            LEFT JOIN v2u_ko_classes_map_j j5
                ON (j5.subject_id = j1.subject_id AND
                    j5.specialty_id = j1.specialty_id AND
                    j5.semester_id = j1.semester_id AND
                    j5.classes_type = j1.classes_type AND
                    j5.job_uuid = j1.job_uuid AND
                    j5.selected = 1)
            LEFT JOIN v2u_classes_map classes_map
                ON (classes_map.id = j5.map_id)
            -- join matched_zajcykl again, this time without classes_type
            -- to find what other classes types we have in the destination
            LEFT JOIN v2u_ko_matched_zajcykl_j j6
                ON (j6.subject_id = j1.subject_id AND
                    j6.specialty_id = j1.specialty_id AND
                    j6.semester_id = j1.semester_id AND
                    j6.job_uuid = j1.job_uuid)
            WHERE j2.id IS NULL
            GROUP BY
                  j1.job_uuid
                , j1.subject_id
                , j1.specialty_id
                , j1.semester_id
                , j1.classes_type
        )
        SELECT
              u.job_uuid job_uuid
            , u.subject_id subject_id
            , u.specialty_id specialty_id
            , u.semester_id semester_id
            , u.classes_type classes_type
            , u.tried_map_classes_type tried_map_classes_type
            , CASE
                WHEN u.subject_maps_count < 1
                THEN 'no useful subject mappings found'
                WHEN u.map_subj_codes_count < 1
                THEN 'missing map_subj_code'
                WHEN u.classes_maps_count < 1
                THEN 'no useful classes mappings found'
                WHEN u.map_class_types_count < 1
                THEN 'missing map_classes_type'
                WHEN (SELECT COUNT(*) FROM TABLE(u.istniejace_tzaj_kody)) < 1
                THEN 'no subject in dz_zajecia_cykli'
                ELSE 'no classes in dz_zajecia_cykli'
              END reason
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
        , tried_map_classes_type
        , reason
        , istniejace_tzaj_kody
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.classes_type
        , src.tried_map_classes_type
        , src.reason
        , src.istniejace_tzaj_kody
        )
WHEN MATCHED THEN UPDATE SET
      tgt.tried_map_classes_type = src.tried_map_classes_type
    , tgt.reason = src.reason
    , tgt.istniejace_tzaj_kody = src.istniejace_tzaj_kody
;
-- vim: set ft=sql ts=4 sw=4 et:
