MERGE INTO v2u_dz_decyzje tgt
USING dz_decyzje src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , prgos_id
        , etp_kod
        , cdyd_kod
        , data_decyzji
        , stan
        , utw_id
        , utw_data
        , termin_do_modyfikacji
        , komentarz
        , nast_etp_kod
        , mod_id
        , mod_data
        , rodzaj
        , wyj_id
        , pod_stan
        , utw_la_data
        , elmo_id_blobbox
        )
VALUES
        ( src.id
        , src.prgos_id
        , src.etp_kod
        , src.cdyd_kod
        , src.data_decyzji
        , src.stan
        , src.utw_id
        , src.utw_data
        , src.termin_do_modyfikacji
        , src.komentarz
        , src.nast_etp_kod
        , src.mod_id
        , src.mod_data
        , src.rodzaj
        , src.wyj_id
        , src.pod_stan
        , src.utw_la_data
        , src.elmo_id_blobbox
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.prgos_id = src.prgos_id
        , tgt.etp_kod = src.etp_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.data_decyzji = src.data_decyzji
        , tgt.stan = src.stan
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.termin_do_modyfikacji = src.termin_do_modyfikacji
        , tgt.komentarz = src.komentarz
        , tgt.nast_etp_kod = src.nast_etp_kod
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.rodzaj = src.rodzaj
        , tgt.wyj_id = src.wyj_id
        , tgt.pod_stan = src.pod_stan
        , tgt.utw_la_data = src.utw_la_data
        , tgt.elmo_id_blobbox = src.elmo_id_blobbox
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
