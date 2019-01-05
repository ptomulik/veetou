CREATE OR REPLACE VIEW v2u_ud_terminy_protokolow_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_terminy_protokolow' "TABLE"
        , t.job_uuid
        , t.prot_id
        , t.nr
        , t.status
        , t.utw_id
        , t.utw_data
        , t.opis
        , t.data_zwrotu
        , t.mod_id
        , t.mod_data
        , t.egzamin_komisyjny
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_terminy_protokolow t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_terminy_protokolow' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_terminy_protokolow t
    ON  (
                t.prot_id = uu.prot_id
            AND t.nr = uu.nr
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        14          -- change_type
      ,  3          -- job_uuid
      ,  4          -- prot_id
      ,  5          -- nr
      ,  1 DESC     -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
