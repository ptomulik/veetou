CREATE OR REPLACE TYPE V2u_Ko_Specialty_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Distinct_t
    ( university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , sheet_ids V2u_Ids_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Specialty_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Specialty_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , MEMBER FUNCTION dup(new_sheet_ids IN V2u_Ids_t := NULL)
            RETURN V2u_Ko_Specialty_t

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
            RETURN INTEGER
    );
/
-- vim: set ft=sql ts=4 sw=4 et:
