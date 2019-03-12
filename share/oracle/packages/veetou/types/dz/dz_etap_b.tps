CREATE OR REPLACE TYPE V2u_Dz_Etap_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( kod VARCHAR2(20 CHAR)
    , opis VARCHAR2(200 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , description VARCHAR2(200 CHAR)


    , CONSTRUCTOR FUNCTION V2u_Dz_Etap_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_B_t
            , kod IN VARCHAR2
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , description IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Etap_B_t
            , kod IN VARCHAR2
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , description IN VARCHAR2
            )
    )
NOT INSTANTIABLE NOT FINAL;
/

-- vim: set ft=sql ts=4 sw=4 et:
