MERGE INTO v2u_dz_osoby tgt
USING dz_osoby src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN
    INSERT
        ( id
        , pesel
        , imie
        , imie2
        , nazwisko
--        , data_ur
--        , miasto_ur
--        , imie_ojca
--        , imie_matki
--        , nazwisko_panien_matki
--        , nazwisko_rodowe
--        , szkola
--        , sr_nr_dowodu
--        , nip
--        , wku_kod
--        , kat_wojskowa
--        , stosunek_wojskowy
--        , uwagi
--        , www
--        , email
--        , ob_kod
--        , nar_kod
        , jed_org_kod
        , utw_id
        , utw_data
        , mod_id
        , mod_data
--        , plec
        , tytul_przed
        , tytul_po
--        , czy_polonia
--        , zamiejscowa
--        , gdzie_socjalne
--        , us_id
--        , akad_czy_rezerwa
--        , akad_wykroczenia
--        , akad_uwagi
--        , szk_id
--        , poziom_uprawnien
--        , typ_dokumentu
--        , nr_karty_bibl
--        , bk_email
--        , bk_czymigrowac
--        , kraj_urodzenia
--        , dane_zew_status
--        , osiagniecia
--        , osiagniecia_ang
--        , epuap_identyfikator
--        , epuap_skrytka
--        , czy_losy_absolwentow
--        , czy_losy_abs_zgoda
--        , czy_losy_abs_rezyg
--        , bk_czy_migr_zgoda
--        , bk_czy_migr_rezyg
--        , kraj_dok_kod
--        , data_waznosci_dowodu
--        , pw_kraj_mat
--        , czy_klub_abs
--        , czy_klub_abs_zgoda
--        , czy_klub_abs_rezyg
        )
    VALUES
        ( src.id
        , src.pesel
        , src.imie
        , src.imie2
        , src.nazwisko
--        , src.data_ur
--        , src.miasto_ur
--        , src.imie_ojca
--        , src.imie_matki
--        , src.nazwisko_panien_matki
--        , src.nazwisko_rodowe
--        , src.szkola
--        , src.sr_nr_dowodu
--        , src.nip
--        , src.wku_kod
--        , src.kat_wojskowa
--        , src.stosunek_wojskowy
--        , src.uwagi
--        , src.www
--        , src.email
--        , src.ob_kod
--        , src.nar_kod
        , src.jed_org_kod
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
--        , src.plec
        , src.tytul_przed
        , src.tytul_po
--        , src.czy_polonia
--        , src.zamiejscowa
--        , src.gdzie_socjalne
--        , src.us_id
--        , src.akad_czy_rezerwa
--        , src.akad_wykroczenia
--        , src.akad_uwagi
--        , src.szk_id
--        , src.poziom_uprawnien
--        , src.typ_dokumentu
--        , src.nr_karty_bibl
--        , src.bk_email
--        , src.bk_czymigrowac
--        , src.kraj_urodzenia
--        , src.dane_zew_status
--        , src.osiagniecia
--        , src.osiagniecia_ang
--        , src.epuap_identyfikator
--        , src.epuap_skrytka
--        , src.czy_losy_absolwentow
--        , src.czy_losy_abs_zgoda
--        , src.czy_losy_abs_rezyg
--        , src.bk_czy_migr_zgoda
--        , src.bk_czy_migr_rezyg
--        , src.kraj_dok_kod
--        , src.data_waznosci_dowodu
--        , src.pw_kraj_mat
--        , src.czy_klub_abs
--        , src.czy_klub_abs_zgoda
--        , src.czy_klub_abs_rezyg
        )
WHEN MATCHED THEN
    UPDATE SET
--          tgt.id = src.id
--        ,
          tgt.pesel = src.pesel
        , tgt.imie = src.imie
        , tgt.imie2 = src.imie2
        , tgt.nazwisko = src.nazwisko
--        , tgt.data_ur = src.data_ur
--        , tgt.miasto_ur = src.miasto_ur
--        , tgt.imie_ojca = src.imie_ojca
--        , tgt.imie_matki = src.imie_matki
--        , tgt.nazwisko_panien_matki = src.nazwisko_panien_matki
--        , tgt.nazwisko_rodowe = src.nazwisko_rodowe
--        , tgt.szkola = src.szkola
--        , tgt.sr_nr_dowodu = src.sr_nr_dowodu
--        , tgt.nip = src.nip
--        , tgt.wku_kod = src.wku_kod
--        , tgt.kat_wojskowa = src.kat_wojskowa
--        , tgt.stosunek_wojskowy = src.stosunek_wojskowy
--        , tgt.uwagi = src.uwagi
--        , tgt.www = src.www
--        , tgt.email = src.email
--        , tgt.ob_kod = src.ob_kod
--        , tgt.nar_kod = src.nar_kod
        , tgt.jed_org_kod = src.jed_org_kod
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
--        , tgt.plec = src.plec
        , tgt.tytul_przed = src.tytul_przed
        , tgt.tytul_po = src.tytul_po
--        , tgt.czy_polonia = src.czy_polonia
--        , tgt.zamiejscowa = src.zamiejscowa
--        , tgt.gdzie_socjalne = src.gdzie_socjalne
--        , tgt.us_id = src.us_id
--        , tgt.akad_czy_rezerwa = src.akad_czy_rezerwa
--        , tgt.akad_wykroczenia = src.akad_wykroczenia
--        , tgt.akad_uwagi = src.akad_uwagi
--        , tgt.szk_id = src.szk_id
--        , tgt.poziom_uprawnien = src.poziom_uprawnien
--        , tgt.typ_dokumentu = src.typ_dokumentu
--        , tgt.nr_karty_bibl = src.nr_karty_bibl
--        , tgt.bk_email = src.bk_email
--        , tgt.bk_czymigrowac = src.bk_czymigrowac
--        , tgt.kraj_urodzenia = src.kraj_urodzenia
--        , tgt.dane_zew_status = src.dane_zew_status
--        , tgt.osiagniecia = src.osiagniecia
--        , tgt.osiagniecia_ang = src.osiagniecia_ang
--        , tgt.epuap_identyfikator = src.epuap_identyfikator
--        , tgt.epuap_skrytka = src.epuap_skrytka
--        , tgt.czy_losy_absolwentow = src.czy_losy_absolwentow
--        , tgt.czy_losy_abs_zgoda = src.czy_losy_abs_zgoda
--        , tgt.czy_losy_abs_rezyg = src.czy_losy_abs_rezyg
--        , tgt.bk_czy_migr_zgoda = src.bk_czy_migr_zgoda
--        , tgt.bk_czy_migr_rezyg = src.bk_czy_migr_rezyg
--        , tgt.kraj_dok_kod = src.kraj_dok_kod
--        , tgt.data_waznosci_dowodu = src.data_waznosci_dowodu
--        , tgt.pw_kraj_mat = src.pw_kraj_mat
--        , tgt.czy_klub_abs = src.czy_klub_abs
--        , tgt.czy_klub_abs_zgoda = src.czy_klub_abs_zgoda
--        , tgt.czy_klub_abs_rezyg = src.czy_klub_abs_rezyg
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
