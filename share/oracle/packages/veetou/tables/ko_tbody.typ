CREATE OR REPLACE TYPE Veetou_Ko_Tbody_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , remark VARCHAR(256)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Tbody_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Tbody_Typ
            , job_uuid IN RAW := NULL
            , id IN NUMBER := NULL
            , remark VARCHAR := NULL
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Tbody_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Tbody_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Tbody_Typ
        , job_uuid IN RAW := NULL
        , id IN NUMBER := NULL
        , remark VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.remark := remark;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
