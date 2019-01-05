CREATE OR REPLACE VIEW v2u_ud_zalicz_przedmiotow_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_zaliczenia_przedmiotow' "TABLE"
        , t.job_uuid
        , t.status_rej
        , t.opis_statusu_rej
        , t.status_zal
        , t.opis_statusu_zal
        , t.suma_ocen
        , t.liczba_ocen
        , t.os_id
        , t.cdyd_kod
        , t.prz_kod
        , t.utw_data
        , t.utw_id
        , t.mod_id
        , t.mod_data
        , t.nr_wyb
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_zaliczenia_przedmiotow t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_zaliczenia_przedmiotow' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_zaliczenia_przedmiotow t
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
        18          -- change_type
      ,  3          -- job_uuid
      , 10          -- os_id
      , 11          -- cdyd_kod
      , 12          -- prz_kod
      ,  1 DESC     -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
