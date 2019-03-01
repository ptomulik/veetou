CREATE OR REPLACE TYPE V2u_Specialty_Map_B_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Distinct_t
    ( university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , map_program_code VARCHAR2(32 CHAR)
    , map_modetier_code VARCHAR2(32 CHAR)
    , map_field_code VARCHAR2(32 CHAR)
    , map_specialty_code VARCHAR2(32 CHAR)
    , map_org_unit VARCHAR(20 CHAR)
    , expr_semester_code VARCHAR2(256 CHAR)
    , expr_semester_number VARCHAR2(256 CHAR)
    , expr_ects_mandatory VARCHAR2(256 CHAR)
    , expr_ects_other VARCHAR2(256 CHAR)
    , expr_ects_total VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Specialty_Map_B_t(
              SELF IN OUT NOCOPY V2u_Specialty_Map_B_t
            , id IN NUMBER := NULL
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , map_program_code IN VARCHAR2
            , map_modetier_code IN VARCHAR2
            , map_field_code IN VARCHAR2
            , map_specialty_code IN VARCHAR2
            , map_org_unit IN VARCHAR2
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Specialty_Map_B_t
            , id IN NUMBER := NULL
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , map_program_code IN VARCHAR2
            , map_modetier_code IN VARCHAR2
            , map_field_code IN VARCHAR2
            , map_specialty_code IN VARCHAR2
            , map_org_unit IN VARCHAR2
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            )

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
            RETURN INTEGER

    , MEMBER FUNCTION cmp_val(other IN V2u_Specialty_Map_B_t)
            RETURN INTEGER
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
