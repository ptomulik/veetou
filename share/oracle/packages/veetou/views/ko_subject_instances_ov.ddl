CREATE OR REPLACE VIEW v2u_ko_subject_instances_ov
OF V2u_Ko_Subject_Instance_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS SELECT
      t.subject_instance.job_uuid
    , t.subject_instance.id
    , t.subject_instance.subj_code
    , t.subject_instance.subj_name
    , t.subject_instance.university
    , t.subject_instance.faculty
    , t.subject_instance.studies_modetier
    , t.subject_instance.studies_field
    , t.subject_instance.studies_specialty
    , t.subject_instance.semester_code
    , t.subject_instance.subj_hours_w
    , t.subject_instance.subj_hours_c
    , t.subject_instance.subj_hours_l
    , t.subject_instance.subj_hours_p
    , t.subject_instance.subj_hours_s
    , t.subject_instance.subj_credit_kind
    , t.subject_instance.subj_ects
    , t.subject_instance.subj_tutor
    --, COUNT(*) trs_count
    --, CAST(COLLECT(tr ORDER BY tr) AS V2u_Ko_Trs_t) trs
FROM v2u_ko_subject_instances_mv t;

-- vim: set ft=sql ts=4 sw=4 et:
