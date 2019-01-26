CREATE OR REPLACE VIEW v2u_ko_sheet_hdr_preamble_v
OF V2u_Ko_Sheet_Hdr_Preamble_t
WITH OBJECT IDENTIFIER (job_uuid, id)
AS WITH u AS
    (
        SELECT
              REF(sheets) sheet
            , MIN(REF(headers)) KEEP (DENSE_RANK FIRST ORDER BY VALUE(pages)) header
            , MIN(REF(preambles)) KEEP (DENSE_RANK FIRST ORDER BY VALUE(pages)) preamble
            , CAST(COLLECT(pages.id ORDER BY pages.id) AS V2u_Ko_5Ids_t) page_ids
            -- both distinct_*_count fields should equal 1 for all rows!
            , COUNT(DISTINCT headers.id) distinct_headers_count
            , COUNT(DISTINCT preambles.id) distinct_preambles_count

        FROM v2u_ko_sheets sheets
        INNER JOIN v2u_ko_sheet_pages sheet_pages
            ON (sheet_pages.ko_sheet_id = sheets.id AND
                sheet_pages.job_uuid = sheets.job_uuid)
        INNER JOIN v2u_ko_pages pages
            ON (sheet_pages.ko_page_id = pages.id AND
                sheet_pages.job_uuid = pages.job_uuid)
        INNER JOIN v2u_ko_page_preamble page_preamble
            ON (page_preamble.ko_page_id = pages.id AND
                page_preamble.job_uuid = pages.job_uuid)
        INNER JOIN v2u_ko_preambles preambles
            ON (page_preamble.ko_preamble_id = preambles.id AND
                page_preamble.job_uuid = preambles.job_uuid)
        INNER JOIN v2u_ko_page_header page_header
            ON (page_header.ko_page_id = pages.id AND
                page_header.job_uuid = pages.job_uuid)
        INNER JOIN v2u_ko_headers headers
            ON (page_header.ko_header_id = headers.id AND
                page_header.job_uuid = headers.job_uuid)
        GROUP BY REF(sheets)
    )
SELECT
      u.sheet.job_uuid
    , u.sheet.id
    , u.sheet
    , u.header
    , u.preamble
    , u.page_ids
    , u.distinct_headers_count
    , u.distinct_preambles_count
FROM u u;

-- vim: set ft=sql ts=4 sw=4 et:
