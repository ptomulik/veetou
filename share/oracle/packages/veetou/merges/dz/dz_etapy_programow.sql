MERGE INTO v2u_dz_etapy_programow tgt
USING dz_etapy_programow src
ON  (
            tgt.prg_kod = src.prg_kod
        AND tgt.etp_kod = src.etp_kod
    )
WHEN NOT MATCHED THEN
    INSERT
        ( prg_kod
        , etp_kod
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , nr_roku
        , pierwszy_etap
        , tcdyd_kod
        , liczba_war
        , czy_wyswietlac
        )
VALUES
        ( src.prg_kod
        , src.etp_kod
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.nr_roku
        , src.pierwszy_etap
        , src.tcdyd_kod
        , src.liczba_war
        , src.czy_wyswietlac
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.nr_roku = src.nr_roku
        , tgt.pierwszy_etap = src.pierwszy_etap
        , tgt.tcdyd_kod = src.tcdyd_kod
        , tgt.liczba_war = src.liczba_war
        , tgt.czy_wyswietlac = src.czy_wyswietlac
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
