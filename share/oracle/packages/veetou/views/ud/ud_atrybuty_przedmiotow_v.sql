CREATE OR REPLACE VIEW v2u_ud_atrybuty_przedmiotow_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_atrybuty_przedmiotow' "TABLE"
        , t.job_uuid
        , t.tatr_kod
        , t.prz_kod
        , t.wart_lst_id
        , t.prz_kod_rel
        , t.utw_id
        , t.utw_data
        , t.mod_id
        , t.mod_data
        , TO_CLOB(t.wartosc) wartosc            -- bug? without this, it gets silently converted to NULL
        , TO_CLOB(t.wartosc_ang) wartosc_ang    -- bug? without this, it gets silently converted to NULL
        , t.id
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_atrybuty_przedmiotow t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_atrybuty_przedmiotow' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_atrybuty_przedmiotow t
    ON  (
              t.id = uu.id
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        15 -- change_type
      ,  3 -- job_uuid
      , 14 -- id
      ,  5 -- prz_kod
      ,  4 -- tatr_kod
      ,  1 DESC -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
