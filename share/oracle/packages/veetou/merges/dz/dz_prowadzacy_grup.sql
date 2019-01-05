MERGE INTO v2u_dz_prowadzacy_grup tgt
USING dz_prowadzacy_grup src
ON  (
            tgt.gr_nr = src.gr_nr
        AND tgt.zaj_cyk_id = src.zaj_cyk_id
        AND tgt.prac_id = src.prac_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( gr_nr
        , zaj_cyk_id
        , prac_id
        , waga_pensum
        , jedn_kod
        , liczba_godz
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , liczba_godz_do_pensum
        , liczba_osob
        , czy_ankiety
        , czy_protokoly
        , liczba_godz_przen
        , komentarz
        )
    VALUES
        ( src.gr_nr
        , src.zaj_cyk_id
        , src.prac_id
        , src.waga_pensum
        , src.jedn_kod
        , src.liczba_godz
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.liczba_godz_do_pensum
        , src.liczba_osob
        , src.czy_ankiety
        , src.czy_protokoly
        , src.liczba_godz_przen
        , src.komentarz
        )
WHEN MATCHED THEN
    UPDATE SET
--          tgt.gr_nr = src.gr_nr
--        , tgt.zaj_cyk_id = src.zaj_cyk_id
--        , tgt.prac_id = src.prac_id
--        ,
          tgt.waga_pensum = src.waga_pensum
        , tgt.jedn_kod = src.jedn_kod
        , tgt.liczba_godz = src.liczba_godz
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.liczba_godz_do_pensum = src.liczba_godz_do_pensum
        , tgt.liczba_osob = src.liczba_osob
        , tgt.czy_ankiety = src.czy_ankiety
        , tgt.czy_protokoly = src.czy_protokoly
        , tgt.liczba_godz_przen = src.liczba_godz_przen
        , tgt.komentarz = src.komentarz
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
