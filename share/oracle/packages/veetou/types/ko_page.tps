CREATE OR REPLACE TYPE V2u_Ko_Page_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , page_number NUMBER(10)
    , parser_page_number NUMBER(10)

    , CONSTRUCTOR FUNCTION V2u_Ko_Page_t(
              SELF IN OUT NOCOPY V2u_Ko_Page_t
            , job_uuid IN RAW
            , id IN NUMBER
            , page_number IN NUMBER := NULL
            , parser_page_number IN NUMBER := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION cat_attribs RETURN VARCHAR
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Pages_t
    AS TABLE OF V2u_Ko_Page_t;

-- vim: set ft=sql ts=4 sw=4 et:
