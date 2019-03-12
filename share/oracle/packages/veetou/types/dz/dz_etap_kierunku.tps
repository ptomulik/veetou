CREATE OR REPLACE TYPE V2u_Dz_Etap_Kierunku_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Etap_Kierunku_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Etap_Kierunku_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Kierunku_t
            , krstd_kod IN VARCHAR2
            , etp_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Etapy_Kierunkow_t
    AS TABLE OF V2u_Dz_Etap_Kierunku_t;
/

-- vim: set ft=sql ts=4 sw=4 et:
