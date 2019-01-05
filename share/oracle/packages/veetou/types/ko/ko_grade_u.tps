CREATE OR REPLACE TYPE V2u_Ko_Grade_U_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Credit_U_t
    ( subj_grade VARCHAR2(10 CHAR)
    , subj_grade_date DATE
    , map_subj_grade VARCHAR2(100 CHAR)
    , map_subj_grade_type VARCHAR2(20 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Grade_U_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_U_t
            , grade_i IN V2u_Ko_Grade_I_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Grade_U_t
            , grade_i IN V2u_Ko_Grade_I_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            )
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
