CREATE OR REPLACE TYPE BODY V2u_Dz_Pracownik_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Pracownik_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Pracownik_B_t
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
    IS
    BEGIN
        SELF.init(
              id => id
            , os_id => os_id
            , pierwsze_zatr => pierwsze_zatr
            , nr_akt => nr_akt
            , nr_karty => nr_karty
            , telefon1 => telefon1
            , telefon2 => telefon2
            , badania_okresowe => badania_okresowe
            , kons_do_zmiany => kons_do_zmiany
            , konsultacje => konsultacje
            , zainteresowania => zainteresowania
            , zainteresowania_ang => zainteresowania_ang
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , emerytura_data => emerytura_data
            , data_nadania_tytulu => data_nadania_tytulu
            , aktywny => aktywny
            , data_przeswietlenia => data_przeswietlenia
            , sl_id => sl_id
            , tytul_ddz_id => tytul_ddz_id
            , data_szkolenia_bhp => data_szkolenia_bhp
            , tytul_szk_id => tytul_szk_id
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Pracownik_B_t
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
        )
    IS
    BEGIN
        SELF.id := id;
        SELF.os_id := os_id;
        SELF.pierwsze_zatr := pierwsze_zatr;
        SELF.nr_akt := nr_akt;
        SELF.nr_karty := nr_karty;
        SELF.telefon1 := telefon1;
        SELF.telefon2 := telefon2;
        SELF.badania_okresowe := badania_okresowe;
        SELF.kons_do_zmiany := kons_do_zmiany;
        SELF.konsultacje := konsultacje;
        SELF.zainteresowania := zainteresowania;
        SELF.zainteresowania_ang := zainteresowania_ang;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.emerytura_data := emerytura_data;
        SELF.data_nadania_tytulu := data_nadania_tytulu;
        SELF.aktywny := aktywny;
        SELF.data_przeswietlenia := data_przeswietlenia;
        SELF.sl_id := sl_id;
        SELF.tytul_ddz_id := tytul_ddz_id;
        SELF.data_szkolenia_bhp := data_szkolenia_bhp;
        SELF.tytul_szk_id := tytul_szk_id;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
