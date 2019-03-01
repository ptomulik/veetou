CREATE OR REPLACE VIEW v2u_ud_studenci_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_studenci' "TABLE"
        , t.job_uuid
        , t.id
        , t.indeks
        , t.jed_org_kod
        , t.typ_ind_kod
        , t.utw_id
        , t.utw_data
        , t.mod_id
        , t.mod_data
        , t.os_id
        , t.indeks_glowny
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_studenci t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_studenci' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_studenci t
    ON  (
              t.id = uu.id
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        14          -- change_type
      ,  3          -- job_uuid
      ,  4          -- id
      ,  1 DESC     -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
