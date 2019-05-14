CREATE OR REPLACE TYPE BODY V2u_Dz_Etap_Osoby_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Etap_Osoby_B_t(
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
    IS
    BEGIN
        SELF.init(
              id => id
            , data_zakon => data_zakon
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , status_zaliczenia => status_zaliczenia
            , etp_kod => etp_kod
            , prg_kod => prg_kod
            , prgos_id => prgos_id
            , cdyd_kod => cdyd_kod
            , status_zal_komentarz => status_zal_komentarz
            , liczba_war => liczba_war
            , wym_cdyd_kod => wym_cdyd_kod
            , czy_platny_na_2_kier => czy_platny_na_2_kier
            , ects_uzyskane => ects_uzyskane
            , czy_przedluzenie => czy_przedluzenie
            , urlop_kod => urlop_kod
            , ects_efekty_uczenia => ects_efekty_uczenia
            , ects_przepisane => ects_przepisane
            , kolejnosc => kolejnosc
            , czy_erasmus => czy_erasmus
            , jedn_dyplomujaca => jedn_dyplomujaca
            );
            RETURN;
    END;


    MEMBER PROCEDURE init(
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
    IS
    BEGIN
        SELF.id := id;
        SELF.data_zakon := data_zakon;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.status_zaliczenia := status_zaliczenia;
        SELF.etp_kod := etp_kod;
        SELF.prg_kod := prg_kod;
        SELF.prgos_id := prgos_id;
        SELF.cdyd_kod := cdyd_kod;
        SELF.status_zal_komentarz := status_zal_komentarz;
        SELF.liczba_war := liczba_war;
        SELF.wym_cdyd_kod := wym_cdyd_kod;
        SELF.czy_platny_na_2_kier := czy_platny_na_2_kier;
        SELF.ects_uzyskane := ects_uzyskane;
        SELF.czy_przedluzenie := czy_przedluzenie;
        SELF.urlop_kod := urlop_kod;
        SELF.ects_efekty_uczenia := ects_efekty_uczenia;
        SELF.ects_przepisane := ects_przepisane;
        SELF.kolejnosc := kolejnosc;
        SELF.czy_erasmus := czy_erasmus;
        SELF.jedn_dyplomujaca := jedn_dyplomujaca;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
