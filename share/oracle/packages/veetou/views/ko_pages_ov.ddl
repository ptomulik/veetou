CREATE OR REPLACE VIEW v2u_ko_pages_ov
    ( job_uuid
    , id
    , page
    , CONSTRAINT v2u_ko_pages_ov_pk PRIMARY KEY (job_uuid, id)
        RELY DISABLE NOVALIDATE
    , CONSTRAINT v2u_ko_pages_ov_fk0 FOREIGN KEY (job_uuid)
        REFERENCES v2u_ko_jobs(job_uuid)
        DISABLE NOVALIDATE
    )
AS SELECT
      t.job_uuid job_uuid
    , t.id id
    , V2u_Ko_Page_t
        ( id => t.id
        , page_number => t.page_number
        , parser_page_number => t.parser_page_number
        ) page
FROM v2u_ko_pages t;

-- vim: set ft=sql ts=4 sw=4 et:
