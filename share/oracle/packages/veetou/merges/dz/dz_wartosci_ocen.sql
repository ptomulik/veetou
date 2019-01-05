MERGE INTO v2u_dz_wartosci_ocen tgt
USING dz_wartosci_ocen src
ON  (
            tgt.toc_kod = src.toc_kod
        AND tgt.kolejnosc = src.kolejnosc
    )
WHEN NOT MATCHED THEN
    INSERT
        ( kolejnosc
        , toc_kod
        , opis
        , czy_zal
        , wartosc
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , description
        , opis_oceny
        , czy_dwoja_reg
        )
VALUES
        ( src.kolejnosc
        , src.toc_kod
        , src.opis
        , src.czy_zal
        , src.wartosc
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.description
        , src.opis_oceny
        , src.czy_dwoja_reg
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.opis = src.opis
        , tgt.czy_zal = src.czy_zal
        , tgt.wartosc = src.wartosc
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.description = src.description
        , tgt.opis_oceny = src.opis_oceny
        , tgt.czy_dwoja_reg = src.czy_dwoja_reg
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
