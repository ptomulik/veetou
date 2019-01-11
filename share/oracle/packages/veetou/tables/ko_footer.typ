CREATE OR REPLACE TYPE Veetou_Ko_Footer_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , pagination VARCHAR(32 CHAR)
    , sheet_page_number NUMBER(16)
    , sheet_pages_total NUMBER(16)
    , generator_name VARCHAR(256 CHAR)
    , generator_home VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Footer_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Footer_Typ
            , job_uuid IN RAW := NULL
            , id IN NUMBER := NULL
            , pagination IN VARCHAR := NULL
            , sheet_page_number IN NUMBER := NULL
            , sheet_pages_total IN NUMBER := NULL
            , generator_name IN VARCHAR := NULL
            , generator_home IN VARCHAR := NULL
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Footer_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Footer_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Footer_Typ
        , job_uuid IN RAW := NULL
        , id IN NUMBER := NULL
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
END;
-- vim: set ft=sql ts=4 sw=4 et:
