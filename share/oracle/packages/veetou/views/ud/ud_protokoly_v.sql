CREATE OR REPLACE VIEW v2u_ud_protokoly_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_protokoly' "TABLE"
        , t.job_uuid
        , t.zaj_cyk_id
        , t.opis
        , t.utw_id
        , t.utw_data
        , t.mod_id
        , t.mod_data
        , t.tpro_kod
        , t.id
        , t.prz_kod
        , t.cdyd_kod
        , t.czy_do_sredniej
        , t.edycja
        , t.opis_ang
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_protokoly t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_protokoly' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_protokoly t
    ON  (
              t.id = uu.id
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        17          -- change_type
      ,  3          -- job_uuid
      , 11          -- id
      ,  1 DESC     -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
