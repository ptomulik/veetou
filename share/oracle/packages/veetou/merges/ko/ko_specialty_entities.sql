MERGE INTO v2u_ko_specialty_entities tgt
USING
    (
        WITH u AS
        (
            SELECT
                  V2u_To.Ko_Specialty_Entity(
                          job_uuid => h.job_uuid
                        , specialty => VALUE(s)
                        , sheet => h.sheet
                        , preamble => h.preamble
                  ) specent
                , h.sheet.id sheet_id
            FROM v2u_ko_sh_hdr_preamb_h h
            INNER JOIN v2u_ko_specialty_sheets_j j
                ON (h.sheet.id = j.sheet_id AND h.job_uuid = j.job_uuid)
            INNER JOIN v2u_ko_specialties s
                ON (s.id = j.specialty_id AND s.job_uuid = j.job_uuid)
        )
        SELECT
              u.specent.dup(CAST(COLLECT(u.sheet_id) AS V2u_Ids_t)) specent
        FROM u u
        GROUP BY u.specent
    ) src
ON
    (       -- normally we should use DECODE(...) for that but it didn't seem to work here in ON clause
            ((src.specent.semester_number = tgt.semester_number) OR (src.specent.semester_number IS NULL AND tgt.semester_number IS NULL))
        AND ((src.specent.semester_code = tgt.semester_code) OR (src.specent.semester_code IS NULL AND tgt.semester_code IS NULL))
        AND ((src.specent.ects_mandatory = tgt.ects_mandatory) OR (src.specent.ects_mandatory IS NULL AND tgt.ects_mandatory IS NULL))
        AND ((src.specent.ects_other = tgt.ects_other) OR (src.specent.ects_other IS NULL AND tgt.ects_other IS NULL))
        AND ((src.specent.ects_total = tgt.ects_total) OR (src.specent.ects_total IS NULL AND tgt.ects_total IS NULL))
        AND ((src.specent.studies_specialty = tgt.studies_specialty) OR (src.specent.studies_specialty IS NULL AND tgt.studies_specialty IS NULL))
        AND ((src.specent.studies_field = tgt.studies_field) OR (src.specent.studies_field IS NULL AND tgt.studies_field IS NULL))
        AND ((src.specent.studies_modetier = tgt.studies_modetier) OR (src.specent.studies_modetier IS NULL AND tgt.studies_modetier IS NULL))
        AND ((src.specent.faculty = tgt.faculty) OR (src.specent.faculty IS NULL AND tgt.faculty IS NULL))
        AND ((src.specent.university = tgt.university) OR (src.specent.university IS NULL AND tgt.university IS NULL))
        AND ((src.specent.job_uuid = tgt.job_uuid) OR (src.specent.job_uuid IS NULL AND tgt.job_uuid IS NULL))
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.specent)
WHEN MATCHED THEN UPDATE SET tgt.sheet_ids = src.specent.sheet_ids;

-- vim: set ft=sql ts=4 sw=4 et:
