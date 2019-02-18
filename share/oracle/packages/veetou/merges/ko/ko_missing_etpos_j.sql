MERGE INTO v2u_ko_missing_etpos_j tgt
USING
    (
        SELECT
              ss_j.job_uuid job_uuid
            , ss_j.student_id student_id
            , ss_j.specialty_id specialty_id
            , ss_j.semester_id semester_id
 --           , ss_j.tried_specialty_map_ids tried_specialty_map_ids
        FROM v2u_ko_student_semesters_j ss_j
        LEFT JOIN v2u_ko_matched_etpos_j ma_etpos_j
            ON  (
                        ma_etpos_j.student_id = ss_j.student_id
                    AND ma_etpos_j.specialty_id = ss_j.specialty_id
                    AND ma_etpos_j.semester_id = ss_j.semester_id
                    AND ma_etpos_j.job_uuid = ss_j.job_uuid
                )
        WHERE ma_etpos_j.job_uuid IS NULL
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
--        , prgos_ids_all_semesters
--        , all_etpos_ids_for_semester
--        , tried_program_codes
--        , all_etpos_progs_for_semester
        )
    VALUES
        ( src.job_uuid
        , src.student_id
        , src.specialty_id
        , src.semester_id
--        , src.tried_specialty_map_ids
--        , src.prgos_ids_all_semesters
--        , src.all_etpos_ids_for_semester
--        , src.tried_program_codes
--        , src.all_etpos_progs_for_semester
        )
--WHEN MATCHED THEN
--    UPDATE SET
--          tgt.tried_specialty_map_ids = src.tried_specialty_map_ids
--        , tgt.prgos_ids_all_semesters = src.prgos_ids_all_semesters
--        , tgt.all_etpos_ids_for_semester = src.all_etpos_ids_for_semester
--        , tgt.tried_program_codes = src.tried_program_codes
--        , tgt.all_etpos_progs_for_semester = src.all_etpos_progs_for_semester
;

COMMIT;
-- vim: set ft=sql ts=4 sw=4 et:
