CREATE OR REPLACE VIEW veetou_ko_pages_ov
        ( job_uuid
        , id
        , page
        , CONSTRAINT veetou_ko_pages_ov_pk PRIMARY KEY (job_uuid, id)
            RELY DISABLE NOVALIDATE
        , CONSTRAINT veetou_ko_pages_ov_fk0 FOREIGN KEY (job_uuid)
            REFERENCES veetou_ko_jobs_ov(job_uuid)
            RELY DISABLE NOVALIDATE
        )
        AS SELECT
          t.job_uuid job_uuid
        , t.id id
        , Veetou_Ko_Page_Typ
            ( page_number => t.page_number
            , parser_page_number => t.parser_page_number
            ) page
        FROM veetou_ko_pages t;

-- vim: set ft=sql ts=4 sw=4 et:
