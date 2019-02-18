CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Etpos_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Etpos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_V_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
            student => student
          , specialty => specialty
          , semester => semester
          , ects_attained => ects_attained
        );
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
