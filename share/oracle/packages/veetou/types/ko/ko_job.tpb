CREATE OR REPLACE TYPE BODY V2u_Ko_Job_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Job_t(
          SELF IN OUT NOCOPY V2u_Ko_Job_t
        , job_uuid RAW
        , job_timestamp IN TIMESTAMP := NULL
        , job_host IN VARCHAR2 := NULL
        , job_user IN VARCHAR2 := NULL
        , job_name IN VARCHAR2 := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.job_timestamp := job_timestamp;
        SELF.job_host := job_host;
        SELF.job_user := job_user;
        SELF.job_name := job_name;
        RETURN;
    END;

    MAP MEMBER FUNCTION rawpk
        RETURN RAW
    IS
    BEGIN
        RETURN job_uuid;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
