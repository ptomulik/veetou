CREATE OR REPLACE VIEW v2u_ko_unmapped_subjects
AS SELECT
      v.job_uuid job_uuid
    , v.subject_map_id subject_map_id
    , v.matching_score matching_score
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
    -- mapped
    , v.subject_map.mapped_subj_code mapped_subj_code
    , v.subject_map.expr_subj_name expr_subj_name
    , v.subject_map.expr_university expr_university
    , v.subject_map.expr_faculty expr_faculty
    , v.subject_map.expr_studies_modetier expr_studies_modetier
    , v.subject_map.expr_studies_field expr_studies_field
    , v.subject_map.expr_studies_specialty expr_studies_specialty
    , v.subject_map.expr_semester_code expr_semester_code
    , v.subject_map.expr_subj_hours_w expr_subj_hours_w
    , v.subject_map.expr_subj_hours_c expr_subj_hours_c
    , v.subject_map.expr_subj_hours_l expr_subj_hours_l
    , v.subject_map.expr_subj_hours_p expr_subj_hours_p
    , v.subject_map.expr_subj_hours_s expr_subj_hours_s
    , v.subject_map.expr_subj_credit_kind expr_subj_credit_kind
    , v.subject_map.expr_subj_ects expr_subj_ects
    , v.subject_map.expr_subj_tutor expr_subj_tutor
    -- count
    , v.trs_count trs_count

FROM v2u_ko_unmapped_subjects_dv v;

-- vim: set ft=sql ts=4 sw=4 et:
