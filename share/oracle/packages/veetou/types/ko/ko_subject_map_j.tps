CREATE OR REPLACE TYPE V2u_Ko_Subject_Map_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( map_id NUMBER(38)
    , matching_score NUMBER(38)
    , highest_score NUMBER(38)
    , selected NUMBER(1)
    , reason VARCHAR2(20 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Subject_Map_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Map_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , map_id IN NUMBER
            , matching_score IN NUMBER
            , highest_score IN NUMBER
            , selected IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Map_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , map_id IN NUMBER
            , matching_score IN NUMBER
            , highest_score IN NUMBER
            , selected IN NUMBER
            , reason IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Subject_Maps_J_t
    AS TABLE OF V2u_Ko_Subject_Map_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
