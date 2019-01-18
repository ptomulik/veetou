CREATE OR REPLACE VIEW veetou_ko_students
AS SELECT
      v.job_uuid job_uuid
    , v.student.student_index student_index
    , v.student.student_name student_name
    , v.student.first_name first_name
    , v.student.last_name last_name
    , v.preambles_count preambles_count
FROM veetou_ko_students_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
