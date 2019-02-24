CREATE OR REPLACE TYPE BODY V2u_Ko_Semester_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            );
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
