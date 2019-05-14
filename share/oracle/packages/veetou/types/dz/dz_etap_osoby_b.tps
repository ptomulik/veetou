CREATE OR REPLACE TYPE V2u_Dz_Etap_Osoby_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(10)
    , data_zakon DATE
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , status_zaliczenia VARCHAR2(1 CHAR)
    , etp_kod VARCHAR2(20 CHAR)
    , prg_kod VARCHAR2(20 CHAR)
    , prgos_id NUMBER(10)
    , cdyd_kod VARCHAR2(20 CHAR)
    , status_zal_komentarz VARCHAR2(1000 CHAR)
    , liczba_war NUMBER(10)
    , wym_cdyd_kod VARCHAR2(20 CHAR)
    , czy_platny_na_2_kier VARCHAR2(1 CHAR)
    , ects_uzyskane NUMBER(5,2)
    , czy_przedluzenie VARCHAR2(1 CHAR)
    , urlop_kod VARCHAR2(1 CHAR)
    , ects_efekty_uczenia NUMBER(5,2)
    , ects_przepisane NUMBER(5,2)
    , kolejnosc NUMBER(2)
    , czy_erasmus VARCHAR2(1 CHAR)
    , jedn_dyplomujaca VARCHAR2(20 CHAR)


    , CONSTRUCTOR FUNCTION V2u_Dz_Etap_Osoby_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Osoby_B_t
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

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Osoby_B_t
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
            )
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
