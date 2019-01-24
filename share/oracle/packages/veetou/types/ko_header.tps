CREATE OR REPLACE TYPE V2u_Ko_Header_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , university VARCHAR(100 CHAR)
    , faculty VARCHAR(100 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Header_t(
          SELF IN OUT NOCOPY V2u_Ko_Header_t
        , job_uuid IN RAW
        , id IN NUMBER
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        )
        RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION rawpk RETURN RAW
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Headers_t
    AS TABLE OF V2u_Ko_Header_t;
/
CREATE OR REPLACE TYPE V2u_Ko_Header_Refs_t
    AS TABLE OF REF V2u_Ko_Header_t;

-- vim: set ft=sql ts=4 sw=4 et:
