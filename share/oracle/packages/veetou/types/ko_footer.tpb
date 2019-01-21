CREATE OR REPLACE TYPE BODY Veetou_Ko_Footer_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Footer_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Footer_Typ
        , id IN NUMBER := NULL
        , pagination IN VARCHAR := NULL
        , sheet_page_number IN NUMBER := NULL
        , sheet_pages_total IN NUMBER := NULL
        , generator_name IN VARCHAR := NULL
        , generator_home IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.pagination := pagination;
        SELF.sheet_page_number := sheet_page_number;
        SELF.sheet_pages_total := sheet_pages_total;
        SELF.generator_name := generator_name;
        SELF.generator_home := generator_home;
        RETURN;
    END;

--    MAP MEMBER FUNCTION cat_attribs RETURN VARCHAR
--    IS
--    BEGIN
--        RETURN  VEETOU_Util.To_CharMap(sheet_page_number, 'S09', ifnull=>'   ')
--                || '|' ||
--                VEETOU_Util.To_CharMap(sheet_pages_total, 'S09', ifnull=>'   ')
--                || '|' ||
--                VEETOU_Util.To_CharMap(pagination,  5)
--                || '|' ||
--                VEETOU_Util.To_CharMap(generator_name, 100)
--                || '|' ||
--                generator_home;
--    END;

    ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Footer_Typ)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := VEETOU_Util.StrNullIcmp(sheet_page_number, other.sheet_page_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(sheet_pages_total, other.sheet_pages_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(pagination, other.pagination);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(generator_name, other.generator_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN VEETOU_Util.StrNullIcmp(generator_home, other.generator_home);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
