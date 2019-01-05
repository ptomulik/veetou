CREATE OR REPLACE VIEW v2u_ud_etapy_osob_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_etapy_osob' "TABLE"
        , t.job_uuid
        , t.id
        , t.data_zakon
        , t.utw_id
        , t.utw_data
        , t.mod_id
        , t.mod_data
        , t.status_zaliczenia
        , t.etp_kod
        , t.prg_kod
        , t.prgos_id
        , t.cdyd_kod
        , t.status_zal_komentarz
        , t.liczba_war
        , t.wym_cdyd_kod
        , t.czy_platny_na_2_kier
        , t.ects_uzyskane
        , t.czy_przedluzenie
        , t.urlop_kod
        , t.ects_efekty_uczenia
        , t.ects_przepisane
        , t.kolejnosc
        , t.czy_erasmus
        , t.jedn_dyplomujaca
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_etapy_osob t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_etapy_osob' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_etapy_osob t
    ON  (
                t.id = uu.id
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        24      -- change_type
      ,  3      -- job_uuid
      ,  4      -- id
      ,  1 DESC -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
