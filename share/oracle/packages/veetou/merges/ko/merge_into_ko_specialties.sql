MERGE INTO v2u_ko_specialties tgt
USING
    (
        WITH v AS
        (
            SELECT
                  V2u_To.Ko_Specialty(
                          job_uuid => u.job_uuid
                        , header => u.header
                        , preamble => u.preamble
                  ) specialty
 --               , u.sheet.id sheet_id
            FROM v2u_ko_sh_hdr_preamb_h u
        )
        SELECT
              v.specialty.dup_with(
                  new_id_seq => 'v2u_ko_specialties_sq1'
--                , new_sheet_ids => CAST(COLLECT(sheet_id) AS V2u_Ids_t)
              ) specialty
        FROM v v
        GROUP BY v.specialty
    ) src
ON
    (
        -- we should use DECODE(...) for this, but it didn't seem to work here in the ON clause
            ((src.specialty.studies_specialty = tgt.studies_specialty) OR (src.specialty.studies_specialty IS NULL AND tgt.studies_specialty IS NULL))
        AND ((src.specialty.studies_field = tgt.studies_field) OR (src.specialty.studies_field IS NULL AND tgt.studies_field IS NULL))
        AND ((src.specialty.studies_modetier = tgt.studies_modetier) OR (src.specialty.studies_modetier IS NULL AND tgt.studies_modetier IS NULL))
        AND ((src.specialty.faculty = tgt.faculty) OR (src.specialty.faculty IS NULL AND tgt.faculty IS NULL))
        AND ((src.specialty.university = tgt.university) OR (src.specialty.university IS NULL AND tgt.university IS NULL))
        AND ((src.specialty.job_uuid = tgt.job_uuid) OR (src.specialty.job_uuid IS NULL AND tgt.job_uuid IS NULL))
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.specialty);

-- vim: set ft=sql ts=4 sw=4 et:
