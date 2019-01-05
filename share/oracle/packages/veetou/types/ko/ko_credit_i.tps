CREATE OR REPLACE TYPE V2u_Ko_Credit_I_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( classes_type CHAR(1)
    , student_id NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Ko_Credit_I_t(
              SELF IN OUT NOCOPY V2u_Ko_Credit_I_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Credit_I_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            )
    )
NOT FINAL NOT INSTANTIABLE;
/

-- vim: set ft=sql ts=4 sw=4 et:
