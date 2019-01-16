CREATE OR REPLACE VIEW veetou_ko_mapped_subjects
AS SELECT
      v.job_uuid job_uuid
    , v.subject_mapping_id subject_mapping_id
    , v.matching_score matching_score
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
    -- mapped
    , v.subject_mapping.mapped_subj_code mapped_subj_code
    , v.subject_mapping.expr_subj_name expr_subj_name
    , v.subject_mapping.expr_university expr_university
    , v.subject_mapping.expr_faculty expr_faculty
    , v.subject_mapping.expr_studies_modetier expr_studies_modetier
    , v.subject_mapping.expr_studies_field expr_studies_field
    , v.subject_mapping.expr_studies_specialty expr_studies_specialty
    , v.subject_mapping.expr_semester_code expr_semester_code
    , v.subject_mapping.expr_subj_hours_w expr_subj_hours_w
    , v.subject_mapping.expr_subj_hours_c expr_subj_hours_c
    , v.subject_mapping.expr_subj_hours_l expr_subj_hours_l
    , v.subject_mapping.expr_subj_hours_p expr_subj_hours_p
    , v.subject_mapping.expr_subj_hours_s expr_subj_hours_s
    , v.subject_mapping.expr_subj_credit_kind expr_subj_credit_kind
    , v.subject_mapping.expr_subj_ects expr_subj_ects
    , v.subject_mapping.expr_subj_tutor expr_subj_tutor
    -- count
    , v.trs_count trs_count

FROM veetou_ko_mapped_subjects_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
