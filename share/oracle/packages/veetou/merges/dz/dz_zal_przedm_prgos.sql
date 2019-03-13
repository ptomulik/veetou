MERGE INTO v2u_dz_zal_przedm_prgos tgt
USING dz_zal_przedm_prgos src
ON  (
            tgt.prgos_id = src.prgos_id
        AND tgt.cdyd_kod = src.cdyd_kod
        AND tgt.prz_kod = src.prz_kod
    )
WHEN NOT MATCHED THEN
    INSERT
        ( os_id
        , prz_kod
        , cdyd_kod
        , prgos_id
        , stan
        , utw_id
        , utw_data
        , etpos_id
        , mod_id
        , mod_data
        , do_sredniej
        , do_sredniej_zmiana_os_id
        , do_sredniej_zmiana_data
        , podp_data
        , podp_os_id
        , czy_platny_ects_ustawa
        , kto_placi
        , podp_etpos_data
        , podp_etpos_os_id
        , katprz_id
        , pw_ponadprogramowy
        )
    VALUES
        ( src.os_id
        , src.prz_kod
        , src.cdyd_kod
        , src.prgos_id
        , src.stan
        , src.utw_id
        , src.utw_data
        , src.etpos_id
        , src.mod_id
        , src.mod_data
        , src.do_sredniej
        , src.do_sredniej_zmiana_os_id
        , src.do_sredniej_zmiana_data
        , src.podp_data
        , src.podp_os_id
        , src.czy_platny_ects_ustawa
        , src.kto_placi
        , src.podp_etpos_data
        , src.podp_etpos_os_id
        , src.katprz_id
        , src.pw_ponadprogramowy
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.os_id = src.os_id
        , tgt.stan = src.stan
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.etpos_id = src.etpos_id
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.do_sredniej = src.do_sredniej
        , tgt.do_sredniej_zmiana_os_id = src.do_sredniej_zmiana_os_id
        , tgt.do_sredniej_zmiana_data = src.do_sredniej_zmiana_data
        , tgt.podp_data = src.podp_data
        , tgt.podp_os_id = src.podp_os_id
        , tgt.czy_platny_ects_ustawa = src.czy_platny_ects_ustawa
        , tgt.kto_placi = src.kto_placi
        , tgt.podp_etpos_data = src.podp_etpos_data
        , tgt.podp_etpos_os_id = src.podp_etpos_os_id
        , tgt.katprz_id = src.katprz_id
        , tgt.pw_ponadprogramowy = src.pw_ponadprogramowy
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
