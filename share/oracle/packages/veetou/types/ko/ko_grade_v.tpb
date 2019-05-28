CREATE OR REPLACE TYPE BODY V2u_Ko_Grade_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Grade_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_V_t
            , grade_j IN V2u_Ko_Grade_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              grade_i => grade_j
            , subject => subject
            , specialty => specialty
            , semester => semester
            , student => student
            );
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
