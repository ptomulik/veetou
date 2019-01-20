CREATE OR REPLACE TYPE Veetou_Ko_Page_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( page_number NUMBER(10)
    , parser_page_number NUMBER(10)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Page_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Page_Typ
            , page_number NUMBER := NULL
            , parser_page_number NUMBER := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION hex_cat RETURN VARCHAR
    );
/
CREATE OR REPLACE TYPE Veetou_Ko_Pages_Typ
    AS TABLE OF Veetou_Ko_Page_Typ;

-- vim: set ft=sql ts=4 sw=4 et: