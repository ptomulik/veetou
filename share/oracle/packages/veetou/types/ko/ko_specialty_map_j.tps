CREATE OR REPLACE TYPE V2u_Ko_Specialty_Map_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Speclty_Semester_J_t
    ( map_id NUMBER(38)
    , matching_score NUMBER(38)
    , highest_score NUMBER(38)
    , selected NUMBER(1)
    , reason VARCHAR2(20 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Map_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Map_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , map_id IN NUMBER
            , matching_score IN NUMBER
            , highest_score IN NUMBER
            , selected IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Map_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Map_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , map IN V2u_Specialty_Map_t
            , matching_score IN NUMBER
            , highest_score IN NUMBER
            , selected IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Map_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , map_id IN NUMBER
            , matching_score IN NUMBER
            , highest_score IN NUMBER
            , selected IN NUMBER
            , reason IN VARCHAR2
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Map_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , map IN V2u_Specialty_Map_t
            , matching_score IN NUMBER
            , highest_score IN NUMBER
            , selected IN NUMBER
            , reason IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Specialty_Maps_J_t
    AS TABLE OF V2u_Ko_Specialty_Map_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
