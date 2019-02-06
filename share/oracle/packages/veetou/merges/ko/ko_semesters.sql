MERGE INTO v2u_ko_semesters tgt
USING
    (
        WITH u AS
        (
            SELECT
                  VALUE(sheets) sheet
                , VALUE(preambles) preamble
            FROM v2u_ko_sheets sheets
            INNER JOIN v2u_ko_sheet_pages_j sheet_pages
                ON (sheet_pages.ko_sheet_id = sheets.id AND
                    sheet_pages.job_uuid = sheets.job_uuid)
            INNER JOIN v2u_ko_page_preamble_j page_preamble
                ON (page_preamble.ko_page_id = sheet_pages.ko_page_id AND
                    page_preamble.job_uuid = sheets.job_uuid)
            INNER JOIN v2u_ko_preambles preambles
                ON (preambles.id = page_preamble.ko_preamble_id AND
                    preambles.job_uuid = sheets.job_uuid)
            GROUP BY VALUE(sheets), VALUE(preambles)
        ),
        v AS
        (
            SELECT
                  V2u_Ko_Semester_t(
                          job_uuid => u.sheet.job_uuid
                        , sheet => u.sheet
                        , preamble => u.preamble
                  ) semester
                , u.sheet.id sheet_id
            FROM u u
        )
        SELECT
            v.semester.dup(CAST(COLLECT(v.sheet_id) AS V2u_Ids_t)) semester
        FROM v v
        GROUP BY v.semester
    ) src
ON
    (
        -- we should use DECODE(...) for this, but it didn't seem to work here in the ON clause
            ((src.semester.semester_code = tgt.semester_code) OR (src.semester.semester_code IS NULL AND tgt.semester_code IS NULL))
        AND ((src.semester.semester_number = tgt.semester_number) OR (src.semester.semester_number IS NULL AND tgt.semester_number IS NULL))
        AND ((src.semester.ects_mandatory = tgt.ects_mandatory) OR (src.semester.ects_mandatory IS NULL AND tgt.ects_mandatory IS NULL))
        AND ((src.semester.ects_other = tgt.ects_other) OR (src.semester.ects_other IS NULL AND tgt.ects_other IS NULL))
        AND ((src.semester.ects_total = tgt.ects_total) OR (src.semester.ects_total IS NULL AND tgt.ects_total IS NULL))
        AND ((src.semester.job_uuid = tgt.job_uuid) OR (src.semester.job_uuid IS NULL AND tgt.job_uuid IS NULL))
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.semester)
WHEN MATCHED THEN UPDATE SET tgt.sheet_ids = src.semester.sheet_ids;

-- vim: set ft=sql ts=4 sw=4 et:
