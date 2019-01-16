CREATE OR REPLACE VIEW veetou_subject_mappings_ov
    ( id
    , subject_mapping
    , CONSTRAINT veetou_subject_mappings_ov_pk PRIMARY KEY (id)
        RELY DISABLE NOVALIDATE
    )
    AS SELECT
          t.id id
        , Veetou_Subject_Mapping_Typ
            ( subj_code => t.subj_code
            , mapped_subj_code => t.mapped_subj_code
            , expr_subj_name => t.expr_subj_name
            , expr_university => t.expr_university
            , expr_faculty => t.expr_faculty
            , expr_studies_modetier => t.expr_studies_modetier
            , expr_studies_field => t.expr_studies_field
            , expr_studies_specialty => t.expr_studies_specialty
            , expr_semester_code => t.expr_semester_code
            , expr_subj_hours_w => t.expr_subj_hours_w
            , expr_subj_hours_c => t.expr_subj_hours_c
            , expr_subj_hours_l => t.expr_subj_hours_l
            , expr_subj_hours_p => t.expr_subj_hours_p
            , expr_subj_hours_s => t.expr_subj_hours_s
            , expr_subj_credit_kind => t.expr_subj_credit_kind
            , expr_subj_ects => t.expr_subj_ects
            , expr_subj_tutor => t.expr_subj_tutor
            ) subject_mapping
FROM veetou_subject_mappings t;

-- vim: set ft=sql ts=4 sw=4 et:
