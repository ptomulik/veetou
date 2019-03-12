CREATE OR REPLACE TYPE V2u_Dz_Etap_Kierunku_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( krstd_kod VARCHAR2(20 CHAR)
    , etp_kod VARCHAR2(20 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE

    , CONSTRUCTOR FUNCTION V2u_Dz_Etap_Kierunku_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Kierunku_B_t
            , krstd_kod IN VARCHAR2
            , etp_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Kierunku_B_t
            , krstd_kod IN VARCHAR2
            , etp_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            )
    )
NOT INSTANTIABLE NOT FINAL;
/

-- vim: set ft=sql ts=4 sw=4 et:
