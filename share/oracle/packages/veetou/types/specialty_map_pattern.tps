CREATE OR REPLACE TYPE V2u_Specialty_Map_Pattern_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , map_program_code VARCHAR2(32 CHAR)
    , map_modetier_code VARCHAR2(32 CHAR)
    , map_field_code VARCHAR2(32 CHAR)
    , map_specialty_code VARCHAR2(32 CHAR)
    , semester_pattern V2u_Semester_Pattern_t

    , CONSTRUCTOR FUNCTION V2u_Specialty_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Specialty_Map_Pattern_t
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , map_program_code IN VARCHAR2
            , map_modetier_code IN VARCHAR2
            , map_field_code IN VARCHAR2
            , map_specialty_code IN VARCHAR2
            , semester_pattern IN V2u_Semester_Pattern_t
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Specialty_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Specialty_Map_Pattern_t
            , specialty_map IN V2u_Specialty_Map_B_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Specialty_Map_Pattern_t
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , map_program_code IN VARCHAR2
            , map_modetier_code IN VARCHAR2
            , map_field_code IN VARCHAR2
            , map_specialty_code IN VARCHAR2
            , semester_pattern IN V2u_Semester_Pattern_t
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Specialty_Map_Pattern_t
            , specialty_map IN V2u_Specialty_Map_B_t
            )

    , MEMBER FUNCTION match_attributes(
              semester_code IN VARCHAR2
            , semester_number IN INTEGER
            , ects_mandatory IN INTEGER
            , ects_other IN INTEGER
            , ects_total IN INTEGER
            ) RETURN INTEGER
    )
NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
