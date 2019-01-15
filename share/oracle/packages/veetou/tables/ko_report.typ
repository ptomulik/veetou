CREATE OR REPLACE TYPE Veetou_Ko_Report_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( source VARCHAR(512 CHAR)
    , datetime TIMESTAMP
    , first_page NUMBER(16)
    , sheets_parsed NUMBER(16)
    , pages_parsed NUMBER(16)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Report_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Report_Typ
            , source VARCHAR := NULL
            , datetime TIMESTAMP := NULL
            , first_page NUMBER := NULL
            , sheets_parsed NUMBER := NULL
            , pages_parsed NUMBER := NULL
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Report_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Report_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Report_Typ
        , source VARCHAR := NULL
        , datetime TIMESTAMP := NULL
        , first_page NUMBER := NULL
        , sheets_parsed NUMBER := NULL
        , pages_parsed NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.source := source;
        SELF.datetime := datetime;
        SELF.first_page := first_page;
        SELF.sheets_parsed := sheets_parsed;
        SELF.pages_parsed := pages_parsed;
        RETURN;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
