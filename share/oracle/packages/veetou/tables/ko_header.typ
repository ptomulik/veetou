CREATE OR REPLACE TYPE Veetou_Ko_Header_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( university VARCHAR(256 CHAR)
    , faculty VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Header_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Header_Typ
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        )
        RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_attribs(other IN Veetou_Ko_Header_Typ)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Header_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Header_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Header_Typ
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        )
        RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := university;
        SELF.faculty := faculty;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_attribs(other IN Veetou_Ko_Header_Typ)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := VEETOU_Util.StrNullIcmp(university, other.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN VEETOU_Util.StrNullIcmp(faculty, other.faculty);
    END;
END;
/
CREATE OR REPLACE TYPE Veetou_Ko_Headers_Typ
    AS TABLE OF Veetou_Ko_Header_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
