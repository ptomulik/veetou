CREATE OR REPLACE VIEW v2u_ud_przedmioty_cykli_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_przedmioty_cykli' "TABLE"
        , t.job_uuid
        , t.prz_kod
        , t.cdyd_kod
        , t.utw_id
        , t.utw_data
        , t.mod_id
        , t.mod_data
        , t.tpro_kod
        , t.uczestnicy
        , t.url
        , TO_CLOB(t.uwagi) uwagi                    -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.notes) notes                    -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.literatura) literatura          -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.literatura_ang) literatura_ang  -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.opis) opis                      -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.opis_ang) opis_ang              -- bug? without this it gets silently converted to NULL
        , t.skrocony_opis
        , t.skrocony_opis_ang
        , t.status_sylabusu
        , t.guid
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_przedmioty_cykli t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_przedmioty_cykli' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_przedmioty_cykli t
    ON  (
                t.prz_kod = uu.prz_kod
            AND t.cdyd_kod = uu.cdyd_kod
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        23      -- change_type
      ,  3      -- job_uuid
      ,  4      -- prz_kod
      ,  5      -- cdyd_kod
      ,  1 DESC -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
