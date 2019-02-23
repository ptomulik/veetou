CREATE OR REPLACE TYPE BODY V2u_Ko_Classes_Semester_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , classes_type => classes_type
            , classes_hours => classes_hours
            );
        RETURN;
    END;

--    CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_J_t(
--              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_J_t
--            , semester IN V2u_Ko_Semester_t
--            , specialty IN V2u_Ko_Specialty_t
--            , subject IN V2u_Ko_Subject_t
--            , classes_type IN VARCHAR2
--            , classes_hours IN NUMBER := NULL
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.init(
--              semester => semester
--            , specialty => specialty
--            , subject => subject
--            , classes_type => classes_type
--            , classes_hours => classes_hours
--            );
--        RETURN;
--    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            );
        SELF.classes_type := classes_type;
        SELF.classes_hours := classes_hours;
    END;

--    MEMBER PROCEDURE init(
--              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_J_t
--            , semester IN V2u_Ko_Semester_t
--            , specialty IN V2u_Ko_Specialty_t
--            , subject IN V2u_Ko_Subject_t
--            , classes_type IN VARCHAR2
--            , classes_hours IN NUMBER := NULL
--            )
--    IS
--    BEGIN
--        SELF.init(
--              semester => semester
--            , specialty => specialty
--            , subject => subject
--            );
--        SELF.classes_type := classes_type;
--        SELF.classes_hours := classes_hours;
--    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
