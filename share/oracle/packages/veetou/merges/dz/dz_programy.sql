MERGE INTO v2u_dz_programy tgt
USING dz_programy src
ON  (tgt.kod = src.kod)
WHEN NOT MATCHED THEN
    INSERT
        ( kod
        , opis
        , data_od
        , data_do
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , tryb_studiow
        , rodzaj_studiow
        , czas_trwania
        , description
        , dalsze_studia
        , dalsze_studia_ang
        , rodzaj_studiow_ang
        , czas_trwania_ang
        , tryb_studiow_ang
        , tcdyd_kod
        , liczba_jedn
        , czy_wyswietlac
        , uprawnienia_zawodowe
        , uprawnienia_zawodowe_ang
        , opis_nie
        , opis_ros
        , opis_his
        , opis_fra
        , konf_sr_kod
        , prow_kier_id
        , profil
        , czy_studia_miedzyobszarowe
        , czy_bezplatny_ustawa
        , limit_ects
        , dodatkowe_ects_ustawa
        , dodatkowe_ects_uczelnia
        , czynniki_szkodliwe
        , zakres
        , zakres_ang
        , jed_org_kod_podst
        , kod_polon_ism
        , kod_polon_dr
        , kod_isced
        , kod_polon_rekrutacja
        , jed_org_kod_prow
        , ustal_date_konca_studiow
        , pw_data_od_rekr
        , pw_data_do_rekr
        , pw_ects_obowiazkowe
        , pw_ects_obieralne
        )
    VALUES
        ( src.kod
        , src.opis
        , src.data_od
        , src.data_do
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.tryb_studiow
        , src.rodzaj_studiow
        , src.czas_trwania
        , src.description
        , src.dalsze_studia
        , src.dalsze_studia_ang
        , src.rodzaj_studiow_ang
        , src.czas_trwania_ang
        , src.tryb_studiow_ang
        , src.tcdyd_kod
        , src.liczba_jedn
        , src.czy_wyswietlac
        , src.uprawnienia_zawodowe
        , src.uprawnienia_zawodowe_ang
        , src.opis_nie
        , src.opis_ros
        , src.opis_his
        , src.opis_fra
        , src.konf_sr_kod
        , src.prow_kier_id
        , src.profil
        , src.czy_studia_miedzyobszarowe
        , src.czy_bezplatny_ustawa
        , src.limit_ects
        , src.dodatkowe_ects_ustawa
        , src.dodatkowe_ects_uczelnia
        , src.czynniki_szkodliwe
        , src.zakres
        , src.zakres_ang
        , src.jed_org_kod_podst
        , src.kod_polon_ism
        , src.kod_polon_dr
        , src.kod_isced
        , src.kod_polon_rekrutacja
        , src.jed_org_kod_prow
        , src.ustal_date_konca_studiow
        , src.pw_data_od_rekr
        , src.pw_data_do_rekr
        , src.pw_ects_obowiazkowe
        , src.pw_ects_obieralne
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.opis = src.opis
        , tgt.data_od = src.data_od
        , tgt.data_do = src.data_do
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.tryb_studiow = src.tryb_studiow
        , tgt.rodzaj_studiow = src.rodzaj_studiow
        , tgt.czas_trwania = src.czas_trwania
        , tgt.description = src.description
        , tgt.dalsze_studia = src.dalsze_studia
        , tgt.dalsze_studia_ang = src.dalsze_studia_ang
        , tgt.rodzaj_studiow_ang = src.rodzaj_studiow_ang
        , tgt.czas_trwania_ang = src.czas_trwania_ang
        , tgt.tryb_studiow_ang = src.tryb_studiow_ang
        , tgt.tcdyd_kod = src.tcdyd_kod
        , tgt.liczba_jedn = src.liczba_jedn
        , tgt.czy_wyswietlac = src.czy_wyswietlac
        , tgt.uprawnienia_zawodowe = src.uprawnienia_zawodowe
        , tgt.uprawnienia_zawodowe_ang = src.uprawnienia_zawodowe_ang
        , tgt.opis_nie = src.opis_nie
        , tgt.opis_ros = src.opis_ros
        , tgt.opis_his = src.opis_his
        , tgt.opis_fra = src.opis_fra
        , tgt.konf_sr_kod = src.konf_sr_kod
        , tgt.prow_kier_id = src.prow_kier_id
        , tgt.profil = src.profil
        , tgt.czy_studia_miedzyobszarowe = src.czy_studia_miedzyobszarowe
        , tgt.czy_bezplatny_ustawa = src.czy_bezplatny_ustawa
        , tgt.limit_ects = src.limit_ects
        , tgt.dodatkowe_ects_ustawa = src.dodatkowe_ects_ustawa
        , tgt.dodatkowe_ects_uczelnia = src.dodatkowe_ects_uczelnia
        , tgt.czynniki_szkodliwe = src.czynniki_szkodliwe
        , tgt.zakres = src.zakres
        , tgt.zakres_ang = src.zakres_ang
        , tgt.jed_org_kod_podst = src.jed_org_kod_podst
        , tgt.kod_polon_ism = src.kod_polon_ism
        , tgt.kod_polon_dr = src.kod_polon_dr
        , tgt.kod_isced = src.kod_isced
        , tgt.kod_polon_rekrutacja = src.kod_polon_rekrutacja
        , tgt.jed_org_kod_prow = src.jed_org_kod_prow
        , tgt.ustal_date_konca_studiow = src.ustal_date_konca_studiow
        , tgt.pw_data_od_rekr = src.pw_data_od_rekr
        , tgt.pw_data_do_rekr = src.pw_data_do_rekr
        , tgt.pw_ects_obowiazkowe = src.pw_ects_obowiazkowe
        , tgt.pw_ects_obieralne = src.pw_ects_obieralne
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
