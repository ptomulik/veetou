CREATE OR REPLACE VIEW v2u_ud_oceny_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_oceny' "TABLE"
        , t.job_uuid
        , t.os_id
        , t.komentarz_pub
        , t.komentarz_pryw
        , t.toc_kod
        , t.wart_oc_kolejnosc
        , t.utw_id
        , t.utw_data
        , t.mod_id
        , t.mod_data
        , t.prot_id
        , t.term_prot_nr
        , t.zmiana_os_id
        , t.zmiana_data
        , t.pos_komi_id
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_oceny t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_oceny' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_oceny t
    ON  (
                t.os_id = uu.os_id
            AND t.prot_id = uu.prot_id
            AND t.term_prot_nr = uu.term_prot_nr
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        18          -- change_type
      ,  3          -- job_uuid
      ,  4          -- os_id
      , 13          -- prot_id
      , 14          -- term_prot_nr
      ,  1 DESC     -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
