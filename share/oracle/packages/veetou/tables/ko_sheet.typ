CREATE OR REPLACE TYPE Veetou_Ko_Sheet_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( pages_parsed NUMBER(4)
    , first_page NUMBER(16)
    , ects_mandatory NUMBER(16)
    , ects_other NUMBER(16)
    , ects_total NUMBER(16)
    , ects_attained NUMBER(16)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Sheet_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Sheet_Typ
            , pages_parsed NUMBER := NULL
            , first_page NUMBER := NULL
            , ects_mandatory NUMBER := NULL
            , ects_other NUMBER := NULL
            , ects_total NUMBER := NULL
            , ects_attained NUMBER := NULL
            ) RETURN SELF AS RESULT
    );
/
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
END;

-- vim: set ft=sql ts=4 sw=4 et:
