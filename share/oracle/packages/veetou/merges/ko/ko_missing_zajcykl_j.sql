MERGE INTO v2u_ko_missing_zajcykl_j tgt
USING
    (
        WITH u AS
        ( -- select all missing entries
            SELECT
                  cs_j.job_uuid
                , cs_j.subject_id
                , cs_j.specialty_id
                , cs_j.semester_id
                , cs_j.classes_type
                , cs_j.classes_hours
            FROM v2u_ko_classes_semesters_j cs_j
            WHERE NOT EXISTS -- MINUS would not allow selecting classes_hours
                (
                    SELECT NULL
                    FROM v2u_ko_matched_zajcykl_j ma_j
                    WHERE
                        (
                                ma_j.job_uuid = cs_j.job_uuid
                            AND ma_j.subject_id = cs_j.subject_id
                            AND ma_j.specialty_id = cs_j.specialty_id
                            AND ma_j.semester_id = cs_j.semester_id
                            AND ma_j.classes_type = cs_j.classes_type
                        )
                )
        ),
        v AS
        ( -- select additional fields
            SELECT
                  u.*
                , sm_j.map_id subject_map_id
                , sm_j.matching_score subject_matching_score
                , subject_map.map_subj_code
                , cm_j.map_id classes_map_id
                , cm_j.matching_score classes_matching_score
                , classes_map.map_classes_type
                , CAST(MULTISET(
                        SELECT DISTINCT SUBSTR(t.tzaj_kod, 1, 20)
                        FROM v2u_dz_zajecia_cykli t
                        WHERE       t.prz_kod = subject_map.map_subj_code
                                AND t.cdyd_kod = semesters.semester_code
                                --AND ROWNUM <= 5
                  ) AS V2u_5Chars3_t) istniejace_tzaj_kody
                , subjects.subj_code                -- for diagnostics
                , semesters.semester_code           -- for diagnostics
            FROM u u
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = u.subject_id
                        AND subjects.job_uuid = u.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = u.semester_id
                        AND semesters.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = u.subject_id
                        AND sm_j.specialty_id = u.specialty_id
                        AND sm_j.semester_id = u.semester_id
                        AND sm_j.job_uuid = u.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = sm_j.map_id
                    )
            LEFT JOIN v2u_ko_classes_map_j cm_j
                ON  (
                            cm_j.subject_id = u.subject_id
                        AND cm_j.specialty_id = u.specialty_id
                        AND cm_j.semester_id = u.semester_id
                        AND cm_j.classes_type = u.classes_type
                        AND cm_j.job_uuid = u.job_uuid
                        AND cm_j.selected = 1
                    )
            LEFT JOIN v2u_classes_map classes_map
                ON  (
                            classes_map.id = cm_j.map_id
                    )
        )
        SELECT
              v.*
            , CASE
                WHEN v.subject_map_id IS NULL
                THEN 'no subject map for '
                     ||
                     v.subj_code
                     || ':' ||
                     v.semester_code
                WHEN v.map_subj_code IS NULL
                THEN 'map_subj_code IS NULL for '
                     ||
                     v.subj_code
                     || ':' ||
                     v.semester_code
                WHEN v.classes_map_id IS NULL
                THEN 'no classes map for '
                     ||
                     v.subj_code
                     || ':' ||
                     v.semester_code
                     || ':' ||
                     v.classes_type
                WHEN v.map_classes_type IS NULL
                THEN 'map_classes_type IS NULL for '
                     ||
                     v.subj_code
                     || ':' ||
                     v.semester_code
                     || ':' ||
                     v.classes_type
                WHEN (SELECT COUNT(*) FROM TABLE(v.istniejace_tzaj_kody)) < 1
                THEN v.map_subj_code
                     || ':' ||
                     v.semester_code
                     ||
                    ' not in dz_zajecia_cykli'
                WHEN (SELECT COUNT(*)
                      FROM TABLE(v.istniejace_tzaj_kody) t
                      WHERE VALUE(t) = v.map_classes_type) < 1
                THEN v.map_subj_code
                     || ':' ||
                     v.semester_code
                     || ':' ||
                     v.map_classes_type
                     ||
                     ' not in dz_zajecia_cykli'
                ELSE 'error (v2u_ko_matched_zajcykl_j out of sync?)'
              END reason
        FROM v v
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
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
