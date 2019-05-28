CREATE OR REPLACE TYPE V2u_Ko_Grade_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Grade_U_t
    ( CONSTRUCTOR FUNCTION V2u_Ko_Grade_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_V_t
            , grade_j IN V2u_Ko_Grade_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            ) RETURN SELF AS RESULT
    );
/
-- vim: set ft=sql ts=4 sw=4 et:
