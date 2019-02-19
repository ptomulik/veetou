MERGE INTO v2u_dz_zajecia_cykli tgt
USING dz_zajecia_cykli src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , prz_kod
        , cdyd_kod
        , tzaj_kod
        , liczba_godz
        , limit_miejsc
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , waga_pensum
        , tpro_kod
        , efekty_uczenia
        , efekty_uczenia_ang
        , kryteria_oceniania
        , kryteria_oceniania_ang
        , url
        , zakres_tematow
        , zakres_tematow_ang
        , metody_dyd
        , metody_dyd_ang
        , literatura
        , literatura_ang
        , czy_pokazywac_termin
        )
    VALUES
        ( src.id
        , src.prz_kod
        , src.cdyd_kod
        , src.tzaj_kod
        , src.liczba_godz
        , src.limit_miejsc
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.waga_pensum
        , src.tpro_kod
        , src.efekty_uczenia
        , src.efekty_uczenia_ang
        , src.kryteria_oceniania
        , src.kryteria_oceniania_ang
        , src.url
        , src.zakres_tematow
        , src.zakres_tematow_ang
        , src.metody_dyd
        , src.metody_dyd_ang
        , src.literatura
        , src.literatura_ang
        , src.czy_pokazywac_termin
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.tzaj_kod = src.tzaj_kod
        , tgt.liczba_godz = src.liczba_godz
        , tgt.limit_miejsc = src.limit_miejsc
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.waga_pensum = src.waga_pensum
        , tgt.tpro_kod = src.tpro_kod
        , tgt.efekty_uczenia = src.efekty_uczenia
        , tgt.efekty_uczenia_ang = src.efekty_uczenia_ang
        , tgt.kryteria_oceniania = src.kryteria_oceniania
        , tgt.kryteria_oceniania_ang = src.kryteria_oceniania_ang
        , tgt.url = src.url
        , tgt.zakres_tematow = src.zakres_tematow
        , tgt.zakres_tematow_ang = src.zakres_tematow_ang
        , tgt.metody_dyd = src.metody_dyd
        , tgt.metody_dyd_ang = src.metody_dyd_ang
        , tgt.literatura = src.literatura
        , tgt.literatura_ang = src.literatura_ang
        , tgt.czy_pokazywac_termin = src.czy_pokazywac_termin
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
