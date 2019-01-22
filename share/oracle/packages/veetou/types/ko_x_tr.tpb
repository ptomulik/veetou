CREATE OR REPLACE TYPE BODY V2u_Ko_X_Tr_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_X_Tr_t(
          SELF IN OUT NOCOPY V2u_Ko_X_Tr_t
        , job_uuid IN RAW
        , id IN NUMBER
        , tr IN V2u_Ko_Tr_t
        , page IN V2u_Ko_Page_t
        , header IN V2u_Ko_Header_t
        , preamble IN V2u_Ko_Preamble_t
        , tbody IN V2u_Ko_Tbody_t
        , footer IN V2u_Ko_Footer_t
        , sheet IN V2u_Ko_Sheet_t
        , report IN V2u_Ko_Report_t
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.tr := tr;
        SELF.page := page;
        SELF.header := header;
        SELF.preamble := preamble;
        SELF.tbody := tbody;
        SELF.footer := footer;
        SELF.sheet := sheet;
        SELF.report := report;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
