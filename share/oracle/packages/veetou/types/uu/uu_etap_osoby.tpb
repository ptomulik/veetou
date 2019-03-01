CREATE OR REPLACE TYPE BODY V2u_Uu_Etap_Osoby_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Etap_Osoby_t(
              SELF IN OUT NOCOPY V2u_Uu_Etap_Osoby_t
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
            , job_uuid IN RAW
            , is_missing IN INTEGER
            , safe_to_add IN NUMBER
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
            , job_uuid => job_uuid
            , is_missing => is_missing
            , safe_to_add => safe_to_add
            );
            RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Etap_Osoby_t
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
            , job_uuid IN RAW
            , is_missing IN INTEGER
            , safe_to_add IN NUMBER
            )
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
        SELF.job_uuid := job_uuid;
        SELF.is_missing := is_missing;
        SELF.safe_to_add := safe_to_add;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et: