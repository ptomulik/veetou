CREATE OR REPLACE VIEW v2u_ud_zal_przedm_prgos_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_zal_przedm_prgos' "TABLE"
        , t.job_uuid
        , t.os_id
        , t.prz_kod
        , t.cdyd_kod
        , t.prgos_id
        , t.stan
        , t.utw_id
        , t.utw_data
        , t.etpos_id
        , t.mod_id
        , t.mod_data
        , t.do_sredniej
        , t.do_sredniej_zmiana_os_id
        , t.do_sredniej_zmiana_data
        , t.podp_data
        , t.podp_os_id
        , t.czy_platny_ects_ustawa
        , t.kto_placi
        , t.podp_etpos_data
        , t.podp_etpos_os_id
        , t.katprz_id
        , t.pw_ponadprogramowy
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_zal_przedm_prgos t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_zal_przedm_prgos' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_zal_przedm_prgos t
    ON  (
                t.os_id = uu.os_id
            AND t.cdyd_kod = uu.cdyd_kod
            AND t.prz_kod = uu.prz_kod
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        25          -- change_type
      ,  3          -- job_uuid
      ,  4          -- os_id
      ,  5          -- prz_kod
      ,  6          -- cdyd_kod
      ,  7          -- prgos_id
      ,  1 DESC     -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
