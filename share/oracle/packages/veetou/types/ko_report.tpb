CREATE OR REPLACE TYPE BODY V2u_Ko_Report_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Report_t(
          SELF IN OUT NOCOPY V2u_Ko_Report_t
        , id NUMBER := NULL
        , source VARCHAR := NULL
        , datetime TIMESTAMP := NULL
        , first_page NUMBER := NULL
        , sheets_parsed NUMBER := NULL
        , pages_parsed NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.source := source;
        SELF.datetime := datetime;
        SELF.first_page := first_page;
        SELF.sheets_parsed := sheets_parsed;
        SELF.pages_parsed := pages_parsed;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Report_t)
        RETURN NUMBER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Util.StrNullCmp(source, other.source);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.TimestampNullCmp(datetime, other.datetime);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(first_page, other.first_page);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Util.NumNullCmp(pages_parsed, other.pages_parsed);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
