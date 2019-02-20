CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Etpos_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Etpos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , ects_attained IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , student_id => student_id
            , ects_attained => ects_attained
            );
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Etpos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , student IN V2u_Ko_Student_t
            , ects_attained IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              semester => semester
            , specialty => specialty
            , student => student
            , ects_attained => ects_attained
            );
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et: