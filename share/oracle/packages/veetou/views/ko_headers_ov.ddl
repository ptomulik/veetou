CREATE OR REPLACE VIEW v2u_ko_headers_ov
    ( job_uuid
    , id
    , header
    , CONSTRAINT v2u_ko_headers_ov_pk PRIMARY KEY (job_uuid, id)
        RELY DISABLE NOVALIDATE
    , CONSTRAINT v2u_ko_headers_ov_fk0 FOREIGN KEY (job_uuid)
        REFERENCES v2u_ko_jobs(job_uuid)
        DISABLE NOVALIDATE
    )
AS SELECT
      t.job_uuid job_uuid
    , t.id id
    , V2u_Ko_Header_t
        ( id => t.id
        , university => t.university
        , faculty => t.faculty
        ) header
FROM v2u_ko_headers t;

-- vim: set ft=sql ts=4 sw=4 et:
