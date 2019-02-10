CREATE OR REPLACE TYPE V2u_Ko_Missing_Przedm_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_V_t
    ( reason VARCHAR2(80 CHAR)
    , tried_map_subj_code VARCHAR2(32 CHAR)


    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Przedm_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przedm_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , reason IN VARCHAR2
            , tried_map_subj_code IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przedm_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , reason IN VARCHAR2
            , tried_map_subj_code IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Przedms_V_t
    AS TABLE OF V2u_Ko_Missing_Przedm_V_t;

-- vim: set ft=sql ts=4 sw=4 et:
