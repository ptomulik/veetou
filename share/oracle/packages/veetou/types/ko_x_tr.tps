CREATE OR REPLACE TYPE V2u_Ko_X_Tr_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , tr V2u_Ko_Tr_t
    , page V2u_Ko_Page_t
    , header V2u_Ko_Header_t
    , preamble V2u_Ko_Preamble_t
    , tbody V2u_Ko_Tbody_t
    , footer V2u_Ko_Footer_t
    , sheet V2u_Ko_Sheet_t
    , report V2u_Ko_Report_t

    , CONSTRUCTOR FUNCTION V2u_Ko_X_Tr_t(
              SELF IN OUT NOCOPY V2u_Ko_X_Tr_t
            , job_uuid RAW
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
    );
/
CREATE OR REPLACE TYPE V2u_Ko_X_Trs_t
    AS TABLE OF V2u_Ko_X_Tr_t;

-- vim: set ft=sql ts=4 sw=4 et:
