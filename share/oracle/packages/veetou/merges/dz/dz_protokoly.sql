MERGE INTO v2u_dz_protokoly tgt
USING dz_protokoly src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN
    INSERT
        ( zaj_cyk_id
        , opis
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , tpro_kod
        , id
        , prz_kod
        , cdyd_kod
        , czy_do_sredniej
        , edycja
        , opis_ang
        )
    VALUES
        ( src.zaj_cyk_id
        , src.opis
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.tpro_kod
        , src.id
        , src.prz_kod
        , src.cdyd_kod
        , src.czy_do_sredniej
        , src.edycja
        , src.opis_ang
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.zaj_cyk_id = src.zaj_cyk_id
        , tgt.opis = src.opis
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.tpro_kod = src.tpro_kod
        , tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.czy_do_sredniej = src.czy_do_sredniej
        , tgt.edycja = src.edycja
        , tgt.opis_ang = src.opis_ang
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
