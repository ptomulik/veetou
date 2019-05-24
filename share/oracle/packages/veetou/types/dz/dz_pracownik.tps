CREATE OR REPLACE TYPE V2u_Dz_Pracownik_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Pracownik_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Pracownik_t(
              SELF IN OUT NOCOPY V2u_Dz_Pracownik_t
            , id IN NUMBER
            , os_id IN NUMBER
            , pierwsze_zatr IN VARCHAR2
            , nr_akt IN NUMBER
            , nr_karty IN VARCHAR2
            , telefon1 IN VARCHAR2
            , telefon2 IN VARCHAR2
            , badania_okresowe IN DATE
            , kons_do_zmiany IN VARCHAR2
            , konsultacje IN VARCHAR2
            , zainteresowania IN VARCHAR2
            , zainteresowania_ang IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , emerytura_data IN DATE
            , data_nadania_tytulu IN DATE
            , aktywny IN VARCHAR2
            , data_przeswietlenia IN DATE
            , sl_id IN NUMBER
            , tytul_ddz_id IN NUMBER
            , data_szkolenia_bhp IN DATE
            , tytul_szk_id IN NUMBER
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Pracownicy_t
    AS TABLE OF V2u_Dz_Pracownik_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
