MERGE INTO v2u_ko_classes_semesters_j tgt
USING
    (
        WITH classes_types AS
        (
            SELECT VALUE(t) classes_type
            FROM TABLE(V2u_5Chars1_t('W', 'C', 'L', 'P', 'S')) t
        ),
        u AS
        (
            SELECT
                  j.*
                , c.*
                , CASE c.classes_type
                    WHEN 'W' THEN subjects.subj_hours_w
                    WHEN 'C' THEN subjects.subj_hours_c
                    WHEN 'L' THEN subjects.subj_hours_l
                    WHEN 'P' THEN subjects.subj_hours_p
                    WHEN 'S' THEN subjects.subj_hours_s
                  END classes_hours
            FROM v2u_ko_subject_semesters_j j
            CROSS JOIN classes_types c
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = j.subject_id
                        AND subjects.job_uuid = j.job_uuid
                    )
        )
        SELECT u.*
        FROM u u
        WHERE u.classes_hours > 0
    ) src
ON  (
            tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.classes_type = src.classes_type
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , subject_id
        , specialty_id
        , semester_id
        , classes_type
        , classes_hours
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.classes_type
        , src.classes_hours
        )
WHEN MATCHED THEN
    UPDATE SET
      tgt.classes_hours = src.classes_hours
;

COMMIT;
-- vim: set ft=sql ts=4 sw=4 et:
