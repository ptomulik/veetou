CREATE OR REPLACE TYPE BODY Veetou_Ko_Sheet_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Sheet_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Sheet_Typ
        , id NUMBER := NULL
        , pages_parsed NUMBER := NULL
        , first_page NUMBER := NULL
        , ects_mandatory NUMBER := NULL
        , ects_other NUMBER := NULL
        , ects_total NUMBER := NULL
        , ects_attained NUMBER := NULL
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
        RETURN  VEETOU_Util.To_CharMap(first_page, 'S0XXXXXXXX', ifnull=>'          ')
                || '|' ||
                VEETOU_Util.To_CharMap(pages_parsed, 'S0XX', ifnull=>'    ')
                || '|' ||
                VEETOU_Util.To_CharMap(ects_mandatory, 'S0XXX', ifnull=>'     ')
                || '|' ||
                VEETOU_Util.To_CharMap(ects_other, 'S0XXX', ifnull=>'     ')
                || '|' ||
                VEETOU_Util.To_CharMap(ects_total, 'S0XXX', ifnull=>'     ')
                || '|' ||
                VEETOU_Util.To_CharMap(ects_attained, 'S0XXX', ifnull=>'     ');
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
