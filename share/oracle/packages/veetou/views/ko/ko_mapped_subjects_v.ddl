CREATE OR REPLACE VIEW v2u_ko_mapped_subjects_v
OF V2u_Ko_Mapped_Subject_t
WITH OBJECT IDENTIFIER (job_uuid, subject_instance_id, subject_map_id)
AS SELECT
      si.job_uuid
    , si.id
    , sm.id
    , sim.matching_score
    , si.subj_code
    , sm.mapped_subj_code
    , si.subj_name
    , sm.expr_subj_name
    , si.university
    , sm.expr_university
    , si.faculty
    , sm.expr_faculty
    , si.studies_modetier
    , sm.expr_studies_modetier
    , si.studies_field
    , sm.expr_studies_field
    , si.studies_specialty
    , sm.expr_studies_specialty
    , si.semester_code
    , sm.expr_semester_code
    , si.subj_hours_w
    , sm.expr_subj_hours_w
    , si.subj_hours_c
    , sm.expr_subj_hours_c
    , si.subj_hours_l
    , sm.expr_subj_hours_l
    , si.subj_hours_p
    , sm.expr_subj_hours_p
    , si.subj_hours_s
    , sm.expr_subj_hours_s
    , si.subj_credit_kind
    , sm.expr_subj_credit_kind
    , si.subj_ects
    , sm.expr_subj_ects
    , si.subj_tutor
    , sm.expr_subj_tutor
FROM v2u_ko_subject_issues si
LEFT JOIN v2u_ko_subject_map_j sim
    ON (sim.subject_instance_id = si.id AND
        sim.job_uuid = si.job_uuid)
LEFT JOIN v2u_subject_map sm
    ON (sim.subject_map_id = sm.id)
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
