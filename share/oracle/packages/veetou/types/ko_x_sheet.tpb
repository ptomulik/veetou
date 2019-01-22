CREATE OR REPLACE TYPE BODY V2u_Ko_X_Sheet_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_X_Sheet_t(
          SELF IN OUT NOCOPY V2u_Ko_X_Sheet_t
        , job_uuid IN RAW
        , id IN NUMBER
        , sheet IN V2u_Ko_Sheet_t
        , pages IN V2u_Ko_Pages_t
        , header IN V2u_Ko_Header_t
        , preamble IN V2u_Ko_Preamble_t
        , report IN V2u_Ko_Report_t
        , distinct_headers_count IN NUMBER
        , distinct_preambles_count IN NUMBER
        , distinct_reports_count IN NUMBER
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.sheet := sheet;
        SELF.pages := pages;
        SELF.header := header;
        SELF.preamble := preamble;
        SELF.report := report;
        SELF.distinct_headers_count := distinct_headers_count;
        SELF.distinct_preambles_count := distinct_preambles_count;
        SELF.distinct_reports_count := distinct_reports_count;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
