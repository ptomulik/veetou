CREATE OR REPLACE TYPE BODY V2u_Ko_X_Sheet_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_X_Sheet_t(
          SELF IN OUT NOCOPY V2u_Ko_X_Sheet_t
        , job_uuid IN RAW
        , id IN NUMBER
        , sheet IN REF V2u_Ko_Sheet_t
        , page_ids IN V2u_Ko_X_Sheet_Pages_t
        , header IN REF V2u_Ko_Header_t
        , preamble IN REF V2u_Ko_Preamble_t
        , footer_ids IN V2u_Ko_X_Sheet_Footers_t
        , report IN REF V2u_Ko_Report_t
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.sheet := sheet;
        SELF.page_ids := page_ids;
        SELF.header := header;
        SELF.preamble := preamble;
        SELF.footer_ids := footer_ids;
        SELF.report := report;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
