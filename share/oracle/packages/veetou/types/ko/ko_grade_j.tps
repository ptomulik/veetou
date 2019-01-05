CREATE OR REPLACE TYPE V2u_Ko_Grade_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Grade_I_t
    ( tr_id NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Ko_Grade_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_J_t
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
            , tr_id IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Grade_J_t
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
            , tr_id IN NUMBER
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Grades_J_t
    AS TABLE OF V2u_Ko_Grade_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
