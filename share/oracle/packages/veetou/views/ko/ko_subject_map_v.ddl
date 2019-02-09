CREATE OR REPLACE VIEW v2u_ko_subject_map_v
OF V2u_Ko_Subject_Map_V_t
WITH OBJECT IDENTIFIER (job_uuid, subject_id, specialty_id, semester_id, map_id)
AS WITH u AS
    (
        SELECT
            V2u_Ko_Subject_Map_V_t(
                  VALUE(subjects)
                , VALUE(specialties)
                , VALUE(semesters)
                , VALUE(subject_map)
                , j.matching_score
            )
        FROM v2u_ko_subject_map_j j
        INNER JOIN v2u_ko_subjects subjects
            ON (subjects.id = j.subject_id AND
                subjects.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j.specialty_id AND
                specialties.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j.semester_id AND
                semesters.job_uuid = j.job_uuid)
        INNER JOIN v2u_subject_map subject_map
            ON (subject_map.id = j.map_id)
    )
SELECT * FROM u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
