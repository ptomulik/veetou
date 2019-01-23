--CREATE OR REPLACE VIEW v2u_ko_x_sheets
--OF V2u_Ko_X_Sheet_t
--WITH OBJECT IDENTIFIER(job_uuid, id)
--AS SELECT sheets.job_uuid
--        , sheets.id
--        , VALUE(sheets)
--        --, MIN(VALUE(sheets)) KEEP (DENSE_RANK FIRST ORDER BY sheets.id)
--        , CAST(COLLECT(VALUE(pages) ORDER BY pages.id) AS V2u_Ko_Pages_t)
--        , MIN(VALUE(headers)) KEEP (DENSE_RANK FIRST ORDER BY pages.id)
--        , MIN(VALUE(preambles)) KEEP (DENSE_RANK FIRST ORDER BY pages.id)
--        , MIN(VALUE(reports)) KEEP (DENSE_RANK FIRST ORDER BY pages.id)
--        -- vvv for verification vvv: all should be 1!
--        , COUNT(DISTINCT headers.id)
--        , COUNT(DISTINCT preambles.id)
--        , COUNT(DISTINCT reports.id)
--FROM v2u_ko_pages pages
--INNER JOIN v2u_ko_sheet_pages sheet_pages
--      ON (sheet_pages.job_uuid = pages.job_uuid AND
--          sheet_pages.ko_page_id = pages.id)
--INNER JOIN v2u_ko_sheets sheets
--      ON (sheet_pages.job_uuid = sheets.job_uuid AND
--          sheet_pages.ko_sheet_id = sheets.id)
--INNER JOIN v2u_ko_report_sheets report_sheets
--      ON (report_sheets.job_uuid = sheets.job_uuid AND
--          report_sheets.ko_sheet_id = sheets.id)
--INNER JOIN v2u_ko_reports reports
--      ON (report_sheets.job_uuid = reports.job_uuid AND
--          report_sheets.ko_report_id = reports.id)
--INNER JOIN v2u_ko_page_header page_header
--      ON (page_header.job_uuid = pages.job_uuid AND
--          page_header.ko_page_id = pages.id)
--INNER JOIN v2u_ko_headers headers
--      ON (page_header.job_uuid = headers.job_uuid AND
--          page_header.ko_header_id = headers.id)
--INNER JOIN v2u_ko_page_preamble page_preamble
--      ON (page_preamble.job_uuid = pages.job_uuid AND
--          page_preamble.ko_page_id = pages.id)
--INNER JOIN v2u_ko_preambles preambles
--      ON (page_preamble.job_uuid = preambles.job_uuid AND
--          page_preamble.ko_preamble_id = preambles.id)
--GROUP BY sheets.job_uuid, sheets.id, VALUE(sheets)
--ORDER BY sheets.job_uuid, sheets.id, VALUE(sheets);

CREATE OR REPLACE VIEW v2u_ko_x_sheets
OF V2u_Ko_X_Sheet_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS
WITH u AS
    (
        SELECT
              VALUE(sheets) sheet
            , VALUE(reports) report
        FROM v2u_ko_sheets sheets
        INNER JOIN v2u_ko_report_sheets report_sheets
              ON (report_sheets.job_uuid = sheets.job_uuid AND
                  report_sheets.ko_sheet_id = sheets.id)
        INNER JOIN v2u_ko_reports reports
              ON (report_sheets.job_uuid = reports.job_uuid AND
                  report_sheets.ko_report_id = reports.id)
        INNER JOIN v2u_ko_jobs jobs
              ON (jobs.job_uuid = reports.job_uuid)
    ),
    v AS
    (
        SELECT
              sheet
            , report
            , CAST(COLLECT(VALUE(pages) ORDER BY pages.id) AS V2u_Ko_Pages_t) pages
            , MIN(VALUE(pages)) KEEP (DENSE_RANK FIRST ORDER BY pages.id) first_page
        FROM u u
        INNER JOIN v2u_ko_sheet_pages sheet_pages
              ON (sheet_pages.job_uuid = u.sheet.job_uuid AND
                  sheet_pages.ko_sheet_id = u.sheet.id)
        INNER JOIN v2u_ko_pages pages
              ON (sheet_pages.job_uuid = pages.job_uuid AND
                  sheet_pages.ko_page_id = pages.id)
        GROUP BY sheet, report
    )
SELECT
      v.sheet.job_uuid
    , v.sheet.id
    , v.sheet
    , v.pages
    , VALUE(headers)
    , VALUE(preambles)
    , report
    , 1
    , 1
    , 1
--    , COUNT(DISTINCT headers.id)
--    , COUNT(DISTINCT preambles.id)
--    , 1
FROM v v
INNER JOIN v2u_ko_page_header page_header
      ON (page_header.job_uuid = v.first_page.job_uuid AND
          page_header.ko_page_id = v.first_page.id)
INNER JOIN v2u_ko_headers headers
      ON (page_header.job_uuid = headers.job_uuid AND
          page_header.ko_header_id = headers.id)
INNER JOIN v2u_ko_page_preamble page_preamble
      ON (page_preamble.job_uuid = v.first_page.job_uuid AND
          page_preamble.ko_page_id = v.first_page.id)
INNER JOIN v2u_ko_preambles preambles
      ON (page_preamble.job_uuid = preambles.job_uuid AND
          page_preamble.ko_preamble_id = preambles.id);
--GROUP BY v.sheet.job_uuid, v.sheet.id, sheet, page, VALUE(headers), VALUE(preambles), report
--ORDER BY v.sheet.job_uuid, v.sheet.id, sheet, page, VALUE(headers), VALUE(preambles), report;

-- vim: set ft=sql ts=4 sw=4 et:
