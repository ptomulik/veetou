MERGE INTO v2u_dz_pracownicy tgt
USING dz_pracownicy src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , os_id
        , pierwsze_zatr
        , nr_akt
        , nr_karty
        , telefon1
        , telefon2
        , badania_okresowe
        , kons_do_zmiany
        , konsultacje
        , zainteresowania
        , zainteresowania_ang
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , emerytura_data
        , data_nadania_tytulu
        , aktywny
        , data_przeswietlenia
        , sl_id
        , tytul_ddz_id
        , data_szkolenia_bhp
        , tytul_szk_id
        )
    VALUES
        ( src.id
        , src.os_id
        , src.pierwsze_zatr
        , src.nr_akt
        , src.nr_karty
        , src.telefon1
        , src.telefon2
        , src.badania_okresowe
        , src.kons_do_zmiany
        , src.konsultacje
        , src.zainteresowania
        , src.zainteresowania_ang
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.emerytura_data
        , src.data_nadania_tytulu
        , src.aktywny
        , src.data_przeswietlenia
        , src.sl_id
        , src.tytul_ddz_id
        , src.data_szkolenia_bhp
        , src.tytul_szk_id
        )
WHEN MATCHED THEN
    UPDATE SET
--          tgt.id = src.id
--          ,
          tgt.os_id = src.os_id
        , tgt.pierwsze_zatr = src.pierwsze_zatr
        , tgt.nr_akt = src.nr_akt
        , tgt.nr_karty = src.nr_karty
        , tgt.telefon1 = src.telefon1
        , tgt.telefon2 = src.telefon2
        , tgt.badania_okresowe = src.badania_okresowe
        , tgt.kons_do_zmiany = src.kons_do_zmiany
        , tgt.konsultacje = src.konsultacje
        , tgt.zainteresowania = src.zainteresowania
        , tgt.zainteresowania_ang = src.zainteresowania_ang
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.emerytura_data = src.emerytura_data
        , tgt.data_nadania_tytulu = src.data_nadania_tytulu
        , tgt.aktywny = src.aktywny
        , tgt.data_przeswietlenia = src.data_przeswietlenia
        , tgt.sl_id = src.sl_id
        , tgt.tytul_ddz_id = src.tytul_ddz_id
        , tgt.data_szkolenia_bhp = src.data_szkolenia_bhp
        , tgt.tytul_szk_id = src.tytul_szk_id
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
