CREATE OR REPLACE VIEW veetou_ko_jobs_ov
        ( job_uuid
        , job
        , CONSTRAINT veetou_ko_jobs_ov_pk PRIMARY KEY (job_uuid)
            RELY DISABLE NOVALIDATE
        )
        AS SELECT
          t.job_uuid job_uuid
        , Veetou_Ko_Job_Typ
            ( job_timestamp => t.job_timestamp
            , job_host => t.job_host
            , job_user => t.job_user
            , job_name => t.job_name
            ) job
        FROM veetou_ko_jobs t;

-- vim: set ft=sql ts=4 sw=4 et:
