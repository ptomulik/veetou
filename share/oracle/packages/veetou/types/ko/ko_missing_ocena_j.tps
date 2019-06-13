CREATE OR REPLACE TYPE V2u_Ko_Missing_Ocena_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Grade_I_t
    ( os_id NUMBER(10)
    , prot_id NUMBER(10)
    , term_prot_nr NUMBER(10)
    , matching_scores V2u_20Ints_t
    , highest_score NUMBER(38)
    , reason VARCHAR2(2048 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Ocena_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Ocena_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , map_subj_grade IN VARCHAR2
            , map_subj_grade_type IN VARCHAR2
            , os_id IN NUMBER
            , prot_id IN NUMBER
            , term_prot_nr IN NUMBER
            , matching_scores IN V2u_20Ints_t
            , highest_score IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Ocena_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , map_subj_grade IN VARCHAR2
            , map_subj_grade_type IN VARCHAR2
            , os_id IN NUMBER
            , prot_id IN NUMBER
            , term_prot_nr IN NUMBER
            , matching_scores IN V2u_20Ints_t
            , highest_score IN NUMBER
            , reason IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Oceny_J_t
    AS TABLE OF V2u_Ko_Missing_Ocena_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
