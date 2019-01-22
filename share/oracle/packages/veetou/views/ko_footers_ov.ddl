CREATE OR REPLACE VIEW v2u_ko_footers_ov
OF V2u_Ko_Footer_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS SELECT t.job_uuid
        , t.id
        , t.pagination
        , t.sheet_page_number
        , t.sheet_pages_total
        , t.generator_name
        , t.generator_home
FROM v2u_ko_footers t;

-- vim: set ft=sql ts=4 sw=4 et:
