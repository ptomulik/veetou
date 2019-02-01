CREATE OR REPLACE VIEW v2u_ko_subject_semesters_v
OF V2u_Ko_Subject_Semester_t
WITH OBJECT IDENTIFIER (job_uuid, subject_id, specialty_id, semester_id)
AS WITH u AS (
    SELECT
        V2u_Ko_Subject_Semester_t(
              VALUE(subjects)
            , VALUE(specialties)
            , VALUE(semesters)
        ) spec_sem
    FROM v2u_ko_subjects subjects
    INNER JOIN v2u_ko_subject_semesters_j j
        ON (j.subject_id = subjects.id AND
            j.job_uuid = subjects.job_uuid)
    INNER JOIN v2u_ko_specialties specialties
        ON (specialties.id = j.specialty_id AND
            specialties.job_uuid = subjects.job_uuid)
    INNER JOIN v2u_ko_semesters semesters
        ON (semesters.id = j.semester_id AND
            semesters.job_uuid = specialties.job_uuid)
)
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
