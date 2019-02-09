CREATE OR REPLACE TYPE V2u_Ko_Strict_Subj_Map_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Map_J_t
    ( rejected_maps V2u_Ko_Rejected_Maps_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Strict_Subj_Map_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Strict_Subj_Map_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , map_id IN NUMBER
            , matching_score IN NUMBER
            , rejected_maps IN V2u_Ko_Rejected_Maps_t
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Strict_Subj_Map_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Strict_Subj_Map_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , subject IN V2u_Ko_Subject_t
            , map IN V2u_Subject_Map_t
            , matching_score IN NUMBER
            , rejected_maps IN V2u_Ko_Rejected_Maps_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Strict_Subj_Map_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , map_id IN NUMBER
            , matching_score IN NUMBER
            , rejected_maps IN V2u_Ko_Rejected_Maps_t
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Strict_Subj_Map_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , subject IN V2u_Ko_Subject_t
            , map IN V2u_Subject_Map_t
            , matching_score IN NUMBER
            , rejected_maps IN V2u_Ko_Rejected_Maps_t
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Strict_Subj_Maps_J_t
    AS TABLE OF V2u_Ko_Strict_Subj_Map_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
