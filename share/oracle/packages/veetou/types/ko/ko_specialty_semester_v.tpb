CREATE OR REPLACE TYPE BODY V2u_Ko_Specialty_Semester_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              specialty => specialty
            , semester => semester
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            )
    IS
    BEGIN
        SELF.job_uuid := specialty.job_uuid;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
        SELF.university := specialty.university;
        SELF.faculty := specialty.faculty;
        SELF.studies_modetier := specialty.studies_modetier;
        SELF.studies_field := specialty.studies_field;
        SELF.studies_specialty := specialty.studies_specialty;
        SELF.semester_number := semester.semester_number;
        SELF.semester_code := semester.semester_code;
        SELF.ects_mandatory := semester.ects_mandatory;
        SELF.ects_other := semester.ects_other;
        SELF.ects_total := semester.ects_total;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
