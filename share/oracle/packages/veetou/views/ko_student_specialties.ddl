CREATE OR REPLACE VIEW veetou_ko_student_specialties
AS SELECT
      v.job_uuid job_uuid
    , v.student.student_index student_index
    , v.student.first_name first_name
    , v.student.last_name last_name
    , v.student.student_name student_name
    , v.specialty.university university
    , v.specialty.faculty faculty
    , v.specialty.studies_modetier studies_modetier
    , v.specialty.studies_field studies_field
    , v.specialty.studies_specialty studies_specialty
    , v.sheets_count sheets_count
    , (
        SELECT LISTAGG(VALUE(t), ',')
        WITHIN GROUP (ORDER BY 1)
        FROM TABLE(sheet_ids) t GROUP BY 1
      ) sheet_ids
    , (
        SELECT LISTAGG(semester_code || ':' || semester_number, ',')
        WITHIN GROUP (ORDER BY 1)
        FROM TABLE(semester_summaries) GROUP BY 1
      ) semesters
FROM veetou_ko_student_specialties_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
