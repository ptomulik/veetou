CREATE OR REPLACE TYPE BODY V2u_Ko_Classes_Semester_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , classes_type => classes_type
            , classes_hours => classes_hours
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            );
        SELF.classes_type := classes_type;
        SELF.classes_hours := classes_hours;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
