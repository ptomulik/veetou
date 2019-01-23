CREATE OR REPLACE TYPE BODY V2u_Ko_X_Sheet_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_X_Sheet_t(
          SELF IN OUT NOCOPY V2u_Ko_X_Sheet_t
        , job_uuid IN RAW
        , id IN NUMBER
        , sheet IN V2u_Ko_Sheet_t
        , pages IN V2u_Ko_Pages_t
        , header IN V2u_Ko_Header_t
        , preamble IN V2u_Ko_Preamble_t
        , footers IN V2u_Ko_Footers_t
        , report IN V2u_Ko_Report_t
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.sheet := sheet;
        SELF.pages := pages;
        SELF.header := header;
        SELF.preamble := preamble;
        SELF.footers := footers;
        SELF.report := report;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
