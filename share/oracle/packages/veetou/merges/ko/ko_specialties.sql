MERGE INTO v2u_ko_specialties tgt
USING
    (
        WITH u AS
        (
            SELECT
                  VALUE(sheets) sheet
                , VALUE(headers) header
                , VALUE(preambles) preamble
            FROM v2u_ko_sheets sheets
            INNER JOIN v2u_ko_sheet_pages_j sheet_pages
                ON  (
                            sheet_pages.ko_sheet_id = sheets.id
                        AND sheet_pages.job_uuid = sheets.job_uuid
                    )
            INNER JOIN v2u_ko_page_preamble_j page_preamble
                ON  (
                            page_preamble.ko_page_id = sheet_pages.ko_page_id
                        AND page_preamble.job_uuid = sheets.job_uuid
                    )
            INNER JOIN v2u_ko_preambles preambles
                ON  (
                            preambles.id = page_preamble.ko_preamble_id
                        AND preambles.job_uuid = sheets.job_uuid
                    )
            INNER JOIN v2u_ko_page_header_j page_header
                ON  (
                            page_header.ko_page_id = sheet_pages.ko_page_id
                        AND page_header.job_uuid = sheets.job_uuid
                    )
            INNER JOIN v2u_ko_headers headers
                ON  (
                            headers.id = page_header.ko_header_id
                        AND headers.job_uuid = sheets.job_uuid
                    )
            GROUP BY
                  VALUE(sheets)
                , VALUE(headers)
                , VALUE(preambles)
        ),
        v AS
        (
            SELECT
                  V2u_Ko_Specialty_t(
                          job_uuid => u.sheet.job_uuid
                        , header => u.header
                        , preamble => u.preamble
                  ) specialty
                , u.sheet.id sheet_id
            FROM u u
        )
        SELECT
            v.specialty.dup(CAST(COLLECT(v.sheet_id) AS V2u_Ids_t)) specialty
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
WHEN NOT MATCHED THEN
    INSERT VALUES(src.specialty)
WHEN MATCHED THEN
    UPDATE SET tgt.sheet_ids = src.specialty.sheet_ids
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
