CREATE OR REPLACE VIEW v2u_ko_unmapped_subjects_v
OF V2u_Ko_Subject_Map_t
WITH OBJECT IDENTIFIER (job_uuid, subject_id, semester_id, map_id)
AS WITH u AS
    (
        SELECT
            V2u_Ko_Subject_Map_t(
                  VALUE(subjects)
                , VALUE(specialties)
                , VALUE(semesters)
                , VALUE(subject_map)
                , j2.matching_score
            )
        FROM v2u_ko_subjects subjects
        INNER JOIN v2u_ko_subject_semesters_j j1
            ON (j1.subject_id = subjects.id AND
                j1.job_uuid = subjects.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j1.specialty_id AND
                specialties.job_uuid = subjects.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j1.semester_id AND
                semesters.job_uuid = subjects.job_uuid)
        LEFT JOIN v2u_ko_subject_map_j j2
            ON (j2.subject_id = subjects.id AND
                j2.specialty_id = j1.specialty_id AND
                j2.semester_id = j1.semester_id AND
                j2.job_uuid = subjects.job_uuid)
        LEFT JOIN v2u_subject_map subject_map
            ON (j2.map_id = subject_map.id)
        WHERE subject_map.id IS NULL OR
              j2.matching_score < 2
    )
SELECT * FROM u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:

-- vim: set ft=sql ts=4 sw=4 et:
