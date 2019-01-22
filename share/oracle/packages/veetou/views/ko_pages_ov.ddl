CREATE OR REPLACE VIEW v2u_ko_pages_ov
OF V2u_Ko_Page_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS SELECT t.job_uuid
        , t.id
        , t.page_number
        , t.parser_page_number
FROM v2u_ko_pages t;

-- vim: set ft=sql ts=4 sw=4 et:
