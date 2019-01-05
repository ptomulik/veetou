CREATE OR REPLACE TYPE V2u_Dz_Przedmiot_Obcy_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(10)
    , dec_id NUMBER(10)
    , nazwa VARCHAR2(200 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , czy_zaliczony VARCHAR2(1 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , ocena VARCHAR2(10 CHAR)
    , nazwa_ang VARCHAR2(200 CHAR)
    , kod VARCHAR2(20 CHAR)
    , liczba_punktow NUMBER(12,2)
    , liczba_ocen NUMBER(12,2)
    , suma_ocen NUMBER(12,2)
    , prowadzacy VARCHAR2(100 CHAR)
    , komentarz VARCHAR2(500 CHAR)
    , szk_id NUMBER(10)
    , szkola VARCHAR2(200 CHAR)
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , status VARCHAR2(1 CHAR)
    , jzk_kod VARCHAR2(3 CHAR)
    , data_anulowania_akceptacji DATE
    , zmiana_os_id NUMBER(10)
    , zmiana_data DATE
    , czy_platny_ects_ustawa VARCHAR2(1 CHAR)
    , kto_placi VARCHAR2(1 CHAR)
    , katprz_id NUMBER(10)
    , do_sredniej VARCHAR2(1 CHAR)
    , tzmian_przob_id_dod NUMBER(10)
    , opis_zmiany_dod VARCHAR2(200 CHAR)
    , tzmian_przob_id_usun NUMBER(10)
    , opis_zmiany_usun VARCHAR2(200 CHAR)
    , przob_id NUMBER(10)
    , url VARCHAR2(500 CHAR)
    , nazwa_pol VARCHAR2(200 CHAR)
    , komentarz_zajec VARCHAR2(2000 CHAR)
    , komentarz_ocen VARCHAR2(2000 CHAR)
    , rozklad_ocen VARCHAR2(2000 CHAR)
    , los_id_ewp VARCHAR2(64 CHAR)
    , loi_id_ewp VARCHAR2(64 CHAR)
    , pw_ponadprogramowy VARCHAR2(1 CHAR)
    , pw_czy_egzamin VARCHAR2(1 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Dz_Przedmiot_Obcy_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Przedmiot_Obcy_B_t
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

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Przedmiot_Obcy_B_t
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
            )
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
