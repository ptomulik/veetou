CREATE OR REPLACE TYPE V2u_Ko_Specialty_Instance_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR2(256 CHAR)
    , studies_field VARCHAR2(256 CHAR)
    , studies_specialty VARCHAR2(256 CHAR)
--    , sheet_ids V2u_Ko_Ids_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Instance_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Instance_t
            , job_uuid IN RAW
            , id IN NUMBER := NULL
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
--            , sheet_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , MEMBER FUNCTION dup_with(
              new_id IN NUMBER := NULL
--            , new_sheet_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Specialty_Instance_t

    , MEMBER FUNCTION dup_with(
              new_id_seq IN VARCHAR2
--            , new_sheet_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Specialty_Instance_t

    , ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Specialty_Instance_t)
            RETURN INTEGER
    );

-- vim: set ft=sql ts=4 sw=4 et:
