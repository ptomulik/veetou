CREATE OR REPLACE VIEW v2u_ko_students_dv
AS WITH ungrouped AS
    (
        SELECT
              v.job_uuid
            , V2u_Ko_Student_t(v.preamble) student
        FROM v2u_ko_preambles_dv v
    )
SELECT
      job_uuid
    , student
    , COUNT(*) preambles_count
FROM ungrouped
GROUP BY job_uuid, student
ORDER BY job_uuid, student;

-- vim: set ft=sql ts=4 sw=4 et:
