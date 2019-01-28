MERGE INTO v2u_ko_specialty_entities tgt
USING
    (
        WITH v AS
        (
            SELECT
                  V2u_To.Ko_Specialty_Entity(
                          job_uuid => u.job_uuid
                        , sheet => u.sheet
                        , header => u.header
                        , preamble => u.preamble
                  ) specialty
                , u.sheet.id sheet_id
            FROM v2u_ko_sh_hdr_preamb_h u
        )
        SELECT
              v.specialty.dup_with(
                  new_id_seq => 'v2u_ko_specialty_entities_sq1'
                , new_sheet_ids => CAST(COLLECT(v.sheet_id) AS V2u_Ids_t)
              ) specialty
        FROM v v
        GROUP BY v.specialty
    ) src
ON
    (       -- normally we should use DECODE(...) for that but it didn't seem to work here in ON clause
            ((src.specialty.semester_number = tgt.semester_number) OR (src.specialty.semester_number IS NULL AND tgt.semester_number IS NULL))
        AND ((src.specialty.semester_code = tgt.semester_code) OR (src.specialty.semester_code IS NULL AND tgt.semester_code IS NULL))
        AND ((src.specialty.ects_mandatory = tgt.ects_mandatory) OR (src.specialty.ects_mandatory IS NULL AND tgt.ects_mandatory IS NULL))
        AND ((src.specialty.ects_other = tgt.ects_other) OR (src.specialty.ects_other IS NULL AND tgt.ects_other IS NULL))
        AND ((src.specialty.ects_total = tgt.ects_total) OR (src.specialty.ects_total IS NULL AND tgt.ects_total IS NULL))
        AND ((src.specialty.studies_specialty = tgt.studies_specialty) OR (src.specialty.studies_specialty IS NULL AND tgt.studies_specialty IS NULL))
        AND ((src.specialty.studies_field = tgt.studies_field) OR (src.specialty.studies_field IS NULL AND tgt.studies_field IS NULL))
        AND ((src.specialty.studies_modetier = tgt.studies_modetier) OR (src.specialty.studies_modetier IS NULL AND tgt.studies_modetier IS NULL))
        AND ((src.specialty.faculty = tgt.faculty) OR (src.specialty.faculty IS NULL AND tgt.faculty IS NULL))
        AND ((src.specialty.university = tgt.university) OR (src.specialty.university IS NULL AND tgt.university IS NULL))
        AND ((src.specialty.job_uuid = tgt.job_uuid) OR (src.specialty.job_uuid IS NULL AND tgt.job_uuid IS NULL))
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.specialty)
WHEN MATCHED THEN UPDATE SET tgt.sheet_ids = src.specialty.sheet_ids;

-- vim: set ft=sql ts=4 sw=4 et:
