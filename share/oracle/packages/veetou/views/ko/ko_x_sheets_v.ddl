CREATE OR REPLACE VIEW v2u_ko_x_sheets_v
OF V2u_Ko_X_Sheet_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS
WITH u AS
    ( -- iterate over sheets
        SELECT
              REF(sheets) sheet
            , REF(reports) report

        FROM v2u_ko_report_sheets_j report_sheets
        INNER JOIN v2u_ko_sheets sheets
            ON (report_sheets.ko_sheet_id = sheets.id AND
                report_sheets.job_uuid = sheets.job_uuid)
        INNER JOIN v2u_ko_reports reports
            ON (report_sheets.ko_report_id = reports.id AND
                report_sheets.job_uuid = reports.job_uuid)
    ),
    v AS
    ( -- having a sheet, collect its pages and select first one
        SELECT
              sheet
            , report
            , CAST(COLLECT(pages.id ORDER BY pages.id) AS V2u_Ko_5Ids_t) pages
            , MIN(REF(pages)) KEEP (DENSE_RANK FIRST ORDER BY VALUE(pages)) page
            , CAST(COLLECT(footers.id ORDER BY pages.id) AS V2u_Ko_5Ids_t) footers
        FROM v2u_ko_sheet_pages_j sheet_pages
        INNER JOIN u u
            ON (sheet_pages.ko_sheet_id = u.sheet.id AND
                sheet_pages.job_uuid = u.sheet.job_uuid)
        INNER JOIN v2u_ko_pages pages
            ON (sheet_pages.ko_page_id = pages.id AND
                sheet_pages.job_uuid = pages.job_uuid)
        INNER JOIN v2u_ko_page_footer_j page_footer
            ON (page_footer.ko_page_id = pages.id AND
                page_footer.job_uuid = pages.job_uuid)
        LEFT JOIN v2u_ko_footers footers
            ON (page_footer.ko_footer_id = footers.id AND
                page_footer.job_uuid = footers.job_uuid)
        GROUP BY sheet, report
    )
SELECT -- having sheet and its first page selected, add header and preamble
      v.sheet.job_uuid
    , v.sheet.id
    , v.sheet
    , v.pages
    , REF(headers)
    , REF(preambles)
    , v.footers
    , report
FROM v v
INNER JOIN v2u_ko_page_header_j page_header
      ON (page_header.ko_page_id = v.page.id AND
          page_header.job_uuid = v.page.job_uuid)
INNER JOIN v2u_ko_headers headers
      ON (page_header.ko_header_id = headers.id AND
          page_header.job_uuid = headers.job_uuid)
INNER JOIN v2u_ko_page_preamble_j page_preamble
      ON (page_preamble.ko_page_id = v.page.id AND
          page_preamble.job_uuid = v.page.job_uuid)
INNER JOIN v2u_ko_preambles preambles
      ON (page_preamble.ko_preamble_id = preambles.id AND
          page_preamble.job_uuid = preambles.job_uuid)

-- vim: set ft=sql ts=4 sw=4 et:
