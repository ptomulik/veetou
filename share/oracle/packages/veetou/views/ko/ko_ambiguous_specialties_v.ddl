CREATE OR REPLACE VIEW v2u_ko_ambiguous_specialties_v
AS WITH u AS
    (
        SELECT
              VALUE(se) se
            , VALUE(sm) sm
            , j.matching_score matching_score
        FROM v2u_ko_specialty_entities se
        INNER JOIN v2u_ko_specialty_map_j j
            ON (j.specent_id = se.id AND
                j.job_uuid = se.job_uuid)
        INNER JOIN v2u_specialty_map sm
            ON (j.specmap_id = sm.id)
    ),
    v AS
    (
        SELECT
              u.se se
            , CAST( COLLECT(sm ORDER BY u.sm.id)
                    AS V2u_Specialty_Maps_t
              ) sm
            , CAST( COLLECT(matching_score ORDER BY u.sm.id)
                    AS V2u_Integers_t
              ) matching_scores
            , COUNT(*) specialty_map_count
        FROM u u
        GROUP BY u.se
    )
SELECT
      v.se.job_uuid job_uuid
    , v.specialty_map_count specialty_map_count
    , CAST(MULTISET(
            SELECT t.id FROM TABLE(v.sm) t
            WHERE ROWNUM <= 20
            ORDER BY t.id
      ) AS V2u_Ids_t) specmap_ids
--    , CAST(MULTISET(
--            SELECT t.mapped_subj_code FROM TABLE(v.sm) t
--            WHERE ROWNUM <= 20
--            ORDER BY t.id
--      ) AS V2u_Subj_Codes_t) mapped_subj_codes
    , v.matching_scores matching_scores
    -- entity
    , v.se.university university
    , v.se.faculty faculty
    , v.se.studies_modetier studies_modetier
    , v.se.studies_field studies_field
    , v.se.studies_specialty studies_specialty
    , v.se.semester_number semester_number
    , v.se.semester_code semester_code
    , v.se.ects_mandatory ects_mandatory
    , v.se.ects_other ects_other
    , v.se.ects_total ects_total
FROM v v
WHERE v.specialty_map_count > 1
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
