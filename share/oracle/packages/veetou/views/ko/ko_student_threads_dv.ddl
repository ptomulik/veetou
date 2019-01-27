CREATE OR REPLACE VIEW v2u_ko_student_threads_dv
AS WITH specialties AS (
    SELECT
          job_uuid
        , student
        , specialty
        , V2U_To.Threads(semester_issues) threads
    FROM v2u_ko_student_specialties_dv
)
SELECT
      job_uuid
    , student
    , specialty
    , ROW_NUMBER() OVER (PARTITION BY job_uuid, student, specialty ORDER BY 1) thread_index
    , (SELECT MAX(ROWNUM) FROM TABLE(threads)) threads_count
    , V2U_Util.Max_Admission_Semester(VALUE(t)) max_admission_semester
    , CAST(MULTISET(SELECT sheet_id FROM TABLE(VALUE(t)) s ORDER BY VALUE(s))
           AS V2u_Ko_Ids_t) sheet_ids
    , VALUE(t) thread_semesters
FROM specialties
CROSS JOIN TABLE(threads) t;


-- vim: set ft=sql ts=4 sw=4 et:
