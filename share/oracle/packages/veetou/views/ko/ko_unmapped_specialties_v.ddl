CREATE OR REPLACE VIEW v2u_ko_unmapped_specialties_v
OF V2u_Ko_Specialty_Map_V_t
WITH OBJECT IDENTIFIER (job_uuid, specialty_id, semester_id, map_id)
AS
    SELECT
        V2u_Ko_Specialty_Map_V_t(
              specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , map => VALUE(specialty_map)
            , matching_score => sm_j.matching_score
            , highest_score => sm_j.highest_score
            , selected => sm_j.selected
            , reason => sm_j.reason
        )
    FROM v2u_ko_specialties specialties
    INNER JOIN v2u_ko_specialty_semesters_j ss_j
        ON  (
                    ss_j.specialty_id = specialties.id
                AND ss_j.job_uuid = specialties.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ss_j.semester_id
                AND semesters.job_uuid = specialties.job_uuid
            )
    LEFT JOIN v2u_ko_specialty_map_j sm_j
        ON  (
                    sm_j.specialty_id = specialties.id
                AND sm_j.semester_id = ss_j.semester_id
                AND sm_j.job_uuid = specialties.job_uuid
            )
    LEFT JOIN v2u_specialty_map specialty_map
        ON  (
                    sm_j.map_id = specialty_map.id
            )
    WHERE   (
                    specialty_map.id IS NULL
                OR  sm_j.matching_score < 2
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
