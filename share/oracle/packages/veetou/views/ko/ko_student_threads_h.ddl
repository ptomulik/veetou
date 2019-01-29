CREATE OR REPLACE VIEW v2u_ko_student_threads_h
AS WITH u AS (
    SELECT
          student
        , specialty_map
        , V2U_To.Threads(
            CAST(COLLECT(h.specialty_entity) AS V2u_Ko_Specialty_Entities_t)
          ) threads
    FROM v2u_ko_student_specialties_h h
    GROUP BY student, specialty_map
)
SELECT
      u.student student
    , u.specialty_map specialty_map
    , ROW_NUMBER() OVER (PARTITION BY u.student, u.specialty_map ORDER BY 1) thread_index
    , (SELECT MAX(ROWNUM) FROM TABLE(u.threads)) threads_count
    , V2U_Util.Max_Admission_Semester(VALUE(t)) max_admission_semester
    , CAST(MULTISET(SELECT sheet_id FROM TABLE(VALUE(t)) s ORDER BY VALUE(s))
           AS V2u_Ids_t) sheet_ids
    , VALUE(t) thread_semesters
FROM u u
CROSS JOIN TABLE(threads) t;


-- vim: set ft=sql ts=4 sw=4 et:
