CREATE OR REPLACE TYPE V2u_Ko_Tr_Hdr_Preamb_H_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , tr V2u_Ko_Tr_t
    , header V2u_Ko_Header_t
    , preamble V2u_Ko_Preamble_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Tr_Hdr_Preamb_H_t(
              SELF IN OUT NOCOPY V2u_Ko_Tr_Hdr_Preamb_H_t
            , job_uuid IN RAW
            , id IN NUMBER
            , tr IN V2u_Ko_Tr_t
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Tr_Hdr_Preambs_H_t
    AS TABLE OF V2u_Ko_Tr_Hdr_Preamb_H_t;

-- vim: set ft=sql ts=4 sw=4 et:
