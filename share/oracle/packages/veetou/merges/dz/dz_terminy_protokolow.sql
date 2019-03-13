MERGE INTO v2u_dz_terminy_protokolow tgt
USING dz_terminy_protokolow src
ON  (
            tgt.prot_id = src.prot_id
        AND tgt.nr = src.nr
    )
WHEN NOT MATCHED THEN
    INSERT
        ( prot_id
        , nr
        , status
        , utw_id
        , utw_data
        , opis
        , data_zwrotu
        , mod_id
        , mod_data
        , egzamin_komisyjny
        )
VALUES
        ( src.prot_id
        , src.nr
        , src.status
        , src.utw_id
        , src.utw_data
        , src.opis
        , src.data_zwrotu
        , src.mod_id
        , src.mod_data
        , src.egzamin_komisyjny
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.status = src.status
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.opis = src.opis
        , tgt.data_zwrotu = src.data_zwrotu
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.egzamin_komisyjny = src.egzamin_komisyjny
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
