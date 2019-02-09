CREATE OR REPLACE TYPE V2u_Ko_Semester_J_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , semester_id NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Ko_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Semester_J_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Semester_J_t
            , semester IN V2u_Ko_Semester_t
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Semesters_J_t
    AS TABLE OF V2u_Ko_Semester_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
