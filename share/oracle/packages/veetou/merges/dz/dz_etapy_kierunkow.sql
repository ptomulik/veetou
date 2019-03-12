MERGE INTO v2u_dz_etapy_kierunkow tgt
USING dz_etapy_kierunkow src
ON  (
            tgt.krstd_kod = src.krstd_kod
        AND tgt.etp_kod = src.etp_kod
    )
WHEN NOT MATCHED THEN
    INSERT
        ( krstd_kod
        , etp_kod
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        )
VALUES
        ( src.krstd_kod
        , src.etp_kod
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
