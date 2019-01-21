CREATE OR REPLACE VIEW v2u_ko_threads
AS SELECT
      v.job_uuid job_uuid
    , v.sheet_id
    , v.student.student_index student_index
    , v.student.first_name first_name
    , v.student.last_name last_name
    , v.student.student_name student_name
    , v.specialty.university university
    , v.specialty.faculty faculty
    , v.specialty.studies_modetier studies_modetier
    , v.specialty.studies_field studies_field
    , v.specialty.studies_specialty studies_specialty
    , v.thread_index thread_index
    , v.threads_count threads_count
    , v.max_admission_semester max_admission_semester
    , (
        SELECT LISTAGG(sheet_id, ',')
        WITHIN GROUP (ORDER BY VALUE(t))
        FROM TABLE(v.thread_semesters) t GROUP BY 1
      ) sheet_ids
    , (
        SELECT LISTAGG(semester_code || ':' || semester_number, ',')
        WITHIN GROUP (ORDER BY VALUE(t))
        FROM TABLE(v.thread_semesters) t GROUP BY 1
      ) thread_semesters
FROM v2u_ko_threads_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
