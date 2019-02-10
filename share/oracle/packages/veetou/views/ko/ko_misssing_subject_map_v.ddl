CREATE OR REPLACE VIEW v2u_ko_missing_subject_map_v
OF V2u_Ko_Missing_Subject_Map_V_t
WITH OBJECT IDENTIFIER (job_uuid, )
AS WITH u AS
    (
        SELECT
            V2u_Ko_Missing_Subject_Map_V_t(
                  subject => VALUE(subjects)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
                , map => VALUE(subject_map)
                , matching_score => j2.matching_score
                , highest_score => j2.highest_score
                , selected => j2.selected
                , reason => j2.reason
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
