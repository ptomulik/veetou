CREATE OR REPLACE TYPE BODY V2u_Ko_Job_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Job_t(
          SELF IN OUT NOCOPY V2u_Ko_Job_t
        , job_timestamp IN TIMESTAMP := NULL
        , job_host IN VARCHAR := NULL
        , job_user IN VARCHAR := NULL
        , job_name IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_timestamp := job_timestamp;
        SELF.job_host := job_host;
        SELF.job_user := job_user;
        SELF.job_name := job_name;
        RETURN;
    END;
    ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Job_t)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := V2U_Util.TimestampNullCmp(job_timestamp, other.job_timestamp);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(job_host, other.job_host);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(job_user, other.job_user);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Util.StrNullIcmp(job_name, other.job_name);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
