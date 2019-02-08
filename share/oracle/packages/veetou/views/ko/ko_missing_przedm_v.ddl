CREATE OR REPLACE VIEW v2u_ko_missing_przedm_v
OF V2u_Ko_Missing_Przedm_t
WITH OBJECT IDENTIFIER (job_uuid, subject_id, specialty_id, semester_id)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Missing_Przedm_t(
                  subject => VALUE(subjects)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
                , subject_map_ids => j.subject_map_ids
            )
        FROM v2u_ko_missing_przedm_j j
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
