CREATE OR REPLACE TYPE V2u_Ko_Classes_Semester_I_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( classes_type VARCHAR(1 CHAR)
    , classes_hours NUMBER(8)

    , CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_I_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_I_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_I_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            )
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
