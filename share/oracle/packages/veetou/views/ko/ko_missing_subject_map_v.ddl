CREATE OR REPLACE VIEW v2u_ko_missing_subject_map_v
OF V2u_Ko_Missing_Subject_Map_V_t
WITH OBJECT IDENTIFIER (job_uuid, subject_id, specialty_id, semester_id)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Missing_Subject_Map_V_t(
                  subject => VALUE(subjects)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
            )
        FROM v2u_ko_subject_semesters_j j1
        INNER JOIN v2u_ko_subjects subjects
            ON (subjects.id = j1.subject_id AND
                subjects.job_uuid = j1.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j1.specialty_id AND
                specialties.job_uuid = j1.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j1.semester_id AND
                semesters.job_uuid = j1.job_uuid)
        LEFT JOIN v2u_ko_subject_map_j j2
            ON (j2.subject_id = j1.subject_id AND
                j2.specialty_id = j1.specialty_id AND
                j2.semester_id = j1.semester_id AND
                j2.selected = 1)
        WHERE j2.id IS NULL;
    )
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
