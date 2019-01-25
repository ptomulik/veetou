CREATE OR REPLACE TYPE V2u_Ko_X_Tr_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , tr REF V2u_Ko_Tr_t
    , page REF V2u_Ko_Page_t
    , header REF V2u_Ko_Header_t
    , preamble REF V2u_Ko_Preamble_t
    , tbody REF V2u_Ko_Tbody_t
    , footer REF V2u_Ko_Footer_t
    , sheet REF V2u_Ko_Sheet_t
    , report REF V2u_Ko_Report_t

    , CONSTRUCTOR FUNCTION V2u_Ko_X_Tr_t(
              SELF IN OUT NOCOPY V2u_Ko_X_Tr_t
            , job_uuid RAW
            , id IN NUMBER
            , tr IN REF V2u_Ko_Tr_t
            , page IN REF V2u_Ko_Page_t
            , header IN REF V2u_Ko_Header_t
            , preamble IN REF V2u_Ko_Preamble_t
            , tbody IN REF V2u_Ko_Tbody_t
            , footer IN REF V2u_Ko_Footer_t
            , sheet IN REF V2u_Ko_Sheet_t
            , report IN REF V2u_Ko_Report_t
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Ko_X_Trs_t
    AS TABLE OF V2u_Ko_X_Tr_t;

-- vim: set ft=sql ts=4 sw=4 et:
