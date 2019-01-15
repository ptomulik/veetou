CREATE VIEW veetou_ko_footers_ov
        ( job_uuid
        , id
        , footer
        , CONSTRAINT veetou_ko_footers_ov_pk PRIMARY KEY (job_uuid, id)
            RELY DISABLE NOVALIDATE
        , CONSTRAINT veetou_ko_footers_ov_fk0 FOREIGN KEY (job_uuid)
            REFERENCES veetou_ko_jobs_ov(job_uuid)
            RELY DISABLE NOVALIDATE
        )
        AS SELECT
          t.job_uuid job_uuid
        , t.id id
        , Veetou_Ko_Footer_Typ
            ( pagination => t.pagination
            , sheet_page_number => t.sheet_page_number
            , sheet_pages_total => t.sheet_pages_total
            , generator_name => t.generator_name
            , generator_home => t.generator_home
            ) footer
        FROM veetou_ko_footers t;

-- vim: set ft=sql ts=4 sw=4 et:
