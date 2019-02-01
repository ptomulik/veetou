CREATE OR REPLACE VIEW v2u_ko_ambiguous_subjects_v
AS WITH u AS
    (
        SELECT
              VALUE(se) subject_entity
            , VALUE(sm) subject_map
            , j.matching_score matching_score
        FROM v2u_ko_subject_entities se
        INNER JOIN v2u_ko_subject_map_j j
            ON (j.subject_entity_id = se.id AND
                j.job_uuid = se.job_uuid)
        INNER JOIN v2u_subject_map sm
            ON (j.subject_map_id = sm.id)
    ),
    v AS
    (
        SELECT
              u.subject_entity subject_entity
            , CAST( COLLECT(subject_map ORDER BY u.subject_map.id)
                    AS V2u_Subject_Maps_t
              ) subject_map
            , CAST( COLLECT(matching_score ORDER BY u.subject_map.id)
                    AS V2u_Integers_t
              ) matching_scores
            , COUNT(*) subject_map_count
        FROM u u
        GROUP BY u.subject_entity
    )
SELECT
      v.subject_entity.job_uuid job_uuid
    , v.subject_map_count subject_map_count
    , CAST(MULTISET(
            SELECT t.id FROM TABLE(v.subject_map) t
            WHERE ROWNUM <= 20
            ORDER BY t.id
      ) AS V2u_Ids_t) subject_map_ids
    , CAST(MULTISET(
            SELECT t.map_subj_code FROM TABLE(v.subject_map) t
            WHERE ROWNUM <= 20
            ORDER BY t.id
      ) AS V2u_Subj_Codes_t) map_subj_codes
    , v.matching_scores matching_scores
    -- entity
    , v.subject_entity.subj_code subj_code
    , v.subject_entity.subj_name subj_name
    , v.subject_entity.university university
    , v.subject_entity.faculty faculty
    , v.subject_entity.studies_modetier studies_modetier
    , v.subject_entity.studies_field studies_field
    , v.subject_entity.studies_specialty studies_specialty
    , v.subject_entity.semester_code semester_code
    , v.subject_entity.subj_hours_w subj_hours_w
    , v.subject_entity.subj_hours_c subj_hours_c
    , v.subject_entity.subj_hours_l subj_hours_l
    , v.subject_entity.subj_hours_p subj_hours_p
    , v.subject_entity.subj_hours_s subj_hours_s
    , v.subject_entity.subj_credit_kind subj_credit_kind
    , v.subject_entity.subj_ects subj_ects
    , v.subject_entity.subj_tutor subj_tutor
FROM v v
WHERE v.subject_map_count > 1
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
