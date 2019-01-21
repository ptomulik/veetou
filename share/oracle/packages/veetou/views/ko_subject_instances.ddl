CREATE OR REPLACE VIEW v2u_ko_subject_instances
AS SELECT
      job_uuid
    , v.subject_instance.subj_code subj_code
    , v.subject_instance.subj_name subj_name
    , v.subject_instance.university university
    , v.subject_instance.faculty faculty
    , v.subject_instance.studies_modetier studies_modetier
    , v.subject_instance.studies_field studies_field
    , v.subject_instance.studies_specialty studies_specialty
    , v.subject_instance.semester_code semester_code
    , v.subject_instance.subj_tutor subj_tutor
    , v.subject_instance.subj_hours_w subj_hours_w
    , v.subject_instance.subj_hours_c subj_hours_c
    , v.subject_instance.subj_hours_l subj_hours_l
    , v.subject_instance.subj_hours_p subj_hours_p
    , v.subject_instance.subj_hours_s subj_hours_s
    , v.subject_instance.subj_credit_kind subj_credit_kind
    , v.subject_instance.subj_ects subj_ects
    , v.trs_count trs_count
FROM v2u_ko_subject_instances_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
