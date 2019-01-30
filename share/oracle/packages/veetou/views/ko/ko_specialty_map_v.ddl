CREATE OR REPLACE VIEW v2u_ko_specialty_map_v
OF V2u_Ko_Specialty_Map_t
WITH OBJECT IDENTIFIER (job_uuid, specialty_id, semester_id, map_id)
AS WITH u AS
    (
        SELECT
            V2u_Ko_Specialty_Map_t(
                  VALUE(specialties)
                , VALUE(semesters)
                , VALUE(specialty_map)
                , j.matching_score
            )
        FROM v2u_ko_specialty_map_j j
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j.specialty_id AND
                specialties.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j.semester_id AND
                semesters.job_uuid = j.job_uuid)
        INNER JOIN v2u_specialty_map specialty_map
            ON (specialty_map.id = j.map_id)
    )
SELECT * FROM u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
