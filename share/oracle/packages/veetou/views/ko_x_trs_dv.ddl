CREATE OR REPLACE VIEW v2u_ko_x_trs_dv
OF V2u_Ko_X_Tr_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS SELECT trs.job_uuid
        , trs.id
        , VALUE(trs)
        , VALUE(pages)
        , VALUE(headers)
        , VALUE(preambles)
        , VALUE(tbodies)
        , VALUE(footers)
        , VALUE(sheets)
        , VALUE(reports)
FROM v2u_ko_trs trs
INNER JOIN v2u_ko_tbody_trs tbody_trs
      ON (tbody_trs.job_uuid = trs.job_uuid AND
          tbody_trs.ko_tr_id = trs.id)
INNER JOIN v2u_ko_tbodies tbodies
      ON (tbody_trs.job_uuid = tbodies.job_uuid AND
          tbody_trs.ko_tbody_id = tbodies.id)
INNER JOIN v2u_ko_page_tbody page_tbody
      ON (page_tbody.job_uuid = tbodies.job_uuid AND
          page_tbody.ko_tbody_id = tbodies.id)
INNER JOIN v2u_ko_pages pages
      ON (page_tbody.job_uuid = pages.job_uuid AND
          page_tbody.ko_page_id = pages.id)
INNER JOIN v2u_ko_sheet_pages sheet_pages
      ON (sheet_pages.job_uuid = pages.job_uuid AND
          sheet_pages.ko_page_id = pages.id)
INNER JOIN v2u_ko_sheets sheets
      ON (sheet_pages.job_uuid = sheets.job_uuid AND
          sheet_pages.ko_sheet_id = sheets.id)
INNER JOIN v2u_ko_report_sheets report_sheets
      ON (report_sheets.job_uuid = sheets.job_uuid AND
          report_sheets.ko_sheet_id = sheets.id)
INNER JOIN v2u_ko_reports reports
      ON (report_sheets.job_uuid = reports.job_uuid AND
          report_sheets.ko_report_id = reports.id)
INNER JOIN v2u_ko_page_preamble page_preamble
      ON (page_preamble.job_uuid = pages.job_uuid AND
          page_preamble.ko_page_id = pages.id)
INNER JOIN v2u_ko_preambles preambles
      ON (page_preamble.job_uuid = preambles.job_uuid AND
          page_preamble.ko_preamble_id = preambles.id)
INNER JOIN v2u_ko_page_header page_header
      ON (page_header.job_uuid = pages.job_uuid AND
          page_header.ko_page_id = pages.id)
INNER JOIN v2u_ko_headers headers
      ON (page_header.job_uuid = headers.job_uuid AND
          page_header.ko_header_id = headers.id)
INNER JOIN v2u_ko_page_footer page_footer
      ON (page_footer.job_uuid = pages.job_uuid AND
          page_footer.ko_page_id = pages.id)
INNER JOIN v2u_ko_footers footers
      ON (page_footer.job_uuid = footers.job_uuid AND
          page_footer.ko_footer_id = footers.id);

-- vim: set ft=sql ts=4 sw=4 et:
