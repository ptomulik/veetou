CREATE OR REPLACE TYPE V2u_Dz_Etap_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Etap_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Etap_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_t
            , kod IN VARCHAR2
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , description IN VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Etapy_t
    AS TABLE OF V2u_Dz_Etap_t;
/

-- vim: set ft=sql ts=4 sw=4 et:
