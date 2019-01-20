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

    , ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Job_Typ)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE Veetou_Ko_Jobs_Typ
    AS TABLE OF Veetou_Ko_Job_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
