CREATE OR REPLACE TYPE BODY V2u_Ko_Page_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Page_t(
          SELF IN OUT NOCOPY V2u_Ko_Page_t
        , job_uuid IN RAW
        , id IN NUMBER
        , page_number IN NUMBER := NULL
        , parser_page_number IN NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.page_number := page_number;
        SELF.parser_page_number := parser_page_number;
        RETURN;
    END;

    MAP MEMBER FUNCTION rawpk
        RETURN RAW
    IS
    BEGIN
        RETURN UTL_RAW.CONCAT(UTL_RAW.CAST_FROM_NUMBER(id), job_uuid);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
