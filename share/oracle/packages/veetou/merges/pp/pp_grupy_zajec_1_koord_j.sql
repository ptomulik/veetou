MERGE INTO v2u_pp_grupy_zajec_1_koord_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  pp.id
                , pr.nr_akt
                , CAST(
                    COLLECT(os.nazwisko ORDER BY os.id, pr.id)
                    AS V2u_Vchars1k_t
                ) nazwiska1k
                , CAST(
                    COLLECT(os.imie ORDER BY os.id, pr.id)
                    AS V2u_Vchars1k_t
                ) imiona1k
                , CAST(
                    COLLECT(os.pesel ORDER BY os.id, pr.id)
                    AS V2u_Vchars1k_t
                ) pesele1k
                , CAST(
                    COLLECT(pr.id ORDER BY os.id, pr.id)
                    AS V2u_Dz_Ids_t
                ) prac_ids
                , CAST(
                    COLLECT(os.id ORDER BY os.id, pr.id)
                    AS V2u_Dz_Ids_t
                ) os_ids
            FROM v2u_pp_grupy_zajec_1 pp
            INNER JOIN v2u_dz_osoby os
                ON  (
                            UPPER(os.nazwisko) = UPPER(pp.koord_nazwisko)
                        AND (
                                    UPPER(os.imie) = UPPER(pp.koord_imie)
                                OR pp.koord_imie IS NULL
                            )
                        AND os.jed_org_kod LIKE pp.koord_jed_org
                    )
            INNER JOIN v2u_dz_pracownicy pr
                ON  (
                            pr.os_id = os.id
                    )
            GROUP BY  pp.id
                    , pr.nr_akt
        ),
        v AS
        (
            SELECT
                  u.*
                , ( SELECT VALUE(t)
                    FROM TABLE(u.nazwiska1k) t
                    WHERE ROWNUM <= 1
                  ) nazwisko
                , ( SELECT VALUE(t)
                    FROM TABLE(u.imiona1k) t
                    WHERE ROWNUM <= 1
                  ) imie
                , ( SELECT VALUE(t)
                    FROM TABLE(u.pesele1k) t
                    WHERE ROWNUM <= 1
                  ) pesel
                , ( SELECT VALUE(t)
                    FROM TABLE(u.prac_ids) t
                    WHERE ROWNUM <= 1
                  ) prac_id
                , ( SELECT VALUE(t)
                    FROM TABLE(u.os_ids) t
                    WHERE ROWNUM <= 1
                  ) os_id
                -- DBG
                , ( SELECT COUNT(*)
                    FROM TABLE(u.nazwiska1k)
                  ) dbg_nazwiska
                , ( SELECT COUNT(*)
                    FROM TABLE(u.imiona1k)
                  ) dbg_imiona
                , ( SELECT COUNT(*)
                    FROM TABLE(u.pesele1k)
                  ) dbg_pesele
                , ( SELECT COUNT(*)
                    FROM TABLE(u.prac_ids)
                  ) dbg_prac_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u.os_ids)
                  ) dbg_os_ids
            FROM u u
            WHERE
                    u.nr_akt IS NOT NULL
                OR  u.nr_akt IS NULL AND (
                        SELECT COUNT(*)
                        FROM u uu
                        WHERE uu.id = u.id
                    ) = 1
        ),
        w AS
        (
            SELECT
                  v.*
                , CASE
                    WHEN    v.dbg_nazwiska = 1
                        AND v.dbg_imiona = 1
                        AND v.dbg_pesele = 1
                        AND v.dbg_prac_ids = 1
                        AND v.dbg_os_ids = 1
                    THEN 1
                    ELSE 0
                  END dbg_is_unique
            FROM v v
        )
        SELECT
              w.id
            , w.pesel koord_pesel
            , w.prac_id koord_prac_id
            , w.os_id koord_os_id
        FROM w w
        WHERE w.dbg_is_unique = 1
    ) src
ON  (
        tgt.id = src.id
    )
WHEN NOT MATCHED THEN
INSERT
    ( id
    , koord_pesel
    , koord_prac_id
    , koord_os_id
    )
VALUES
    ( src.id
    , src.koord_pesel
    , src.koord_prac_id
    , src.koord_os_id
    )
WHEN MATCHED THEN
UPDATE SET
      tgt.koord_pesel = src.koord_pesel
    , tgt.koord_prac_id = src.koord_prac_id
    , tgt.koord_os_id = src.koord_os_id
;

COMMIT;
-- vim: set ft=sql ts=4 sw=4 et:
