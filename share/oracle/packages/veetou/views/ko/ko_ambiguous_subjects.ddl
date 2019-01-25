CREATE OR REPLACE VIEW v2u_ko_ambiguous_subjects
AS WITH u AS
    (
        SELECT
              VALUE(si) subject_instance
            , VALUE(sm) subject_mapping
            , sim.matching_score matching_score
        FROM v2u_ko_subject_instances si
        INNER JOIN v2u_ko_subj_inst_mapping sim
            ON (sim.subject_instance_id = si.id AND
                sim.job_uuid = si.job_uuid)
        INNER JOIN v2u_subject_mappings sm
            ON (sim.subject_mapping_id = sm.id)
    ),
    v AS
    (
        SELECT
              u.subject_instance subject_instance
            , CAST( COLLECT(subject_mapping ORDER BY u.subject_mapping.id)
                    AS V2u_Subject_Mappings_t
              ) subject_mappings
            , CAST( COLLECT(matching_score ORDER BY u.subject_mapping.id)
                    AS V2u_Integers_t
              ) matching_scores
            , COUNT(*) subject_mappings_count
        FROM u u
        GROUP BY u.subject_instance
    )
SELECT
      v.subject_instance.job_uuid job_uuid
    , v.subject_mappings_count subject_mappings_count
    , CAST(MULTISET(
            SELECT t.id FROM TABLE(v.subject_mappings) t
            WHERE ROWNUM <= 20
            ORDER BY t.id
      ) AS V2u_Ko_Ids_t) subject_mapping_ids
    , CAST(MULTISET(
            SELECT t.mapped_subj_code FROM TABLE(v.subject_mappings) t
            WHERE ROWNUM <= 20
            ORDER BY t.id
      ) AS V2u_Subj_Codes_t) mapped_subj_codes
    , v.matching_scores matching_scores
    -- instance
    , v.subject_instance.subj_code subj_code
    , v.subject_instance.subj_name subj_name
    , v.subject_instance.university university
    , v.subject_instance.faculty faculty
    , v.subject_instance.studies_modetier studies_modetier
    , v.subject_instance.studies_field studies_field
    , v.subject_instance.studies_specialty studies_specialty
    , v.subject_instance.semester_code semester_code
    , v.subject_instance.subj_hours_w subj_hours_w
    , v.subject_instance.subj_hours_c subj_hours_c
    , v.subject_instance.subj_hours_l subj_hours_l
    , v.subject_instance.subj_hours_p subj_hours_p
    , v.subject_instance.subj_hours_s subj_hours_s
    , v.subject_instance.subj_credit_kind subj_credit_kind
    , v.subject_instance.subj_ects subj_ects
    , v.subject_instance.subj_tutor subj_tutor
FROM v v
WHERE v.subject_mappings_count > 1
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
