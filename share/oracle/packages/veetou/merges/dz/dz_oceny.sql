MERGE INTO v2u_dz_oceny tgt
USING dz_oceny src
ON  (
            tgt.os_id = src.os_id
        AND tgt.prot_id = src.prot_id
        AND tgt.term_prot_nr = src.term_prot_nr
    )
WHEN NOT MATCHED THEN
    INSERT
        ( os_id
        , komentarz_pub
        , komentarz_pryw
        , toc_kod
        , wart_oc_kolejnosc
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , prot_id
        , term_prot_nr
        , zmiana_os_id
        , zmiana_data
        , pos_komi_id
        )
VALUES
        ( src.os_id
        , src.komentarz_pub
        , src.komentarz_pryw
        , src.toc_kod
        , src.wart_oc_kolejnosc
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.prot_id
        , src.term_prot_nr
        , src.zmiana_os_id
        , src.zmiana_data
        , src.pos_komi_id
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.komentarz_pub = src.komentarz_pub
        , tgt.komentarz_pryw = src.komentarz_pryw
        , tgt.toc_kod = src.toc_kod
        , tgt.wart_oc_kolejnosc = src.wart_oc_kolejnosc
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.zmiana_os_id = src.zmiana_os_id
        , tgt.zmiana_data = src.zmiana_data
        , tgt.pos_komi_id = src.pos_komi_id
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
