CREATE OR REPLACE TYPE BODY V2u_Ko_Sh_Hdr_Preamb_H_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Sh_Hdr_Preamb_H_t(
          SELF IN OUT NOCOPY V2u_Ko_Sh_Hdr_Preamb_H_t
        , job_uuid IN RAW
        , id IN NUMBER
        , sheet IN REF V2u_Ko_Sheet_t
        , header IN REF V2u_Ko_Header_t
        , preamble IN REF V2u_Ko_Preamble_t
        , page_ids IN V2u_Ko_5Ids_t
        , distinct_headers_count IN NUMBER := NULL
        , distinct_preambles_count IN NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.sheet := sheet;
        SELF.header := header;
        SELF.preamble := preamble;
        SELF.page_ids := page_ids;
        SELF.distinct_headers_count := distinct_headers_count;
        SELF.distinct_preambles_count := distinct_preambles_count;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
