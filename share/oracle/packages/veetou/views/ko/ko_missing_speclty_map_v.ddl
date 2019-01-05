CREATE OR REPLACE VIEW v2u_ko_missing_speclty_map_v
OF V2u_Ko_Missing_Speclty_Map_V_t
WITH OBJECT IDENTIFIER (job_uuid, specialty_id, semester_id)
AS WITH u AS
    (
        SELECT
              ss_j.specialty_id
            , ss_j.semester_id
            , ss_j.job_uuid
        FROM v2u_ko_specialty_semesters_j ss_j
        LEFT JOIN v2u_ko_specialty_map_j sm_j
            ON  (
                        sm_j.specialty_id = ss_j.specialty_id
                    AND sm_j.semester_id = ss_j.semester_id
                    AND sm_j.job_uuid = ss_j.job_uuid
                )
        GROUP BY
              ss_j.specialty_id
            , ss_j.semester_id
            , ss_j.job_uuid
        HAVING COUNT(sm_j.map_id) = 0
    )
    SELECT
          V2u_Ko_Missing_Speclty_Map_V_t(
              specialty => VALUE(specialties)
            , semester => VALUE(semesters)
          )
    FROM u u
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = u.specialty_id
                AND specialties.job_uuid = u.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = u.semester_id
                AND semesters.job_uuid = u.job_uuid
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
