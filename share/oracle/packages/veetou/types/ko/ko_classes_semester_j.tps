CREATE OR REPLACE TYPE V2u_Ko_Classes_Semester_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_J_t
    ( classes_type VARCHAR(1)
    , classes_hours NUMBER(8)

    , CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , subject IN V2u_Ko_Subject_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER := NULL
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , subject IN V2u_Ko_Subject_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER := NULL
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Classes_Semesters_J_t
    AS TABLE OF V2u_Ko_Classes_Semester_J_t;

-- vim: set ft=sql ts=4 sw=4 et: