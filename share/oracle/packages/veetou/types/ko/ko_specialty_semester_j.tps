CREATE OR REPLACE TYPE V2u_Ko_Specialty_Semester_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Specialty_Semester_I_t
    ( CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Specialty_Semesters_J_t
    AS TABLE OF V2u_Ko_Specialty_Semester_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
