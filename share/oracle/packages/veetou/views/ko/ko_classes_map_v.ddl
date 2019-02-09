CREATE OR REPLACE VIEW v2u_ko_classes_map_v
OF V2u_Ko_Classes_Map_V_t
WITH OBJECT IDENTIFIER (job_uuid, semester_id, specialty_id, subject_id, classes_type, map_id)
AS WITH u AS
    (
        SELECT
            V2u_Ko_Classes_Map_V_t(
                  subject => VALUE(subjects)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
                , map => VALUE(classes_map)
                , matching_score => j.matching_score
                , highest_score => j.highest_score
                , selected => j.selected
                , reason => j.reason
                , classes_type => j.classes_type
                , classes_hours => j.classes_hours
            )
        FROM v2u_ko_classes_map_j j
        INNER JOIN v2u_ko_subjects subjects
            ON (subjects.id = j.subject_id AND
                subjects.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j.specialty_id AND
                specialties.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j.semester_id AND
                semesters.job_uuid = j.job_uuid)
        INNER JOIN v2u_classes_map classes_map
            ON (classes_map.id = j.map_id)
    )
SELECT * FROM u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
