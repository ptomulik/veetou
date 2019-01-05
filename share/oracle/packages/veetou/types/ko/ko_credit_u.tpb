CREATE OR REPLACE TYPE BODY V2u_Ko_Credit_U_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Credit_U_t(
              SELF IN OUT NOCOPY V2u_Ko_Credit_U_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN CHAR
            , student IN V2u_Ko_Student_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , classes_type => classes_type
            , student => student
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Credit_U_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN CHAR
            , student IN V2u_Ko_Student_t
            )
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
        );
        SELF.classes_type := classes_type;
        SELF.student_id := student.id;
        SELF.student_index := student.student_index;
        SELF.student_name := student.student_name;
        SELF.first_name := student.first_name;
        SELF.last_name := student.last_name;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
