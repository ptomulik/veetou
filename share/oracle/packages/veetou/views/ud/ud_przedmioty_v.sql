CREATE OR REPLACE VIEW v2u_ud_przedmioty_v
AS
WITH uu AS
  (
    SELECT
          '+' "DIFF"
        , 'v2u_uu_przedmioty' "TABLE"
        , t.job_uuid
        , t.kod
        , t.nazwa
        , t.jed_org_kod
        , t.utw_id
        , t.utw_data
        , t.mod_id
        , t.mod_data
        , t.tpro_kod
        , t.czy_wielokrotne
        , t.name
        , t.skrocony_opis
        , t.short_description
        , t.jed_org_kod_biorca
        , t.jzk_kod
        , t.kod_sok
        , TO_CLOB(t.opis) opis                                      -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.description) description                        -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.literatura) literatura                          -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.bibliography) bibliography                      -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.efekty_uczenia) efekty_uczenia                  -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.efekty_uczenia_ang) efekty_uczenia_ang          -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.kryteria_oceniania) kryteria_oceniania          -- bug? without this it gets silently converted to NULL
        , TO_CLOB(t.kryteria_oceniania_ang) kryteria_oceniania_ang  -- bug? without this it gets silently converted to NULL
        , t.praktyki_zawodowe
        , t.praktyki_zawodowe_ang
        , t.url
        , t.kod_isced
        , t.nazwa_pol
        , t.guid
        , t.pw_nazwa_supl
        , t.pw_nazwa_supl_ang
        , t.change_type
        , t.safe_to_change
    FROM v2u_uu_przedmioty t
    WHERE t.change_type <> '-'
  ),
dz AS
  (
    SELECT
          '-' "DIFF"
        , 'v2u_dz_przedmioty' "TABLE"
        , uu.job_uuid
        , t.*
        , uu.change_type
        , uu.safe_to_change
    FROM uu uu
    INNER JOIN v2u_dz_przedmioty t
    ON  (
              t.kod = uu.kod
        )
  )
SELECT * FROM uu
UNION ALL
SELECT * FROM dz
ORDER BY
        3           -- job_uuid
      , 4           -- kod
      , 1 DESC      -- diff
;

-- vim: set ft=sql ts=4 sw=4 et:
