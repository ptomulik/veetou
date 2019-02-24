CREATE OR REPLACE TYPE V2u_Ko_Specialty_Semester_I_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Semester_I_t
    ( specialty_id NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Semester_I_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_I_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_I_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
