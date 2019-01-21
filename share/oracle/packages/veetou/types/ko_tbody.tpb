CREATE OR REPLACE TYPE BODY Veetou_Ko_Tbody_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Tbody_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Tbody_Typ
        , id NUMBER := NULL
        , remark VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.remark := remark;
        RETURN;
    END;

    MAP MEMBER FUNCTION cat_attribs
        RETURN VARCHAR
    IS
    BEGIN
        RETURN remark;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
