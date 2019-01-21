CREATE OR REPLACE TYPE BODY V2u_Ko_Footer_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Footer_t(
          SELF IN OUT NOCOPY V2u_Ko_Footer_t
        , id IN NUMBER
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
--        RETURN  V2U_Util.To_CharMap(sheet_page_number, 'S09', ifnull=>'   ')
--                || '|' ||
--                V2U_Util.To_CharMap(sheet_pages_total, 'S09', ifnull=>'   ')
--                || '|' ||
--                V2U_Util.To_CharMap(pagination,  5)
--                || '|' ||
--                V2U_Util.To_CharMap(generator_name, 100)
--                || '|' ||
--                generator_home;
--    END;

    ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Footer_t)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := V2U_Util.StrNullIcmp(sheet_page_number, other.sheet_page_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(sheet_pages_total, other.sheet_pages_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(pagination, other.pagination);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(generator_name, other.generator_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Util.StrNullIcmp(generator_home, other.generator_home);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
