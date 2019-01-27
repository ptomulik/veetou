CREATE OR REPLACE VIEW v2u_ko_student_specialties_dv
AS WITH ungrouped AS (
    SELECT
          job_uuid
        , V2u_To.Ko_Student(preamble) student
        , V2u_To.Ko_Specialty(header, preamble) specialty
        , V2u_To.Ko_Semester_Instance(preamble, sheet, sheet_id) semester_issue
        FROM v2u_ko_x_sheets
)
SELECT
      job_uuid
    , student
    , specialty
    , COUNT(*) sheets_count
--    , CAST
--        (
--            COLLECT(u.semester_issue.sheet_id ORDER BY u.semester_issue)
--            AS V2u_Ko_Ids_t
--        ) sheet_ids
    , CAST
        (
            COLLECT(semester_issue ORDER BY semester_issue)
            AS V2u_Ko_Semester_Instances_t
        ) semester_issues
FROM ungrouped u
GROUP BY job_uuid, student, specialty
ORDER BY job_uuid, student, specialty;


-- vim: set ft=sql ts=4 sw=4 et:
