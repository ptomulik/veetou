CREATE OR REPLACE TYPE BODY V2u_Ko_Grade_U_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Grade_U_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_U_t
            , grade_i IN V2u_Ko_Grade_I_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              grade_i => grade_i
            , subject => subject
            , specialty => specialty
            , semester => semester
            , student => student
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Grade_U_t
            , grade_i IN V2u_Ko_Grade_I_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            )
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , classes_type => grade_i.classes_type
            , student => student
        );
        SELF.subj_grade := grade_i.subj_grade;
        SELF.subj_grade_date := grade_i.subj_grade_date;
        SELF.map_subj_grade := grade_i.map_subj_grade;
        SELF.map_subj_grade_type := grade_i.map_subj_grade_type;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
