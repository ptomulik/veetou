CREATE OR REPLACE VIEW v2u_ko_tr_hdr_preamble_v
OF V2u_Ko_Tr_Hdr_Preamble_t
WITH OBJECT IDENTIFIER (job_uuid, id)
AS SELECT
      VALUE(trs).job_uuid
    , VALUE(trs).id
    , REF(trs) tr
    , REF(headers) header
    , REF(preambles) preamble
FROM v2u_ko_tbody_trs tbody_trs
INNER JOIN v2u_ko_trs trs
    ON (tbody_trs.ko_tr_id = trs.id AND
        tbody_trs.job_uuid = trs.job_uuid)
INNER JOIN v2u_ko_tbodies tbodies
    ON (tbody_trs.ko_tbody_id = tbodies.id AND
        tbody_trs.job_uuid = tbodies.job_uuid)
INNER JOIN v2u_ko_page_tbody page_tbody
    ON (page_tbody.ko_tbody_id = tbodies.id AND
        page_tbody.job_uuid = tbodies.job_uuid)
INNER JOIN v2u_ko_pages pages
    ON (page_tbody.ko_page_id = pages.id AND
        page_tbody.job_uuid = pages.job_uuid)
INNER JOIN v2u_ko_page_header page_header
    ON (page_header.ko_page_id = pages.id AND
        page_header.job_uuid = pages.job_uuid)
INNER JOIN v2u_ko_headers headers
    ON (page_header.ko_header_id = headers.id AND
        page_header.job_uuid = headers.job_uuid)
INNER JOIN v2u_ko_page_preamble page_preamble
    ON (page_preamble.ko_page_id = pages.id AND
        page_preamble.job_uuid = pages.job_uuid)
INNER JOIN v2u_ko_preambles preambles
    ON (page_preamble.ko_preamble_id = preambles.id AND
        page_preamble.job_uuid = preambles.job_uuid)
;

-- vim: set ft=sql ts=4 sw=4 et:
