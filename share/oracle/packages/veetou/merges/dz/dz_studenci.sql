MERGE INTO v2u_dz_studenci tgt
USING dz_studenci src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , indeks
        , jed_org_kod
        , typ_ind_kod
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , os_id
        , indeks_glowny
        )
    VALUES
        ( src.id
        , src.indeks
        , src.jed_org_kod
        , src.typ_ind_kod
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.os_id
        , src.indeks_glowny
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.indeks = src.indeks
        , tgt.jed_org_kod = src.jed_org_kod
        , tgt.typ_ind_kod = src.typ_ind_kod
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.os_id = src.os_id
        , tgt.indeks_glowny = src.indeks_glowny
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
