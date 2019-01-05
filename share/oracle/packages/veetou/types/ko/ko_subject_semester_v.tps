CREATE OR REPLACE TYPE V2u_Ko_Subject_Semester_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_U_t
    ( subj_grades V2u_Subj_20Grades_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Subject_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subj_grades IN V2u_Subj_20Grades_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subj_grades IN V2u_Subj_20Grades_t
            )
    )
NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
