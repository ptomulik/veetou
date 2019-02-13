MERGE INTO v2u_dz_przedmioty_cykli tgt
USING dz_przedmioty_cykli src
ON  (tgt.prz_kod = src.prz_kod AND tgt.cdyd_kod = src.cdyd_kod)
WHEN NOT MATCHED THEN INSERT
    ( prz_kod
    , cdyd_kod
    , utw_id
    , utw_data
    , mod_id
    , mod_data
    , tpro_kod
    , uczestnicy
    , url
    , uwagi
    , notes
    , literatura
    , literatura_ang
    , opis
    , opis_ang
    , skrocony_opis
    , skrocony_opis_ang
    , status_sylabusu
    , guid
    )
VALUES
    ( src.prz_kod
    , src.cdyd_kod
    , src.utw_id
    , src.utw_data
    , src.mod_id
    , src.mod_data
    , src.tpro_kod
    , src.uczestnicy
    , src.url
    , src.uwagi
    , src.notes
    , src.literatura
    , src.literatura_ang
    , src.opis
    , src.opis_ang
    , src.skrocony_opis
    , src.skrocony_opis_ang
    , src.status_sylabusu
    , src.guid
    )
WHEN MATCHED THEN UPDATE SET
      tgt.utw_id = src.utw_id
    , tgt.utw_data = src.utw_data
    , tgt.mod_id = src.mod_id
    , tgt.mod_data = src.mod_data
    , tgt.tpro_kod = src.tpro_kod
    , tgt.uczestnicy = src.uczestnicy
    , tgt.url = src.url
    , tgt.uwagi = src.uwagi
    , tgt.notes = src.notes
    , tgt.literatura = src.literatura
    , tgt.literatura_ang = src.literatura_ang
    , tgt.opis = src.opis
    , tgt.opis_ang = src.opis_ang
    , tgt.skrocony_opis = src.skrocony_opis
    , tgt.skrocony_opis_ang = src.skrocony_opis_ang
    , tgt.status_sylabusu = src.status_sylabusu
    , tgt.guid = src.guid
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
