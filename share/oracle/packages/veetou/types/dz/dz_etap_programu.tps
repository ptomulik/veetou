CREATE OR REPLACE TYPE V2u_Dz_Etap_Programu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Etap_Programu_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Etap_Programu_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Programu_t
            , prg_kod IN VARCHAR2
            , etp_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , nr_roku IN NUMBER
            , pierwszy_etap IN VARCHAR2
            , tcdyd_kod IN VARCHAR2
            , liczba_war IN NUMBER
            , czy_wyswietlac IN VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Etapy_Programow_t
    AS TABLE OF V2u_Dz_Etap_Programu_t;
/

-- vim: set ft=sql ts=4 sw=4 et:
