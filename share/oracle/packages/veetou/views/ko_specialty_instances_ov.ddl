CREATE OR REPLACE VIEW veetou_ko_specialty_instances_ov
AS WITH joined AS
    (
    SELECT
          pages.job_uuid job_uuid
        , Veetou_Ko_Specialty_Instance_Typ(headers.header, preambles.preamble) specialty_instance
        , headers.id header_id
        , preambles.id preamble_id
        , sheets.id sheet_id
    FROM veetou_ko_pages_ov pages
    INNER JOIN veetou_ko_sheet_pages sheet_pages
          ON (sheet_pages.job_uuid = pages.job_uuid AND
              sheet_pages.ko_page_id = pages.id)
    INNER JOIN veetou_ko_sheets_ov sheets
          ON (sheet_pages.job_uuid = sheets.job_uuid AND
              sheet_pages.ko_sheet_id = sheets.id)
    INNER JOIN veetou_ko_page_preamble page_preamble
          ON (page_preamble.job_uuid = pages.job_uuid AND
              page_preamble.ko_page_id = pages.id)
    INNER JOIN veetou_ko_preambles_ov preambles
          ON (page_preamble.job_uuid = preambles.job_uuid AND
              page_preamble.ko_preamble_id = preambles.id)
    INNER JOIN veetou_ko_page_header page_header
          ON (page_header.job_uuid = pages.job_uuid AND
              page_header.ko_page_id = pages.id)
    INNER JOIN veetou_ko_headers_ov headers
          ON (page_header.job_uuid = headers.job_uuid AND
              page_header.ko_header_id = headers.id)
    )
SELECT
      job_uuid
    , specialty_instance
    , COUNT(*) pages_count
    , COUNT(DISTINCT sheet_id) sheets_count
FROM joined
GROUP BY job_uuid, specialty_instance
ORDER BY job_uuid, specialty_instance;

-- vim: set ft=sql ts=4 sw=4 et:
