CREATE OR REPLACE TYPE V2u_Program_Mapping_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR2(256 CHAR)
    , studies_field VARCHAR2(256 CHAR)
    , studies_specialty VARCHAR2(256 CHAR)
    , mapped_program_code VARCHAR2(32 CHAR)
    , mapped_modetier_code VARCHAR2(32 CHAR)
    , mapped_field_code VARCHAR2(32 CHAR)
    , expr_semester_code VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Program_Mapping_t(
              SELF IN OUT NOCOPY V2u_Program_Mapping_t
            , id IN NUMBER
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , studies_specialty IN VARCHAR2 := NULL
            , mapped_program_code IN VARCHAR2 := NULL
            , mapped_modetier_code IN VARCHAR2 := NULL
            , mapped_field_code IN VARCHAR2 := NULL
            , expr_semester_code IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , MEMBER FUNCTION match_expr_fields(semester_code IN VARCHAR2)
            RETURN INTEGER

    , MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR2)
            RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE V2u_Program_Mappings_t
    AS TABLE OF V2u_Program_Mapping_t;

-- vim: set ft=sql ts=4 sw=4 et:
