MERGE INTO v2u_ko_missing_prgos_j tgt
USING
    (
        SELECT
              ss_j.job_uuid
            , ss_j.semester_id
            , ss_j.specialty_id
            , ss_j.student_id
            , ss_j.ects_attained
        FROM v2u_ko_student_semesters_j ss_j
        LEFT JOIN v2u_ko_matched_prgos_j ma_prgos_j
            ON  (
                        ma_prgos_j.student_id = ss_j.student_id
                    AND ma_prgos_j.specialty_id = ss_j.specialty_id
                    AND ma_prgos_j.semester_id = ss_j.semester_id
                    AND ma_prgos_j.job_uuid = ss_j.job_uuid
                )
        WHERE ma_prgos_j.job_uuid IS NULL
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.semester_id = src.semester_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.student_id = src.student_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , student_id
        , ects_attained
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.student_id
        , src.ects_attained
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.ects_attained = src.ects_attained
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
