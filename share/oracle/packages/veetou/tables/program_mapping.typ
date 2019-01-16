CREATE OR REPLACE TYPE Veetou_Program_Mapping_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( expr_university VARCHAR(256 CHAR)
    , expr_faculty VARCHAR(256 CHAR)
    , expr_studies_modetier VARCHAR(256 CHAR)
    , expr_studies_field VARCHAR(256 CHAR)
    , expr_studies_specialty VARCHAR(256 CHAR)
    , mapped_program_code VARCHAR(32 CHAR)
    , mapped_modetier_code VARCHAR(32 CHAR)
    , mapped_field_code VARCHAR(32 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Program_Mapping_Typ(
              SELF IN OUT NOCOPY Veetou_Program_Mapping_Typ
            , expr_university VARCHAR := NULL
            , expr_faculty VARCHAR := NULL
            , expr_studies_modetier VARCHAR := NULL
            , expr_studies_field VARCHAR := NULL
            , expr_studies_specialty VARCHAR := NULL
            , mapped_program_code VARCHAR := NULL
            , mapped_modetier_code VARCHAR := NULL
            , mapped_field_code VARCHAR := NULL
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Program_Mapping_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Program_Mapping_Typ(
          SELF IN OUT NOCOPY Veetou_Program_Mapping_Typ
        , expr_university VARCHAR := NULL
        , expr_faculty VARCHAR := NULL
        , expr_studies_modetier VARCHAR := NULL
        , expr_studies_field VARCHAR := NULL
        , expr_studies_specialty VARCHAR := NULL
        , mapped_program_code VARCHAR := NULL
        , mapped_modetier_code VARCHAR := NULL
        , mapped_field_code VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.expr_university := expr_university;
        SELF.expr_faculty := expr_faculty;
        SELF.expr_studies_modetier := expr_studies_modetier;
        SELF.expr_studies_field := expr_studies_field;
        SELF.expr_studies_specialty := expr_studies_specialty;
        SELF.mapped_program_code := mapped_program_code;
        SELF.mapped_modetier_code := mapped_modetier_code;
        SELF.mapped_field_code := mapped_field_code;
        RETURN;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
