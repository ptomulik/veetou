CREATE OR REPLACE TYPE V2u_Ko_Missing_Etpos_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Missing_Prgos_V_t
    ( CONSTRUCTOR FUNCTION V2u_Ko_Missing_Etpos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_V_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Etposes_V_t
    AS TABLE OF V2u_Ko_Missing_Etpos_V_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
