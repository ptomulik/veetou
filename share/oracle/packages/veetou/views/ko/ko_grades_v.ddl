CREATE OR REPLACE VIEW v2u_ko_grades_v
OF V2u_Ko_Grade_V_t
WITH OBJECT IDENTIFIER (job_uuid, student_id, subject_id, specialty_id, semester_id)
AS WITH u AS (
    SELECT
        V2u_Ko_Grade_V_t(
              student => VALUE(students)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , subj_grade => j.subj_grade
            , subj_grade_date => j.subj_grade_date
            , tr_id => j.tr_id
        )
    FROM v2u_ko_grades_j j
    INNER JOIN v2u_ko_students students
        ON (students.id = j.student_id AND
            students.job_uuid = j.job_uuid)
    INNER JOIN v2u_ko_subjects subjects
        ON (subjects.id = j.subject_id AND
            subjects.job_uuid = j.job_uuid)
    INNER JOIN v2u_ko_specialties specialties
        ON (specialties.id = j.specialty_id AND
            specialties.job_uuid = j.job_uuid)
    INNER JOIN v2u_ko_semesters semesters
        ON (semesters.id = j.semester_id AND
            semesters.job_uuid = j.job_uuid)
)
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
