CREATE OR REPLACE TYPE V2u_Ko_Matched_Przedm_I_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( subject_map_id NUMBER(38)
    , matching_score NUMBER(38)
    , prz_kod VARCHAR2(20 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_I_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_I_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_I_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
