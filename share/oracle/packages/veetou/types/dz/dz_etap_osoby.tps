CREATE OR REPLACE TYPE V2u_Dz_Etap_Osoby_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Etap_Osoby_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Etap_Osoby_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Osoby_t
            , id NUMBER
            , data_zakon DATE
            , utw_id VARCHAR2
            , utw_data DATE
            , mod_id VARCHAR2
            , mod_data DATE
            , status_zaliczenia VARCHAR2
            , etp_kod VARCHAR2
            , prg_kod VARCHAR2
            , prgos_id NUMBER
            , cdyd_kod VARCHAR2
            , status_zal_komentarz VARCHAR2
            , liczba_war NUMBER
            , wym_cdyd_kod VARCHAR2
            , czy_platny_na_2_kier VARCHAR2
            , ects_uzyskane NUMBER
            , czy_przedluzenie VARCHAR2
            , urlop_kod VARCHAR2
            , ects_efekty_uczenia NUMBER
            , ects_przepisane NUMBER
            , kolejnosc NUMBER
            , czy_erasmus VARCHAR2
            , jedn_dyplomujaca VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Etapy_Osob_t
    AS TABLE OF V2u_Dz_Etap_Osoby_t;
/

-- vim: set ft=sql ts=4 sw=4 et:
