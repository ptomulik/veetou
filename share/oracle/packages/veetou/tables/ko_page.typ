CREATE OR REPLACE TYPE Veetou_Ko_Page_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , page_number NUMBER(16)
    , parser_page_number NUMBER(16)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Page_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Page_Typ
            , job_uuid IN RAW := NULL
            , id NUMBER := NULL
            , page_number NUMBER := NULL
            , parser_page_number NUMBER := NULL
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Page_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Page_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Page_Typ
        , job_uuid IN RAW := NULL
        , id NUMBER := NULL
        , page_number NUMBER := NULL
        , parser_page_number NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.page_number := page_number;
        SELF.parser_page_number := parser_page_number;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
