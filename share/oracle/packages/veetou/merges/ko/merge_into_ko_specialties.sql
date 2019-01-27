MERGE INTO v2u_ko_specialties tgt
USING
    (
        WITH v AS
        (
            SELECT
                  V2u_To.Ko_Specialty(
                          job_uuid => u.job_uuid
                        , header => DEREF(u.header)
                        , preamble => DEREF(u.preamble)
                  ) specialty
 --               , u.sheet.id sheet_id
            FROM v2u_ko_sh_hdr_preamb_h u
        )
        SELECT
              v.specialty.dup_with(
                  new_id_seq => 'v2u_ko_specialties_sq1'
--                , new_sheet_ids => CAST(COLLECT(sheet_id) AS V2u_Ko_Ids_t)
              ) specialty
        FROM v v
        GROUP BY v.specialty
    ) src
ON
    (
            DECODE(src.specialty.studies_specialty, tgt.studies_specialty, 1, 0) = 1
        AND DECODE(src.specialty.studies_field, tgt.studies_field, 1, 0) = 1
        AND DECODE(src.specialty.studies_modetier, tgt.studies_modetier, 1, 0) = 1
        AND DECODE(src.specialty.faculty, tgt.faculty, 1, 0) = 1
        AND DECODE(src.specialty.university, tgt.university, 1, 0) = 1
        AND DECODE(src.specialty.job_uuid, tgt.job_uuid, 1, 0) = 1
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.specialty);

-- vim: set ft=sql ts=4 sw=4 et:
