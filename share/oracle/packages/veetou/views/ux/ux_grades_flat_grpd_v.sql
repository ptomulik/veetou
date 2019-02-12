CREATE OR REPLACE VIEW v2u_ux_grades_flat_grpd_v
OF V2u_Ux_Grade_Flat_Grpd_V_t
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
    FROM v2u_ux_grades_flat g
    GROUP BY v2u_job_uuid
            , v2u_student_id
            , v2u_subject_id
            , v2u_specialty_id
            , v2u_semester_id
  )
SELECT
    V2u_Ux_Grade_Flat_Grpd_V_t(grade_flat => VALUE(grades_flat))
FROM v2u_ux_grades_flat grades_flat
INNER JOIN u
ON (   grades_flat.v2u_job_uuid = u.v2u_job_uuid
   AND grades_flat.v2u_student_id = u.v2u_student_id
   AND grades_flat.v2u_subject_id = u.v2u_subject_id
   AND grades_flat.v2u_specialty_id = u.v2u_specialty_id
   AND grades_flat.v2u_semester_id = u.v2u_semester_id
   AND grades_flat.v2u_classes_type = u.v2u_classes_type
   );
