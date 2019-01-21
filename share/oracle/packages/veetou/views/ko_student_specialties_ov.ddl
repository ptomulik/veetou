CREATE OR REPLACE VIEW v2u_ko_student_specialties_ov
AS WITH ungrouped AS (
    SELECT
          job_uuid
        , V2u_Ko_Student_t(preamble) student
        , V2u_Ko_Specialty_t(header, preamble) specialty
        , V2u_Ko_Semester_Instance_t(preamble, sheet, sheet_id) semester_instance
        FROM v2u_ko_x_sheets_ov
)
SELECT
      job_uuid
    , student
    , specialty
    , COUNT(*) sheets_count
--    , CAST
--        (
--            COLLECT(u.semester_instance.sheet_id ORDER BY u.semester_instance)
--            AS V2u_Ko_Ids_t
--        ) sheet_ids
    , CAST
        (
            COLLECT(semester_instance ORDER BY semester_instance)
            AS V2u_Ko_Semester_Instances_t
        ) semester_instances
FROM ungrouped u
GROUP BY job_uuid, student, specialty
ORDER BY job_uuid, student, specialty;


-- vim: set ft=sql ts=4 sw=4 et:
