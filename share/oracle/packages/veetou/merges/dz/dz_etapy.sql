MERGE INTO v2u_dz_etapy tgt
USING dz_etapy src
ON  (tgt.kod = src.kod)
WHEN NOT MATCHED THEN
    INSERT
        ( kod
        , opis
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , description
        )
VALUES
        ( src.kod
        , src.opis
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.description
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.opis = src.opis
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.description = src.description
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
