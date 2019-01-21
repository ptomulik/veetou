CREATE OR REPLACE TYPE BODY V2u_Ko_Sheet_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Sheet_t(
          SELF IN OUT NOCOPY V2u_Ko_Sheet_t
        , id IN NUMBER
        , pages_parsed IN NUMBER := NULL
        , first_page IN NUMBER := NULL
        , ects_mandatory IN NUMBER := NULL
        , ects_other IN NUMBER := NULL
        , ects_total IN NUMBER := NULL
        , ects_attained IN NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.pages_parsed := pages_parsed;
        SELF.first_page := first_page;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.ects_attained := ects_attained;
        RETURN;
    END;

    MAP MEMBER FUNCTION cat_attribs
        RETURN VARCHAR
    IS
    BEGIN
        RETURN  V2U_Util.To_CharMap(first_page, 'S0XXXXXXXX', ifnull=>'          ')
                || '|' ||
                V2U_Util.To_CharMap(pages_parsed, 'S0XX', ifnull=>'    ')
                || '|' ||
                V2U_Util.To_CharMap(ects_mandatory, 'S0XXX', ifnull=>'     ')
                || '|' ||
                V2U_Util.To_CharMap(ects_other, 'S0XXX', ifnull=>'     ')
                || '|' ||
                V2U_Util.To_CharMap(ects_total, 'S0XXX', ifnull=>'     ')
                || '|' ||
                V2U_Util.To_CharMap(ects_attained, 'S0XXX', ifnull=>'     ');
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
