CREATE OR REPLACE VIEW v2u_uu_subject_grades_v
OF V2u_Uu_Subject_Grade_V_t
WITH OBJECT IDENTIFIER (v2u_job_uuid , v2u_subject_id, v2u_student_id, v2u_specialty_id, v2u_semester_id)
AS
WITH u AS
  (
    SELECT    v2u_job_uuid
            , v2u_student_id
            , v2u_subject_id
            , v2u_specialty_id
            , v2u_semester_id
            , MIN(g.v2u_classes_type) KEEP (
                DENSE_RANK FIRST ORDER BY g.v2u_classes_type
              ) v2u_classes_type
    FROM v2u_uu_classes_grades g
    GROUP BY v2u_job_uuid
            , v2u_student_id
            , v2u_subject_id
            , v2u_specialty_id
            , v2u_semester_id
  )
SELECT
    V2u_Uu_Subject_Grade_V_t(classes_grade => VALUE(classes_grades))
FROM v2u_uu_classes_grades classes_grades
INNER JOIN u
ON (   classes_grades.v2u_job_uuid = u.v2u_job_uuid
   AND classes_grades.v2u_student_id = u.v2u_student_id
   AND classes_grades.v2u_subject_id = u.v2u_subject_id
   AND classes_grades.v2u_specialty_id = u.v2u_specialty_id
   AND classes_grades.v2u_semester_id = u.v2u_semester_id
   AND classes_grades.v2u_classes_type = u.v2u_classes_type
   );
