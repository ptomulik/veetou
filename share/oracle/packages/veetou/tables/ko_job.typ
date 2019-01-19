CREATE OR REPLACE TYPE Veetou_Ko_Job_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_timestamp TIMESTAMP
    , job_host VARCHAR(32 CHAR)
    , job_user VARCHAR(32 CHAR)
    , job_name VARCHAR(32 CHAR)


    , CONSTRUCTOR FUNCTION Veetou_Ko_Job_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Job_Typ
            , job_timestamp TIMESTAMP := NULL
            , job_host VARCHAR := NULL
            , job_user VARCHAR := NULL
            , job_name VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_attribs(other IN Veetou_Ko_Job_Typ)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Job_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Job_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Job_Typ
        , job_timestamp TIMESTAMP := NULL
        , job_host VARCHAR := NULL
        , job_user VARCHAR := NULL
        , job_name VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_timestamp := job_timestamp;
        SELF.job_host := job_host;
        SELF.job_user := job_user;
        SELF.job_name := job_name;
        RETURN;
    END;
    ORDER MEMBER FUNCTION cmp_attribs(other IN Veetou_Ko_Job_Typ)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := VEETOU_Util.TimestampNullCmp(job_timestamp, other.job_timestamp);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(job_host, other.job_host);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(job_user, other.job_user);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN VEETOU_Util.StrNullIcmp(job_name, other.job_name);
    END;
END;
/
CREATE OR REPLACE TYPE Veetou_Ko_Jobs_Typ
    AS TABLE OF Veetou_Ko_Job_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
