CREATE OR REPLACE TYPE BODY V2u_Dz_Przedmiot_Obcy_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Przedmiot_Obcy_t(
              SELF IN OUT NOCOPY V2u_Dz_Przedmiot_Obcy_t
            , id IN NUMBER
            , dec_id IN NUMBER
            , nazwa IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , czy_zaliczony IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , ocena IN VARCHAR2
            , nazwa_ang IN VARCHAR2
            , kod IN VARCHAR2
            , liczba_punktow IN NUMBER
            , liczba_ocen IN NUMBER
            , suma_ocen IN NUMBER
            , prowadzacy IN VARCHAR2
            , komentarz IN VARCHAR2
            , szk_id IN NUMBER
            , szkola IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , status IN VARCHAR2
            , jzk_kod IN VARCHAR2
            , data_anulowania_akceptacji IN DATE
            , zmiana_os_id IN NUMBER
            , zmiana_data IN DATE
            , czy_platny_ects_ustawa IN VARCHAR2
            , kto_placi IN VARCHAR2
            , katprz_id IN NUMBER
            , do_sredniej IN VARCHAR2
            , tzmian_przob_id_dod IN NUMBER
            , opis_zmiany_dod IN VARCHAR2
            , tzmian_przob_id_usun IN NUMBER
            , opis_zmiany_usun IN VARCHAR2
            , przob_id IN NUMBER
            , url IN VARCHAR2
            , nazwa_pol IN VARCHAR2
            , komentarz_zajec IN VARCHAR2
            , komentarz_ocen IN VARCHAR2
            , rozklad_ocen IN VARCHAR2
            , los_id_ewp IN VARCHAR2
            , loi_id_ewp IN VARCHAR2
            , pw_ponadprogramowy IN VARCHAR2
            , pw_czy_egzamin IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , dec_id => dec_id
            , nazwa => nazwa
            , cdyd_kod => cdyd_kod
            , czy_zaliczony => czy_zaliczony
            , utw_id => utw_id
            , utw_data => utw_data
            , ocena => ocena
            , nazwa_ang => nazwa_ang
            , kod => kod
            , liczba_punktow => liczba_punktow
            , liczba_ocen => liczba_ocen
            , suma_ocen => suma_ocen
            , prowadzacy => prowadzacy
            , komentarz => komentarz
            , szk_id => szk_id
            , szkola => szkola
            , mod_id => mod_id
            , mod_data => mod_data
            , status => status
            , jzk_kod => jzk_kod
            , data_anulowania_akceptacji => data_anulowania_akceptacji
            , zmiana_os_id => zmiana_os_id
            , zmiana_data => zmiana_data
            , czy_platny_ects_ustawa => czy_platny_ects_ustawa
            , kto_placi => kto_placi
            , katprz_id => katprz_id
            , do_sredniej => do_sredniej
            , tzmian_przob_id_dod => tzmian_przob_id_dod
            , opis_zmiany_dod => opis_zmiany_dod
            , tzmian_przob_id_usun => tzmian_przob_id_usun
            , opis_zmiany_usun => opis_zmiany_usun
            , przob_id => przob_id
            , url => url
            , nazwa_pol => nazwa_pol
            , komentarz_zajec => komentarz_zajec
            , komentarz_ocen => komentarz_ocen
            , rozklad_ocen => rozklad_ocen
            , los_id_ewp => los_id_ewp
            , loi_id_ewp => loi_id_ewp
            , pw_ponadprogramowy => pw_ponadprogramowy
            , pw_czy_egzamin => pw_czy_egzamin
            );
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
