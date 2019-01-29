MERGE INTO v2u_ko_specialties tgt
USING
    (
        WITH u AS
        (
            SELECT
                  V2u_To.Ko_Specialty(
                          job_uuid => h.job_uuid
                        , header => h.header
                        , preamble => h.preamble
                  ) specialty
                , h.sheet.id sheet_id
            FROM v2u_ko_sh_hdr_preamb_h h
        )
        SELECT
            u.specialty.dup(CAST(COLLECT(u.sheet_id) AS V2u_Ids_t)) specialty
        FROM u u
        GROUP BY u.specialty
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
WHEN NOT MATCHED THEN INSERT VALUES(src.specialty)
WHEN MATCHED THEN UPDATE SET tgt.sheet_ids = src.specialty.sheet_ids;

-- vim: set ft=sql ts=4 sw=4 et:
