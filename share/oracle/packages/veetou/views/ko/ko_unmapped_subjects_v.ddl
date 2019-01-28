CREATE OR REPLACE VIEW v2u_ko_unmapped_subjects_v
OF V2u_Ko_Mapped_Subject_t
WITH OBJECT IDENTIFIER (job_uuid, subject_entity_id, subject_map_id)
AS SELECT
      v.job_uuid
    , v.subject_entity_id
    , v.subject_map_id
    , v.matching_score
    , v.subj_code
    , v.mapped_subj_code
    , v.subj_name
    , v.expr_subj_name
    , v.university
    , v.expr_university
    , v.faculty
    , v.expr_faculty
    , v.studies_modetier
    , v.expr_studies_modetier
    , v.studies_field
    , v.expr_studies_field
    , v.studies_specialty
    , v.expr_studies_specialty
    , v.semester_code
    , v.expr_semester_code
    , v.subj_hours_w
    , v.expr_subj_hours_w
    , v.subj_hours_c
    , v.expr_subj_hours_c
    , v.subj_hours_l
    , v.expr_subj_hours_l
    , v.subj_hours_p
    , v.expr_subj_hours_p
    , v.subj_hours_s
    , v.expr_subj_hours_s
    , v.subj_credit_kind
    , v.expr_subj_credit_kind
    , v.subj_ects
    , v.expr_subj_ects
    , v.subj_tutor
    , v.expr_subj_tutor
FROM v2u_ko_mapped_subjects_v v
WHERE v.subject_map_id IS NULL OR
      v.mapped_subj_code IS NULL OR
      v.matching_score < 1;

-- vim: set ft=sql ts=4 sw=4 et:
