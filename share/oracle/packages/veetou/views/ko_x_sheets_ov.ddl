CREATE OR REPLACE VIEW v2u_ko_x_sheets_ov
    (
      job_uuid
    , sheet_id
    , sheet
    , page_id_list
    , distinct_page_ids_count
    , header_id_list
    , distinct_header_ids_count
    , preamble_id_list
    , distinct_preamble_ids_count
    , pages
    , header_id
    , header
    , preamble_id
    , preamble
    , CONSTRAINT v2u_ko_x_sheets_ov_pk PRIMARY KEY (job_uuid, sheet_id)
        RELY DISABLE NOVALIDATE
    , CONSTRAINT v2u_ko_x_sheets_ov_fk0 FOREIGN KEY (job_uuid)
        REFERENCES v2u_ko_jobs(job_uuid)
        DISABLE NOVALIDATE
    )
AS SELECT
      sheets.job_uuid job_uuid
    , sheets.id sheet_id
    , sheets.sheet sheet
    , LISTAGG(pages.id, ',') WITHIN GROUP (ORDER BY pages.id) page_id_list
    , COUNT(DISTINCT pages.id) distinct_page_ids_count
    , LISTAGG(headers.id, ',') WITHIN GROUP (ORDER BY pages.id) header_id_list
    , COUNT(DISTINCT headers.id) distinct_header_ids_count
    , LISTAGG(preambles.id, ',') WITHIN GROUP (ORDER BY pages.id) preamble_id_list
    , COUNT(DISTINCT preambles.id) distinct_preamble_ids_count
    , CAST(COLLECT(pages.page) AS V2u_Ko_Pages_t) pages
    , MIN(headers.id) KEEP (DENSE_RANK FIRST ORDER BY headers.id) header_id
    , MIN(headers.header) KEEP (DENSE_RANK FIRST ORDER BY headers.id) header
    , MIN(preambles.id) KEEP (DENSE_RANK FIRST ORDER BY preambles.id) preamble_id
    , MIN(preambles.preamble) KEEP (DENSE_RANK FIRST ORDER BY preambles.id) preamble
FROM v2u_ko_pages_ov pages
INNER JOIN v2u_ko_sheet_pages sheet_pages
      ON (sheet_pages.job_uuid = pages.job_uuid AND
          sheet_pages.ko_page_id = pages.id)
INNER JOIN v2u_ko_sheets_ov sheets
      ON (sheet_pages.job_uuid = sheets.job_uuid AND
          sheet_pages.ko_sheet_id = sheets.id)
INNER JOIN v2u_ko_page_preamble page_preamble
      ON (page_preamble.job_uuid = pages.job_uuid AND
          page_preamble.ko_page_id = pages.id)
INNER JOIN v2u_ko_preambles_ov preambles
      ON (page_preamble.job_uuid = preambles.job_uuid AND
          page_preamble.ko_preamble_id = preambles.id)
INNER JOIN v2u_ko_page_header page_header
      ON (page_header.job_uuid = pages.job_uuid AND
          page_header.ko_page_id = pages.id)
INNER JOIN v2u_ko_headers_ov headers
      ON (page_header.job_uuid = headers.job_uuid AND
          page_header.ko_header_id = headers.id)
GROUP BY sheets.job_uuid, sheets.id, sheets.sheet
ORDER BY sheets.job_uuid, sheets.id, sheets.sheet;

-- vim: set ft=sql ts=4 sw=4 et:
