UPDATE v2u_pp_grupy_zajec_1 tgt
SET (
          koord_pesel
        , koord_prac_id
        , koord_os_id
    ) = (
        SELECT
              src.koord_pesel
            , src.koord_prac_id
            , src.koord_os_id
        FROM v2u_pp_grupy_zajec_1_koord_j src
        WHERE src.id = tgt.id
    )
WHERE EXISTS (
    SELECT 1 FROM v2u_pp_grupy_zajec_1_koord_j src
    WHERE src.id = tgt.id
);

COMMIT;

UPDATE v2u_pp_grupy_zajec_1 tgt
SET (
          prow_pesel
        , prow_prac_id
        , prow_os_id
    ) = (
        SELECT
              src.prow_pesel
            , src.prow_prac_id
            , src.prow_os_id
        FROM v2u_pp_grupy_zajec_1_prow_j src
        WHERE src.id = tgt.id
    )
WHERE EXISTS (
    SELECT 1 FROM v2u_pp_grupy_zajec_1_prow_j src
    WHERE src.id = tgt.id
);

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
