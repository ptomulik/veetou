CREATE OR REPLACE TYPE V2u_Ko_Sheet_Hdr_Preamble_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , sheet REF V2u_Ko_Sheet_t
    , header REF V2u_Ko_Header_t
    , preamble REF V2u_Ko_Preamble_t
    , page_ids V2u_Ko_5Ids_t
    , distinct_headers_count NUMBER(2)
    , distinct_preambles_count NUMBER(2)

    , CONSTRUCTOR FUNCTION V2u_Ko_Sheet_Hdr_Preamble_t(
              SELF IN OUT NOCOPY V2u_Ko_Sheet_Hdr_Preamble_t
            , job_uuid IN RAW
            , id IN NUMBER
            , sheet IN REF V2u_Ko_Sheet_t
            , header IN REF V2u_Ko_Header_t
            , preamble IN REF V2u_Ko_Preamble_t
            , page_ids IN V2u_Ko_5Ids_t
            , distinct_headers_count IN NUMBER := NULL
            , distinct_preambles_count IN NUMBER := NULL
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Sheet_Hdr_Preambles_t
    AS TABLE OF V2u_Ko_Sheet_Hdr_Preamble_t;

-- vim: set ft=sql ts=4 sw=4 et:
