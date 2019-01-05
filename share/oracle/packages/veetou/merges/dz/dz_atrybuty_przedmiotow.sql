MERGE INTO v2u_dz_atrybuty_przedmiotow tgt
USING dz_atrybuty_przedmiotow src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN
    INSERT
        ( tatr_kod
        , prz_kod
        , wart_lst_id
        , prz_kod_rel
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , wartosc
        , wartosc_ang
        , id
        )
    VALUES
        ( src.tatr_kod
        , src.prz_kod
        , src.wart_lst_id
        , src.prz_kod_rel
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.wartosc
        , src.wartosc_ang
        , src.id
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.tatr_kod = src.tatr_kod
        , tgt.prz_kod = src.prz_kod
        , tgt.wart_lst_id = src.wart_lst_id
        , tgt.prz_kod_rel = src.prz_kod_rel
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.wartosc = src.wartosc
        , tgt.wartosc_ang = src.wartosc_ang
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
