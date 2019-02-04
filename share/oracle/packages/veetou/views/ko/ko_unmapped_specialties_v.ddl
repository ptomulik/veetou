CREATE OR REPLACE VIEW v2u_ko_unmapped_specialties_v
OF V2u_Ko_Specialty_Map_t
WITH OBJECT IDENTIFIER (job_uuid, specialty_id, semester_id, map_id)
AS WITH u AS
    (
        SELECT
            V2u_Ko_Specialty_Map_t(
                  VALUE(specialties)
                , VALUE(semesters)
                , VALUE(specialty_map)
                , j2.matching_score
            )
        FROM v2u_ko_specialties specialties
        INNER JOIN v2u_ko_specialty_semesters_j j1
            ON (j1.specialty_id = specialties.id AND
                j1.job_uuid = specialties.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j1.semester_id AND
                semesters.job_uuid = specialties.job_uuid)
        LEFT JOIN v2u_ko_specialty_map_j j2
            ON (j2.specialty_id = specialties.id AND
                j2.semester_id = j1.semester_id AND
                j2.job_uuid = specialties.job_uuid)
        LEFT JOIN v2u_specialty_map specialty_map
            ON (j2.map_id = specialty_map.id)
        WHERE specialty_map.id IS NULL OR
              j2.matching_score < 2
    )
SELECT * FROM u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
