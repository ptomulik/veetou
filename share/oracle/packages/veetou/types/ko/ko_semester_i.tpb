CREATE OR REPLACE TYPE BODY V2u_Ko_Semester_I_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Semester_I_t(
              SELF IN OUT NOCOPY V2u_Ko_Semester_I_t
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

--    CONSTRUCTOR FUNCTION V2u_Ko_Semester_I_t(
--              SELF IN OUT NOCOPY V2u_Ko_Semester_I_t
--            , semester IN V2u_Ko_Semester_t
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.init(semester => semester);
--        RETURN;
--    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Semester_I_t
            , job_uuid RAW
            , semester_id IN NUMBER
            )
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.semester_id := semester_id;
    END;

--    MEMBER PROCEDURE init(
--              SELF IN OUT NOCOPY V2u_Ko_Semester_I_t
--            , semester IN V2u_Ko_Semester_t
--            )
--    IS
--    BEGIN
--        SELF.init(
--              job_uuid => semester.job_uuid
--            , semester_id => semester.id
--        );
--    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
