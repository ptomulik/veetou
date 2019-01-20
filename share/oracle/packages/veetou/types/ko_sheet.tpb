CREATE OR REPLACE TYPE BODY Veetou_Ko_Sheet_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Sheet_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Sheet_Typ
        , pages_parsed NUMBER := NULL
        , first_page NUMBER := NULL
        , ects_mandatory NUMBER := NULL
        , ects_other NUMBER := NULL
        , ects_total NUMBER := NULL
        , ects_attained NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.pages_parsed := pages_parsed;
        SELF.first_page := first_page;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.ects_attained := ects_attained;
        RETURN;
    END;

    MAP MEMBER FUNCTION hex_cat
        RETURN VARCHAR
    IS
    BEGIN
        RETURN TO_CHAR(pages_parsed, '0XX') || '|' ||
               TO_CHAR(first_page, '0XXXXXXXX') || '|' ||
               TO_CHAR(ects_mandatory, '0XXX') || '|' ||
               TO_CHAR(ects_other, '0XXX') || '|' ||
               TO_CHAR(ects_total, '0XXX') || '|' ||
               TO_CHAR(ects_attained, '0XXX');
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
