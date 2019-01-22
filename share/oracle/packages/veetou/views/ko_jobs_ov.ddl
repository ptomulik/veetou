CREATE OR REPLACE VIEW v2u_ko_jobs_ov
OF V2u_Ko_Job_t
WITH OBJECT IDENTIFIER(job_uuid)
AS SELECT t.job_uuid
        , t.job_timestamp
        , t.job_host
        , t.job_user
        , t.job_name
FROM v2u_ko_jobs t;

-- vim: set ft=sql ts=4 sw=4 et:
