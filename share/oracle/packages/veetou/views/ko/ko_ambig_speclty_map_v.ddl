CREATE OR REPLACE VIEW v2u_ko_ambig_speclty_map_v
OF V2u_Ko_Ambig_Speclty_Map_V_t
WITH OBJECT IDENTIFIER (job_uuid, specialty_id, semester_id)
AS WITH u AS
    (
        SELECT
              j.job_uuid job_uuid
            , j.specialty_id specialty_id
            , j.semester_id semester_id
            , COUNT(*) map_count
            , CAST(COLLECT(j.map_id ORDER BY j.map_id) AS V2u_Ids_t) map_ids
            , CAST(COLLECT(j.matching_score ORDER BY j.map_id) AS V2u_Integers_t) matching_scores
        FROM v2u_ko_specialty_map_j j
        GROUP BY
              j.job_uuid
            , j.specialty_id
            , j.semester_id
    )
    SELECT
        V2u_Ko_Ambig_Speclty_Map_V_t(
              (SELECT VALUE(s) FROM v2u_ko_specialties s WHERE s.id = u.specialty_id AND s.job_uuid = u.job_uuid)
            , (SELECT VALUE(s) FROM v2u_ko_semesters s WHERE s.id = u.semester_id AND s.job_uuid = u.job_uuid)
            , u.map_count
            , u.map_ids
            , u.matching_scores
        )
    FROM u u
    WHERE u.map_count > 1
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
