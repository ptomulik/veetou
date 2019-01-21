CREATE OR REPLACE TYPE Veetou_Ko_Header_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , university VARCHAR(100 CHAR)
    , faculty VARCHAR(100 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Header_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Header_Typ
        , id IN NUMBER := NULL
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        )
        RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION cat_attribs RETURN VARCHAR
--
--    , ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Header_Typ)
--        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE Veetou_Ko_Headers_Typ
    AS TABLE OF Veetou_Ko_Header_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
