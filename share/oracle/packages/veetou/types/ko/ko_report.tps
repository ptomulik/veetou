CREATE OR REPLACE TYPE V2u_Ko_Report_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , source VARCHAR2(512 CHAR)
    , datetime TIMESTAMP
    , first_page NUMBER(10)
    , sheets_parsed NUMBER(10)
    , pages_parsed NUMBER(10)

    , CONSTRUCTOR FUNCTION V2u_Ko_Report_t(
              SELF IN OUT NOCOPY V2u_Ko_Report_t
            , job_uuid IN RAW
            , id IN NUMBER
            , source IN VARCHAR2 := NULL
            , datetime IN TIMESTAMP := NULL
            , first_page IN NUMBER := NULL
            , sheets_parsed IN NUMBER := NULL
            , pages_parsed IN NUMBER := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION rawpk RETURN RAW
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Reports_t
    AS TABLE OF V2u_Ko_Report_t;

-- vim: set ft=sql ts=4 sw=4 et:
