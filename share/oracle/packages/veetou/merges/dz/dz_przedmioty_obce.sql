MERGE INTO v2u_dz_przedmioty_obce tgt
USING dz_przedmioty_obce src
ON  (
            tgt.id = src.id
        AND tgt.dec_id = src.dec_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , dec_id
        , nazwa
        , cdyd_kod
        , czy_zaliczony
        , utw_id
        , utw_data
        , ocena
        , nazwa_ang
        , kod
        , liczba_punktow
        , liczba_ocen
        , suma_ocen
        , prowadzacy
        , komentarz
        , szk_id
        , szkola
        , mod_id
        , mod_data
        , status
        , jzk_kod
        , data_anulowania_akceptacji
        , zmiana_os_id
        , zmiana_data
        , czy_platny_ects_ustawa
        , kto_placi
        , katprz_id
        , do_sredniej
        , tzmian_przob_id_dod
        , opis_zmiany_dod
        , tzmian_przob_id_usun
        , opis_zmiany_usun
        , przob_id
        , url
        , nazwa_pol
        , komentarz_zajec
        , komentarz_ocen
        , rozklad_ocen
        , los_id_ewp
        , loi_id_ewp
        , pw_ponadprogramowy
        , pw_czy_egzamin
        )
    VALUES
        ( src.id
        , src.dec_id
        , src.nazwa
        , src.cdyd_kod
        , src.czy_zaliczony
        , src.utw_id
        , src.utw_data
        , src.ocena
        , src.nazwa_ang
        , src.kod
        , src.liczba_punktow
        , src.liczba_ocen
        , src.suma_ocen
        , src.prowadzacy
        , src.komentarz
        , src.szk_id
        , src.szkola
        , src.mod_id
        , src.mod_data
        , src.status
        , src.jzk_kod
        , src.data_anulowania_akceptacji
        , src.zmiana_os_id
        , src.zmiana_data
        , src.czy_platny_ects_ustawa
        , src.kto_placi
        , src.katprz_id
        , src.do_sredniej
        , src.tzmian_przob_id_dod
        , src.opis_zmiany_dod
        , src.tzmian_przob_id_usun
        , src.opis_zmiany_usun
        , src.przob_id
        , src.url
        , src.nazwa_pol
        , src.komentarz_zajec
        , src.komentarz_ocen
        , src.rozklad_ocen
        , src.los_id_ewp
        , src.loi_id_ewp
        , src.pw_ponadprogramowy
        , src.pw_czy_egzamin
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.nazwa = src.nazwa
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.czy_zaliczony = src.czy_zaliczony
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.ocena = src.ocena
        , tgt.nazwa_ang = src.nazwa_ang
        , tgt.kod = src.kod
        , tgt.liczba_punktow = src.liczba_punktow
        , tgt.liczba_ocen = src.liczba_ocen
        , tgt.suma_ocen = src.suma_ocen
        , tgt.prowadzacy = src.prowadzacy
        , tgt.komentarz = src.komentarz
        , tgt.szk_id = src.szk_id
        , tgt.szkola = src.szkola
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.status = src.status
        , tgt.jzk_kod = src.jzk_kod
        , tgt.data_anulowania_akceptacji = src.data_anulowania_akceptacji
        , tgt.zmiana_os_id = src.zmiana_os_id
        , tgt.zmiana_data = src.zmiana_data
        , tgt.czy_platny_ects_ustawa = src.czy_platny_ects_ustawa
        , tgt.kto_placi = src.kto_placi
        , tgt.katprz_id = src.katprz_id
        , tgt.do_sredniej = src.do_sredniej
        , tgt.tzmian_przob_id_dod = src.tzmian_przob_id_dod
        , tgt.opis_zmiany_dod = src.opis_zmiany_dod
        , tgt.tzmian_przob_id_usun = src.tzmian_przob_id_usun
        , tgt.opis_zmiany_usun = src.opis_zmiany_usun
        , tgt.przob_id = src.przob_id
        , tgt.url = src.url
        , tgt.nazwa_pol = src.nazwa_pol
        , tgt.komentarz_zajec = src.komentarz_zajec
        , tgt.komentarz_ocen = src.komentarz_ocen
        , tgt.rozklad_ocen = src.rozklad_ocen
        , tgt.los_id_ewp = src.los_id_ewp
        , tgt.loi_id_ewp = src.loi_id_ewp
        , tgt.pw_ponadprogramowy = src.pw_ponadprogramowy
        , tgt.pw_czy_egzamin = src.pw_czy_egzamin
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
