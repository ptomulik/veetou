CREATE OR REPLACE TYPE V2u_Ko_Missing_Pktprz_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Missing_Przedm_V_t
    ( istniejace_cdyd_kody V2u_Semester_Codes_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Pktprz_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Pktprz_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_cdyd_kody IN V2u_Semester_Codes_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Pktprz_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_cdyd_kody IN V2u_Semester_Codes_t
            )
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Pktprzes_V_t
    AS TABLE OF V2u_Ko_Missing_Pktprz_V_t;

-- vim: set ft=sql ts=4 sw=4 et:
