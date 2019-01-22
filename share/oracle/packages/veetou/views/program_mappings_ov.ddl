CREATE OR REPLACE VIEW v2u_program_mappings_ov
OF V2u_Program_Mapping_t
WITH OBJECT IDENTIFIER(id)
AS SELECT t.id
        , t.university
        , t.faculty
        , t.studies_modetier
        , t.studies_field
        , t.studies_specialty
        , t.mapped_program_code
        , t.mapped_modetier_code
        , t.mapped_field_code
        , t.expr_semester_code
FROM v2u_program_mappings t;

-- vim: set ft=sql ts=4 sw=4 et:
