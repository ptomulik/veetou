CREATE OR REPLACE TYPE Veetou_Ko_Report_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( source VARCHAR(512 CHAR)
    , datetime TIMESTAMP
    , first_page NUMBER(10)
    , sheets_parsed NUMBER(10)
    , pages_parsed NUMBER(10)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Report_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Report_Typ
            , source VARCHAR := NULL
            , datetime TIMESTAMP := NULL
            , first_page NUMBER := NULL
            , sheets_parsed NUMBER := NULL
            , pages_parsed NUMBER := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_attribs(other IN Veetou_Ko_Report_Typ)
        RETURN NUMBER
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
    ORDER MEMBER FUNCTION cmp_attribs(other IN Veetou_Ko_Report_Typ)
        RETURN NUMBER
    IS
        ord INTEGER;
    BEGIN
        ord := VEETOU_Util.StrNullCmp(source, other.source);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.TimestampNullCmp(datetime, other.datetime);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(first_page, other.first_page);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN VEETOU_Util.NumNullCmp(pages_parsed, other.pages_parsed);
    END;
END;
/
CREATE OR REPLACE TYPE Veetou_Ko_Reports_Typ
    AS TABLE OF Veetou_Ko_Report_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
