CREATE OR REPLACE TYPE V2u_Ko_Job_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_timestamp TIMESTAMP
    , job_host VARCHAR(32 CHAR)
    , job_user VARCHAR(32 CHAR)
    , job_name VARCHAR(32 CHAR)


    , CONSTRUCTOR FUNCTION V2u_Ko_Job_t(
              SELF IN OUT NOCOPY V2u_Ko_Job_t
            , job_timestamp IN TIMESTAMP := NULL
            , job_host IN VARCHAR := NULL
            , job_user IN VARCHAR := NULL
            , job_name IN VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Job_t)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Jobs_t
    AS TABLE OF V2u_Ko_Job_t;

-- vim: set ft=sql ts=4 sw=4 et:
