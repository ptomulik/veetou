MERGE INTO v2u_ko_specialty_issues tgt
USING
    (
        WITH v AS
        (
            SELECT
                  V2u_To.Ko_Specialty_Issue(
                          job_uuid => u.job_uuid
                        , sheet => DEREF(u.sheet)
                        , header => DEREF(u.header)
                        , preamble => DEREF(u.preamble)
                  ) specialty
                , u.sheet.id sheet_id
            FROM v2u_ko_sh_hdr_preamb_h u
        )
        SELECT
              v.specialty.dup_with(
                  new_id_seq => 'v2u_ko_specialty_issues_sq1'
                , new_sheet_ids => CAST(COLLECT(v.sheet_id) AS V2u_Ko_Ids_t)
              ) specialty
        FROM v v
        GROUP BY v.specialty
    ) src
ON (VALUE(tgt) = src.specialty)
WHEN NOT MATCHED THEN INSERT VALUES(src.specialty);

-- vim: set ft=sql ts=4 sw=4 et:
