CREATE OR REPLACE TYPE BODY V2u_Ux_Etap_Osoby_t AS
    CONSTRUCTOR FUNCTION V2u_Ux_Etap_Osoby_t(
              SELF IN OUT NOCOPY V2u_Ux_Etap_Osoby_t
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
            , job_uuid IN RAW
            , safe_to_add INTEGER
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
            , safe_to_add => safe_to_add
            );
            RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ux_Etap_Osoby_t
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
            , job_uuid IN RAW
            , safe_to_add INTEGER
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
        SELF.safe_to_add := safe_to_add;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
