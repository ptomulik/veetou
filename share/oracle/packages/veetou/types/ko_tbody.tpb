CREATE OR REPLACE TYPE BODY V2u_Ko_Tbody_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Tbody_t(
          SELF IN OUT NOCOPY V2u_Ko_Tbody_t
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
