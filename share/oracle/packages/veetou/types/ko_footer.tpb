CREATE OR REPLACE TYPE BODY V2u_Ko_Footer_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Footer_t(
          SELF IN OUT NOCOPY V2u_Ko_Footer_t
        , job_uuid IN RAW
        , id IN NUMBER
        , pagination IN VARCHAR := NULL
        , sheet_page_number IN NUMBER := NULL
        , sheet_pages_total IN NUMBER := NULL
        , generator_name IN VARCHAR := NULL
        , generator_home IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.pagination := pagination;
        SELF.sheet_page_number := sheet_page_number;
        SELF.sheet_pages_total := sheet_pages_total;
        SELF.generator_name := generator_name;
        SELF.generator_home := generator_home;
        RETURN;
    END;

    MAP MEMBER FUNCTION rawpk
        RETURN RAW
    IS
    BEGIN
        RETURN UTL_RAW.CONCAT(UTL_RAW.CAST_FROM_NUMBER(id), job_uuid);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
