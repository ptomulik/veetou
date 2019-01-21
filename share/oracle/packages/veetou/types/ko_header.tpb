CREATE OR REPLACE TYPE BODY Veetou_Ko_Header_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Header_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Header_Typ
        , id IN NUMBER := NULL
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        )
        RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.university := university;
        SELF.faculty := faculty;
        RETURN;
    END;

    MAP MEMBER FUNCTION cat_attribs
        RETURN VARCHAR
    IS
    BEGIN
        RETURN VEETOU_Util.To_CharMap(university, 100)
                || '|' ||
                faculty;
    END;

--    ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Header_Typ)
--        RETURN NUMBER
--    IS
--        ord NUMBER;
--    BEGIN
--        ord := VEETOU_Util.StrNullIcmp(university, other.university);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        RETURN VEETOU_Util.StrNullIcmp(faculty, other.faculty);
--    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
