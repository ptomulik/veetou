CREATE OR REPLACE TYPE V2u_Ko_Tbody_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , remark VARCHAR2(256)

    , CONSTRUCTOR FUNCTION V2u_Ko_Tbody_t(
              SELF IN OUT NOCOPY V2u_Ko_Tbody_t
            , job_uuid IN RAW
            , id IN NUMBER
            , remark IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION rawpk RETURN RAW
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Tbodies_t
    AS TABLE OF V2u_Ko_Tbody_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
