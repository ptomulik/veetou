CREATE OR REPLACE TYPE Veetou_Program_Mapping_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( university VARCHAR(256 CHAR)
    , faculty VARCHAR(256 CHAR)
    , studies_modetier VARCHAR(256 CHAR)
    , studies_field VARCHAR(256 CHAR)
    , studies_specialty VARCHAR(256 CHAR)
    , mapped_program_code VARCHAR(32 CHAR)
    , mapped_modetier_code VARCHAR(32 CHAR)
    , mapped_field_code VARCHAR(32 CHAR)
    , expr_semester_code VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Program_Mapping_Typ(
              SELF IN OUT NOCOPY Veetou_Program_Mapping_Typ
            , university VARCHAR := NULL
            , faculty VARCHAR := NULL
            , studies_modetier VARCHAR := NULL
            , studies_field VARCHAR := NULL
            , studies_specialty VARCHAR := NULL
            , mapped_program_code VARCHAR := NULL
            , mapped_modetier_code VARCHAR := NULL
            , mapped_field_code VARCHAR := NULL
            , expr_semester_code VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , MEMBER FUNCTION match_expr_fields(
              specialty IN Veetou_Ko_Specialty_Typ
            , semester_code IN VARCHAR
            ) RETURN INTEGER

    , MEMBER FUNCTION match_expr_fields(refined IN Veetou_Ko_Refined_Typ)
            RETURN INTEGER

    , MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR)
            RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE Veetou_Program_Mappings_Typ
    AS TABLE OF Veetou_Program_Mapping_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
