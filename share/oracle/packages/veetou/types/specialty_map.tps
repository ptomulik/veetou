CREATE OR REPLACE TYPE V2u_Specialty_Map_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Distinct_t
    ( university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , map_program_code VARCHAR2(32 CHAR)
    , map_modetier_code VARCHAR2(32 CHAR)
    , map_field_code VARCHAR2(32 CHAR)
    , expr_semester_number VARCHAR2(256 CHAR)
    , expr_semester_code VARCHAR2(256 CHAR)
    , expr_ects_mandatory VARCHAR2(256 CHAR)
    , expr_ects_other VARCHAR2(256 CHAR)
    , expr_ects_total VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Specialty_Map_t(
              SELF IN OUT NOCOPY V2u_Specialty_Map_t
            , id IN NUMBER
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , studies_specialty IN VARCHAR2 := NULL
            , map_program_code IN VARCHAR2 := NULL
            , map_modetier_code IN VARCHAR2 := NULL
            , map_field_code IN VARCHAR2 := NULL
            , expr_semester_number VARCHAR2 := NULL
            , expr_semester_code VARCHAR2 := NULL
            , expr_ects_mandatory VARCHAR2 := NULL
            , expr_ects_other VARCHAR2 := NULL
            , expr_ects_total VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER

    , MEMBER FUNCTION cmp_val(other IN V2u_Specialty_Map_t)
        RETURN INTEGER

    , MEMBER FUNCTION match_expr_fields(
              semester_number IN VARCHAR2
            , semester_code IN VARCHAR2
            , ects_mandatory IN VARCHAR2
            , ects_other IN VARCHAR2
            , ects_total IN VARCHAR2
            ) RETURN INTEGER

    , MEMBER FUNCTION match_semester_number(semester_number IN INTEGER)
        RETURN INTEGER

    , MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR2)
        RETURN INTEGER

    , MEMBER FUNCTION match_ects_mandatory(ects_mandatory IN INTEGER)
        RETURN INTEGER

    , MEMBER FUNCTION match_ects_other(ects_other IN INTEGER)
        RETURN INTEGER

    , MEMBER FUNCTION match_ects_total(ects_total IN INTEGER)
        RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE V2u_Specialty_Maps_t
    AS TABLE OF V2u_Specialty_Map_t;

-- vim: set ft=sql ts=4 sw=4 et:
