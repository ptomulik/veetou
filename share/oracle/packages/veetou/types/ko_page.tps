CREATE OR REPLACE TYPE V2u_Ko_Page_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , page_number NUMBER(10)
    , parser_page_number NUMBER(10)

    , CONSTRUCTOR FUNCTION V2u_Ko_Page_t(
              SELF IN OUT NOCOPY V2u_Ko_Page_t
            , id NUMBER := NULL
            , page_number NUMBER := NULL
            , parser_page_number NUMBER := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION cat_attribs RETURN VARCHAR
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Pages_t
    AS TABLE OF V2u_Ko_Page_t;

-- vim: set ft=sql ts=4 sw=4 et:
