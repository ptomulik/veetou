MERGE INTO v2u_dz_zajecia_prz_obcych tgt
USING dz_zajecia_prz_obcych src
ON  (
            tgt.przob_id = src.przob_id
        AND tgt.dec_id = src.dec_id
        AND tgt.tzaj_kod = src.tzaj_kod
    )
WHEN NOT MATCHED THEN
    INSERT
        ( przob_id
        , dec_id
        , tzaj_kod
        , utw_id
        , utw_data
        , ocena
        , liczba_godzin
        , mod_id
        , mod_data
        )
    VALUES
        ( src.przob_id
        , src.dec_id
        , src.tzaj_kod
        , src.utw_id
        , src.utw_data
        , src.ocena
        , src.liczba_godzin
        , src.mod_id
        , src.mod_data
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.ocena = src.ocena
        , tgt.liczba_godzin = src.liczba_godzin
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
