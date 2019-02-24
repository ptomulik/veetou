CREATE OR REPLACE TYPE V2u_Ko_Classes_Semester_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_U_t
    ( classes_type VARCHAR2(1 CHAR)
    , classes_hours NUMBER(8)

    , CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            )
    )
NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
