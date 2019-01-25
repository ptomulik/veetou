CREATE OR REPLACE TYPE BODY V2u_Ko_Report_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Report_t(
          SELF IN OUT NOCOPY V2u_Ko_Report_t
        , job_uuid IN RAW
        , id IN NUMBER
        , source IN VARCHAR2 := NULL
        , datetime IN TIMESTAMP := NULL
        , first_page IN NUMBER := NULL
        , sheets_parsed IN NUMBER := NULL
        , pages_parsed IN NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.source := source;
        SELF.datetime := datetime;
        SELF.first_page := first_page;
        SELF.sheets_parsed := sheets_parsed;
        SELF.pages_parsed := pages_parsed;
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
