CREATE VIEW veetou_ko_subject_instances AS
SELECT DISTINCT
      subj_code
    , subj_name
    , university
    , faculty
    , studies_modetier
    , studies_field
    , studies_specialty
    , semester_code
    , subj_tutor
    , subj_hours_w
    , subj_hours_c
    , subj_hours_l
    , subj_hours_p
    , subj_hours_s
    , subj_credit_kind
    , subj_ects
FROM veetou_ko_refined
ORDER BY subj_code;

-- vim: set ft=sql ts=4 sw=4 et: