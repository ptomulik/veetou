MERGE INTO v2u_dz_punkty_przedmiotow tgt
USING v2u_dx_punkty_przedmiotow src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN
    INSERT
        ( prz_kod
        , prg_kod
        , tpkt_kod
        , ilosc
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , id
        , cdyd_pocz
        , cdyd_kon
        )
    VALUES
        ( src.prz_kod
        , src.prg_kod
        , src.tpkt_kod
        , src.ilosc
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.id
        , src.cdyd_pocz
        , src.cdyd_kon
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.prz_kod = src.prz_kod
        , tgt.prg_kod = src.prg_kod
        , tgt.tpkt_kod = src.tpkt_kod
        , tgt.ilosc = src.ilosc
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.cdyd_pocz = src.cdyd_pocz
        , tgt.cdyd_kon = src.cdyd_kon
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
