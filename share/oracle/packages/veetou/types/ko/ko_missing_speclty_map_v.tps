CREATE OR REPLACE TYPE V2u_Ko_Missing_Speclty_Map_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Specialty_Map_B_t
    ( job_uuid RAW(16)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)

--    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Speclty_Map_V_t(
--              SELF IN OUT NOCOPY V2u_Ko_Missing_Speclty_Map_V_t
--            , id IN NUMBER := NULL
--            , university IN VARCHAR2
--            , faculty IN VARCHAR2
--            , studies_modetier IN VARCHAR2
--            , studies_field IN VARCHAR2
--            , studies_specialty IN VARCHAR2
--            , map_program_code IN VARCHAR2
--            , map_modetier_code IN VARCHAR2
--            , map_field_code IN VARCHAR2
--            , map_specialty_code IN VARCHAR2
--            , expr_semester_code IN VARCHAR2
--            , expr_semester_number IN VARCHAR2
--            , expr_ects_mandatory IN VARCHAR2
--            , expr_ects_other IN VARCHAR2
--            , expr_ects_total IN VARCHAR2
--            , job_uuid IN RAW
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Speclty_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Speclty_Map_V_t
            , id IN NUMBER := NULL
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT

--    , MEMBER PROCEDURE init(
--              SELF IN OUT NOCOPY V2u_Ko_Missing_Speclty_Map_V_t
--            , id IN NUMBER := NULL
--            , university IN VARCHAR2
--            , faculty IN VARCHAR2
--            , studies_modetier IN VARCHAR2
--            , studies_field IN VARCHAR2
--            , studies_specialty IN VARCHAR2
--            , map_program_code IN VARCHAR2
--            , map_modetier_code IN VARCHAR2
--            , map_field_code IN VARCHAR2
--            , map_specialty_code IN VARCHAR2
--            , expr_semester_code IN VARCHAR2
--            , expr_semester_number IN VARCHAR2
--            , expr_ects_mandatory IN VARCHAR2
--            , expr_ects_other IN VARCHAR2
--            , expr_ects_total IN VARCHAR2
--            , job_uuid IN RAW
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Speclty_Map_V_t
            , id IN NUMBER := NULL
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            )
    );
/
--CREATE OR REPLACE TYPE V2u_Ko_Missing_Speclty_Maps_V_t
--    AS TABLE OF V2u_Ko_Missing_Speclty_Map_V_t;

-- vim: set ft=sql ts=4 sw=4 et:
