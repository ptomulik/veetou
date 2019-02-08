MERGE INTO v2u_dz_przedmioty tgt
USING dz_przedmioty src
ON  (tgt.kod = src.kod)
WHEN NOT MATCHED THEN INSERT
    ( kod
    , nazwa
    , jed_org_kod
    , utw_id
    , utw_data
    , mod_id
    , mod_data
    , tpro_kod
    , czy_wielokrotne
    , name
    , skrocony_opis
    , short_description
    , jed_org_kod_biorca
    , jzk_kod
    , kod_sok
    , opis
    , description
    , literatura
    , bibliography
    , efekty_uczenia
    , efekty_uczenia_ang
    , kryteria_oceniania
    , kryteria_oceniania_ang
    , praktyki_zawodowe
    , praktyki_zawodowe_ang
    , url
    , kod_isced
    , nazwa_pol
    , guid
    , pw_nazwa_supl
    , pw_nazwa_supl_ang
    )
VALUES
    ( src.kod
    , src.nazwa
    , src.jed_org_kod
    , src.utw_id
    , src.utw_data
    , src.mod_id
    , src.mod_data
    , src.tpro_kod
    , src.czy_wielokrotne
    , src.name
    , src.skrocony_opis
    , src.short_description
    , src.jed_org_kod_biorca
    , src.jzk_kod
    , src.kod_sok
    , src.opis
    , src.description
    , src.literatura
    , src.bibliography
    , src.efekty_uczenia
    , src.efekty_uczenia_ang
    , src.kryteria_oceniania
    , src.kryteria_oceniania_ang
    , src.praktyki_zawodowe
    , src.praktyki_zawodowe_ang
    , src.url
    , src.kod_isced
    , src.nazwa_pol
    , src.guid
    , src.pw_nazwa_supl
    , src.pw_nazwa_supl_ang
    )
WHEN MATCHED THEN UPDATE SET
      tgt.nazwa = src.nazwa
    , tgt.jed_org_kod = src.jed_org_kod
    , tgt.utw_id = src.utw_id
    , tgt.utw_data = src.utw_data
    , tgt.mod_id = src.mod_id
    , tgt.mod_data = src.mod_data
    , tgt.tpro_kod = src.tpro_kod
    , tgt.czy_wielokrotne = src.czy_wielokrotne
    , tgt.name = src.name
    , tgt.skrocony_opis = src.skrocony_opis
    , tgt.short_description = src.short_description
    , tgt.jed_org_kod_biorca = src.jed_org_kod_biorca
    , tgt.jzk_kod = src.jzk_kod
    , tgt.kod_sok = src.kod_sok
    , tgt.opis = src.opis
    , tgt.description = src.description
    , tgt.literatura = src.literatura
    , tgt.bibliography = src.bibliography
    , tgt.efekty_uczenia = src.efekty_uczenia
    , tgt.efekty_uczenia_ang = src.efekty_uczenia_ang
    , tgt.kryteria_oceniania = src.kryteria_oceniania
    , tgt.kryteria_oceniania_ang = src.kryteria_oceniania_ang
    , tgt.praktyki_zawodowe = src.praktyki_zawodowe
    , tgt.praktyki_zawodowe_ang = src.praktyki_zawodowe_ang
    , tgt.url = src.url
    , tgt.kod_isced = src.kod_isced
    , tgt.nazwa_pol = src.nazwa_pol
    , tgt.guid = src.guid
    , tgt.pw_nazwa_supl = src.pw_nazwa_supl
    , tgt.pw_nazwa_supl_ang = src.pw_nazwa_supl_ang
;
-- vim: set ft=sql ts=4 sw=4 et:
