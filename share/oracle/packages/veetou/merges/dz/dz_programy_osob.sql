MERGE INTO dz_programy_osob tgt
USING dz_programy_osob src
ON  (tgt.id = src.id)
WHEN NOT MATCHED THEN INSERT
    (
          os_id
        , prg_kod
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , st_id
        , czy_glowny
        , id
        , data_nast_zal
        , uprawnienia_zawodowe
        , uprawnienia_zawodowe_ang
        , jed_org_kod
        , dok_upr_id
        , data_przyjecia
        , plan_data_ukon
        , czy_zgloszony
        , status
        , data_rozpoczecia
        , numer_s
        , numer_swiadectwa
        , tecz_id
        , data_arch
        , warunki_przyjec_na_prog
        , warunki_przyjec_na_prog_ang
        , numer_do_banku
        , numer_do_banku_sygn
        , numer_5_proc
        , numer_5_proc_sygn
        , status_arch
        , osiagniecia
        , osiagniecia_ang
        , nr_kierunku_ustawa
        , limit_ects
        , dodatkowe_ects_uczelnia
        , wykorzystane_ects_obce
        , limit_ects_podpiecia
        , prgos_id
        , osiagniecia_programu
        , osiagniecia_programu_ang
        , wynik_studiow
        , wynik_studiow_ang
        , umowa_data_przeczytania
        , umowa_data_podpisania
        , umowa_sygnatura
        , kod_isced
    )
VALUES
    (
          src.os_id
        , src.prg_kod
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.st_id
        , src.czy_glowny
        , src.id
        , src.data_nast_zal
        , src.uprawnienia_zawodowe
        , src.uprawnienia_zawodowe_ang
        , src.jed_org_kod
        , src.dok_upr_id
        , src.data_przyjecia
        , src.plan_data_ukon
        , src.czy_zgloszony
        , src.status
        , src.data_rozpoczecia
        , src.numer_s
        , src.numer_swiadectwa
        , src.tecz_id
        , src.data_arch
        , src.warunki_przyjec_na_prog
        , src.warunki_przyjec_na_prog_ang
        , src.numer_do_banku
        , src.numer_do_banku_sygn
        , src.numer_5_proc
        , src.numer_5_proc_sygn
        , src.status_arch
        , src.osiagniecia
        , src.osiagniecia_ang
        , src.nr_kierunku_ustawa
        , src.limit_ects
        , src.dodatkowe_ects_uczelnia
        , src.wykorzystane_ects_obce
        , src.limit_ects_podpiecia
        , src.prgos_id
        , src.osiagniecia_programu
        , src.osiagniecia_programu_ang
        , src.wynik_studiow
        , src.wynik_studiow_ang
        , src.umowa_data_przeczytania
        , src.umowa_data_podpisania
        , src.umowa_sygnatura
        , src.kod_isced
    )
WHEN MATCHED
    THEN UPDATE SET
          tgt.os_id = src.os_id
        , tgt.prg_kod = src.prg_kod
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.st_id = src.st_id
        , tgt.czy_glowny = src.czy_glowny
        --, tgt.id = src.id
        , tgt.data_nast_zal = src.data_nast_zal
        , tgt.uprawnienia_zawodowe = src.uprawnienia_zawodowe
        , tgt.uprawnienia_zawodowe_ang = src.uprawnienia_zawodowe_ang
        , tgt.jed_org_kod = src.jed_org_kod
        , tgt.dok_upr_id = src.dok_upr_id
        , tgt.data_przyjecia = src.data_przyjecia
        , tgt.plan_data_ukon = src.plan_data_ukon
        , tgt.czy_zgloszony = src.czy_zgloszony
        , tgt.status = src.status
        , tgt.data_rozpoczecia = src.data_rozpoczecia
        , tgt.numer_s = src.numer_s
        , tgt.numer_swiadectwa = src.numer_swiadectwa
        , tgt.tecz_id = src.tecz_id
        , tgt.data_arch = src.data_arch
        , tgt.warunki_przyjec_na_prog = src.warunki_przyjec_na_prog
        , tgt.warunki_przyjec_na_prog_ang = src.warunki_przyjec_na_prog_ang
        , tgt.numer_do_banku = src.numer_do_banku
        , tgt.numer_do_banku_sygn = src.numer_do_banku_sygn
        , tgt.numer_5_proc = src.numer_5_proc
        , tgt.numer_5_proc_sygn = src.numer_5_proc_sygn
        , tgt.status_arch = src.status_arch
        , tgt.osiagniecia = src.osiagniecia
        , tgt.osiagniecia_ang = src.osiagniecia_ang
        , tgt.nr_kierunku_ustawa = src.nr_kierunku_ustawa
        , tgt.limit_ects = src.limit_ects
        , tgt.dodatkowe_ects_uczelnia = src.dodatkowe_ects_uczelnia
        , tgt.wykorzystane_ects_obce = src.wykorzystane_ects_obce
        , tgt.limit_ects_podpiecia = src.limit_ects_podpiecia
        , tgt.prgos_id = src.prgos_id
        , tgt.osiagniecia_programu = src.osiagniecia_programu
        , tgt.osiagniecia_programu_ang = src.osiagniecia_programu_ang
        , tgt.wynik_studiow = src.wynik_studiow
        , tgt.wynik_studiow_ang = src.wynik_studiow_ang
        , tgt.umowa_data_przeczytania = src.umowa_data_przeczytania
        , tgt.umowa_data_podpisania = src.umowa_data_podpisania
        , tgt.umowa_sygnatura = src.umowa_sygnatura
        , tgt.kod_isced = src.kod_isced
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
