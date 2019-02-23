CREATE OR REPLACE TYPE V2u_Ko_Missing_Przedm_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_J_t
    ( subject_map_id NUMBER(38)
    , subject_matching_score NUMBER(38)
    , map_subj_code VARCHAR2(32 CHAR)
    , reason VARCHAR2(80 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Przedm_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przedm_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , map_subj_code IN VARCHAR2
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przedm_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , map_subj_code IN VARCHAR2
            , reason IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Przedms_J_t
    AS TABLE OF V2u_Ko_Missing_Przedm_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
