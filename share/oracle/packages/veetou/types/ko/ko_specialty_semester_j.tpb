CREATE OR REPLACE TYPE BODY V2u_Ko_Specialty_Semester_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_J_t
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

    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              semester => semester
            , specialty => specialty
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_J_t
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

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            )
    IS
    BEGIN
        IF semester.job_uuid <> specialty.job_uuid THEN
            RAISE_APPLICATION_ERROR(
                  -20101
                , 'job_uuid missmatch in V2u_Ko_Specialty_Semester_J_t.init:' ||
                  ' semester.job_uuid='  || RAWTOHEX(semester.job_uuid) ||
                  ' specialty.job_uuid=' || RAWTOHEX(specialty.job_uuid)
                );
        END IF;
        SELF.init(semester => semester);
        SELF.specialty_id := specialty.id;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
