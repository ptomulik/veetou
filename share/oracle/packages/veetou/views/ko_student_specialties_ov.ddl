CREATE OR REPLACE VIEW veetou_ko_student_specialties_ov
AS WITH ungrouped AS (
    SELECT
          job_uuid
        , Veetou_Ko_Student_Typ(preamble) student
        , Veetou_Ko_Specialty_Typ(header, preamble) specialty
        , Veetou_Ko_Semester_Summary_Typ(preamble, sheet) semester_summary
        FROM veetou_ko_xsheets_ov
)
SELECT
      job_uuid
    , student
    , specialty
    , CAST
        (
            COLLECT(semester_summary ORDER BY semester_summary)
            AS Veetou_Ko_Semester_Summaries_Typ
        ) semester_summaries
FROM ungrouped
GROUP BY job_uuid, student, specialty
ORDER BY job_uuid, student, specialty;


-- vim: set ft=sql ts=4 sw=4 et:
