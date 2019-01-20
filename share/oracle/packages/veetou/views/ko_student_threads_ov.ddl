CREATE OR REPLACE VIEW veetou_ko_student_threads_ov
AS WITH specialties AS (
    SELECT
          job_uuid
        , student
        , specialty
        , VEETOU_Util.To_Threads(semester_summaries) threads
    FROM veetou_ko_student_specialties_ov
)
SELECT
      job_uuid
    , student
    , specialty
    , ROW_NUMBER() OVER (PARTITION BY job_uuid, student, specialty ORDER BY 1) thread_index
    , (SELECT MAX(ROWNUM) FROM TABLE(threads)) threads_count
    , VEETOU_Util.Max_Admission_Semester(VALUE(t)) max_admission_semester
    , VALUE(t) thread_semesters
FROM specialties
CROSS JOIN TABLE(threads) t;


-- vim: set ft=sql ts=4 sw=4 et:
