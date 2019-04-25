CREATE OR REPLACE TYPE V2u_Ko_Missing_Ocena_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( student_id NUMBER(38)
    , classes_type CHAR(1)
    , subj_grade VARCHAR2(10 CHAR)
    , subj_grade_date DATE
    , tr_id NUMBER(38)
    , os_id NUMBER(10)
    , prot_id NUMBER(10)
    , term_prot_nr NUMBER(10)
    , reason VARCHAR2(300 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Ocena_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Ocena_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , classes_type IN CHAR
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , tr_id IN NUMBER
            , os_id IN NUMBER
            , prot_id IN NUMBER
            , term_prot_nr IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Ocena_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , classes_type IN CHAR
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , tr_id IN NUMBER
            , os_id IN NUMBER
            , prot_id IN NUMBER
            , term_prot_nr IN NUMBER
            , reason IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Oceny_J_t
    AS TABLE OF V2u_Ko_Missing_Ocena_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
