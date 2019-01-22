CREATE OR REPLACE TYPE V2u_Ko_X_Sheet_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( sheet REF V2u_Ko_Sheet_t
    , pages V2u_Ko_Page_Refs_t
    , header REF V2u_Ko_Header_t
    , preamble REF V2u_Ko_Preamble_t
    , report REF V2u_Ko_Report_t
    , distinct_headers_count NUMBER(38)
    , distinct_preambles_count NUMBER(38)
    , distinct_reports_count NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Ko_X_Sheet_t(
              SELF IN OUT NOCOPY V2u_Ko_X_Sheet_t
            , sheet IN REF V2u_Ko_Sheet_t
            , pages IN V2u_Ko_Page_Refs_t
            , header IN REF V2u_Ko_Header_t
            , preamble IN REF V2u_Ko_Preamble_t
            , report IN REF V2u_Ko_Report_t
            , distinct_headers_count IN NUMBER
            , distinct_preambles_count IN NUMBER
            , distinct_reports_count IN NUMBER
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Ko_X_Sheets_t
    AS TABLE OF V2u_Ko_X_Sheet_t;

-- vim: set ft=sql ts=4 sw=4 et:
