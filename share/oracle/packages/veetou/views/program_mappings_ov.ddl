CREATE OR REPLACE VIEW v2u_program_mappings_ov
    ( id
    , program_mapping
    , CONSTRAINT v2u_program_mappings_ov_pk PRIMARY KEY (id)
        RELY DISABLE NOVALIDATE
    )
AS SELECT
      t.id id
    , V2u_Program_Mapping_t
        ( university => t.university
        , faculty => t.faculty
        , studies_modetier => t.studies_modetier
        , studies_field => t.studies_field
        , studies_specialty => t.studies_specialty
        , mapped_program_code => t.mapped_program_code
        , mapped_modetier_code => t.mapped_modetier_code
        , mapped_field_code => t.mapped_field_code
        , expr_semester_code => t.expr_semester_code
        ) program_mapping
FROM v2u_program_mappings t;

-- vim: set ft=sql ts=4 sw=4 et:
