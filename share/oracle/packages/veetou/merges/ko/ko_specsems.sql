MERGE INTO v2u_ko_specsems tgt
USING
    (
        WITH u AS
        (
            SELECT
                  V2u_To.Ko_SpecSem(
                          job_uuid => h.job_uuid
                        , specialty => REF(s)
                        , sheet => h.sheet
                        , preamble => h.preamble
                  ) specsem
                , h.sheet.id sheet_id
            FROM v2u_ko_sh_hdr_preamb_h h
            INNER JOIN v2u_ko_specialty_sheets_j j
                ON (h.sheet.id = j.sheet_id AND h.job_uuid = j.job_uuid)
            INNER JOIN v2u_ko_specialties s
                ON (s.id = j.specialty_id AND s.job_uuid = j.job_uuid)
        )
        SELECT
              u.specsem.dup(CAST(COLLECT(u.sheet_id) AS V2u_Ids_t)) specsem
            , DEREF(u.specsem.specialty) specialty
        FROM u u
        GROUP BY u.specsem
    ) src
ON
    (       -- normally we should use DECODE(...) for that but it didn't seem to work here in ON clause
            ((src.specsem.semester_number = tgt.semester_number) OR (src.specsem.semester_number IS NULL AND tgt.semester_number IS NULL))
        AND ((src.specsem.semester_code = tgt.semester_code) OR (src.specsem.semester_code IS NULL AND tgt.semester_code IS NULL))
        AND ((src.specsem.ects_mandatory = tgt.ects_mandatory) OR (src.specsem.ects_mandatory IS NULL AND tgt.ects_mandatory IS NULL))
        AND ((src.specsem.ects_other = tgt.ects_other) OR (src.specsem.ects_other IS NULL AND tgt.ects_other IS NULL))
        AND ((src.specsem.ects_total = tgt.ects_total) OR (src.specsem.ects_total IS NULL AND tgt.ects_total IS NULL))
        AND ((src.specialty.studies_specialty = tgt.specialty.studies_specialty) OR (src.specialty.studies_specialty IS NULL AND tgt.specialty.studies_specialty IS NULL))
        AND ((src.specialty.studies_field = tgt.specialty.studies_field) OR (src.specialty.studies_field IS NULL AND tgt.specialty.studies_field IS NULL))
        AND ((src.specialty.studies_modetier = tgt.specialty.studies_modetier) OR (src.specialty.studies_modetier IS NULL AND tgt.specialty.studies_modetier IS NULL))
        AND ((src.specialty.faculty = tgt.specialty.faculty) OR (src.specialty.faculty IS NULL AND tgt.specialty.faculty IS NULL))
        AND ((src.specialty.university = tgt.specialty.university) OR (src.specialty.university IS NULL AND tgt.specialty.university IS NULL))
        AND ((src.specialty.job_uuid = tgt.specialty.job_uuid) OR (src.specialty.job_uuid IS NULL AND tgt.specialty.job_uuid IS NULL))
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.specsem)
WHEN MATCHED THEN UPDATE SET tgt.sheet_ids = src.specsem.sheet_ids;

-- vim: set ft=sql ts=4 sw=4 et:
