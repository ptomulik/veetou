CREATE OR REPLACE VIEW veetou_ko_students_ov
AS SELECT
      v.job_uuid job_uuid
    , Veetou_Ko_Student_Typ
        ( student_index => v.student_index
        , student_name => v.student_name
        , first_name => v.first_name
        , last_name => v.last_name
        ) student
FROM veetou_ko_students v;

-- vim: set ft=sql ts=4 sw=4 et:
