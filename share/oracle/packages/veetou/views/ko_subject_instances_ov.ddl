CREATE OR REPLACE VIEW veetou_ko_subject_instances_ov AS
    SELECT
      v.job_uuid job_uuid
    , Veetou_Ko_Subject_Instance_Typ
        ( subj_code => v.subj_code
        , subj_name => v.subj_name
        , university => v.university
        , faculty => v.faculty
        , studies_modetier => v.studies_modetier
        , studies_field => v.studies_field
        , studies_specialty => v.studies_specialty
        , semester_code => v.semester_code
        , subj_tutor => v.subj_tutor
        , subj_hours_w => v.subj_hours_w
        , subj_hours_c => v.subj_hours_c
        , subj_hours_l => v.subj_hours_l
        , subj_hours_p => v.subj_hours_p
        , subj_hours_s => v.subj_hours_s
        , subj_credit_kind => v.subj_credit_kind
        , subj_ects => v.subj_ects
        ) subject_instance
FROM veetou_ko_subject_instances v;

-- vim: set ft=sql ts=4 sw=4 et:
