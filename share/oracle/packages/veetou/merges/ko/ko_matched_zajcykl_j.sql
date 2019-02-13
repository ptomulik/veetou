MERGE INTO v2u_ko_matched_zajcykl_j tgt
USING
    (
        SELECT
              j1.job_uuid job_uuid
            , j1.subject_id subject_id
            , j1.specialty_id specialty_id
            , j1.semester_id semester_id
            , j2.classes_type classes_type
            , j2.classes_hours classes_hours
            , j1.map_id subject_map_id
            , j1.matching_score subject_matching_score
            , j2.map_id classes_map_id
            , j2.matching_score classes_matching_score
            , zajecia_cykli.prz_kod prz_kod
            , zajecia_cykli.cdyd_kod cdyd_kod
            , zajecia_cykli.tzaj_kod tzaj_kod
            , zajecia_cykli.id zajcykl_id
        FROM v2u_ko_subject_map_j j1
        INNER JOIN v2u_ko_classes_map_j j2
            ON (j2.subject_id = j1.subject_id AND
                j2.specialty_id = j1.specialty_id AND
                j2.semester_id = j1.semester_id AND
                j2.job_uuid = j1.job_uuid AND
                j2.selected = 1)
        INNER JOIN v2u_subject_map subject_map
            ON (subject_map.id = j1.map_id AND
                subject_map.map_subj_code IS NOT NULL)
        INNER JOIN v2u_classes_map classes_map
            ON (classes_map.id = j2.map_id AND
                classes_map.map_classes_type IS NOT NULL)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j1.semester_id AND
                semesters.job_uuid = j1.job_uuid)
        INNER JOIN v2u_dz_zajecia_cykli zajecia_cykli
            ON (zajecia_cykli.prz_kod = subject_map.map_subj_code AND
                zajecia_cykli.cdyd_kod = semesters.semester_code AND
                zajecia_cykli.tzaj_kod = classes_map.map_classes_type)
        WHERE j1.selected = 1
    ) src
ON  ( tgt.job_uuid = src.job_uuid AND
      tgt.subject_id = src.subject_id AND
      tgt.specialty_id = src.specialty_id AND
      tgt.semester_id = src.semester_id AND
      tgt.classes_type = src.classes_type )
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
        , classes_map_id
        , classes_matching_score
        , prz_kod
        , cdyd_kod
        , tzaj_kod
        , zajcykl_id
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
        , src.classes_map_id
        , src.classes_matching_score
        , src.prz_kod
        , src.cdyd_kod
        , src.tzaj_kod
        , src.zajcykl_id
        )
WHEN MATCHED THEN UPDATE SET
      tgt.classes_hours = src.classes_hours
    , tgt.subject_map_id = src.subject_map_id
    , tgt.subject_matching_score = src.subject_matching_score
    , tgt.classes_map_id = src.classes_map_id
    , tgt.classes_matching_score = src.classes_matching_score
    , tgt.prz_kod = src.prz_kod
    , tgt.cdyd_kod = src.cdyd_kod
    , tgt.tzaj_kod = src.tzaj_kod
    , tgt.zajcykl_id = src.zajcykl_id
;

COMMIT;
-- vim: set ft=sql ts=4 sw=4 et:
