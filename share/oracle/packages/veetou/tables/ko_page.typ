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
CREATE OR REPLACE TYPE BODY Veetou_Ko_Page_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Page_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Page_Typ
        , page_number NUMBER := NULL
        , parser_page_number NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.page_number := page_number;
        SELF.parser_page_number := parser_page_number;
        RETURN;
    END;

    MAP MEMBER FUNCTION hex_cat
        RETURN VARCHAR
    IS
    BEGIN
        RETURN TO_CHAR(page_number, '0XXXXXXXXX') || '|' ||
               TO_CHAR(parser_page_number, '0XXXXXXXXX');
    END;
END;
/
CREATE OR REPLACE TYPE Veetou_Ko_Pages_Typ
    AS TABLE OF Veetou_Ko_Page_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
