CREATE OR REPLACE VIEW v2u_ud_zajecia_cykli_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_zajecia_cykli' "TABLE"
        , t.job_uuid
        , t.id
        , t.prz_kod
        , t.cdyd_kod
        , t.tzaj_kod
        , t.liczba_godz
        , t.limit_miejsc
        , t.utw_id
        , t.utw_data
        , t.mod_id
        , t.mod_data
        , t.waga_pensum
        , t.tpro_kod
        , TO_CLOB(t.efekty_uczenia) efekty_uczenia                  -- bug? without TO_CLOB it gets silently converted to NULL
        , TO_CLOB(t.efekty_uczenia_ang) efekty_uczenia_ang          -- bug? without TO_CLOB it gets silently converted to NULL
        , TO_CLOB(t.kryteria_oceniania) kryteria_oceniania          -- bug? without TO_CLOB it gets silently converted to NULL
        , TO_CLOB(t.kryteria_oceniania_ang) kryteria_oceniania_ang  -- bug? without TO_CLOB it gets silently converted to NULL
        , t.url
        , TO_CLOB(t.zakres_tematow) zakres_tematow                  -- bug? without TO_CLOB it gets silently converted to NULL
        , TO_CLOB(t.zakres_tematow_ang) zakres_tematow_ang          -- bug? without TO_CLOB it gets silently converted to NULL
        , TO_CLOB(t.metody_dyd) metody_dyd                          -- bug? without TO_CLOB it gets silently converted to NULL
        , TO_CLOB(t.metody_dyd_ang) metody_dyd_ang                  -- bug? without TO_CLOB it gets silently converted to NULL
        , TO_CLOB(t.literatura) literatura                          -- bug? without TO_CLOB it gets silently converted to NULL
        , TO_CLOB(t.literatura_ang) literatura_ang                  -- bug? without TO_CLOB it gets silently converted to NULL
        , t.czy_pokazywac_termin
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_zajecia_cykli t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_zajecia_cykli' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_zajecia_cykli t
    ON  (
                t.id = uu.id
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        28      -- change_type
      ,  3      -- job_uuid
      ,  4      -- id
      ,  1 DESC -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
