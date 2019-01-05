MERGE INTO v2u_ko_protocol_map_j tgt
USING
    (
        WITH t AS
        (
            SELECT
                  g_j.job_uuid
                , g_j.specialty_id
                , g_j.semester_id
                , g_j.subject_id
                , g_j.classes_type
                , g_j.student_id
                , protocol_map.id map_id
                , V2U_Fit.Attributes(
                          protocol_map => VALUE(protocol_map)
                        , subject => VALUE(subjects)
                        , specialty => VALUE(specialties)
                        , semester => VALUE(semesters)
                        , student => VALUE(students)
                        , grade_i => VALUE(g_j)
                  ) matching_score
            FROM v2u_ko_grades_j g_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = g_j.subject_id
                        AND subjects.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_specialties specialties
                ON  (
                            specialties.id = g_j.specialty_id
                        AND specialties.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = g_j.semester_id
                        AND semesters.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_students students
                ON  (
                            students.id = g_j.student_id
                        AND students.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_protocol_map protocol_map
                ON  (
                            protocol_map.semester_code = semesters.semester_code
                    )
        ),
        u AS
        (
            SELECT
                  t.*
                , MAX(t.matching_score) OVER (
                    PARTITION BY
                          t.job_uuid
                        , t.classes_type
                        , t.subject_id
                        , t.specialty_id
                        , t.semester_id
                        , t.student_id
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
                        , v.classes_type
                        , v.subject_id
                        , v.specialty_id
                        , v.semester_id
                        , v.student_id
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
            tgt.student_id = src.student_id
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.map_id = src.map_id
        AND tgt.classes_type = src.classes_type
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , subject_id
        , classes_type
        , student_id
        , map_id
        , matching_score
        , highest_score
        , selected
        , reason
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.classes_type
        , src.student_id
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
