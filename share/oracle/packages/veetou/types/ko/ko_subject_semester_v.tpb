CREATE OR REPLACE TYPE BODY V2u_Ko_Subject_Semester_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Subject_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subj_grades IN V2u_Subj_20Grades_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , subj_grades => subj_grades
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subj_grades IN V2u_Subj_20Grades_t
            )
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            );
        SELF.subj_grades := subj_grades;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
