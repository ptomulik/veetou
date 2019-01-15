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
END;

-- vim: set ft=sql ts=4 sw=4 et:
