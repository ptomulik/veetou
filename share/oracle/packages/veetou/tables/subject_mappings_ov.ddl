CREATE VIEW veetou_subject_mappings_ov AS SELECT
    Veetou_Subject_Mapping_Typ(
      id => sm.id
    , subj_code => sm.subj_code
    , mapped_subj_code => sm.mapped_subj_code
    , expr_subj_name => sm.expr_subj_name
    , expr_university => sm.expr_university
    , expr_faculty => sm.expr_faculty
    , expr_studies_modetier => sm.expr_studies_modetier
    , expr_studies_field => sm.expr_studies_field
    , expr_studies_specialty => sm.expr_studies_specialty
    , expr_semester_code => sm.expr_semester_code
    , expr_subj_hours_w => sm.expr_subj_hours_w
    , expr_subj_hours_c => sm.expr_subj_hours_c
    , expr_subj_hours_l => sm.expr_subj_hours_l
    , expr_subj_hours_p => sm.expr_subj_hours_p
    , expr_subj_hours_s => sm.expr_subj_hours_s
    , expr_subj_credit_kind => sm.expr_subj_credit_kind
    , expr_subj_ects => sm.expr_subj_ects
    , expr_subj_tutor => sm.expr_subj_tutor
    )
    AS mapping

FROM veetou_subject_mappings sm;


-- vim: set ft=sql ts=4 sw=4 et:
