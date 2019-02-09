CREATE OR REPLACE VIEW v2u_ko_specialty_semesters_v
OF V2u_Ko_Specialty_Semester_V_t
WITH OBJECT IDENTIFIER (job_uuid, specialty_id, semester_id)
AS WITH u AS (
    SELECT
        V2u_Ko_Specialty_Semester_V_t(
              VALUE(specialties)
            , VALUE(semesters)
        ) spec_sem
    FROM v2u_ko_specialties specialties
    INNER JOIN v2u_ko_specialty_semesters_j j1
        ON (j1.specialty_id = specialties.id AND
            j1.job_uuid = specialties.job_uuid)
    INNER JOIN v2u_ko_semesters semesters
        ON (semesters.id = j1.semester_id AND
            semesters.job_uuid = specialties.job_uuid)
)
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
