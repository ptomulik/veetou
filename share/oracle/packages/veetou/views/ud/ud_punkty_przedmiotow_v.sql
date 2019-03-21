CREATE OR REPLACE VIEW v2u_ud_punkty_przedmiotow_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_punkty_przedmiotow' "TABLE"
        , t.job_uuid
        , t.prz_kod
        , t.prg_kod
        , t.tpkt_kod
        , t.ilosc
        , t.utw_id
        , t.utw_data
        , t.mod_id
        , t.mod_data
        , t.id
        , t.cdyd_pocz
        , t.cdyd_kon
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_punkty_przedmiotow t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_punkty_przedmiotow' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_punkty_przedmiotow t
    ON  (
                t.id = uu.id
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        15      -- change_type
      ,  3      -- job_uuid
      ,  4      -- prz_kod
      , 13      -- cdyd_pocz
      ,  5      -- prg_kod
      ,  1 DESC -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
