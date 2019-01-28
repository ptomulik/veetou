CREATE OR REPLACE VIEW v2u_ko_mapped_subjects_v
OF V2u_Ko_Mapped_Subject_t
WITH OBJECT IDENTIFIER (job_uuid, subject_entity_id, subject_map_id)
AS SELECT
      se.job_uuid
    , se.id
    , sm.id
    , j.matching_score
    , se.subj_code
    , sm.mapped_subj_code
    , se.subj_name
    , sm.expr_subj_name
    , se.university
    , sm.expr_university
    , se.faculty
    , sm.expr_faculty
    , se.studies_modetier
    , sm.expr_studies_modetier
    , se.studies_field
    , sm.expr_studies_field
    , se.studies_specialty
    , sm.expr_studies_specialty
    , se.semester_code
    , sm.expr_semester_code
    , se.subj_hours_w
    , sm.expr_subj_hours_w
    , se.subj_hours_c
    , sm.expr_subj_hours_c
    , se.subj_hours_l
    , sm.expr_subj_hours_l
    , se.subj_hours_p
    , sm.expr_subj_hours_p
    , se.subj_hours_s
    , sm.expr_subj_hours_s
    , se.subj_credit_kind
    , sm.expr_subj_credit_kind
    , se.subj_ects
    , sm.expr_subj_ects
    , se.subj_tutor
    , sm.expr_subj_tutor
FROM v2u_ko_subject_entities se
LEFT JOIN v2u_ko_subject_map_j j
    ON (j.subject_entity_id = se.id AND
        j.job_uuid = se.job_uuid)
LEFT JOIN v2u_subject_map sm
    ON (j.subject_map_id = sm.id)
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
