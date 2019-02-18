MERGE INTO v2u_ko_missing_prgos_j tgt
USING
    (
        SELECT
              ss_j.job_uuid job_uuid
            , ss_j.student_id student_id
            , ss_j.specialty_id specialty_id
            , ss_j.semester_id semester_id
 --           , ss_j.tried_specialty_map_ids tried_specialty_map_ids
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
        AND tgt.student_id = src.student_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , student_id
        , specialty_id
        , semester_id
--        , tried_specialty_map_ids
        )
    VALUES
        ( src.job_uuid
        , src.student_id
        , src.specialty_id
        , src.semester_id
--        , src.tried_specialty_map_ids
        )
--WHEN MATCHED THEN
--    UPDATE SET
--          tgt.tried_specialty_map_ids = src.tried_specialty_map_ids
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
