MERGE INTO v2u_dz_grupy tgt
USING dz_grupy src
ON  (
            tgt.nr = src.nr
        AND tgt.zaj_cyk_id = src.zaj_cyk_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( nr
        , zaj_cyk_id
        , limit_miejsc
        , utw_id
        , utw_data
        , mod_data
        , mod_id
        , gr_nr
        , gr_zaj_cyk_id
        , opis
        , waga_pensum
        , zakres_tematow
        , zakres_tematow_ang
        , metody_dyd
        , metody_dyd_ang
        , literatura
        , literatura_ang
        , url
        , opis_ang
        , dolny_limit_miejsc
        , kryteria_oceniania
        , kryteria_oceniania_ang
        )
    VALUES
        ( src.nr
        , src.zaj_cyk_id
        , src.limit_miejsc
        , src.utw_id
        , src.utw_data
        , src.mod_data
        , src.mod_id
        , src.gr_nr
        , src.gr_zaj_cyk_id
        , src.opis
        , src.waga_pensum
        , src.zakres_tematow
        , src.zakres_tematow_ang
        , src.metody_dyd
        , src.metody_dyd_ang
        , src.literatura
        , src.literatura_ang
        , src.url
        , src.opis_ang
        , src.dolny_limit_miejsc
        , src.kryteria_oceniania
        , src.kryteria_oceniania_ang
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.limit_miejsc = src.limit_miejsc
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_data = src.mod_data
        , tgt.mod_id = src.mod_id
        , tgt.gr_nr = src.gr_nr
        , tgt.gr_zaj_cyk_id = src.gr_zaj_cyk_id
        , tgt.opis = src.opis
        , tgt.waga_pensum = src.waga_pensum
        , tgt.zakres_tematow = src.zakres_tematow
        , tgt.zakres_tematow_ang = src.zakres_tematow_ang
        , tgt.metody_dyd = src.metody_dyd
        , tgt.metody_dyd_ang = src.metody_dyd_ang
        , tgt.literatura = src.literatura
        , tgt.literatura_ang = src.literatura_ang
        , tgt.url = src.url
        , tgt.opis_ang = src.opis_ang
        , tgt.dolny_limit_miejsc = src.dolny_limit_miejsc
        , tgt.kryteria_oceniania = src.kryteria_oceniania
        , tgt.kryteria_oceniania_ang = src.kryteria_oceniania_ang
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
