CREATE OR REPLACE TYPE BODY V2u_Ko_Tr_Hdr_Preamb_H_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Tr_Hdr_Preamb_H_t(
          SELF IN OUT NOCOPY V2u_Ko_Tr_Hdr_Preamb_H_t
        , job_uuid IN RAW
        , id IN NUMBER
        , tr IN REF V2u_Ko_Tr_t
        , header IN REF V2u_Ko_Header_t
        , preamble IN REF V2u_Ko_Preamble_t
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.tr := tr;
        SELF.header := header;
        SELF.preamble := preamble;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
