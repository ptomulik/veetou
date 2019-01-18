CREATE OR REPLACE VIEW veetou_ko_students_ov
AS WITH ungrouped AS
    (
        SELECT
              v.job_uuid
            , Veetou_Ko_Student_Typ(v.preamble) student
        FROM veetou_ko_preambles_ov v
    )
SELECT
      job_uuid
    , student
    , COUNT(*) preambles_count
FROM ungrouped
GROUP BY job_uuid, student
ORDER BY job_uuid, student;

-- vim: set ft=sql ts=4 sw=4 et:
