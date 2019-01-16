CREATE OR REPLACE VIEW veetou_ko_students AS
SELECT
      job_uuid
    , student_index
    , student_name
    , first_name
    , last_name
    , COUNT(*) AS trs_count
FROM veetou_ko_refined v
GROUP BY job_uuid, student_index, student_name, first_name, last_name
ORDER BY job_uuid, student_index;

-- vim: set ft=sql ts=4 sw=4 et:
