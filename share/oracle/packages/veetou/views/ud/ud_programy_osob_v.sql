CREATE OR REPLACE VIEW v2u_ud_programy_osob_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_programy_osob' "TABLE"
        , t.job_uuid
        , t.os_id
        , t.prg_kod
        , t.utw_id
        , t.utw_data
        , t.mod_id
        , t.mod_data
        , t.st_id
        , t.czy_glowny
        , t.id
        , t.data_nast_zal
        , t.uprawnienia_zawodowe
        , t.uprawnienia_zawodowe_ang
        , t.jed_org_kod
        , t.dok_upr_id
        , t.data_przyjecia
        , t.plan_data_ukon
        , t.czy_zgloszony
        , t.status
        , t.data_rozpoczecia
        , t.numer_s
        , t.numer_swiadectwa
        , t.tecz_id
        , t.data_arch
        , t.warunki_przyjec_na_prog
        , t.warunki_przyjec_na_prog_ang
        , t.numer_do_banku
        , t.numer_do_banku_sygn
        , t.numer_5_proc
        , t.numer_5_proc_sygn
        , t.status_arch
        , TO_CLOB(t.osiagniecia) osiagniecia
        , TO_CLOB(t.osiagniecia_ang) osiagniecia_ang
        , t.nr_kierunku_ustawa
        , t.limit_ects
        , t.dodatkowe_ects_uczelnia
        , t.wykorzystane_ects_obce
        , t.limit_ects_podpiecia
        , t.prgos_id
        , t.osiagniecia_programu
        , t.osiagniecia_programu_ang
        , t.wynik_studiow
        , t.wynik_studiow_ang
        , t.umowa_data_przeczytania
        , t.umowa_data_podpisania
        , t.umowa_sygnatura
        , t.kod_isced
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_programy_osob t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_programy_osob' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_programy_osob t
    ON  (
                t.id = uu.id
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        50      -- change_type
      ,  3      -- job_uuid
      , 12      -- id
      ,  1 DESC -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
