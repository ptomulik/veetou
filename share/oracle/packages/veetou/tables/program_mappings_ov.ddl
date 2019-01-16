CREATE OR REPLACE VIEW veetou_program_mappings_ov
    ( id
    , program_mapping
    , CONSTRAINT veetou_program_mappings_ov_pk PRIMARY KEY (id)
        RELY DISABLE NOVALIDATE
    )
AS SELECT
      t.id id
    , Veetou_Program_Mapping_Typ
        ( expr_university => t.expr_university
        , expr_faculty => t.expr_faculty
        , expr_studies_modetier => t.expr_studies_modetier
        , expr_studies_field => t.expr_studies_field
        , expr_studies_specialty => t.expr_studies_specialty
        , mapped_program_code => t.mapped_program_code
        , mapped_modetier_code => t.mapped_modetier_code
        , mapped_field_code => t.mapped_field_code
        ) program_mapping
FROM veetou_program_mappings t;

-- vim: set ft=sql ts=4 sw=4 et:
