MERGE INTO v2u_dz_osoby_grup tgt
USING dz_osoby_grup src
ON  (
            tgt.gr_nr = src.gr_nr
        AND tgt.os_id = src.os_id
        AND tgt.zaj_cyk_id = src.zaj_cyk_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( gr_nr
        , os_id
        , zaj_cyk_id
        , utw_data
        , utw_id
        , mod_data
        , mod_id
        , rej_data
        , rej_os_id
        )
    VALUES
        ( src.gr_nr
        , src.os_id
        , src.zaj_cyk_id
        , src.utw_data
        , src.utw_id
        , src.mod_data
        , src.mod_id
        , src.rej_data
        , src.rej_os_id
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.utw_data = src.utw_data
        , tgt.utw_id = src.utw_id
        , tgt.mod_data = src.mod_data
        , tgt.mod_id = src.mod_id
        , tgt.rej_data = src.rej_data
        , tgt.rej_os_id = src.rej_os_id
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
