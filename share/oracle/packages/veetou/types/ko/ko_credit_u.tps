CREATE OR REPLACE TYPE V2u_Ko_Credit_U_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_U_t
    ( classes_type CHAR(1)
    , student_id NUMBER(38)
    , student_index VARCHAR2(32 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , first_name VARCHAR2(48 CHAR)
    , last_name VARCHAR2(48 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Credit_U_t(
              SELF IN OUT NOCOPY V2u_Ko_Credit_U_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN CHAR
            , student IN V2u_Ko_Student_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Credit_U_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN CHAR
            , student IN V2u_Ko_Student_t
            )
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
