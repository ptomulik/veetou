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

    , ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Footer_Typ)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE Veetou_Ko_Footers_Typ
    AS TABLE OF Veetou_Ko_Footer_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
