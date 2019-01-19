CREATE OR REPLACE TYPE Veetou_Ko_Tbody_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( remark VARCHAR(256)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Tbody_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Tbody_Typ
            , remark VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION map_fcn RETURN VARCHAR
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Tbody_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Tbody_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Tbody_Typ
        , remark VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.remark := remark;
        RETURN;
    END;

    MAP MEMBER FUNCTION map_fcn
        RETURN VARCHAR
    IS
    BEGIN
        RETURN remark;
    END;
END;
/
CREATE OR REPLACE TYPE Veetou_Ko_Tbodies_Typ
    AS TABLE OF Veetou_Ko_Tbody_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
