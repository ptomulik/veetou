CREATE OR REPLACE VIEW veetou_ko_student_programs
AS SELECT
      v.job_uuid job_uuid
--    , v.header_id header_id
--    , v.preamble_id preamble_id
--    , v.sheet_id sheet_id
    , v.student_program.student_index student_index
    , v.student_program.first_name first_name
    , v.student_program.last_name last_name
    , v.student_program.student_name student_name
    , v.student_program.university university
    , v.student_program.faculty faculty
    , v.student_program.studies_modetier studies_modetier
    , v.student_program.studies_field studies_field
    , v.student_program.studies_specialty studies_specialty

    , (
        SELECT LISTAGG(semester_code || ':' || semester_number, ',')
        WITHIN GROUP (ORDER BY semester_code)
        FROM TABLE(semester_summaries) GROUP BY 1
      ) semester_log
--    , v.semester_summaries.semester_number semester_number
--    , v.semester_summaries.ects_mandatory ects_mandatory
--    , v.semester_summaries.ects_other ects_other
--    , v.semester_summaries.ects_total ects_total
--    , v.semester_summaries.ects_attained ects_attained
FROM veetou_ko_student_programs_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
