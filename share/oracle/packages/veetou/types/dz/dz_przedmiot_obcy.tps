CREATE OR REPLACE TYPE V2u_Dz_Przedmiot_Obcy_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Przedmiot_Obcy_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Przedmiot_Obcy_t(
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
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Przedmioty_Obce_t
    AS TABLE OF V2u_Dz_Przedmiot_Obcy_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
