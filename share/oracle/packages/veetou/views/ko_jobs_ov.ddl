CREATE OR REPLACE VIEW v2u_ko_jobs_ov
    ( job_uuid
    , job
    , CONSTRAINT v2u_ko_jobs_ov_pk PRIMARY KEY (job_uuid)
        RELY DISABLE NOVALIDATE
    )
AS SELECT
      t.job_uuid job_uuid
    , V2u_Ko_Job_t
        ( job_timestamp => t.job_timestamp
        , job_host => t.job_host
        , job_user => t.job_user
        , job_name => t.job_name
        ) job
FROM v2u_ko_jobs t;

-- vim: set ft=sql ts=4 sw=4 et:
