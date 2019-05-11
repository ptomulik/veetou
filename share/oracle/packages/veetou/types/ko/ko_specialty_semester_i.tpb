CREATE OR REPLACE TYPE BODY V2u_Ko_Specialty_Semester_I_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Semester_I_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_I_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_I_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            );
        SELF.specialty_id := specialty_id;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
