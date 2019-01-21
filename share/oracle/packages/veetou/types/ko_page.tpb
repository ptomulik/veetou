CREATE OR REPLACE TYPE BODY V2u_Ko_Page_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Page_t(
          SELF IN OUT NOCOPY V2u_Ko_Page_t
        , id NUMBER := NULL
        , page_number NUMBER := NULL
        , parser_page_number NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.page_number := page_number;
        SELF.parser_page_number := parser_page_number;
        RETURN;
    END;

    MAP MEMBER FUNCTION cat_attribs
        RETURN VARCHAR
    IS
    BEGIN
        RETURN V2U_Util.To_CharMap(page_number, 'S0XXXXXXXXX',
                                         ifnull => '           ')
               || '|' ||
               V2U_Util.To_CharMap(parser_page_number, 'S0XXXXXXXXX',
                                                ifnull => '           ');
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
