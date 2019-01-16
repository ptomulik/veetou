CREATE OR REPLACE VIEW veetou_ko_mapped_programs_ov
AS SELECT
      v.job_uuid job_uuid
    , v.program_mapping_id program_mapping_id
    , Veetou_Ko_Program_Instance_Typ
        ( university => v.university
        , faculty => v.faculty
        , studies_modetier => v.studies_modetier
        , studies_field => v.studies_field
        , studies_specialty => v.studies_specialty
        ) program_instance
    , Veetou_Program_Mapping_Typ
        ( expr_university => v.expr_university
        , expr_faculty => v.expr_faculty
        , expr_studies_modetier => v.expr_studies_modetier
        , expr_studies_field => v.expr_studies_field
        , expr_studies_specialty => v.expr_studies_specialty
        , mapped_program_code => v.mapped_program_code
        , mapped_modetier_code => v.mapped_modetier_code
        , mapped_field_code => v.mapped_field_code
        ) program_mapping
    , v.trs_count trs_count
FROM veetou_ko_mapped_programs v;

-- vim: set ft=sql ts=4 sw=4 et:
