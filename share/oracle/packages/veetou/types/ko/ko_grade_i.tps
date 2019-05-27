CREATE OR REPLACE TYPE V2u_Ko_Grade_I_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Credit_I_t
    ( subj_grade VARCHAR2(10 CHAR)
    , subj_grade_date DATE
    , map_subj_grade VARCHAR2(100 CHAR)
    , map_subj_grade_type VARCHAR2(20 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Grade_I_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_I_t
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
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Grade_I_t
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
            )
    )
NOT FINAL NOT INSTANTIABLE;
/
-- vim: set ft=sql ts=4 sw=4 et:
