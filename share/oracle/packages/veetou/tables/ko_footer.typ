CREATE OR REPLACE TYPE Veetou_Ko_Footer_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( pagination VARCHAR(32 CHAR)
    , sheet_page_number NUMBER(2)
    , sheet_pages_total NUMBER(2)
    , generator_name VARCHAR(256 CHAR)
    , generator_home VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Footer_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Footer_Typ
            , pagination IN VARCHAR := NULL
            , sheet_page_number IN NUMBER := NULL
            , sheet_pages_total IN NUMBER := NULL
            , generator_name IN VARCHAR := NULL
            , generator_home IN VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_attribs(other IN Veetou_Ko_Footer_Typ)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Footer_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Footer_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Footer_Typ
        , pagination IN VARCHAR := NULL
        , sheet_page_number IN NUMBER := NULL
        , sheet_pages_total IN NUMBER := NULL
        , generator_name IN VARCHAR := NULL
        , generator_home IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.pagination := pagination;
        SELF.sheet_page_number := sheet_page_number;
        SELF.sheet_pages_total := sheet_pages_total;
        SELF.generator_name := generator_name;
        SELF.generator_home := generator_home;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_attribs(other IN Veetou_Ko_Footer_Typ)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := VEETOU_Util.StrNullIcmp(pagination, other.pagination);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(sheet_page_number, other.sheet_page_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(sheet_pages_total, other.sheet_pages_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(generator_name, other.generator_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN VEETOU_Util.StrNullIcmp(generator_home, other.generator_home);
    END;
END;
/
CREATE OR REPLACE TYPE Veetou_Ko_Footers_Typ
    AS TABLE OF Veetou_Ko_Footer_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
