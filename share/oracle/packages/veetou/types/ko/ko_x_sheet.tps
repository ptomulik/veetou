CREATE OR REPLACE TYPE V2u_Ko_X_Sheet_Pages_t AS VARRAY(5) OF NUMBER(38);
/
CREATE OR REPLACE TYPE V2u_Ko_X_Sheet_Footers_t AS VARRAY(5) OF NUMBER(38);
/
CREATE OR REPLACE TYPE V2u_Ko_X_Sheet_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , sheet REF V2u_Ko_Sheet_t
    , page_ids V2u_Ko_X_Sheet_Pages_t
    , header REF V2u_Ko_Header_t
    , preamble REF V2u_Ko_Preamble_t
    , footer_ids V2u_Ko_X_Sheet_Footers_t
    , report REF V2u_Ko_Report_t

    , CONSTRUCTOR FUNCTION V2u_Ko_X_Sheet_t(
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
    );
/
CREATE OR REPLACE TYPE V2u_Ko_X_Sheets_t
    AS TABLE OF V2u_Ko_X_Sheet_t;

-- vim: set ft=sql ts=4 sw=4 et:
