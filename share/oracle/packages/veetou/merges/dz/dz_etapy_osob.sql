MERGE INTO v2u_dz_etapy_osob tgt
USING dz_etapy_osob src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , data_zakon
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , status_zaliczenia
        , etp_kod
        , prg_kod
        , prgos_id
        , cdyd_kod
        , status_zal_komentarz
        , liczba_war
        , wym_cdyd_kod
        , czy_platny_na_2_kier
        , ects_uzyskane
        , czy_przedluzenie
        , urlop_kod
        , ects_efekty_uczenia
        , ects_przepisane
        , kolejnosc
        , czy_erasmus
        , jedn_dyplomujaca
        )
VALUES
        ( src.id
        , src.data_zakon
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.status_zaliczenia
        , src.etp_kod
        , src.prg_kod
        , src.prgos_id
        , src.cdyd_kod
        , src.status_zal_komentarz
        , src.liczba_war
        , src.wym_cdyd_kod
        , src.czy_platny_na_2_kier
        , src.ects_uzyskane
        , src.czy_przedluzenie
        , src.urlop_kod
        , src.ects_efekty_uczenia
        , src.ects_przepisane
        , src.kolejnosc
        , src.czy_erasmus
        , src.jedn_dyplomujaca
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.data_zakon = src.data_zakon
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.status_zaliczenia = src.status_zaliczenia
        , tgt.etp_kod = src.etp_kod
        , tgt.prg_kod = src.prg_kod
        , tgt.prgos_id = src.prgos_id
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.status_zal_komentarz = src.status_zal_komentarz
        , tgt.liczba_war = src.liczba_war
        , tgt.wym_cdyd_kod = src.wym_cdyd_kod
        , tgt.czy_platny_na_2_kier = src.czy_platny_na_2_kier
        , tgt.ects_uzyskane = src.ects_uzyskane
        , tgt.czy_przedluzenie = src.czy_przedluzenie
        , tgt.urlop_kod = src.urlop_kod
        , tgt.ects_efekty_uczenia = src.ects_efekty_uczenia
        , tgt.ects_przepisane = src.ects_przepisane
        , tgt.kolejnosc = src.kolejnosc
        , tgt.czy_erasmus = src.czy_erasmus
        , tgt.jedn_dyplomujaca = src.jedn_dyplomujaca
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
