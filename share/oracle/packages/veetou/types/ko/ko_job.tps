CREATE OR REPLACE TYPE V2u_Ko_Job_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , job_timestamp TIMESTAMP
    , job_host VARCHAR2(32 CHAR)
    , job_user VARCHAR2(32 CHAR)
    , job_name VARCHAR2(32 CHAR)


    , CONSTRUCTOR FUNCTION V2u_Ko_Job_t(
              SELF IN OUT NOCOPY V2u_Ko_Job_t
            , job_uuid IN RAW
            , job_timestamp IN TIMESTAMP := NULL
            , job_host IN VARCHAR2 := NULL
            , job_user IN VARCHAR2 := NULL
            , job_name IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION rawpk RETURN RAW
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Jobs_t
    AS TABLE OF V2u_Ko_Job_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
