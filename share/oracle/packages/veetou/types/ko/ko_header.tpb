CREATE OR REPLACE TYPE BODY V2u_Ko_Header_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Header_t(
          SELF IN OUT NOCOPY V2u_Ko_Header_t
        , job_uuid IN RAW
        , id IN NUMBER
        , university IN VARCHAR2 := NULL
        , faculty IN VARCHAR2 := NULL
        )
        RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.university := university;
        SELF.faculty := faculty;
        RETURN;
    END;

    MAP MEMBER FUNCTION rawpk
        RETURN RAW
    IS
    BEGIN
        RETURN UTL_RAW.CONCAT(UTL_RAW.CAST_FROM_NUMBER(id), job_uuid);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
