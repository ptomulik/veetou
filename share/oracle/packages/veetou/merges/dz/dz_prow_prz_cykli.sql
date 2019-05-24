MERGE INTO v2u_dz_prow_prz_cykli tgt
USING dz_prowadzacy_przedmioty_cykli src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , prz_kod
        , cdyd_kod
        , prac_id
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        )
    VALUES
        ( src.id
        , src.prz_kod
        , src.cdyd_kod
        , src.prac_id
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        )
WHEN MATCHED THEN
    UPDATE SET
--          id
--        ,
          tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.prac_id = src.prac_id
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
