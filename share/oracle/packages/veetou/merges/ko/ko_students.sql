MERGE INTO v2u_ko_students tgt
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
                  V2u_Ko_Student_t(
                        job_uuid => u.sheet.job_uuid,
                        preamble => u.preamble
                  ) student
                , u.sheet.id sheet_id
            FROM u u
        )
        SELECT
            v.student.dup(CAST(COLLECT(v.sheet_id) AS V2u_Ids_t)) student
        FROM v v
        GROUP BY v.student
    ) src
ON
    (
        -- We should actually use DECODE(...) here, but it doesn't seem to work well in the ON clause
            ((src.student.student_index = tgt.student_index) OR (src.student.student_index IS NULL AND tgt.student_index IS NULL))
        AND ((src.student.student_name = tgt.student_name) OR (src.student.student_name IS NULL AND tgt.student_name IS NULL))
        AND ((src.student.first_name = tgt.first_name) OR (src.student.first_name IS NULL AND tgt.first_name IS NULL))
        AND ((src.student.last_name = tgt.last_name) OR (src.student.last_name IS NULL AND tgt.last_name IS NULL))
        AND ((src.student.job_uuid = tgt.job_uuid) OR (src.student.job_uuid IS NULL AND tgt.job_uuid IS NULL))
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.student)
WHEN MATCHED THEN UPDATE SET tgt.sheet_ids = src.student.sheet_ids;

-- vim: set ft=sql ts=4 sw=4 et:
