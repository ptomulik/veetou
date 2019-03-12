CREATE OR REPLACE TYPE V2u_Dz_Etap_Osoby_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Etap_Osoby_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Etap_Osoby_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Osoby_t
            , id IN NUMBER
            , data_zakon IN DATE
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , status_zaliczenia IN VARCHAR2
            , etp_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , prgos_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , status_zal_komentarz IN VARCHAR2
            , liczba_war IN NUMBER
            , wym_cdyd_kod IN VARCHAR2
            , czy_platny_na_2_kier IN VARCHAR2
            , ects_uzyskane IN NUMBER
            , czy_przedluzenie IN VARCHAR2
            , urlop_kod IN VARCHAR2
            , ects_efekty_uczenia IN NUMBER
            , ects_przepisane IN NUMBER
            , kolejnosc IN NUMBER
            , czy_erasmus IN VARCHAR2
            , jedn_dyplomujaca IN VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Etapy_Osob_t
    AS TABLE OF V2u_Dz_Etap_Osoby_t;
/

-- vim: set ft=sql ts=4 sw=4 et:
