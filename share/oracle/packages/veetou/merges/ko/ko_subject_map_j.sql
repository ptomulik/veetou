MERGE INTO v2u_ko_subject_map_j tgt
USING
    (
        WITH t AS
        (
            SELECT
                  j.job_uuid job_uuid
                , j.subject_id subject_id
                , j.specialty_id specialty_id
                , j.semester_id semester_id
                , subject_map.id map_id
                , V2U_Fit.Attributes(
                          subject_map => VALUE(subject_map)
                        , subject => VALUE(subjects)
                        , specialty => VALUE(specialties)
                        , semester => VALUE(semesters)
                  ) matching_score
            FROM v2u_ko_subject_semesters_j j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = j.subject_id
                        AND subjects.job_uuid = j.job_uuid
                    )
            INNER JOIN v2u_ko_specialties specialties
                ON  (
                            specialties.id = j.specialty_id
                        AND specialties.job_uuid = j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = j.semester_id
                        AND semesters.job_uuid = j.job_uuid
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.subj_code = subjects.subj_code
                    )
        ),
        u AS
        (
            SELECT
                  t.*
                , MAX(t.matching_score) OVER (
                    PARTITION BY
                          t.job_uuid
                        , t.subject_id
                        , t.specialty_id
                        , t.semester_id
                  ) highest_score
            FROM t t
            WHERE t.matching_score > 0
        ),
        v AS
        (
            SELECT
                  u.*
                , CASE
                    WHEN u.highest_score = u.matching_score
                    THEN 1
                    ELSE NULL
                    END is_candidate
            FROM u u
        ),
        w AS
        (
            SELECT
                  v.*
                , COUNT(v.is_candidate) OVER (
                    PARTITION BY
                          v.job_uuid
                        , v.subject_id
                        , v.specialty_id
                        , v.semester_id
                  ) candidates_count
            FROM v v
        )
        SELECT
              w.*
            , CASE
                WHEN w.is_candidate IS NOT NULL AND w.candidates_count = 1
                THEN 1
                ELSE 0
                END selected
            , CASE
                WHEN w.is_candidate IS NULL THEN 'score'
                WHEN w.candidates_count <> 1 THEN 'ambiguous'
                ELSE 'unique'
                END reason
        FROM w w
    ) src
ON  (
            tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.map_id = src.map_id
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , subject_id
        , specialty_id
        , semester_id
        , map_id
        , matching_score
        , highest_score
        , selected
        , reason
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.map_id
        , src.matching_score
        , src.highest_score
        , src.selected
        , src.reason
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.matching_score = src.matching_score
        , tgt.highest_score = src.highest_score
        , tgt.selected = src.selected
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
