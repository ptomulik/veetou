CREATE OR REPLACE TYPE BODY V2u_Ko_Tbody_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Tbody_t(
          SELF IN OUT NOCOPY V2u_Ko_Tbody_t
        , job_uuid IN RAW
        , id IN NUMBER
        , remark IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
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
