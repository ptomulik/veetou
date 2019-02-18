CREATE OR REPLACE TYPE V2u_Ko_Missing_Etpos_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Student_Semester_J_t
    (
      CONSTRUCTOR FUNCTION V2u_Ko_Missing_Etpos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Etpos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , student IN V2u_Ko_Student_t
            ) RETURN SELF AS RESULT
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Etposes_J_t
    AS TABLE OF V2u_Ko_Missing_Etpos_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
