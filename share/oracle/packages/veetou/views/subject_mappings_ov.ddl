CREATE OR REPLACE VIEW v2u_subject_mappings_ov
OF V2u_Subject_Mapping_t
WITH OBJECT IDENTIFIER(id)
AS SELECT t.id
        , t.subj_code
        , t.mapped_subj_code
        , t.expr_subj_name
        , t.expr_university
        , t.expr_faculty
        , t.expr_studies_modetier
        , t.expr_studies_field
        , t.expr_studies_specialty
        , t.expr_semester_code
        , t.expr_subj_hours_w
        , t.expr_subj_hours_c
        , t.expr_subj_hours_l
        , t.expr_subj_hours_p
        , t.expr_subj_hours_s
        , t.expr_subj_credit_kind
        , t.expr_subj_ects
        , t.expr_subj_tutor
FROM v2u_subject_mappings t;

-- vim: set ft=sql ts=4 sw=4 et:
