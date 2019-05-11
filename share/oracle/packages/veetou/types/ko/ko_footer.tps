CREATE OR REPLACE TYPE V2u_Ko_Footer_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , pagination VARCHAR2(5 CHAR)
    , sheet_page_number NUMBER(2)
    , sheet_pages_total NUMBER(2)
    , generator_name VARCHAR2(100 CHAR)
    , generator_home VARCHAR2(100 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Footer_t(
              SELF IN OUT NOCOPY V2u_Ko_Footer_t
            , job_uuid IN RAW
            , id IN NUMBER
            , pagination IN VARCHAR2 := NULL
            , sheet_page_number IN NUMBER := NULL
            , sheet_pages_total IN NUMBER := NULL
            , generator_name IN VARCHAR2 := NULL
            , generator_home IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION rawpk RETURN RAW
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Footers_t
    AS TABLE OF V2u_Ko_Footer_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
