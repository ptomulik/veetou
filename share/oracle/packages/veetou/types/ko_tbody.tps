CREATE OR REPLACE TYPE Veetou_Ko_Tbody_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , remark VARCHAR(256)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Tbody_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Tbody_Typ
            , id NUMBER := NULL
            , remark VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION cat_attribs RETURN VARCHAR
    );
/
CREATE OR REPLACE TYPE Veetou_Ko_Tbodies_Typ
    AS TABLE OF Veetou_Ko_Tbody_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
