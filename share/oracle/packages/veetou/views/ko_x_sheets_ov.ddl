CREATE OR REPLACE VIEW v2u_ko_x_sheets_ov
OF V2u_Ko_X_Sheet_t
WITH OBJECT IDENTIFIER(sheet.job_uuid, sheet.id)
AS SELECT REF(sheets)
        , CAST(COLLECT(REF(pages)) AS V2u_Ko_Page_Refs_t)
        , MIN(REF(headers)) KEEP (DENSE_RANK FIRST ORDER BY headers.id)
        , MIN(REF(preambles)) KEEP (DENSE_RANK FIRST ORDER BY preambles.id)
        , MIN(REF(reports)) KEEP (DENSE_RANK FIRST ORDER BY reports.id)
        -- vvv for verification vvv: all should be 1!
        , COUNT(DISTINCT headers.id)
        , COUNT(DISTINCT preambles.id)
        , COUNT(DISTINCT reports.id)
FROM v2u_ko_pages_ov pages
INNER JOIN v2u_ko_page_header page_header
      ON (page_header.job_uuid = pages.job_uuid AND
          page_header.ko_page_id = pages.id)
INNER JOIN v2u_ko_headers_ov headers
      ON (page_header.job_uuid = headers.job_uuid AND
          page_header.ko_header_id = headers.id)
INNER JOIN v2u_ko_page_preamble page_preamble
      ON (page_preamble.job_uuid = pages.job_uuid AND
          page_preamble.ko_page_id = pages.id)
INNER JOIN v2u_ko_preambles_ov preambles
      ON (page_preamble.job_uuid = preambles.job_uuid AND
          page_preamble.ko_preamble_id = preambles.id)
INNER JOIN v2u_ko_sheet_pages sheet_pages
      ON (sheet_pages.job_uuid = pages.job_uuid AND
          sheet_pages.ko_page_id = pages.id)
INNER JOIN v2u_ko_sheets_ov sheets
      ON (sheet_pages.job_uuid = sheets.job_uuid AND
          sheet_pages.ko_sheet_id = sheets.id)
INNER JOIN v2u_ko_report_sheets report_sheets
      ON (report_sheets.job_uuid = sheets.job_uuid AND
          report_sheets.ko_sheet_id = sheets.id)
INNER JOIN v2u_ko_reports_ov reports
      ON (report_sheets.job_uuid = reports.job_uuid AND
          report_sheets.ko_report_id = reports.id)
GROUP BY sheets.job_uuid, sheets.id, REF(sheets)
ORDER BY sheets.job_uuid, sheets.id, REF(sheets);

-- vim: set ft=sql ts=4 sw=4 et:
