CREATE OR REPLACE VIEW veetou_ko_student_programs_ov
AS WITH ungrouped AS (
    SELECT
          job_uuid
        , header_id
        , preamble_id
        , sheet_id
        , Veetou_Ko_Student_Program_Typ(sheet_info) student_program
        , Veetou_Ko_Semester_Summary_Typ(sheet_info) semester_summary
        FROM veetou_ko_sheet_infos_ov v
)
SELECT
      u.job_uuid job_uuid
    , u.student_program student_program
    , CAST
        (
            COLLECT(u.semester_summary ORDER BY u.semester_summary)
            AS Veetou_Ko_Semester_Summaries_Typ
        ) semester_summaries
FROM ungrouped u
GROUP BY job_uuid, student_program
ORDER BY job_uuid, student_program;


-- vim: set ft=sql ts=4 sw=4 et:
