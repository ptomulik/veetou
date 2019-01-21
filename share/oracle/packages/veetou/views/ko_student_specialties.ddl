CREATE OR REPLACE VIEW v2u_ko_student_specialties
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
--    , (
--        SELECT LISTAGG(sheet_id, ',')
--        WITHIN GROUP (ORDER BY VALUE(t))
--        FROM TABLE(semester_instances) t GROUP BY 1
--      ) sheet_ids
    , (
        SELECT LISTAGG(semester_code || ':' || semester_number, ',')
        WITHIN GROUP (ORDER BY VALUE(t))
        FROM TABLE(semester_instances) t GROUP BY 1
      ) semesters
FROM v2u_ko_student_specialties_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
