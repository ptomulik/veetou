CREATE OR REPLACE TYPE V2u_Ko_Missing_Przcykl_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Missing_Przedm_J_t
    ( istniejace_cdyd_kody V2u_Semester_Codes_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Przcykl_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przcykl_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , map_subj_code IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_cdyd_kody IN V2u_Semester_Codes_t
            ) RETURN SELF AS RESULT


    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przcykl_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , map_subj_code IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_cdyd_kody IN V2u_Semester_Codes_t
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Przcykles_J_t
    AS TABLE OF V2u_Ko_Missing_Przcykl_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
